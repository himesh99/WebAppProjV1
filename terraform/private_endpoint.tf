resource "azurerm_private_endpoint" "storage_private_endpoint" {
  for_each   = toset(var.environments)
  name                = "storage-private-endpoint-${var.environment}-001"
  location            = var.location
  resource_group_name = var.resource_group_hp
  subnet_id           = azurerm_subnet.service.id

  private_service_connection {
    name                           = "storage-private-connectio-${var.environment}-001"
    private_connection_resource_id = azurerm_storage_account.storageaccount.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}

resource "azurerm_private_endpoint" "keyvault_private_endpoint" {
  for_each   = toset(var.environments)
  name                = "keyvault-private-endpoint-${var.environment}-001"
  location            = var.location
  resource_group_name = var.resource_group_hp
  subnet_id           = azurerm_subnet.service.id

  private_service_connection {
    name                           = "keyvault-private-connection-${var.environment}-001"
    private_connection_resource_id = azurerm_key_vault.webappkv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
}

resource "azurerm_private_endpoint" "sql_private_endpoint" {
  for_each   = toset(var.environments)
  name                = "sql-private-endpoint-${var.environment}-001"
  location            = var.location
  resource_group_name = var.resource_group_hp
  subnet_id           = azurerm_subnet.database.id

  private_service_connection {
    name                           = "sql-private-connection-${var.environment}-001"
    private_connection_resource_id = azurerm_sql_server.sqlsvr.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }
}