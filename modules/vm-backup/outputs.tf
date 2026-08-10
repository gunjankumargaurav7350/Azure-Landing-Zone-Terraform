output "protected_vm_id" {

  value = {

    for key, value in azurerm_backup_protected_vm.this :

    key => value.id

  }

}