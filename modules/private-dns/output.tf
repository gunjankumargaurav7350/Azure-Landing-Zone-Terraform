output "private_dns_zone_id" {

  value = {

    for key, value in azurerm_private_dns_zone.this :

    key => value.id

  }

}

output "private_dns_zone_name" {

  value = {

    for key, value in azurerm_private_dns_zone.this :

    key => value.name

  }

}