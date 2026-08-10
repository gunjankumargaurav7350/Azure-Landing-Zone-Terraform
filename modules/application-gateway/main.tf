resource "azurerm_application_gateway" "this" {

  for_each = var.application_gateways

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {

    name     = each.value.sku_name
    tier     = each.value.sku_tier
    capacity = each.value.capacity

  }

  gateway_ip_configuration {

    name      = "gateway-ip-config"
    subnet_id = each.value.subnet_id

  }

  frontend_ip_configuration {

    name                 = "frontend-ip"
    public_ip_address_id = each.value.public_ip_id

  }

  frontend_port {

    name = "http-port"
    port = 80

  }

  backend_address_pool {

    name = "backend-pool"

  }

  backend_http_settings {

    name                  = "http-setting"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30

  }

  http_listener {

    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"

  }

  request_routing_rule {

    name                       = "http-rule"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-setting"
    priority                   = 100

  }

  tags = var.tags

}