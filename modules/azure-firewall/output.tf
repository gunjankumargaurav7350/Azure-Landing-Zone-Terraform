output "firewall_id" {

  value = {

    for k, v in azurerm_firewall.this :

    k => v.id

  }

}

output "firewall_private_ip" {

  value = {

    for k, v in azurerm_firewall.this :

    k => v.ip_configuration[0].private_ip_address

  }

}