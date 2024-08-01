

resource "azurerm_virtual_network" "vnet_test" {
  resource_group_name = azurerm_resource_group.himesh_rg
  name = "vnet_test"
  location = var.location
  address_space = ["10.0.0.0/16"]
}