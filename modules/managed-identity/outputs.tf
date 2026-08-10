output "id" {

  value = {

    for key, value in azurerm_user_assigned_identity.this :

    key => value.id

  }

}

output "principal_id" {

  value = {

    for key, value in azurerm_user_assigned_identity.this :

    key => value.principal_id

  }

}

output "client_id" {

  value = {

    for key, value in azurerm_user_assigned_identity.this :

    key => value.client_id

  }

}