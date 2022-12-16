<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.35.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.35.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.default_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.read_only_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.read_write_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_resource_group.key_vault_resource_group_name](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_resource_group.key_vault_resource_group_name](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | (Optional) If the resource group is to be created or not | `bool` | `false` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | (Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. | `bool` | `false` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | (Optional) Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault. Must be defined to "false" when [key\_vault\_network\_acls\_bypass="None"]. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | (Optional) Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys. Must be defined to "false" when [key\_vault\_network\_acls\_bypass="None"]. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | (Optional) Allow Azure Resource Manager to retrieve secrets from the Azure Key Vault. Must be defined to "false" when [key\_vault\_network\_acls\_bypass="None"]. | `bool` | `false` | no |
| <a name="input_key_vault_certificate_permissions_full"></a> [key\_vault\_certificate\_permissions\_full](#input\_key\_vault\_certificate\_permissions\_full) | (Optional) List of full certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update. | `list(string)` | <pre>[<br>  "Backup",<br>  "Create",<br>  "Delete",<br>  "DeleteIssuers",<br>  "Get",<br>  "GetIssuers",<br>  "Import",<br>  "List",<br>  "ListIssuers",<br>  "ManageContacts",<br>  "ManageIssuers",<br>  "Purge",<br>  "Recover",<br>  "Restore",<br>  "SetIssuers",<br>  "Update"<br>]</pre> | no |
| <a name="input_key_vault_certificate_permissions_read"></a> [key\_vault\_certificate\_permissions\_read](#input\_key\_vault\_certificate\_permissions\_read) | (Optional) List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update | `list(string)` | <pre>[<br>  "Get",<br>  "GetIssuers",<br>  "List",<br>  "ListIssuers"<br>]</pre> | no |
| <a name="input_key_vault_key_permissions_full"></a> [key\_vault\_key\_permissions\_full](#input\_key\_vault\_key\_permissions\_full) | (Optional) List of full key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey. | `list(string)` | <pre>[<br>  "Backup",<br>  "Create",<br>  "Decrypt",<br>  "Delete",<br>  "Encrypt",<br>  "Get",<br>  "Import",<br>  "List",<br>  "Purge",<br>  "Recover",<br>  "Restore",<br>  "Sign",<br>  "UnwrapKey",<br>  "Update",<br>  "Verify",<br>  "WrapKey"<br>]</pre> | no |
| <a name="input_key_vault_key_permissions_read"></a> [key\_vault\_key\_permissions\_read](#input\_key\_vault\_key\_permissions\_read) | (Optional) List of read key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey | `list(string)` | <pre>[<br>  "Get",<br>  "List"<br>]</pre> | no |
| <a name="input_key_vault_network_acls_bypass"></a> [key\_vault\_network\_acls\_bypass](#input\_key\_vault\_network\_acls\_bypass) | (Required) Specifies which traffic can bypass the network rules. Possible values are 'AzureServices' and 'None'. | `string` | `"None"` | no |
| <a name="input_key_vault_secret_permissions_full"></a> [key\_vault\_secret\_permissions\_full](#input\_key\_vault\_secret\_permissions\_full) | (Optional) List of full secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set. | `list(string)` | <pre>[<br>  "Backup",<br>  "Delete",<br>  "Get",<br>  "List",<br>  "Purge",<br>  "Recover",<br>  "Restore",<br>  "Set"<br>]</pre> | no |
| <a name="input_key_vault_secret_permissions_read"></a> [key\_vault\_secret\_permissions\_read](#input\_key\_vault\_secret\_permissions\_read) | (Optional) List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set | `list(string)` | <pre>[<br>  "Get",<br>  "List"<br>]</pre> | no |
| <a name="input_key_vault_storage_permissions_full"></a> [key\_vault\_storage\_permissions\_full](#input\_key\_vault\_storage\_permissions\_full) | (Optional) List of storage permissions, must be one or more from the following: `Backup`, `Delete`, `DeleteSAS`, `Get`, `GetSAS`, `List`, `ListSAS`, `Purge`, `Recover`, `RegenerateKey`, `Restore`, `Set`, `SetSAS` and `Update`. | `list(string)` | <pre>[<br>  "Backup",<br>  "Delete",<br>  "DeleteSAS",<br>  "Get",<br>  "GetSAS",<br>  "List",<br>  "ListSAS",<br>  "Purge",<br>  "Recover",<br>  "RegenerateKey",<br>  "Restore",<br>  "Set",<br>  "SetSAS",<br>  "Update"<br>]</pre> | no |
| <a name="input_key_vault_storage_permissions_read"></a> [key\_vault\_storage\_permissions\_read](#input\_key\_vault\_storage\_permissions\_read) | (Optional) List of read storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update | `list(string)` | <pre>[<br>  "Get",<br>  "GetSAS",<br>  "List",<br>  "ListSAS"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Define the region the Azure Key Vault should be created, you should use the Resource Group location | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Azure Key Vault | `string` | n/a | yes |
| <a name="input_policies"></a> [policies](#input\_policies) | (Optional) Define a Azure Key Vault access policy. | <pre>map(object({<br>    tenant_id               = string<br>    object_ids              = set(string)<br>    key_permissions         = list(string)<br>    secret_permissions      = list(string)<br>    certificate_permissions = list(string)<br>    storage_permissions     = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | (Optional) Is Purge Protection enabled for this Key Vault? | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of an existing Resource Group | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | (Optional) Define Azure Key Vault secrets. | <pre>map(object({<br>    value = string<br>  }))</pre> | `{}` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) Select Standard or Premium SKU | `string` | `"standard"` | no |
| <a name="input_soft_delete_enabled"></a> [soft\_delete\_enabled](#input\_soft\_delete\_enabled) | (Optional) Should Soft Delete be enabled for this Key Vault? | `bool` | `true` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | (Optional) The number of days that items should be retained for once soft-deleted. | `number` | `90` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | Key Vault ID |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | Key Vault Name |
| <a name="output_key_vault_policies"></a> [key\_vault\_policies](#output\_key\_vault\_policies) | n/a |
| <a name="output_key_vault_rg"></a> [key\_vault\_rg](#output\_key\_vault\_rg) | Key Vault Resource Group Name |
| <a name="output_key_vault_secrets"></a> [key\_vault\_secrets](#output\_key\_vault\_secrets) | Key Vault created Secrets |
| <a name="output_key_vault_subscription_id"></a> [key\_vault\_subscription\_id](#output\_key\_vault\_subscription\_id) | Key Vault Subscription ID |
| <a name="output_key_vault_url"></a> [key\_vault\_url](#output\_key\_vault\_url) | Key Vault URI |
<!-- END_TF_DOCS -->