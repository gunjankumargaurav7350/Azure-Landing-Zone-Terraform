variable "location" {

  type = string

}

variable "resource_group_name" {

  type = string

}

variable "tenant_id" {

  type = string

}

variable "tags" {

  type = map(string)

  default = {}

}

variable "key_vaults" {

  type = map(object({

    name = string

    sku_name = string

  }))

}