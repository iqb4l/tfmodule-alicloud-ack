output "cluster_id" {
  value = alicloud_cs_managed_kubernetes.cluster.id
}

output "cluster_name" {
  value = alicloud_cs_managed_kubernetes.cluster.name
}

output "node_pool_id" {
  value = var.create_node_pool ? alicloud_cs_kubernetes_node_pool.node_pool[0].id : null
}