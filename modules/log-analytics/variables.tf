variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "log_analytics_workspaces" {

  type = map(object({

    name              = string
    sku               = string
    retention_in_days = number

  }))

}