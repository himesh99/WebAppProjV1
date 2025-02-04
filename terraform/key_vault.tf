resource "azurerm_key_vault" "webappkv" {
  name                = "kv-webapp-${var.environment}-uks"
  resource_group_name = var.resource_group_hp
  location            = var.location
  sku_name            = "standard"
  tenant_id           = var.tenant_id
  tags                = var.tags

}

resource "azurerm_key_vault_access_policy" "access_policy_1" {
  key_vault_id = azurerm_key_vault.webappkv.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
  ]
}

resource "azurerm_key_vault_access_policy" "webappkv_access_policy_2" {
  key_vault_id = azurerm_key_vault.webappkv.id
  tenant_id    = var.tenant_id
  #Allow V1-ADOTeam
  object_id = var.v1_object_id
  key_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
  ]
}

resource "azurerm_key_vault_secret" "sql_server_admin_password" {
  name         = "sql-server-${var.environment}-password"
  value        = azurerm_mysql_flexible_server.sqlsvr.administrator_password
  key_vault_id = azurerm_key_vault.webappkv.id
  tags         = var.tags
  content_type = "password"
  depends_on   = [azurerm_key_vault_access_policy.webappkv_access_policy_2]
}

resource "azurerm_private_dns_zone" "kv" {
  name                = "privatelink.kv.database.azure.com"
  resource_group_name = var.resource_group_hp

}

resource "azurerm_private_endpoint" "keyvault_private_endpoint" {
  name                = "pe-kv-${var.environment}-uks"
  location            = var.location
  resource_group_name = var.resource_group_hp
  subnet_id           = azurerm_subnet.service.id

  private_service_connection {
    name                           = "keyvault-private-connection-${var.environment}-001"
    private_connection_resource_id = azurerm_key_vault.webappkv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
  private_dns_zone_group {
    name                 = "kv-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv.id]
  }
}