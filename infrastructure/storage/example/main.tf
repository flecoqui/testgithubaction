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

module "storage_blob" {
  source = "../module"

  name                  = join("", [var.blob_storage_name_prefix, random_string.unique.result])
  create_resource_group = false
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location

  depends_on = [
    azurerm_resource_group.rg
  ]
}
