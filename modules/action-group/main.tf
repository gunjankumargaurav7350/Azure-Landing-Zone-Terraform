resource "azurerm_monitor_action_group" "this" {

  for_each = var.action_groups

  name                = each.value.name
  short_name          = each.value.short_name
  resource_group_name = var.resource_group_name

  email_receiver {

    name                    = "Admin"
    email_address           = each.value.email_address
    use_common_alert_schema = true

  }

  tags = var.tags

}