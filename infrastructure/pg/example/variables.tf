variable "server_name_prefix" {
  description = "The prefix name of the PostgreSQL Server"
  default     = "pgntt"
}

variable "administrator_login" {
  description = "The administrator login for PostgreSQL"
  default     = "azureuser"
}

variable "postgres_version" {
  description = "The PostgreSQL major version"
  default     = "11"
}

variable "sku_name" {
  description = "The PostgreSQL SKU Name"
  default     = "GP_Gen5_4"
}

variable "ha_enabled" {
  description = "Enable High Availability"
  default     = "Enabled"
}

variable "storage_size_mb" {
  description = "Storage size for PostgreSQL"
  default     = "32768"
}

variable "availability_zone" {
  description = "Availability zone for the primary server"
  default     = "1"
}

variable "rg_name_prefix" {
  description = "The prefix name of the resource group"
  default     = "rg-ntt"
}

variable "rg_location" {
  description = "The location where resource group will be deployed"
  default     = "westeurope"
}

variable "ssl_enforcement_enabled" {
  description = "Specifies if SSL should be enforced on connections."
  default     = true
}
