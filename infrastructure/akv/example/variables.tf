variable "create_resource_group" {
  type        = bool
  default     = false
  description = "(Optional) If the resource group is to be created or not"
}

variable "key_vault_name" {
  type        = string
  description = "(Required) Key Vault name where secrets are stored"
}

variable "key_vault_resource_group_region" {
  description = "(Optional) The Azure Region in which all resources in this module should be provisioned"
  type        = string
  default     = "North Europe"
}

variable "key_vault_resource_group_name_prefix" {
  type        = string
  description = "(Required) Key Vault resource group name where Key Vault is deployed"
  default     = "rg-ntt"
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

variable "key_vault_vm_deployment" {
  type        = bool
  description = "(Optional) Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault. Must be defined to \"false\" when [key_vault_network_acls_bypass=\"None\"]."
  default     = false
}

variable "key_vault_disk_encryption" {
  type        = bool
  description = "(Optional) Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys. Must be defined to \"false\" when [key_vault_network_acls_bypass=\"None\"]."
  default     = false
}

variable "key_vault_template_deployment" {
  type        = bool
  description = "(Optional) Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault. Must be defined to \"false\" when [key_vault_network_acls_bypass=\"None\"]."
  default     = false
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

variable "key_vault_secrets" {
  type = map(object({
    value = string
  }))
  description = "(Optional) Define Azure Key Vault secrets"
  default     = {}
}

variable "key_vault_principals_read_write" {
  type        = list(string)
  description = "(Optional) List of objects IDs of users, service principals or security groups in the Azure Active Directory tenant for the vault that will be granted READ/WRITE access level."
  default     = []
}

variable "key_vault_principals_read_only" {
  type        = list(string)
  description = "(Optional) List of objects IDs of users, service principals or security groups in the Azure Active Directory tenant for the vault that will be granted READ ONLY access leve."
  default     = []
}
