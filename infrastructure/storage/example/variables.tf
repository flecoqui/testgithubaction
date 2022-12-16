variable "blob_storage_name_prefix" {
  description = "The prefix name of the container registry"
  default     = "storagentt"
}

variable "rg_name_prefix" {
  description = "The prefix name of the resource group"
  default     = "rg-ntt"
}

variable "rg_location" {
  description = "The location where resource group will be deployed"
  default     = "northeurope"
}
