locals {
  deploy_resource_group_name = format("rg%s%s%s", var.prefix, var.deployment_type, var.environment)
  acr_sku_name               = "Standard"
  acr_admin_enabled          = false
  tags                       = { "environment" : var.deployment_type, "deployment" : var.deployment_type }
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

  name                  = join("", [var.prefix, random_string.unique.result])
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

