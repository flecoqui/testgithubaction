output "postgresql_server_fqdn" {
  value = module.postgresql_server.postgresql_server_fqdn
}

output "postgresql_server_login" {
  value = module.postgresql_server.postgresql_server_login
}

output "postgresql_server_password" {
  value     = module.postgresql_server.postgresql_server_password
  sensitive = true
}


