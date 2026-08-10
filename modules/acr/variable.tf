variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "container_registries" {

  type = map(object({

    name                          = string
    sku                           = string
    admin_enabled                 = bool
    public_network_access_enabled = bool

  }))

}