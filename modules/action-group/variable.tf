variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "action_groups" {

  type = map(object({

    name          = string
    short_name    = string
    email_address = string

  }))

}