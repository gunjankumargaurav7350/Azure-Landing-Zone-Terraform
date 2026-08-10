resource "azurerm_monitor_diagnostic_setting" "this" {

  for_each = var.diagnostic_settings

  name                       = each.value.name
  target_resource_id         = each.value.target_resource_id
  log_analytics_workspace_id = each.value.log_analytics_workspace_id

  enabled_log {

    category = "AllLogs"

  }

enabled_metric {
  category = "AllMetrics"
}

}