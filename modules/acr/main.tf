resource "azurerm_container_registry" "this" {

  for_each = var.container_registries

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku           = each.value.sku
  admin_enabled = each.value.admin_enabled

  public_network_access_enabled = each.value.public_network_access_enabled

  tags = var.tags

}