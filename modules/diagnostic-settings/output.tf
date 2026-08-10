output "diagnostic_setting_id" {

  value = {

    for key, value in azurerm_monitor_diagnostic_setting.this :

    key => value.id

  }

}