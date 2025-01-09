resource "azurerm_mysql_database" "sqldb" {
  name                = "sqldb-webapp-${var.environment}"
  resource_group_name = var.resource_group_hp
  server_name         = azurerm_mysql_server.sqlsvr.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}