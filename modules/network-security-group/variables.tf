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

variable "network_security_groups" {

  type = map(object({

    name = string

    security_rules = list(object({

      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string

      source_port_range          = string
      destination_port_range     = string

      source_address_prefix      = string
      destination_address_prefix = string

    }))

  }))

}