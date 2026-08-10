output "key_vault_id" {

  value = {

    for key, kv in azurerm_key_vault.this :

    key => kv.id

  }

}

output "key_vault_uri" {

  value = {

    for key, kv in azurerm_key_vault.this :

    key => kv.vault_uri

  }

}

output "key_vault_name" {

  value = {

    for key, kv in azurerm_key_vault.this :

    key => kv.name

  }

}