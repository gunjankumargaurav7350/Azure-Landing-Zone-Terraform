resource "azurerm_firewall_policy" "this" {

  for_each = var.firewall_policies

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku = each.value.sku

  tags = var.tags

}