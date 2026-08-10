output "storage_account_id" {

  value = {

    for key, value in azurerm_storage_account.this :

    key => value.id

  }

}

output "storage_account_name" {

  value = {

    for key, value in azurerm_storage_account.this :

    key => value.name

  }

}