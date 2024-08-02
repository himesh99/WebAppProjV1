

resource "azurerm_storage_account" "storageaccount" {
    name  = "storageaccounthpwebapp"
    resource_group_name = var.resource_group_hp
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    public_network_access_enabled = false
    allow_nested_items_to_be_public = false


  
}

resource "azurerm_storage_container" "containerhp" {
    name  = "containerhp"
    storage_account_name = azurerm_storage_account.storageaccount.name

}