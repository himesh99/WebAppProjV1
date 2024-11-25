data "azurerm_app_service" "webapp" {
  name                = "webapp-deployment-${var.environment}-001"
  resource_group_name = var.resource_group_hp
}

data "azurerm_virtual_network" "webapp" {
  name                = "vnet-shared-uksouth-${var.environment}-001"
  resource_group_name = var.resource_group_hp
}

data "azurerm_sql_database" "webapp" {
  name                = "sqldb-webapp-${var.environment}"
  resource_group_name = var.resource_group_hp

}