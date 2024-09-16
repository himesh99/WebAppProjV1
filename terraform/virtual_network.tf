

resource "azurerm_virtual_network" "webapp_vnet" {
  resource_group_name = var.resource_group_hp
  name = "vnet-shared-uksouth-001"
  location = var.location
  address_space = ["10.0.0.0/16"]
  tags = var.tags
}