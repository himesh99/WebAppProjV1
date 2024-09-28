resource "azurerm_sql_database" "sqldb" {
  name                = "sqldb-webapp-001"
  resource_group_name = var.resource_group_hp
  location            = var.location
  server_name         = azurerm_sql_server.sqlsvr.name
  edition             = "Standard"
  requested_service_objective_name = "S1"
  tags                = var.tags
}