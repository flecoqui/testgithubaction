output "key_vault_id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.key_vault.id
}

output "key_vault_name" {
  description = "Key Vault Name"
  value       = azurerm_key_vault.key_vault.name
}

output "key_vault_subscription_id" {
  description = "Key Vault Subscription ID"
  value       = data.azurerm_client_config.current.subscription_id
}

output "key_vault_rg" {
  description = "Key Vault Resource Group Name"
  value       = azurerm_key_vault.key_vault.resource_group_name
}

output "key_vault_url" {
  description = "Key Vault URI"
  value       = azurerm_key_vault.key_vault.vault_uri
}

output "key_vault_secrets" {
  description = "Key Vault created Secrets"
  value       = values(azurerm_key_vault_secret.secret)
}

output "key_vault_policies" {
  value = [azurerm_key_vault_access_policy.read_write_policy, azurerm_key_vault_access_policy.read_only_policy]
}