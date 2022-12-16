output "acr_url" {
  description = "The URL that can be used to log into the container registry."
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  value       = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
  value       = azurerm_container_registry.acr.admin_password
}

output "acr_resource_id" {
  description = "The resource ID for the ACR Instance."
  value       = azurerm_container_registry.acr.id
}
