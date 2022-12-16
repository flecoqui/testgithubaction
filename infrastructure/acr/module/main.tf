resource "azurerm_resource_group" "rg" {
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

resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.create_resource_group ? azurerm_resource_group.rg[0].name : data.azurerm_resource_group.rg[0].name
  location            = var.location
  sku                 = var.sku_name
  admin_enabled       = var.admin_enabled
  tags                = var.tags

  public_network_access_enabled = true

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_role_assignment" "acr_contributors" {
  count                = length(var.acr_contributors_ids)
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "Contributor"
  principal_id         = var.acr_contributors_ids[count.index]
}

resource "azurerm_role_assignment" "acr_readers" {
  count                = length(var.acr_readers_ids)
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "Reader"
  principal_id         = var.acr_readers_ids[count.index]
}
