output "firewall_policy_id" {

  value = {

    for key, value in azurerm_firewall_policy.this :

    key => value.id

  }

}

output "firewall_policy_name" {

  value = {

    for key, value in azurerm_firewall_policy.this :

    key => value.name

  }

}