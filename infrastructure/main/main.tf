locals {
  deploy_resource_group_name = format("%s/%s", var.resource_group_name, var.environment)
}
provider "azurerm" {
  subscription_id = var.subscriptionId
  tenant_id       = var.tenantId
  features {
  }
}

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "resourcegroup" {
  name     = local.deploy_resource_group_name
  location = var.location
}
 