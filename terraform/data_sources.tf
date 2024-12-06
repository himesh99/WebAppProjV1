data "azurerm_key_vault" "config_kv" {
  name                = "kv-backend-001"
  resource_group_name = var.resource_group_hp
}

data "azurerm_key_vault_secret" "tenant_id" {
  name         = "tenantid"
  key_vault_id = data.azurerm_key_vault.config_kv.id
}

data "azurerm_key_vault_secret" "sa_access_key" {
  name         = "saaccesskey"
  key_vault_id = data.azurerm_key_vault.config_kv.id
}

data "azurerm_key_vault_secret" "object_id" {
  name         = "objectid"
  key_vault_id = data.azurerm_key_vault.config_kv.id
}

data "azurerm_key_vault_secret" "v1_object_id" {
  name         = "v1objectid"
  key_vault_id = data.azurerm_key_vault.config_kv.id
}

