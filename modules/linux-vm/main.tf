resource "azurerm_linux_virtual_machine" "this" {

  for_each = var.virtual_machines

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = each.value.size

  admin_username = each.value.admin_username

  network_interface_ids = [
    each.value.network_interface_id
  ]

  disable_password_authentication = true

  admin_ssh_key {

    username   = each.value.admin_username
    public_key = each.value.public_key

  }

  os_disk {

    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type

  }

  source_image_reference {

    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version

  }

  computer_name = each.value.computer_name

  zone = each.value.zone

  tags = var.tags

}