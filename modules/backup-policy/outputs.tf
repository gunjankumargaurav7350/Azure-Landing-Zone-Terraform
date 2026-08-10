output "backup_policy_id" {
  value = {
    for key, value in azurerm_backup_policy_vm.this :
    key => value.id
  }
}