variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "bastions" {

  type = map(object({

    name          = string
    sku           = string
    subnet_id     = string
    public_ip_id  = string

  }))

}