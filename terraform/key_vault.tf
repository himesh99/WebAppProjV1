# import {
#   to = azurerm_key_vault_access_policy.access_policy_1
#   id = "/subscriptions/4ac7e4ba-2b33-4c38-8852-1a6ba4098aa3/resourceGroups/patelh-sandbox-rg/providers/Microsoft.KeyVault/vaults/app-kv-development-001/objectId/18755058-a4c0-4705-b50a-35348fb876d6"
# }

# import {
#   to = azurerm_key_vault_access_policy.webappkv_access_policy_2
#   id = "/subscriptions/4ac7e4ba-2b33-4c38-8852-1a6ba4098aa3/resourceGroups/patelh-sandbox-rg/providers/Microsoft.KeyVault/vaults/app-kv-development-001/objectId/0e4b967e-0513-4269-aa22-687166d31276"
# }

# import {
#   to = azurerm_key_vault_secret.sql_server_admin_password
#   id = "https://kv-development-uks-001.vault.azure.net/secrets/sql-server-development-password/e93daaaeb9884ff4827a13689156960f"
# }

resource "azurerm_key_vault" "webappkv" {
  name                = "kv-${var.environment}-uks-001"
  resource_group_name = var.resource_group_hp
  location            = var.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_key_vault_secret.tenant_id.value
  tags                = var.tags

}

resource "azurerm_key_vault_access_policy" "access_policy_1" {
  key_vault_id = azurerm_key_vault.webappkv.id
  tenant_id    = data.azurerm_key_vault_secret.tenant_id.value
  object_id    = data.azurerm_key_vault_secret.object_id.value

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
  tenant_id    = data.azurerm_key_vault_secret.tenant_id.value
  #Allow V1-ADOTeam
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

resource "azurerm_key_vault_secret" "sql_server_admin_password" {
  name         = "sql-server-${var.environment}-password"
  value        = azurerm_sql_server.sqlsvr.administrator_login_password
  key_vault_id = azurerm_key_vault.webappkv.id
  tags         = var.tags
  content_type = "password"
  depends_on   = [azurerm_key_vault_access_policy.webappkv_access_policy_2]
}
