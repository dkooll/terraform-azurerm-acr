![example workflow](https://github.com/dkooll/terraform-azurerm-vnet/actions/workflows/validate.yml/badge.svg)

# Container registry

Terraform module which creates container registry resources on Azure.

The below features are made available:

- Multiple container registries
- Multiple replications on each registry
- Terratest is used to validate different integrations in [examples](examples)

The below examples shows the usage when consuming the module:

## Usage: single container registry multiple replications

```hcl
module "acr" {
  source = "github.com/dkooll/terraform-azurerm-acr"
  registry = {
    acr1 = {
      config = { sku = "Premium", location = "westeurope", resourcegroup = "rg-acr-weu" }
      replications = {
        sea  = {
          location = "southeastasia"
          enable_redundancy = false
        }

        eus2 = {
          location = "eastus2"
          enable_redundancy = false
        }
      }
    }
  }
}
```

## Usage: multiple container registries

```hcl
module "acr" {
  source = "github.com/dkooll/terraform-azurerm-acr"
  registry = {
    acr1 = { config = { sku = "Premium", location = "westeurope", resourcegroup = "rg-acr-weu" }}
    acr2 = { config = { sku = "Premium", location = "eastus2", resourcegroup = "rg-acr-eus2" }}
  }
}
```

## Resources

| Name | Type |
| :-- | :-- |
| [azurerm_resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [random_string](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_container_registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_dns_servers) | resource |

## Inputs

| Name | Description | Type | Required |
| :-- | :-- | :-- | :-- |
| `registry` | describes vnet related configuration | object | yes |

## Outputs

| Name | Description |
| :-- | :-- |
| `acr` | contains all container registry config |

## Authors

Module is maintained by [Dennis Kool](https://github.com/dkooll) with help from [these awesome contributors](https://github.com/dkooll/terraform-azurerm-vnet/graphs/contributors).

## License

MIT Licensed. See [LICENSE](https://github.com/dkooll/terraform-azurerm-vnet/tree/master/LICENSE) for full details.