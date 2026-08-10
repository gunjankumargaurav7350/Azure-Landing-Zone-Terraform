variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "firewalls" {

  type = map(object({

    name               = string
    sku_name           = string
    sku_tier           = string
    subnet_id          = string
    public_ip_id       = string
    firewall_policy_id = string

  }))

}

variable "tags" {
  type = map(string)
}