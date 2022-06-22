provider "azurerm" {
  features {}
}

#----------------------------------------------------------------------------------------
# Resourcegroups
#----------------------------------------------------------------------------------------

resource "azurerm_resource_group" "rg" {
  for_each = var.registry

  name     = each.value.config.resourcegroup
  location = each.value.config.location
}

#----------------------------------------------------------------------------------------
# Generate random id
#----------------------------------------------------------------------------------------

resource "random_string" "random" {
  for_each = var.registry

  length    = 8
  min_lower = 8
  special   = false
  numeric   = false
  upper     = false
}

#----------------------------------------------------------------------------------------
# Container registry
#----------------------------------------------------------------------------------------

resource "azurerm_container_registry" "acr" {
  for_each = var.registry

  name                = "acr${random_string.random[each.key].result}"
  resource_group_name = azurerm_resource_group.rg[each.key].name
  location            = each.value.config.location
  sku                 = each.value.config.sku
  admin_enabled       = true

  dynamic "georeplications" {
    for_each = try(each.value.replications, {})

    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.enable_redundancy
    }
  }
}