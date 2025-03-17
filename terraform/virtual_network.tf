resource "azurerm_virtual_network" "webapp_vnet" {
  resource_group_name = var.resource_group_hp
  name                = "vnet-shared-uksouth-${var.environment}"
  location            = var.location
  address_space       = var.address_space
  tags                = var.tags
}