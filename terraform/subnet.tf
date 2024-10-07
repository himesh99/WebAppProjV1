resource "azurerm_subnet" "database" {
  name                 = "snet-db-shared-uksouth-001"
  resource_group_name  = var.resource_group_hp
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Sql"]
  virtual_network_name = azurerm_virtual_network.webapp_vnet.name


}

resource "azurerm_subnet" "service" {
  name                 = "snet-shared-uksouth-001"
  resource_group_name  = var.resource_group_hp
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
  virtual_network_name = azurerm_virtual_network.webapp_vnet.name


}