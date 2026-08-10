output "nsg_id" {

  value = {

    for key, nsg in azurerm_network_security_group.this :

    key => nsg.id

  }

}

output "nsg_name" {

  value = {

    for key, nsg in azurerm_network_security_group.this :

    key => nsg.name

  }

}