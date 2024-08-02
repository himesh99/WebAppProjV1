resource "azurerm_subnet" "hp_subnet" {
    name = "subnethp"
    resource_group_name = var.resource_group_hp
    address_prefixes     = ["10.0.1.0/24"]
    virtual_network_name = azurerm_virtual_network.vnet_test.name

  
}