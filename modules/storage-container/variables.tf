variable "storage_containers" {

  description = "Storage Containers"

  type = map(object({

    name = string

    storage_account_id = string

    container_access_type = string

  }))

}