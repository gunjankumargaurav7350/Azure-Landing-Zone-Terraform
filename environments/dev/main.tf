module "resource_groups" {

  source = "../../modules/resource-group"

  for_each = local.resource_groups

  name     = each.value.name
  location = local.location
  tags     = local.common_tags

}

module "virtual_network" {

  source = "../../modules/virtual-network"

  name = local.virtual_network.name

  location = local.location

  resource_group_name = module.resource_groups["network"].name

  address_space = local.virtual_network.address_space

  dns_servers = local.virtual_network.dns_servers

  tags = local.common_tags

}

module "subnet" {

  source = "../../modules/subnet"

  resource_group_name = module.resource_groups["network"].name

  virtual_network_name = module.virtual_network.vnet_name

  subnets = local.subnets

}

module "network_security_group" {

  source = "../../modules/network-security-group"

  location = local.location

  resource_group_name = module.resource_groups["network"].name

  network_security_groups = local.network_security_groups

  tags = local.common_tags

}

module "nsg_association" {

  source = "../../modules/nsg-association"

  associations = {

    vm = {

      subnet_id = module.subnet.subnet_ids["vm"]

      network_security_group_id = module.network_security_group.nsg_id["vm"]

    }

    appgw = {

      subnet_id = module.subnet.subnet_ids["appgw"]

      network_security_group_id = module.network_security_group.nsg_id["appgw"]

    }

    private_endpoint = {

      subnet_id = module.subnet.subnet_ids["private-endpoint"]

      network_security_group_id = module.network_security_group.nsg_id["private_endpoint"]

    }

  }

}

module "route_table" {

  source = "../../modules/route-table"

  location            = local.location
  resource_group_name = module.resource_groups["network"].name

  route_tables = {
    for key, value in local.route_tables :
    key => merge(value, {
      routes = [
        for route in value.routes :
        merge(route, {
          next_hop_in_ip_address = route.name == "default-to-firewall" ? module.azure_firewall.firewall_private_ip["primary"] : route.next_hop_in_ip_address
        })
      ]
    })
  }

  tags = local.common_tags
}
module "route_table_association" {

  source = "../../modules/route-table-association"

  associations = {

    vm = {

      subnet_id = module.subnet.subnet_ids["vm"]

      route_table_id = module.route_table.route_table_id["vm"]

    }

    appgw = {

      subnet_id = module.subnet.subnet_ids["appgw"]

      route_table_id = module.route_table.route_table_id["appgw"]

    }

    private-endpoint = {

      subnet_id = module.subnet.subnet_ids["private-endpoint"]

      route_table_id = module.route_table.route_table_id["private-endpoint"]

    }

  }

}

module "public_ip" {

  source = "../../modules/public-ip"

  location = local.location

  resource_group_name = module.resource_groups["network"].name

  public_ips = local.public_ips

  tags = local.common_tags

}

module "network_interface" {

  source = "../../modules/network-interface"

  location = local.location

  resource_group_name = module.resource_groups["compute"].name

  network_interfaces = {

    for key, value in local.network_interfaces :

    key => merge(value, {

      subnet_id = module.subnet.subnet_ids["vm"]

      public_ip_address_id = null

    })

  }

  tags = local.common_tags

}


module "linux_vm" {

  source = "../../modules/linux-vm"

  location = local.location

  resource_group_name = module.resource_groups["compute"].name

  virtual_machines = {

    for key, value in local.linux_virtual_machines :

    key => merge(value, {

      network_interface_id = module.network_interface.network_interface_id["linux"]

    })

  }

  tags = local.common_tags

}

module "managed_identity" {

  source = "../../modules/managed-identity"

  location = local.location

  resource_group_name = module.resource_groups["security"].name

  identities = local.managed_identities

  tags = local.common_tags

}


module "application_gateway" {

  source = "../../modules/application-gateway"

  location = local.location

  resource_group_name = module.resource_groups["network"].name

  application_gateways = {

    for key, value in local.application_gateways :

    key => merge(value, {

      subnet_id = module.subnet.subnet_ids["appgw"]

      public_ip_id = module.public_ip.public_ip_id["appgw"]

    })

  }

  tags = local.common_tags

}


module "storage_account" {

  source = "../../modules/storage-account"

  location = local.location

  resource_group_name = module.resource_groups["storage"].name

  storage_accounts = local.storage_accounts

  tags = local.common_tags

}

module "storage_container" {

  source = "../../modules/storage-container"

  storage_containers = {

    for key, value in local.storage_containers :

    key => merge(value, {

      storage_account_id = module.storage_account.storage_account_id["terraform"]

    })

  }

}

module "key_vault" {

  source = "../../modules/key-vault"

  location = local.location

  resource_group_name = module.resource_groups["security"].name

  tenant_id = var.tenant_id

  key_vaults = local.key_vaults

  tags = local.common_tags

}

module "firewall_policy" {

  source = "../../modules/firewall-policy"

  location = local.location

  resource_group_name = module.resource_groups["network"].name

  firewall_policies = local.firewall_policies

  tags = local.common_tags
}


module "azure_firewall" {

  source = "../../modules/azure-firewall"

  location = local.location

  resource_group_name = module.resource_groups["network"].name

  firewalls = {

    for key, value in local.firewalls :

    key => merge(value, {

      subnet_id = module.subnet.subnet_ids["firewall"]

      public_ip_id = module.public_ip.public_ip_id["firewall"]

      firewall_policy_id = module.firewall_policy.firewall_policy_id["primary"]

    })

  }

  tags = local.common_tags

}

module "private_dns" {

  source = "../../modules/private-dns"

  resource_group_name = module.resource_groups["network"].name

  virtual_network_id = module.virtual_network.vnet_id

  private_dns_zones = local.private_dns_zones

