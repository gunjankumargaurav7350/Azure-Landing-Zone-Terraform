resource "azurerm_network_interface" "this" {

  for_each = var.network_interfaces

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_forwarding_enabled           = each.value.enable_ip_forwarding
  accelerated_networking_enabled  = each.value.enable_accelerated_networking

  ip_configuration {

    name                          = each.value.ip_configuration_name
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    private_ip_address            = each.value.private_ip_address
    public_ip_address_id          = each.value.public_ip_address_id

  }

  tags = var.tags
}