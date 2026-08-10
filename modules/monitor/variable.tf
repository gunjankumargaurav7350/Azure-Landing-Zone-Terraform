variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "metric_alerts" {

  type = map(object({

    name             = string
    scopes           = list(string)
    description      = string
    severity         = number
    frequency        = string
    window_size      = string

    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number

    action_group_id  = string

  }))

}