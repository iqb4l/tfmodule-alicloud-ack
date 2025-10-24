# Activate ACK service
data "alicloud_ack_service" "open" {
  enable = "On"
  type   = "propayasgo"
}

# Create ACK Cluster
resource "alicloud_cs_managed_kubernetes" "cluster" {
  name                  = var.cluster_name
  cluster_spec          = var.cluster_spec
  version               = var.ack_version
  ip_stack              = "ipv4"
  timezone              = var.timezone
  deletion_protection   = var.deletion_protection
  proxy_mode            = var.proxy_mode
  slb_internet_enabled  = var.slb_internet_enabled
  new_nat_gateway       = false
  security_group_id     = var.security_group_id
  control_plane_log_ttl = var.control_plane_log_ttl

  operation_policy {
    cluster_auto_upgrade {
      channel = var.auto_upgrade_channel
      enabled = var.auto_upgrade_enabled
    }
  }

  maintenance_window {
    duration         = var.maintenance_duration
    weekly_period    = var.maintenance_weekly_period
    enable           = var.maintenance_enabled
    maintenance_time = var.maintenance_time
  }

  audit_log_config { 
    enabled = var.audit_log_enabled 
  }
  
  service_cidr    = var.service_cidr
  vswitch_ids     = var.vswitch_ids
  pod_vswitch_ids = var.pod_vswitch_ids

  # Dynamically add addons
  dynamic "addons" {
    for_each = var.cluster_addons
    content {
      name   = addons.value.name
      config = addons.value.config != "" ? addons.value.config : null
    }
  }
}

# Create Node Pool
resource "alicloud_cs_kubernetes_node_pool" "node_pool" {
  count = var.create_node_pool ? 1 : 0

  cluster_id           = alicloud_cs_managed_kubernetes.cluster.id
  node_pool_name       = var.node_pool_name
  vswitch_ids          = var.node_pool_vswitch_ids
  instance_types       = var.instance_types
  system_disk_category = var.system_disk_category
  system_disk_size     = var.system_disk_size
  image_type           = var.image_type
  runtime_name         = var.runtime_name
  instance_charge_type = var.instance_charge_type
  password             = var.node_password

  scaling_config {
    min_size = var.min_size
    max_size = var.max_size
  }

  depends_on = [alicloud_cs_managed_kubernetes.cluster]
}