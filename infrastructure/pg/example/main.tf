resource "random_string" "unique" {
  length  = 4
  special = false
  upper   = false
  numeric = false
}

resource "azurerm_resource_group" "rg" {
  name     = join("", [var.rg_name_prefix, random_string.unique.result])
  location = var.rg_location
}

module "postgresql_server" {
  source = "../module"

  server_name             = join("", [var.server_name_prefix, random_string.unique.result])
  create_resource_group   = false
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  administrator_login     = var.administrator_login
  postgres_version        = var.postgres_version
  ha_enabled              = var.ha_enabled
  storage_size_mb         = var.storage_size_mb
  availability_zone       = var.availability_zone
  sku_name                = var.sku_name
  ssl_enforcement_enabled = var.ssl_enforcement_enabled

  depends_on = [
    azurerm_resource_group.rg
  ]
}
