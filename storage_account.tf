

resource "azurerm_storage_account" "storageaccount" {
    name  = "storageaccounthpwebapp"
    resource_group_name = var.resource_group_hp
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    public_network_access_enabled = false
    allow_nested_items_to_be_public = false

    network_rules {
    default_action             = "Allow"
    virtual_network_subnet_ids = [azurerm_subnet.hp_subnet.id]
  }

}

resource "azurerm_storage_container" "containerhp" {
  name                  = "containerhp"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "public"
}


