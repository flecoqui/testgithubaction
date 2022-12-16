data "azurerm_client_config" "current" {}

resource "random_string" "unique" {
  length  = 4
  special = false
  upper   = false
  numeric = false
}

resource "azurerm_resource_group" "rg" {
  name     = join("", [var.key_vault_resource_group_name_prefix, random_string.unique.result])
  location = var.key_vault_resource_group_region
}

#############
# key vault #
#############

module "keyvault" {
  source              = "../module"
  name                = join("-", [var.key_vault_name, random_string.unique.result])
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  create_resource_group = false

  key_vault_network_acls_bypass   = var.key_vault_network_acls_bypass
  enabled_for_deployment          = var.key_vault_vm_deployment
  enabled_for_disk_encryption     = var.key_vault_disk_encryption
  enabled_for_template_deployment = var.key_vault_template_deployment

  policies = {
    full = {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_ids              = var.key_vault_principals_read_write
      key_permissions         = var.key_vault_key_permissions_full
      secret_permissions      = var.key_vault_secret_permissions_full
      certificate_permissions = var.key_vault_certificate_permissions_full
      storage_permissions     = var.key_vault_storage_permissions_full
    }
    read = {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_ids              = var.key_vault_principals_read_only
      key_permissions         = var.key_vault_key_permissions_read
      secret_permissions      = var.key_vault_secret_permissions_read
      certificate_permissions = var.key_vault_certificate_permissions_read
      storage_permissions     = var.key_vault_storage_permissions_read
    }
  }

  secrets = var.key_vault_secrets

  depends_on = [
    azurerm_resource_group.rg
  ]
}
