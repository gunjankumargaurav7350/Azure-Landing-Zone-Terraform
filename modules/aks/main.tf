resource "azurerm_kubernetes_cluster" "this" {

  for_each = var.aks_clusters

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = each.value.dns_prefix

  kubernetes_version  = each.value.kubernetes_version
  sku_tier            = each.value.sku_tier

  default_node_pool {

    name                = each.value.default_node_pool.name
    vm_size             = each.value.default_node_pool.vm_size
    node_count          = each.value.default_node_pool.node_count
    os_disk_size_gb     = each.value.default_node_pool.os_disk_size_gb
    vnet_subnet_id      = each.value.default_node_pool.vnet_subnet_id
    orchestrator_version = each.value.kubernetes_version

  }

  identity {

    type = "SystemAssigned"

  }

  network_profile {

  network_plugin    = each.value.network_plugin
  network_policy    = each.value.network_policy
  load_balancer_sku = each.value.load_balancer_sku

  outbound_type = "userDefinedRouting"
}

  oms_agent {

    log_analytics_workspace_id = each.value.log_analytics_workspace_id

  }

  tags = var.tags

}