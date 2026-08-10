variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "aks_clusters" {

  type = map(object({

    name                 = string
    dns_prefix           = string
    kubernetes_version   = string
    sku_tier             = string

    network_plugin       = string
    network_policy       = string
    load_balancer_sku    = string

    log_analytics_workspace_id = string

    default_node_pool = object({

      name            = string
      vm_size         = string
      node_count      = number
      os_disk_size_gb = number
      vnet_subnet_id  = string

    })

  }))

}