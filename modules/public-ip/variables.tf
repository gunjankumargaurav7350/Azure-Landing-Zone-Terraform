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

variable "public_ips" {

  type = map(object({

    name = string

    allocation_method = string

    sku = string

    zones = optional(list(string), [])

  }))

}