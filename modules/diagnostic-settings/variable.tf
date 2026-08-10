variable "diagnostic_settings" {

  type = map(object({

    name                       = string
    target_resource_id         = string
    log_analytics_workspace_id = string

  }))

}