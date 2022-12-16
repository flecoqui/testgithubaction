variable "create_resource_group" {
  type        = bool
  description = "(Required) Specifies if the resource group must be created or not."
}

variable "server_name" {
  type        = string
  description = "(Required) Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = { "environment" : "test", "owner" : "ntt" }
}

variable "administrator_login" {
  type        = string
  description = "(Required) Administrator login."
}

variable "ha_enabled" {
  type        = string
  description = "(Required) Enable HA."

  validation {
    condition     = contains(["Enabled", "Disabled"], var.ha_enabled)
    error_message = "HA is not set to a valid option."
  }
}

variable "availability_zone" {
  type        = string
  description = "(Required) Availability Zone to use for the primary server."
}

variable "postgres_version" {
  type        = string
  description = "(Required) PostgreSQL version."

  validation {
    condition     = contains(["9.5", "9.6", "10", "10.0", "10.2", "11"], var.postgres_version)
    error_message = "Version is not set to a valid option."
  }
}

variable "sku_name" {
  type        = string
  description = "(Required) Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the `tier` + `family` + `cores` pattern (e.g. `B_Gen4_1`, `GP_Gen5_8`)."
}

variable "storage_size_mb" {
  type        = number
  description = "(Optional) Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 16777216 MB(16TB) for General Purpose/Memory Optimized SKUs."
  default     = 640000
}

variable "backup_retention_days" {
  type        = string
  description = "(Optional) Backup retention days for the server."
  default     = "7"
}

variable "geo_redundant_backup_enabled" {
  type        = bool
  description = "(Optional) Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not support for the Basic tier. Changing this forces a new resource to be created."
  default     = true
}

variable "auto_grow_enabled" {
  type        = bool
  description = "(Optional) Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. "
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether or not public network access is allowed for this server."
  default     = true
}

variable "ssl_enforcement_enabled" {
  type        = bool
  description = " (Required) Specifies if SSL should be enforced on connections."
}

variable "ssl_minimal_tls_version_enforced" {
  type        = string
  description = "(Optional) The minimum TLS version to support on the sever. Possible values are `TLSEnforcementDisabled`, `TLS1_0`, `TLS1_1`, and `TLS1_2`. Defaults to `TLS1_2`."
  default     = "TLS1_2"
}
