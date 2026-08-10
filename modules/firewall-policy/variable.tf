variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "firewall_policies" {

  type = map(object({

    name = string

    sku = string

  }))

}