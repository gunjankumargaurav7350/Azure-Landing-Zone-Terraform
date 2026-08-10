output "association_ids" {

  value = {

    for key, association in azurerm_subnet_nat_gateway_association.this :

    key => association.id

  }

}