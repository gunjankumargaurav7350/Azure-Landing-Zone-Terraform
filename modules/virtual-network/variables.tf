variable "name" {

  description = "Virtual Network Name"

  type = string

}

variable "location" {

  description = "Azure Region"

  type = string

}

variable "resource_group_name" {

  description = "Resource Group Name"

  type = string

}

variable "address_space" {

  description = "VNet Address Space"

  type = list(string)

}

variable "dns_servers" {

  description = "Custom DNS Servers"

  type = list(string)

  default = []

}

variable "tags" {

  description = "Tags"

  type = map(string)

  default = {}

}