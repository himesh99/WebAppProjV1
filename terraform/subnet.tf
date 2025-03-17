resource "azurerm_subnet" "database" {
  name                 = "snet-db-shared-uksouth-${var.environment}"
  resource_group_name  = var.resource_group_hp
  address_prefixes     = [var.address_space_db]
  service_endpoints    = ["Microsoft.Sql"]
  virtual_network_name = azurerm_virtual_network.webapp_vnet.name


}

resource "azurerm_subnet" "service" {
  name                 = "snet-service-shared-uksouth-${var.environment}"
  resource_group_name  = var.resource_group_hp
  address_prefixes     = [var.address_space_sve]
  service_endpoints    = ["Microsoft.KeyVault", "Microsoft.Storage"]
  virtual_network_name = azurerm_virtual_network.webapp_vnet.name


}