resource "azurerm_log_analytics_workspace" "this" {

  for_each = var.log_analytics_workspaces

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = each.value.sku
  retention_in_days = each.value.retention_in_days

  tags = var.tags

}