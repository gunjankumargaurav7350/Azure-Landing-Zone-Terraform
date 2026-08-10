resource "azurerm_bastion_host" "this" {

  for_each = var.bastions

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku = each.value.sku

  ip_configuration {

    name                 = "configuration"
    subnet_id            = each.value.subnet_id
    public_ip_address_id = each.value.public_ip_id

  }

  tags = var.tags

}