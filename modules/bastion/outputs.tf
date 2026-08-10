output "bastion_id" {

  value = {

    for k, v in azurerm_bastion_host.this :

    k => v.id

  }

}

output "bastion_name" {

  value = {

    for k, v in azurerm_bastion_host.this :

    k => v.name

  }

}