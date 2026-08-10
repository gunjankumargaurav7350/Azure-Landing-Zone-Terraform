variable "resource_group_name" {
  type = string
}

variable "recovery_vault_name" {
  type = string
}

variable "protected_vms" {

  type = map(object({

    source_vm_id    = string
    backup_policy_id = string

  }))

}