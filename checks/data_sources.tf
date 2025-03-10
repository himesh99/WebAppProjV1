# data "azurerm_app_service" "webapp" {
#   name                = "wordpress-webapp-${var.environment}"
#   resource_group_name = var.resource_group_hp
# }

# data "azurerm_virtual_network" "webapp" {
#   name                = "vnet-shared-uksouth-${var.environment}"
#   resource_group_name = var.resource_group_hp
# }

# data "azurerm_key_vault" "webapp" {
#   name                = "kv-${var.environment}-uks"
#   resource_group_name = var.resource_group_hp
# }