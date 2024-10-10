resource "azurerm_key_vault" "webappkv" {
  name                = "webapp-kv-001-test3"
  resource_group_name = var.resource_group_hp
  location            = var.location
  sku_name            = "standard"
  tenant_id           = var.tenant_id
  tags                = var.tags
  public_network_access_enabled = true

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

  network_acls {
    bypass = "AzureServices"
    default_action = "Deny"
    virtual_network_subnet_ids = [ azurerm_subnet.service.id]
    ip_rules = ["84.69.79.240/32"] 
  }

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
  name         = "sql-server-admin-password"
  value        = azurerm_sql_server.sqlsvr.administrator_login_password
  key_vault_id = azurerm_key_vault.webappkv.id
  tags         = var.tags
  content_type = "password"
  depends_on = [ azurerm_key_vault_access_policy.access_policy_1, azurerm_key_vault_access_policy.webappkv_access_policy_2 ]
}
