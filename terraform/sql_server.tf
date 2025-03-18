locals {
  sql_server_username = "webappadministrator"
}

resource "random_password" "sqlpass" {
  length           = 12
  special          = true
  override_special = "_%@"
}

resource "azurerm_mysql_flexible_server" "sqlsvr" {
  name                   = "sqlsvr-wp-app-${var.environment}"
  resource_group_name    = var.resource_group_hp
  location               = var.location
  administrator_login    = local.sql_server_username
  administrator_password = random_password.sqlpass.result
  sku_name               = "GP_Standard_D2ds_v4"
  private_dns_zone_id    = azurerm_private_dns_zone_virtual_network_link.sqlsvrLink.id

  depends_on = [azurerm_private_dns_zone_virtual_network_link.sqlsvrLink]

}

resource "azurerm_mysql_flexible_server_configuration" "require_secure_transport" {
  name                = "require_secure_transport"
  resource_group_name = var.resource_group_hp
  server_name         = azurerm_mysql_flexible_server.sqlsvr.name
  value               = "off"

}

resource "azurerm_mysql_flexible_server_firewall_rule" "allow_all_ips" {
  name                = "all_ip"
  resource_group_name = var.resource_group_hp
  server_name         = azurerm_mysql_flexible_server.sqlsvr.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_private_dns_zone" "sqlsvr" {
  name                = "privatelink.mysqlsvr.database.azure.com"
  resource_group_name = var.resource_group_hp

}

resource "azurerm_private_dns_zone_virtual_network_link" "sqlsvrLink" {
  name                  = "sqlsvr-vnet-link"
  resource_group_name   = var.resource_group_hp
  private_dns_zone_name = azurerm_private_dns_zone.sqlsvr.name
  virtual_network_id    = azurerm_virtual_network.webapp_vnet.id
}

resource "azurerm_private_dns_a_record" "sqlsvrArecord" {
  name                = "sqlsvr-webapp-dev"
  zone_name           = azurerm_private_dns_zone.sqlsvr.name
  resource_group_name = var.resource_group_hp
  ttl                 = 10
  records             = ["10.0.1.5"]
}


resource "azurerm_private_endpoint" "database_private_endpoint" {
  name                = "pe-svr-${var.environment}-uks"
  location            = var.location
  resource_group_name = var.resource_group_hp
  subnet_id           = azurerm_subnet.database.id

  private_service_connection {
    name                           = "database-private-connection-${var.environment}"
    private_connection_resource_id = azurerm_mysql_flexible_server.sqlsvr.id
    is_manual_connection           = false
    subresource_names              = ["mysqlServer"]
  }
  private_dns_zone_group {
    name                 = "sqlsvr-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sqlsvr.id]
  }
}

