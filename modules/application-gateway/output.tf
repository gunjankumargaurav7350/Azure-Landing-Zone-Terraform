output "application_gateway_id" {

  value = {

    for key, appgw in azurerm_application_gateway.this :

    key => appgw.id

  }

}

output "application_gateway_name" {

  value = {

    for key, appgw in azurerm_application_gateway.this :

    key => appgw.name

  }

}