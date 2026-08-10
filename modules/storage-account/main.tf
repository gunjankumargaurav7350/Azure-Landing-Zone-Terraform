resource "azurerm_storage_account" "this" {

  for_each = var.storage_accounts

  name                     = each.value.name
  resource_group_name      = var.resource_group_name
  location                 = var.location

  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  account_kind             = each.value.account_kind
  access_tier              = each.value.access_tier

  shared_access_key_enabled = true

  tags = var.tags
}