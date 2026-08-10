output "nat_gateway_id" {

  value = {

    for key, nat in azurerm_nat_gateway.this :

    key => nat.id

  }

}

output "nat_gateway_name" {

  value = {

    for key, nat in azurerm_nat_gateway.this :

    key => nat.name

  }

}