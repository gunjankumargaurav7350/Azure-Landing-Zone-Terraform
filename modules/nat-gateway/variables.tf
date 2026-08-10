variable "location" {

  type = string

}

variable "resource_group_name" {

  type = string

}

variable "tags" {

  type    = map(string)

  default = {}

}

variable "nat_gateways" {

  type = map(object({

    name = string

    sku_name = string

    idle_timeout_in_minutes = number

    zones = optional(list(string), [])

    public_ip_id = string

  }))

}