output "resource_groups" {

  value = module.resource_groups

}

output "virtual_network_id" {

  value = module.virtual_network.vnet_id

}

output "virtual_network_name" {

  value = module.virtual_network.vnet_name

}
output "subnet_ids" {

  value = module.subnet.subnet_ids

}