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

resource "azurerm_storage_account" "storage_blob" {
  name                          = var.name
  resource_group_name           = var.create_resource_group ? azurerm_resource_group.rg[0].name : data.azurerm_resource_group.rg[0].name
  location                      = var.location
  account_kind                  = var.account_kind
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  access_tier                   = var.access_tier
  tags                          = var.tags
  enable_https_traffic_only     = var.enable_https_traffic_only
  public_network_access_enabled = var.public_network_access_enabled

  network_rules {
    default_action = "Deny"
    bypass         = var.storage_blob_network_rules_bypass
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_role_assignment" "blob_contributors" {
  count                = length(var.storage_blob_contributors_ids)
  scope                = azurerm_storage_account.storage_blob.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.storage_blob_contributors_ids[count.index]
}

resource "azurerm_role_assignment" "blob_readers" {
  count                = length(var.storage_blob_readers_ids)
  scope                = azurerm_storage_account.storage_blob.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = var.storage_blob_readers_ids[count.index]
}
