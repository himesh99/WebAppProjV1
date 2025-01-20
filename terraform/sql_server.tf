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
  sku_name               = "GP_Standard_D2ds_v4"

}

resource "azurerm_mysql_flexible_server_configuration" "require_secure_transport" {
  name                = "require_secure_transport"
  resource_group_name = var.resource_group_hp
  server_name = azurerm_mysql_flexible_server.sqlsvr.name
  value = "OFF"
  
}

resource "azurerm_mysql_flexible_server_firewall_rule" "allow_all_ips" {
  name                = "all_ip"
  resource_group_name = var.resource_group_hp
  server_name         = azurerm_mysql_flexible_server.sqlsvr.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

