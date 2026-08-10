variable "name" {

  description = "Azure Resource Group Name"

  type = string

}

variable "location" {

  description = "Azure Region"

  type = string

}

variable "tags" {

  description = "Tags to apply on Resource Group"

  type = map(string)

  default = {}

}