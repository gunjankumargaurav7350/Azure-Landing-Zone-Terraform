output "private_endpoint_id" {
  value = {
    for key, value in azurerm_private_endpoint.this :
    key => value.id
  }
}