variable "create_resource_group" {
  type        = bool
  description = "(Required) Specifies if the resource group must be created or not."
}

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the container registry. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the container registry. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "account_kind" {
  type        = string
  description = "(Optional) Defines the Kind of account."
  default     = "StorageV2"

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "Account Kind is not set to a valid option."
  }
}

variable "account_tier" {
  type        = string
  description = "(Optional) Defines the Tier to use for this storage account."
  default     = "Premium"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account Tier is not set to a valid option."
  }
}

variable "account_replication_type" {
  type        = string
  description = "(Optional) Defines the type of replication to use for this storage account."
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "Account replication type is not set to a valid option."
  }
}

variable "access_tier" {
  type        = string
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts."
  default     = "Hot"

  validation {
    condition     = contains(["Hot", "Cool"], var.access_tier)
    error_message = "Account access tier is not set to a valid option."
  }
}

variable "enable_https_traffic_only" {
  type        = bool
  description = "(Optional) Boolean flag which forces HTTPS if enabled."
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether the public network access is enabled?"
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = { "environment" : "test", "owner" : "ntt" }
}

variable "storage_blob_network_rules_bypass" {
  type        = list(string)
  description = "(Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  default     = ["None"]
}

variable "storage_blob_contributors_ids" {
  type        = list(string)
  description = "(Optional) List of blob storage contributors (object ids). Grant read/write/delete permissions."
  default     = []
}

variable "storage_blob_readers_ids" {
  type        = list(string)
  description = "(Optional) List of blob storage readers (object ids). Grant read-only permissions."
  default     = []
}
