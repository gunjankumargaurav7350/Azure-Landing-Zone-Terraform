output "association_ids" {

  value = {

    for key, association in azurerm_subnet_route_table_association.this :

    key => association.id

  }

}