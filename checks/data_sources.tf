data "azurerm_app_service" "webapp" {
  name                = "webapp-deployment-${var.environment}-001"
  resource_group_name = var.resource_group_hp
}

data "azurerm_virtual_network" "vnet" {
  name                = "vnet-shared-uksouth-${var.environment}-001"
  resource_group_name = var.resource_group_hp
}

data "azurerm_sql_database" "db" {
  name                = "sqldb-webapp-${var.environment}"
  resource_group_name = var.resource_group_hp
  server_name         = "sqlsvr-webapp-${var.environment}"

}