variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "recovery_services_vaults" {

  type = map(object({

    name                         = string
    sku                          = string
    soft_delete_enabled          = bool
    storage_mode_type            = string
    cross_region_restore_enabled = bool

  }))

}