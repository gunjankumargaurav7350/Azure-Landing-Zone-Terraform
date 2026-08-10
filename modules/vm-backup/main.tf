resource "azurerm_backup_protected_vm" "this" {

  for_each = var.protected_vms

  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name

  source_vm_id = each.value.source_vm_id

  backup_policy_id = each.value.backup_policy_id

}