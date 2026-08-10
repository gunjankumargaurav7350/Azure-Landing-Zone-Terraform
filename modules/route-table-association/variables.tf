variable "associations" {

  description = "Subnet Route Table Associations"

  type = map(object({

    subnet_id      = string
    route_table_id = string

  }))

}