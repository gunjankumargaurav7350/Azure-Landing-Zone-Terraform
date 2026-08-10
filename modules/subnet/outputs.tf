output "subnet_ids" {

  value = {

    for key, subnet in azurerm_subnet.this :

    key => subnet.id

  }

}

output "subnet_names" {

  value = {

    for key, subnet in azurerm_subnet.this :

    key => subnet.name

  }

}