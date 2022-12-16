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

variable "prefix" {
  type        = string
  description = "(Required) deployment prefix"
  default     = "5gpoc"
}

variable "deployment_type" {
  type        = string
  description = "(Required) deployment type: cloud or edge"
  default     = "cloud"
}