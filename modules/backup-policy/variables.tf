variable "resource_group_name" {
  type = string
}

variable "recovery_vault_name" {
  type = string
}

variable "backup_policies" {

  type = map(object({

    name             = string
    timezone         = string
    frequency        = string
    time             = string
    retention_daily  = number

  }))

}