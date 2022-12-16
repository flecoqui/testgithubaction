output "acr_url" {
  description = "The URL that can be used to log into the container registry."
  value       = module.acr.acr_url
}

output "acr_admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  value       = module.acr.acr_admin_username
}

output "acr_admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
  value       = module.acr.acr_admin_password
  sensitive   = true
}

output "acr_resource_id" {
  description = "The resource ID for the ACR Instance."
  value       = module.acr.acr_resource_id
}
