

resource "azurerm_storage_account" "storageaccount" {
    name  = "storageaccounthp"
    resource_group_name = var.resource_group_hp
    location = var.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    public_network_access_enabled = false


  
}