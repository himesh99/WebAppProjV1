resource "azurerm_subnet" "private_endpoint" {
  name                                          = "snet-pe-shared-uks-${var.environment}"
  resource_group_name                           = var.resource_group_hp
  address_prefixes                              = [var.address_space_snet_pe]
  service_endpoints                             = ["Microsoft.Sql", "Microsoft.KeyVault", "Microsoft.Storage"]
  virtual_network_name                          = azurerm_virtual_network.webapp_vnet.name
  private_link_service_network_policies_enabled = true

}

resource "azurerm_subnet" "integration_service" {
  name                 = "snet-int-serv-shared-uks-${var.environment}"
  resource_group_name  = var.resource_group_hp
  address_prefixes     = [var.address_space_snet_int]
  virtual_network_name = azurerm_virtual_network.webapp_vnet.name


}