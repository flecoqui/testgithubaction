locals {
  deploy_resource_group_name = format("%s%s", var.resource_group_name, var.environment)
  acr_sku_name = "Standard"
  acr_admin_enabled = false
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

  name                  = join("", [var.acr_name_prefix, random_string.unique.result])
  create_resource_group = false
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  admin_enabled         = local.acr_admin_enabled
  sku_name              = local.acr_sku_name

  depends_on = [
    azurerm_resource_group.rg
  ]
}

