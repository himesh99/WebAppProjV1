resource "azurerm_key_vault" "webappkv" {
  for_each   = toset(var.environments)
  name                = "app-kv-${var.environment}-001"
  resource_group_name = var.resource_group_hp
  location            = var.location
  sku_name            = "standard"
  tenant_id           = var.tenant_id
  tags                = var.tags

  access_policy {

    tenant_id = var.tenant_id
    object_id = var.object_id

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

}

resource "azurerm_key_vault_access_policy" "access_policy_1" {
  for_each   = toset(var.environments)
  key_vault_id = azurerm_key_vault.webappkv[each.key].id
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
  for_each   = toset(var.environments)
  key_vault_id = azurerm_key_vault.webappkv[each.key].id
  tenant_id    = var.tenant_id
  object_id    = "0e4b967e-0513-4269-aa22-687166d31276"

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
  for_each   = toset(var.environments)
  name         = "sql-server-${var.environment}-password"
  value        = azurerm_sql_server.sqlsvr[each.key].administrator_login_password
  key_vault_id = azurerm_key_vault.webappkv[each.key].id
  tags         = var.tags
  content_type = "password"
  depends_on = [ azurerm_key_vault_access_policy.access_policy_1, azurerm_key_vault_access_policy.webappkv_access_policy_2 ]
}