  tags = local.common_tags

}
module "private_endpoint" {

  source = "../../modules/private-endpoint"

  location = local.location

  resource_group_name = module.resource_groups["network"].name

  private_endpoints = {

    keyvault = {

      name = local.private_endpoints.keyvault.name

      subnet_id = module.subnet.subnet_ids["private-endpoint"]

      private_connection_resource_id = module.key_vault.key_vault_id["primary"]

      subresource_names = local.private_endpoints.keyvault.subresource_names

      private_dns_zone_ids = [

        module.private_dns.private_dns_zone_id["keyvault"]

      ]

    }

    storage = {

      name = local.private_endpoints.storage.name

      subnet_id = module.subnet.subnet_ids["private-endpoint"]

      private_connection_resource_id = module.storage_account.storage_account_id["terraform"]

      subresource_names = local.private_endpoints.storage.subresource_names

      private_dns_zone_ids = [

        module.private_dns.private_dns_zone_id["storage"]

      ]

    }

  }

  tags = local.common_tags

}

module "acr" {

  source = "../../modules/acr"

  location = local.location

  resource_group_name = module.resource_groups["compute"].name

  container_registries = local.container_registries

  tags = local.common_tags

}
module "aks" {

  source = "../../modules/aks"

  location = local.location

  resource_group_name = module.resource_groups["compute"].name

  aks_clusters = {

    for key, value in local.aks_clusters :

    key => merge(value, {

      log_analytics_workspace_id = module.log_analytics.workspace_id["primary"]

      default_node_pool = merge(

        value.default_node_pool,

        {

          vnet_subnet_id = module.subnet.subnet_ids["vm"]

        }

      )

    })

  }

  tags = local.common_tags

}

module "log_analytics" {

  source = "../../modules/log-analytics"

  location = local.location

  resource_group_name = module.resource_groups["monitoring"].name

  log_analytics_workspaces = local.log_analytics_workspaces

  tags = local.common_tags

}

module "role_assignment" {

  source = "../../modules/role-assignment"

  role_assignments = {

    acr_pull = {

      scope = module.acr.acr_id["primary"]

      role_definition_name = local.role_assignments.acr_pull.role_definition_name

      principal_id = module.managed_identity.principal_id["vm"]

    }

    keyvault_secrets_user = {

      scope = module.key_vault.key_vault_id["primary"]

      role_definition_name = local.role_assignments.keyvault_secrets_user.role_definition_name

      principal_id = module.managed_identity.principal_id["vm"]

    }

  }

}

module "diagnostic_settings" {

  source = "../../modules/diagnostic-settings"

  diagnostic_settings = {

    keyvault = {

      name = local.diagnostic_settings.keyvault.name

      target_resource_id = module.key_vault.key_vault_id["primary"]

      log_analytics_workspace_id = module.log_analytics.workspace_id["primary"]

    }

    storage = {

      name = local.diagnostic_settings.storage.name

      target_resource_id = module.storage_account.storage_account_id["terraform"]

      log_analytics_workspace_id = module.log_analytics.workspace_id["primary"]

    }

    aks = {

      name = local.diagnostic_settings.aks.name

      target_resource_id = module.aks.aks_id["primary"]

      log_analytics_workspace_id = module.log_analytics.workspace_id["primary"]

    }

  }

}

module "action_group" {

  source = "../../modules/action-group"

  resource_group_name = module.resource_groups["monitoring"].name

  action_groups = local.action_groups

  tags = local.common_tags

}

module "monitor" {

  source = "../../modules/monitor"

  resource_group_name = module.resource_groups["monitoring"].name

  metric_alerts = {

    vm_cpu = {

      name = local.metric_alerts.vm_cpu.name

      scopes = [

        module.linux_vm.linux_vm_ids["agent"]

      ]

      description = local.metric_alerts.vm_cpu.description

      severity = local.metric_alerts.vm_cpu.severity

      frequency = local.metric_alerts.vm_cpu.frequency

      window_size = local.metric_alerts.vm_cpu.window_size

      metric_namespace = local.metric_alerts.vm_cpu.metric_namespace

      metric_name = local.metric_alerts.vm_cpu.metric_name

      aggregation = local.metric_alerts.vm_cpu.aggregation

      operator = local.metric_alerts.vm_cpu.operator

      threshold = local.metric_alerts.vm_cpu.threshold

      action_group_id = module.action_group.action_group_id["primary"]

    }

  }

  tags = local.common_tags

}
module "recovery_services_vault" {

  source = "../../modules/recovery-services-vault"

  location = local.location

  resource_group_name = module.resource_groups["monitoring"].name

  recovery_services_vaults = local.recovery_services_vaults

  tags = local.common_tags

}

module "backup_policy" {

  source = "../../modules/backup-policy"

  resource_group_name = module.resource_groups["monitoring"].name

  recovery_vault_name = module.recovery_services_vault.recovery_services_vault_name["primary"]

  backup_policies = local.backup_policies

}
module "vm_backup" {

  source = "../../modules/vm-backup"

  resource_group_name = module.resource_groups["monitoring"].name

  recovery_vault_name = module.recovery_services_vault.recovery_services_vault_name["primary"]

  protected_vms = {

    linux = {

      source_vm_id = module.linux_vm.linux_vm_ids["agent"]

      backup_policy_id = module.backup_policy.backup_policy_id["daily"]

    }

  }

}

module "bastion" {

  source = "../../modules/bastion"

  location = local.location

  resource_group_name = module.resource_groups["network"].name

  bastions = {

    primary = {

      name = local.bastions.primary.name

      sku = local.bastions.primary.sku

      subnet_id = module.subnet.subnet_ids["bastion"]

      public_ip_id = module.public_ip.public_ip_id["bastion"]

    }

  }

  tags = local.common_tags

}