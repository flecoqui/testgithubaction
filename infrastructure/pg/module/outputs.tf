output "postgresql_server_fqdn" {
  description = "The FQDN of the PostgreSQL Server."
  value       = azurerm_postgresql_server.db.fqdn
}

output "postgresql_server_login" {
  description = "The PostgreSQL Server Administrator Login"
  value       = azurerm_postgresql_server.db.administrator_login
}

output "postgresql_server_password" {
  description = "The PostgreSQL Server Administrator Password"
  value       = azurerm_postgresql_server.db.administrator_login_password
  sensitive   = true
}
