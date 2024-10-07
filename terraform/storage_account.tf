resource "azurerm_storage_account" "storageaccount" {
  name                            = "stwebappdata001"
  resource_group_name             = var.resource_group_hp
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false
  tags                            = var.tags
  network_rules {
    default_action             = "Allow"
    virtual_network_subnet_ids = [azurerm_subnet.storage.id]
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "st-blob-container-webapp-001"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
}




