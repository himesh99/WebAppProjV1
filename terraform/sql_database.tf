resource "azurerm_mysql_flexible_database" "sqldb" {
  name                = "sqldb-webapp-${var.environment}"
  resource_group_name = var.resource_group_hp
  server_name         = azurerm_mysql_flexible_server.sqlsvr.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = var.resource_group_hp

}

resource "azurerm_private_dns_zone_virtual_network_link" "sqlLink" {
  name                  = "sql-vnet-link"
  resource_group_name = var.resource_group_hp
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = azurerm_virtual_network.webapp_vnet.id
}

resource "azurerm_private_dns_a_record" "sqlArecord" {
  name                = "sqldb-webapp-dev"
  zone_name           = azurerm_private_dns_zone.sql.name
  resource_group_name = var.resource_group_hp
  ttl                 = 10
  records             = [azurerm_private_dns_zone.sql.id]
}


resource "azurerm_private_endpoint" "database_private_endpoint" {
  name                = "pe-db-${var.environment}-uks"
  location            = var.location
  resource_group_name = var.resource_group_hp
  subnet_id           = azurerm_subnet.database.id

  private_service_connection {
    name                           = "database-private-connection-${var.environment}-001"
    private_connection_resource_id = azurerm_mysql_flexible_database.sqldb.id
    is_manual_connection           = false
    subresource_names              = ["mysqlServer"]
  }
  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql.id]
  }
}