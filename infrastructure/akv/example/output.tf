output "key_vault_id" {
  description = "Key Vault ID"
  value       = module.keyvault.key_vault_id
}

output "key_vault_name" {
  description = "Key Vault Name"
  value       = module.keyvault.key_vault_name
}

output "key_vault_subscription_id" {
  description = "Key Vault Subscription ID"
  value       = module.keyvault.key_vault_subscription_id
}

output "key_vault_rg" {
  description = "Key Vault Resource Group Name"
  value       = module.keyvault.key_vault_rg
}

output "key_vault_url" {
  description = "Key Vault URL"
  value       = module.keyvault.key_vault_url
}

output "key_vault_secrets" {
  description = "Key Vault created Secrets"
  value       = module.keyvault.key_vault_secrets
}

output "key_vault_policies" {
  value = module.keyvault.key_vault_policies
}
