output "role_assignment_id" {

  value = {

    for key, value in azurerm_role_assignment.this :

    key => value.id

  }

}