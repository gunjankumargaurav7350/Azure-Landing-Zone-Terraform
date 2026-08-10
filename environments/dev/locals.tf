locals {

  environment = "dev"

  location = "Central India"

  common_tags = {

    Environment = local.environment
    Project     = "Volantis Cloud Platform"
    ManagedBy   = "Terraform"
    Owner       = "Gunjan kumar"
    CostCenter  = "IT"

  }

  resource_groups = {

    network = {

      name = "rg-vcp-network-dev"

    }

    compute = {

      name = "rg-vcp-compute-dev"

    }

    storage = {

      name = "rg-vcp-storage-dev"

    }

    security = {

      name = "rg-vcp-security-dev"

    }

    monitoring = {

      name = "rg-vcp-monitoring-dev"

    }

  }
  virtual_network = {

    name = "vnet-vcp-dev"

    address_space = [
      "10.10.0.0/16"
    ]

    dns_servers = []

  }

  subnets = {

    appgw = {

      name = "snet-appgw-dev"

      address_prefixes = [
        "10.10.1.0/24"
      ]

    }

    vm = {

      name = "snet-vm-dev"

      address_prefixes = [
        "10.10.2.0/24"
      ]

    }

    private-endpoint = {

      name = "snet-private-endpoint-dev"

      address_prefixes = [
        "10.10.3.0/24"
      ]

    }

    firewall = {

      # Azure ke liye naam exactly yehi hona chahiye
      name = "AzureFirewallSubnet"

      address_prefixes = [
        "10.10.10.0/26"
      ]

    }

    bastion = {

      name = "AzureBastionSubnet"

      address_prefixes = [
        "10.10.11.0/26"
      ]

    }

  }

  network_security_groups = {

    vm = {

      name = "nsg-vm-dev"

      security_rules = [

        {
          name                       = "Allow-SSH"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }

      ]
    }

    appgw = {

      name = "nsg-appgw-dev"

      security_rules = [

        {
          name                       = "Allow-HTTPS"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },

        {
          name                       = "Allow-AppGateway-Management"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "65200-65535"
          source_address_prefix      = "Internet"
          destination_address_prefix = "*"
        }

      ]
    }
    private_endpoint = {

      name = "nsg-private-endpoint-dev"

      security_rules = []

    }

  }

  route_tables = {

    vm = {

      name = "rt-vm-dev"

      bgp_route_propagation_enabled = true

      routes = [
        {
          name                   = "default-to-firewall"
          address_prefix         = "0.0.0.0/0"
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = null
        }
      ]
    }

    appgw = {

      name = "rt-appgw-dev"

      bgp_route_propagation_enabled = true

      routes = []
    }

    private-endpoint = {

      name = "rt-private-dev"

      bgp_route_propagation_enabled = true

      routes = []
    }
  }

  public_ips = {

    appgw = {

      name = "pip-appgw-dev"

      allocation_method = "Static"

      sku = "Standard"

      zones = ["1", "2", "3"]

    }

    bastion = {

      name = "pip-bastion-dev"

      allocation_method = "Static"

      sku = "Standard"

      zones = ["1", "2", "3"]

    }

    firewall = {

      name = "pip-firewall-dev"

      allocation_method = "Static"

      sku = "Standard"

      zones = ["1", "2", "3"]

    }


  }

  network_interfaces = {

    linux = {

      name = "nic-linux-dev"

      ip_configuration_name = "ipconfig1"

      private_ip_address_allocation = "Dynamic"

      private_ip_address = null

      enable_accelerated_networking = false

      enable_ip_forwarding = false

    }

    windows = {

      name = "nic-windows-dev"

      ip_configuration_name = "ipconfig1"

      private_ip_address_allocation = "Dynamic"

      private_ip_address = null

      enable_accelerated_networking = false

      enable_ip_forwarding = false

    }

  }
  linux_virtual_machines = {

    agent = {

      name = "vm-agent-dev"

      computer_name = "vm-agent-dev"

      size = "Standard_D2s_v5"


      zone = "1"

      admin_username = "azureuser"

      #  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
      public_key = file(pathexpand("~/.ssh/id_rsa.pub"))

      os_disk = {

        caching = "ReadWrite"

        storage_account_type = "StandardSSD_LRS"

      }

      image = {

        publisher = "Canonical"

        offer = "ubuntu-24_04-lts"

        sku = "server"

        version = "latest"

      }

    }

  }

  managed_identities = {

    vm = {

      name = "id-vm-dev"

    }

    app = {

      name = "id-app-dev"

    }

  }

  application_gateways = {

    primary = {

      name = "appgw-vcp-dev"

      sku_name = "Standard_v2"

      sku_tier = "Standard_v2"

      capacity = 2

    }

  }

  storage_accounts = {

    terraform = {

      name = "stvolantisdev001"

      account_tier = "Standard"

      account_replication_type = "LRS"

      account_kind = "StorageV2"

      access_tier = "Hot"

    }

  }

  storage_containers = {

    terraform = {

      name = "tfstate"

      container_access_type = "private"

    }

  }

  key_vaults = {

    primary = {

      name = "kv-volantis-dev-001"

      sku_name = "standard"

    }

  }

  firewall_policies = {

    primary = {

      name = "fw-policy-dev"

      sku = "Standard"

    }

  }

  firewalls = {

    primary = {

      name = "azfw-dev"

      sku_name = "AZFW_VNet"

      sku_tier = "Standard"

    }

  }

  private_dns_zones = {

    keyvault = {

      name = "privatelink.vaultcore.azure.net"

    }

    storage = {

      name = "privatelink.blob.core.windows.net"

    }

    acr = {

      name = "privatelink.azurecr.io"

    }

  }

  private_endpoints = {

    keyvault = {

      name = "pep-keyvault-dev"

      subresource_names = [
        "vault"
      ]

    }

    storage = {

      name = "pep-storage-dev"

      subresource_names = [
        "blob"
      ]

    }

  }

  container_registries = {

    primary = {

      name = "acrvcpdev001"

      sku = "Basic"

      admin_enabled = false

      public_network_access_enabled = true

    }

  }
  aks_clusters = {

    primary = {

      name = "aks-vcp-dev"

      dns_prefix = "aks-vcp-dev"

      kubernetes_version = "1.35.6"

      sku_tier = "Free"

      network_plugin = "azure"

      network_policy = "azure"

      load_balancer_sku = "standard"

      default_node_pool = {

        name = "system"

        vm_size = "Standard_D2s_v5"

        node_count = 1

        os_disk_size_gb = 64

      }

    }

  }

  log_analytics_workspaces = {

    primary = {

      name = "log-vcp-dev"

      sku = "PerGB2018"

      retention_in_days = 30

    }

  }

  role_assignments = {

    acr_pull = {

      role_definition_name = "AcrPull"

    }

    keyvault_secrets_user = {

      role_definition_name = "Key Vault Secrets User"

    }

  }

  diagnostic_settings = {

    keyvault = {

      name = "diag-keyvault"

    }

    storage = {

      name = "diag-storage"

    }

    aks = {

      name = "diag-aks"

    }

  }

  action_groups = {

    primary = {

      name = "ag-vcp-dev"

      short_name = "vcp"

      email_address = "gunjankumargaurav7@gmail.com"

    }

  }
  metric_alerts = {

    vm_cpu = {

      name = "vm-cpu-alert"

      description = "CPU Usage Greater Than 80%"

      severity = 2

      frequency = "PT5M"

      window_size = "PT5M"

      metric_namespace = "Microsoft.Compute/virtualMachines"

      metric_name = "Percentage CPU"

      aggregation = "Average"

      operator = "GreaterThan"

      threshold = 80

    }

  }

  recovery_services_vaults = {

    primary = {

      name = "rsv-vcp-dev"

      sku = "Standard"

      soft_delete_enabled = true

      storage_mode_type = "GeoRedundant"

      cross_region_restore_enabled = true

    }

  }

  backup_policies = {

    daily = {

      name = "daily-backup"

      timezone = "India Standard Time"

      frequency = "Daily"

      time = "23:00"

      retention_daily = 30

    }

  }

  bastions = {

    primary = {

      name = "bas-vcp-dev"

      sku = "Standard"

    }

  }
}
