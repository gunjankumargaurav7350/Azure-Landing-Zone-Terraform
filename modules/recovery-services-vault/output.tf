output "recovery_services_vault_id" {

  value = {

    for key, value in azurerm_recovery_services_vault.this :

    key => value.id

  }

}

output "recovery_services_vault_name" {

  value = {

    for key, value in azurerm_recovery_services_vault.this :

    key => value.name

  }

}