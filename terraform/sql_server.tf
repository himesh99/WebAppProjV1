locals {
  sql_server_username = "webappadministrator"
}

#tst
resource "azurerm_mysql_flexible_server" "sqlsvr" {
  name                   = "sqlsvr-wp-${var.environment}-uks"
  resource_group_name    = var.resource_group_hp
  location               = var.location
  administrator_login    = local.sql_server_username
  administrator_password = azurerm_key_vault_secret.sql_server_admin_password.value
  sku_name               = "GP_Standard_D2ds_v4"
  zone                   = "1"
  private_dns_zone_id    = azurerm_private_dns_zone.sqlsvr.id
  depends_on = [ azurerm_private_dns_zone_virtual_network_link.sqlsvrLink ]
  
}

resource "azurerm_mysql_flexible_server_configuration" "require_secure_transport" {
  name                = "require_secure_transport"
  resource_group_name = var.resource_group_hp
  server_name         = azurerm_mysql_flexible_server.sqlsvr.name
  value               = "on"

}

resource "azurerm_mysql_flexible_server_firewall_rule" "allow_my_ip" {
  name                = "my_ip"
  resource_group_name = var.resource_group_hp
  server_name         = azurerm_mysql_flexible_server.sqlsvr.name
  start_ip_address    = "84.69.91.47"
  end_ip_address      = "84.69.91.47"
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
  records             = ["10.0.2.3"]
}


resource "azurerm_private_endpoint" "database_private_endpoint" {
  name                = "pe-svr-${var.environment}-uks"
  location            = var.location
  resource_group_name = var.resource_group_hp
  subnet_id           = azurerm_subnet.private_endpoint.id

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

