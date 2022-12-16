variable "rg_name_prefix" {
  description = "The prefix name of the resource group"
  default     = "rg-ntt"
}

variable "rg_location" {
  description = "The location where resource group will be deployed"
  default     = "westeurope"
}

variable "acr_name_prefix" {
  description = "The prefix name of the container registry"
  default     = "nttregistry"
}

variable "sku_name" {
  description = "The container registry SKU Name"
  default     = "Premium"
}

variable "admin_enabled" {
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to `false`."
  default     = true
}
