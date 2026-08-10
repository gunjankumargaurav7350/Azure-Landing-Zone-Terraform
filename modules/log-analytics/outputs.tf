output "workspace_id" {

  value = {

    for key, value in azurerm_log_analytics_workspace.this :

    key => value.id

  }

}

output "workspace_name" {

  value = {

    for key, value in azurerm_log_analytics_workspace.this :

    key => value.name

  }

}