output "vm_id" {

  value = {

    for key, vm in azurerm_linux_virtual_machine.this :

    key => vm.id

  }

}

output "vm_name" {

  value = {

    for key, vm in azurerm_linux_virtual_machine.this :

    key => vm.name

  }

}

output "private_ip" {

  value = {

    for key, vm in azurerm_linux_virtual_machine.this :

    key => vm.private_ip_address

  }

}

output "linux_vm_ids" {

  value = {
    for key, vm in azurerm_linux_virtual_machine.this :
    key => vm.id
  }
}

output "linux_vm_names" {

  value = {
    for key, vm in azurerm_linux_virtual_machine.this :
    key => vm.name
  }

}