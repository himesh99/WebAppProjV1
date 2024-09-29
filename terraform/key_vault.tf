resource "azurerm_key_vault" "webappkv" {
    name  = "webapp-kv-001"
    resource_group_name = var.resource_group_hp
    location = var.location
    sku_name = "standard"
    tenant_id = var.tenant_id
    tags = var.tags

}

resource "azurerm_key_vault_secret" "sql_server_admin_password" {
  name         = "sql-server-admin-password"
  value        = random_password.sqlpass.result
  key_vault_id = azurerm_key_vault.webappkv.id
  tags         = var.tags
  content_type = "password"

}