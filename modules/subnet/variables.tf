variable "resource_group_name" {

  description = "Resource Group Name"

  type = string

}

variable "virtual_network_name" {

  description = "Virtual Network Name"

  type = string

}

variable "subnets" {

  description = "Subnet Configuration"

  type = map(object({

    name = string

    address_prefixes = list(string)

  }))

}