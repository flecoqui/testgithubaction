output "storage_blob_primary_url" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = module.storage_blob.storage_blob_primary_url
}

output "storage_blob_secondary_url" {
  description = "The endpoint URL for blob storage in the secondary location."
  value       = module.storage_blob.storage_blob_secondary_url
}

output "storage_blob_primary_host" {
  description = "The hostname with port if applicable for blob storage in the primary location."
  value       = module.storage_blob.storage_blob_primary_host
}

output "storage_blob_secondary_host" {
  description = "The hostname with port if applicable for blob storage in the secondary location."
  value       = module.storage_blob.storage_blob_secondary_host
}

output "storage_primary_access_key" {
  description = "The hostname with port if applicable for blob storage in the secondary location."
  value       = module.storage_blob.storage_primary_access_key
  sensitive   = true
}

output "storage_secondary_access_key" {
  description = "The hostname with port if applicable for blob storage in the secondary location."
  value       = module.storage_blob.storage_secondary_access_key
  sensitive   = true
}

output "storage_primary_connection_string" {
  description = "The connection string associated with the primary location."
  value       = module.storage_blob.storage_primary_connection_string
  sensitive   = true
}

output "storage_secondary_connection_string" {
  description = "The connection string associated with the secondary location."
  value       = module.storage_blob.storage_secondary_connection_string
  sensitive   = true
}

output "primary_blob_connection_string" {
  description = "The connection string associated with the primary blob location."
  value       = module.storage_blob.primary_blob_connection_string
  sensitive   = true
}

output "secondary_blob_connection_string" {
  description = "The connection string associated with the secondary blob location."
  value       = module.storage_blob.secondary_blob_connection_string
  sensitive   = true
}
