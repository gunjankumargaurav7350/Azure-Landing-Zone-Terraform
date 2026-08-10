output "metric_alert_id" {

  value = {

    for key, value in azurerm_monitor_metric_alert.this :

    key => value.id

  }

}