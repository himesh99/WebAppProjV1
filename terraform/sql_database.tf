resource "azurerm_mysql_database" "sqldb" {
  name                             = "sqldb-webapp-${var.environment}"
  resource_group_name              = var.resource_group_hp
  location                         = var.location
  server_name                      = azurerm_mysql_server.sqlsvr.name
  edition                          = "Standard"
  requested_service_objective_name = "S1"
  tags                             = var.tags
}