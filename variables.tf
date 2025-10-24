variable "cluster_name" {
  type        = string
  description = "Name of the ACK cluster"
}

variable "cluster_spec" {
  type        = string
  description = "The cluster specification"
}

variable "ack_version" {
  type        = string
  description = "Kubernetes version"
}

variable "timezone" {
  type        = string
  description = "Cluster timezone"
}

variable "deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection"
}

variable "proxy_mode" {
  type        = string
  description = "Proxy mode for kube-proxy"
}

variable "slb_internet_enabled" {
  type        = bool
  description = "Whether to create an internet-facing SLB"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for the cluster"
}

variable "control_plane_log_ttl" {
  type        = string
  description = "Control plane log retention period in days"
}

variable "auto_upgrade_enabled" {
  type        = bool
  description = "Whether to enable automatic cluster upgrades"
  default     = true
}

variable "auto_upgrade_channel" {
  type        = string
  description = "Auto upgrade channel"
  default     = "stable"
}

variable "maintenance_enabled" {
  type        = bool
  description = "Whether to enable maintenance window"
  default     = true
}

variable "maintenance_duration" {
  type        = string
  description = "Maintenance window duration"
  default     = "3h"
}

variable "maintenance_weekly_period" {
  type        = string
  description = "Maintenance weekly period"
  default     = "Monday"
}

variable "maintenance_time" {
  type        = string
  description = "Maintenance start time"
}

variable "audit_log_enabled" {
  type        = bool
  description = "Whether to enable audit logging"
  default     = true
}

variable "service_cidr" {
  type        = string
  description = "Service CIDR for the cluster"
}

variable "vswitch_ids" {
  type        = list(string)
  description = "VSwitch IDs for the cluster"
}

variable "pod_vswitch_ids" {
  type        = list(string)
  description = "VSwitch IDs for pods"
}

variable "cluster_addons" {
  type = list(object({
    name   = string
    config = string
  }))
  description = "List of cluster addons"
}

variable "create_node_pool" {
  type        = bool
  description = "Whether to create a node pool"
}

variable "node_pool_name" {
  type        = string
  description = "Name of the node pool"
}

variable "node_pool_vswitch_ids" {
  type        = list(string)
  description = "VSwitch IDs for the node pool"
  default     = []
}

variable "instance_types" {
  type        = list(string)
  description = "Instance types for nodes"
}

variable "system_disk_category" {
  type        = string
  description = "System disk category"
}

variable "system_disk_size" {
  type        = number
  description = "System disk size in GB"
}

variable "image_type" {
  type        = string
  description = "Node image type"
  default     = "AliyunLinux3"
}

variable "runtime_name" {
  type        = string
  description = "Container runtime"
  default     = "containerd"
}

variable "instance_charge_type" {
  type        = string
  description = "Instance charge type"
  default     = "PostPaid"
}

variable "node_password" {
  type        = string
  description = "Password for nodes"
  sensitive   = true
}

variable "min_size" {
  type        = number
  description = "Minimum number of nodes"
}

variable "max_size" {
  type        = number
  description = "Maximum number of nodes"
}