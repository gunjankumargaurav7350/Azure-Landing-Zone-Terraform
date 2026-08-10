resource "azurerm_recovery_services_vault" "this" {

  for_each = var.recovery_services_vaults

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku = each.value.sku

  soft_delete_enabled = each.value.soft_delete_enabled

  storage_mode_type = each.value.storage_mode_type

  cross_region_restore_enabled = each.value.cross_region_restore_enabled

  tags = var.tags

}