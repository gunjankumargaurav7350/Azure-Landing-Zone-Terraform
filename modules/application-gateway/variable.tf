variable "location" {

  type = string

}

variable "resource_group_name" {

  type = string

}

variable "tags" {

  type = map(string)

  default = {}

}

variable "application_gateways" {

  type = map(object({

    name = string

    sku_name = string

    sku_tier = string

    capacity = number

    subnet_id = string

    public_ip_id = string

  }))

}