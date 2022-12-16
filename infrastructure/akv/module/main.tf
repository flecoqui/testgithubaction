#Key Vault RESOURCE GROUP
resource "azurerm_resource_group" "key_vault_resource_group_name" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create the Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  soft_delete_retention_days      = var.soft_delete_retention_days

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = var.sku_name
  tags      = var.tags

  network_acls {
    default_action = "Deny"
    bypass         = var.key_vault_network_acls_bypass
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create a Default Azure Key Vault access policy with Admin permissions
# This policy must be kept for a proper run of the "destroy" process
resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  lifecycle {
    create_before_destroy = true
  }

  key_permissions         = var.key_vault_key_permissions_full
  secret_permissions      = var.key_vault_secret_permissions_full
  certificate_permissions = var.key_vault_certificate_permissions_full
  storage_permissions     = var.key_vault_storage_permissions_full
}

# Create an Azure Key Vault READ/WRITE access policy
resource "azurerm_key_vault_access_policy" "read_write_policy" {
  for_each                = toset(var.policies.full.object_ids)
  object_id               = each.value
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = var.policies.full.tenant_id
  key_permissions         = var.policies.full.key_permissions
  secret_permissions      = var.policies.full.secret_permissions
  certificate_permissions = var.policies.full.certificate_permissions
  storage_permissions     = var.policies.full.storage_permissions
}

# Create an Azure Key Vault READ ONLY access policy
resource "azurerm_key_vault_access_policy" "read_only_policy" {
  for_each                = toset(var.policies.read.object_ids)
  object_id               = each.value
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = var.policies.read.tenant_id
  key_permissions         = var.policies.read.key_permissions
  secret_permissions      = var.policies.read.secret_permissions
  certificate_permissions = var.policies.read.certificate_permissions
  storage_permissions     = var.policies.read.storage_permissions
}

# Generate a random password
resource "random_password" "password" {
  for_each    = var.secrets
  length      = 20
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2

  keepers = {
    name = each.key
  }
}

# Create an Azure Key Vault secrets
resource "azurerm_key_vault_secret" "secret" {
  for_each     = var.secrets
  key_vault_id = azurerm_key_vault.key_vault.id
  name         = each.key
  value        = lookup(each.value, "value") != "" ? lookup(each.value, "value") : random_password.password[each.key].result
  tags         = var.tags
  depends_on = [
    azurerm_key_vault.key_vault,
    azurerm_key_vault_access_policy.default_policy,
  ]
}
