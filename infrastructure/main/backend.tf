provider "azurerm" {
  subscription_id = var.subscriptionId
  tenant_id       = var.tenantId
  features {
  }
}

terraform {
  backend "azurerm" {
  }
}

