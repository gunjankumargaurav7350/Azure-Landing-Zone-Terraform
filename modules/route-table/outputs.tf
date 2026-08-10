output "route_table_id" {

  value = {

    for key, rt in azurerm_route_table.this :

    key => rt.id

  }

}

output "route_table_name" {

  value = {

    for key, rt in azurerm_route_table.this :

    key => rt.name

  }

}