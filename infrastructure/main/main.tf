locals {
  deploy_resource_group_name = format("rg%s%s%s", var.prefix, var.deployment_type, var.environment)
  tags                       = { "environment" : var.deployment_type, "deployment" : var.deployment_type }

  acr_sku_name      = "Standard"
  acr_admin_enabled = false

  akv_principals_read_write        = []
  akv_key_permissions_full         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"]
  akv_secret_permissions_full      = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
  akv_certificate_permissions_full = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
  akv_storage_permissions_full     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]
  akv_principals_read_only         = []
  akv_key_permissions_read         = ["Get", "List"]
  akv_secret_permissions_read      = ["Get", "List"]
  akv_certificate_permissions_read = ["Get", "GetIssuers", "List", "ListIssuers"]
  akv_storage_permissions_read     = ["Get", "GetSAS", "List", "ListSAS"]
  akv_secrets                      = {}

  pg_administrator_login     = "azureuser"
  pg_postgres_version        = 11
  pg_ha_enabled              = "Enabled"
  pg_storage_size_mb         = "32768"
  pg_availability_zone       = "1"
  pg_sku_name                = "GP_Gen5_4"
  pg_ssl_enforcement_enabled = true

}

data "azurerm_client_config" "current" {}

resource "random_string" "unique" {
  length  = 4
  special = false
  upper   = false
  numeric = false
}

#Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.deploy_resource_group_name
  location = var.location
}


module "acr" {
  source = "../acr/module"

  name                  = join("", ["acr", var.prefix, random_string.unique.result])
  create_resource_group = false
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  admin_enabled         = local.acr_admin_enabled
  sku_name              = local.acr_sku_name
  tags                  = local.tags

  depends_on = [
    azurerm_resource_group.rg
  ]
}


module "keyvault" {
  source              = "../akv/module"
  name                = join("-", ["akv", var.prefix, random_string.unique.result])
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  create_resource_group = false

  key_vault_network_acls_bypass   = local.akv_network_acls_bypass
  enabled_for_deployment          = local.akv_vm_deployment
  enabled_for_disk_encryption     = local.akv_disk_encryption
  enabled_for_template_deployment = local.akv_template_deployment

  policies = {
    full = {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_ids              = local.akv_principals_read_write
      key_permissions         = local.akv_key_permissions_full
      secret_permissions      = local.akv_secret_permissions_full
      certificate_permissions = local.akv_certificate_permissions_full
      storage_permissions     = local.akv_storage_permissions_full
    }
    read = {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_ids              = local.akv_principals_read_only
      key_permissions         = local.akv_key_permissions_read
      secret_permissions      = local.akv_secret_permissions_read
      certificate_permissions = local.akv_certificate_permissions_read
      storage_permissions     = local.akv_storage_permissions_read
    }
  }

  secrets = local.akv_secrets

  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "postgresql_server" {
  source = "../pg/module"

  server_name             = join("", ["pg", var.prefix, random_string.unique.result])
  create_resource_group   = false
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  administrator_login     = local.pg_administrator_login
  postgres_version        = local.pg_postgres_version
  ha_enabled              = local.pg_ha_enabled
  storage_size_mb         = local.pg_storage_size_mb
  availability_zone       = local.pg_availability_zone
  sku_name                = local.pg_sku_name
  ssl_enforcement_enabled = local.pg_ssl_enforcement_enabled

  depends_on = [
    azurerm_resource_group.rg
  ]
}

module "storage_blob" {
  source = "../storage/module"

  name                  = join("", ["st", var.prefix, random_string.unique.result])
  create_resource_group = false
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location

  depends_on = [
    azurerm_resource_group.rg
  ]
}
