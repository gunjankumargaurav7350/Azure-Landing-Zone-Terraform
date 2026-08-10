variable "location" {

  type = string

}

variable "resource_group_name" {

  type = string

}

variable "tags" {

  type = map(string)

}

variable "virtual_machines" {

  type = map(object({

    name = string

    computer_name = string

    size = string

    zone = string

    admin_username = string

    public_key = string

    network_interface_id = string

    os_disk = object({

      caching = string

      storage_account_type = string

    })

    image = object({

      publisher = string

      offer = string

      sku = string

      version = string

    })

  }))

}