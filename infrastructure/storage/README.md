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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.blob_contributors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.blob_readers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.storage_blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | (Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | (Optional) Defines the Kind of account. | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | (Optional) Defines the type of replication to use for this storage account. | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | (Optional) Defines the Tier to use for this storage account. | `string` | `"Premium"` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | (Required) Specifies if the resource group must be created or not. | `bool` | n/a | yes |
| <a name="input_enable_https_traffic_only"></a> [enable\_https\_traffic\_only](#input\_enable\_https\_traffic\_only) | (Optional) Boolean flag which forces HTTPS if enabled. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the container registry. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether the public network access is enabled? | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the container registry. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_storage_blob_contributors_ids"></a> [storage\_blob\_contributors\_ids](#input\_storage\_blob\_contributors\_ids) | (Optional) List of blob storage contributors (object ids). Grant read/write/delete permissions. | `list(string)` | `[]` | no |
| <a name="input_storage_blob_network_rules_bypass"></a> [storage\_blob\_network\_rules\_bypass](#input\_storage\_blob\_network\_rules\_bypass) | (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None. | `list(string)` | <pre>[<br>  "None"<br>]</pre> | no |
| <a name="input_storage_blob_readers_ids"></a> [storage\_blob\_readers\_ids](#input\_storage\_blob\_readers\_ids) | (Optional) List of blob storage readers (object ids). Grant read-only permissions. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | <pre>{<br>  "environment": "test",<br>  "owner": "ntt"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_blob_connection_string"></a> [primary\_blob\_connection\_string](#output\_primary\_blob\_connection\_string) | The connection string associated with the primary blob location. |
| <a name="output_secondary_blob_connection_string"></a> [secondary\_blob\_connection\_string](#output\_secondary\_blob\_connection\_string) | The connection string associated with the secondary blob location. |
| <a name="output_storage_blob_primary_host"></a> [storage\_blob\_primary\_host](#output\_storage\_blob\_primary\_host) | The hostname with port if applicable for blob storage in the primary location. |
| <a name="output_storage_blob_primary_url"></a> [storage\_blob\_primary\_url](#output\_storage\_blob\_primary\_url) | The endpoint URL for blob storage in the primary location. |
| <a name="output_storage_blob_secondary_host"></a> [storage\_blob\_secondary\_host](#output\_storage\_blob\_secondary\_host) | The hostname with port if applicable for blob storage in the secondary location. |
| <a name="output_storage_blob_secondary_url"></a> [storage\_blob\_secondary\_url](#output\_storage\_blob\_secondary\_url) | The endpoint URL for blob storage in the secondary location. |
| <a name="output_storage_primary_access_key"></a> [storage\_primary\_access\_key](#output\_storage\_primary\_access\_key) | The hostname with port if applicable for blob storage in the secondary location. |
| <a name="output_storage_primary_connection_string"></a> [storage\_primary\_connection\_string](#output\_storage\_primary\_connection\_string) | The connection string associated with the primary location. |
| <a name="output_storage_secondary_access_key"></a> [storage\_secondary\_access\_key](#output\_storage\_secondary\_access\_key) | The hostname with port if applicable for blob storage in the secondary location. |
| <a name="output_storage_secondary_connection_string"></a> [storage\_secondary\_connection\_string](#output\_storage\_secondary\_connection\_string) | The connection string associated with the secondary location. |
<!-- END_TF_DOCS -->