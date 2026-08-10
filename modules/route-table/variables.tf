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

variable "route_tables" {

  type = map(object({

    name = string

    bgp_route_propagation_enabled = bool

    routes = list(object({

      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)

    }))

  }))

}