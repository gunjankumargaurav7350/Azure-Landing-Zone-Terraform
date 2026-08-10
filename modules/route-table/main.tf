resource "azurerm_route_table" "this" {

  for_each = var.route_tables

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  bgp_route_propagation_enabled = each.value.bgp_route_propagation_enabled

  dynamic "route" {

    for_each = each.value.routes

    content {

      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address

    }

  }

  tags = var.tags

}