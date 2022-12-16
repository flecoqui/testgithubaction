##################################
# Azure Resource Group variables #
##################################

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of an existing Resource Group"
}

variable "location" {
  type        = string
  description = "(Required) Define the region the Azure Key Vault should be created, you should use the Resource Group location"
}

variable "create_resource_group" {
  type        = bool
  default     = false
  description = "(Optional) If the resource group is to be created or not"
}

#############################
# Azure Key Vault variables #
#############################

variable "name" {
  type        = string
  description = "(Required) The name of the Azure Key Vault"
}

variable "sku_name" {
  type        = string
  description = "(Optional) Select Standard or Premium SKU"
  default     = "standard"
}

variable "key_vault_network_acls_bypass" {
  type        = string
  default     = "None"
  description = "(Required) Specifies which traffic can bypass the network rules. Possible values are 'AzureServices' and 'None'."

  validation {
    condition     = contains(["AzureServices", "None"], var.key_vault_network_acls_bypass)
    error_message = "Allowed values for input_parameter are \"AzureServices\" or \"None\"."
  }
}

variable "enabled_for_deployment" {
  type        = bool
  description = "(Optional) Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault. Must be defined to \"false\" when [key_vault_network_acls_bypass=\"None\"]."
  default     = false
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "(Optional) Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys. Must be defined to \"false\" when [key_vault_network_acls_bypass=\"None\"]."
  default     = false
}

variable "enabled_for_template_deployment" {
  type        = bool
  description = "(Optional) Allow Azure Resource Manager to retrieve secrets from the Azure Key Vault. Must be defined to \"false\" when [key_vault_network_acls_bypass=\"None\"]."
  default     = false
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
  default     = false
}

variable "purge_protection_enabled" {
  type        = bool
  description = "(Optional) Is Purge Protection enabled for this Key Vault?"
  default     = false
}

variable "soft_delete_enabled" {
  type        = bool
  description = "(Optional) Should Soft Delete be enabled for this Key Vault?"
  default     = true
}

variable "soft_delete_retention_days" {
  type        = number
  description = "(Optional) The number of days that items should be retained for once soft-deleted."
  default     = 90
}

variable "key_vault_key_permissions_full" {
  type        = list(string)
  description = "(Optional) List of full key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey."
  default     = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"]
}

variable "key_vault_secret_permissions_full" {
  type        = list(string)
  description = "(Optional) List of full secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set."
  default     = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
}

variable "key_vault_certificate_permissions_full" {
  type        = list(string)
  description = "(Optional) List of full certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update."
  default     = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
}

variable "key_vault_storage_permissions_full" {
  type        = list(string)
  description = "(Optional) List of storage permissions, must be one or more from the following: `Backup`, `Delete`, `DeleteSAS`, `Get`, `GetSAS`, `List`, `ListSAS`, `Purge`, `Recover`, `RegenerateKey`, `Restore`, `Set`, `SetSAS` and `Update`."
  default     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]
}

variable "key_vault_key_permissions_read" {
  type        = list(string)
  description = "(Optional) List of read key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey"
  default     = ["Get", "List"]
}

variable "key_vault_secret_permissions_read" {
  type        = list(string)
  description = "(Optional) List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["Get", "List"]
}

variable "key_vault_certificate_permissions_read" {
  type        = list(string)
  description = "(Optional) List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default     = ["Get", "GetIssuers", "List", "ListIssuers"]
}

variable "key_vault_storage_permissions_read" {
  type        = list(string)
  description = "(Optional) List of read storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update"
  default     = ["Get", "GetSAS", "List", "ListSAS"]
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "policies" {
  type = map(object({
    tenant_id               = string
    object_ids              = set(string)
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    storage_permissions     = list(string)
  }))
  description = "(Optional) Define a Azure Key Vault access policy."
  default     = {}
}

variable "secrets" {
  type = map(object({
    value = string
  }))
  description = "(Optional) Define Azure Key Vault secrets."
  default     = {}
}

