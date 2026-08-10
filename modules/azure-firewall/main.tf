resource "azurerm_firewall" "this" {

  for_each = var.firewalls

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = each.value.sku_name
  sku_tier = each.value.sku_tier

  firewall_policy_id = each.value.firewall_policy_id

  ip_configuration {

    name                 = "configuration"
    subnet_id            = each.value.subnet_id
    public_ip_address_id = each.value.public_ip_id

  }

  tags = var.tags
}