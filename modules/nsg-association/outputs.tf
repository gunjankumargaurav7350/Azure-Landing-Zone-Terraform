output "association_ids" {

  value = {

    for key, association in azurerm_subnet_network_security_group_association.this :

    key => association.id

  }

}