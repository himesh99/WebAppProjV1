

resource "azurerm_virtual_network" "vnet_test" {
  resource_group_name = var.resource_group_hp
  name = "vnet_test"
  location = var.location
  address_space = ["10.0.0.0/16"]
}