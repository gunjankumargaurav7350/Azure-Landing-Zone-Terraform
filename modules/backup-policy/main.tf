resource "azurerm_backup_policy_vm" "this" {

  for_each = var.backup_policies

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name

  timezone = each.value.timezone

  backup {

    frequency = each.value.frequency
    time      = each.value.time

  }

  retention_daily {

    count = each.value.retention_daily

  }

}