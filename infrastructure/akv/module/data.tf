data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "key_vault_resource_group_name" {
  count = var.create_resource_group ? 0 : 1
  name  = var.resource_group_name
}
