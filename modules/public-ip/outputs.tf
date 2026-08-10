output "public_ip_id" {

  value = {

    for key, pip in azurerm_public_ip.this :

    key => pip.id

  }

}

output "public_ip_address" {

  value = {

    for key, pip in azurerm_public_ip.this :

    key => pip.ip_address

  }

}

output "public_ip_name" {

  value = {

    for key, pip in azurerm_public_ip.this :

    key => pip.name

  }

}