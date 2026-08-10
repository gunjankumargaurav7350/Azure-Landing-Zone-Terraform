variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "private_endpoints" {

  type = map(object({

    name                           = string
    subnet_id                      = string
    private_connection_resource_id = string
    subresource_names              = list(string)
    private_dns_zone_ids           = list(string)

  }))

}