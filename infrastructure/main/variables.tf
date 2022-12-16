variable "terraform_resource_group" {
  type        = string
  description = "(Required) The resource group where the terraform state is stored."
  default     = "rgtf5gpoc"
}

variable "terraform_storage_account" {
  type        = string
  description = "(Required) Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
  default     = "sttf5gpoc"
}

variable "terraform_storage_container" {
  type        = string
  description = "(Required) Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
  default     = "cotf5gpoc"
}

variable "terraform_storage_key" {
  type        = string
  description = "(Required) Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
  default     = "cotf5gpoc.tfstate"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
  default     = "rg5gpoc"
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = "eastus2"
}

variable "environment" {
  type        = string
  description = "(Required) environment variable : dev, test, prod."
  default     = "dev"
}
