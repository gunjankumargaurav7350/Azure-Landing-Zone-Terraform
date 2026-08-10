output "action_group_id" {

  value = {

    for key, value in azurerm_monitor_action_group.this :

    key => value.id

  }

}