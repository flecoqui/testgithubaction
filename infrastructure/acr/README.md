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
| [azurerm_container_registry.acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.acr_contributors](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.acr_readers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_contributors_ids"></a> [acr\_contributors\_ids](#input\_acr\_contributors\_ids) | (Optional) List of container registry contributors (object ids). | `list(string)` | `[]` | no |
| <a name="input_acr_readers_ids"></a> [acr\_readers\_ids](#input\_acr\_readers\_ids) | (Optional) List of container registry readers (object ids). | `list(string)` | `[]` | no |
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | (Optional) Specifies whether the admin user is enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_create_resource_group"></a> [create\_resource\_group](#input\_create\_resource\_group) | (Required) Specifies if the resource group must be created or not. | `bool` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the container registry. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the container registry. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Required) The SKU name of the container registry. Possible values are `Basic`, `Standard` and `Premium`. | `string` | `"Premium"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | <pre>{<br>  "environment": "test",<br>  "owner": "ntt"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_admin_password"></a> [acr\_admin\_password](#output\_acr\_admin\_password) | The Password associated with the Container Registry Admin account - if the admin account is enabled. |
| <a name="output_acr_admin_username"></a> [acr\_admin\_username](#output\_acr\_admin\_username) | The Username associated with the Container Registry Admin account - if the admin account is enabled. |
| <a name="output_acr_resource_id"></a> [acr\_resource\_id](#output\_acr\_resource\_id) | The resource ID for the ACR Instance. |
| <a name="output_acr_url"></a> [acr\_url](#output\_acr\_url) | The URL that can be used to log into the container registry. |
<!-- END_TF_DOCS -->