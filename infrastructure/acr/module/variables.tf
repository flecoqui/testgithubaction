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

variable "admin_enabled" {
  type        = bool
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  default     = false
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = { "environment" : "test", "owner" : "ntt" }
}

variable "sku_name" {
  type        = string
  description = "(Required) The SKU name of the container registry. Possible values are `Basic`, `Standard` and `Premium`."
  default     = "Premium"
}

variable "acr_contributors_ids" {
  type        = list(string)
  description = "(Optional) List of container registry contributors (object ids)."
  default     = []
}

variable "acr_readers_ids" {
  type        = list(string)
  description = "(Optional) List of container registry readers (object ids)."
  default     = []
}

