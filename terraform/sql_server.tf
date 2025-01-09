locals {
  sql_server_username = "webappadministrator"
}

resource "random_password" "sqlpass" {
  length           = 12
  special          = true
  override_special = "_%@"
}

resource "azurerm_mysql_server" "sqlsvr" {
  name                         = "sqlsvr-webapp-${var.environment}"
  resource_group_name          = var.resource_group_hp
  location                     = var.location
  sku_name                     = "B_Gen4_1"
  version                      = "5.7"
  administrator_login          = local.sql_server_username
  administrator_login_password = random_password.sqlpass.result
  tags                         = var.tags
  ssl_enforcement_enabled      = false

}

# resource "azurerm_private_endpoint" "sql_private_endpoint" {
#   name                = "pe-sql-${var.environment}-uks"
#   location            = var.location
#   resource_group_name = var.resource_group_hp
#   subnet_id           = azurerm_subnet.database.id

#   private_service_connection {
#     name                           = "sql-private-connection-${var.environment}-001"
#     private_connection_resource_id = azurerm_sql_server.sqlsvr.id
#     is_manual_connection           = false
#     subresource_names              = ["sqlServer"]
#   }
# }