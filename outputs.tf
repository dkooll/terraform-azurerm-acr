# output "acr" {
#   value = azurerm_container_registry.acr
# }

output "acr" {
  value = {
    for k, acr in azurerm_container_registry.acr : k => acr.id
  }
}