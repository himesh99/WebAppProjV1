data "azurerm_app_service" "webapp" {
  name                = "wp-app-${var.environment}"
  resource_group_name = var.resource_group_hp
}

data "azurerm_virtual_network" "webapp" {
  name                = "vnet-shared-uks-${var.environment}"
  resource_group_name = var.resource_group_hp
}

data "azurerm_key_vault" "webapp" {
  name                = "kv-wp-uks-${var.environment}"
  resource_group_name = var.resource_group_hp
}