## Azure Container Registry Module

This terraform module installs Azure Container Registy.

Main options: 

- Create resource group if needed
- Create azure container registry
- Set RBAC permissions for contributors and readers
    - If needed, access by using login/password can be enabled using `admin-enabled` option

### Use case:

```terraform
module "acr" {
  source = "../module"

  name                  = join("", [var.acr_name_prefix, random_string.unique.result])
  create_resource_group = false
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  admin_enabled         = var.admin_enabled
  sku_name              = var.sku_name

}
```

`admin_enabled` and `sku_name` are two mandatory fields to deploy the ACR.


### References

[Azure Container Registry roles and permissions](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-roles)