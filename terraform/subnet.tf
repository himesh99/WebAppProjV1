resource "azurerm_subnet" "webapp_snet" {
  name                 = "snet-shared-uksouth-001"
  resource_group_name  = var.resource_group_hp
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage", "Microsoft.KeyVault"]
  virtual_network_name = azurerm_virtual_network.webapp_vnet.name


}