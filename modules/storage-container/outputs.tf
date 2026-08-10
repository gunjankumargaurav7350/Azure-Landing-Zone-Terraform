output "storage_container_id" {

  value = {

    for key, value in azurerm_storage_container.this :

    key => value.id

  }

}

output "storage_container_name" {

  value = {

    for key, value in azurerm_storage_container.this :

    key => value.name

  }

}