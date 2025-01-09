locals {
  sql_server_username = "webappadministrator"
}

resource "random_password" "sqlpass" {
  length           = 12
  special          = true
  override_special = "_%@"
}

resource "azurerm_mysql_flexible_server" "sqlsvr" {
  name                   = "sqlsvr-webapp-${var.environment}"
  resource_group_name    = var.resource_group_hp
  location               = var.location
  administrator_login    = local.sql_server_username
  administrator_password = random_password.sqlpass.result
  tags                   = var.tags
  sku_name               = "B_Standard_B1s"

}

