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

variable "network_interfaces" {

  type = map(object({

    name = string

    ip_configuration_name = string

    subnet_id = string

    private_ip_address_allocation = string

    private_ip_address = optional(string)

    public_ip_address_id = optional(string)

    enable_accelerated_networking = bool

    enable_ip_forwarding = bool

  }))

}