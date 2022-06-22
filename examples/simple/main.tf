module "acr" {
  source = "../../"
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