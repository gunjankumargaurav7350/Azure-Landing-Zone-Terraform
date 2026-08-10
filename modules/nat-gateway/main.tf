resource "azurerm_nat_gateway" "this" {

  for_each = var.nat_gateways

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = each.value.sku_name

  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes

  zones = each.value.zones

  tags = var.tags

}

resource "azurerm_nat_gateway_public_ip_association" "this" {

  for_each = var.nat_gateways

  nat_gateway_id       = azurerm_nat_gateway.this[each.key].id
  public_ip_address_id = each.value.public_ip_id

}