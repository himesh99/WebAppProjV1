resource "azurerm_storage_account" "storageaccount" {
  name                            = "stwpdata${var.environment}"
  resource_group_name             = var.resource_group_hp
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = true
  tags                            = var.tags
  network_rules {
    default_action = "Allow"
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "st-blob-wp-${var.environment}"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.storageaccount]
}




