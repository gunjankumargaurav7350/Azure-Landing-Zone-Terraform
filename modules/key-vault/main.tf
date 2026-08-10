resource "azurerm_key_vault" "this" {

  for_each = var.key_vaults

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  tenant_id = var.tenant_id
  sku_name  = each.value.sku_name

  soft_delete_retention_days = 90
  purge_protection_enabled   = true

  tags = var.tags
}