output "network_interface_id" {

  value = {

    for key, nic in azurerm_network_interface.this :

    key => nic.id

  }

}

output "network_interface_name" {

  value = {

    for key, nic in azurerm_network_interface.this :

    key => nic.name

  }

}

output "private_ip_address" {

  value = {

    for key, nic in azurerm_network_interface.this :

    key => nic.private_ip_address

  }

}