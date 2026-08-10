output "acr_id" {

  value = {

    for key, value in azurerm_container_registry.this :

    key => value.id

  }

}

output "login_server" {

  value = {

    for key, value in azurerm_container_registry.this :

    key => value.login_server

  }

}

output "acr_name" {

  value = {

    for key, value in azurerm_container_registry.this :

    key => value.name

  }

}