resource "azurerm_storage_account" "storageaccount" {
  name                     = "stwpdata${var.environment}"
  resource_group_name      = var.resource_group_hp
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
  network_rules {
    default_action = "Deny"
    ip_rules = [
      "84.69.91.47",
      "51.140.190.0/23",
      "51.140.192.0/23",
      "51.140.194.0/24",
      "51.140.195.0/24",
      "51.140.196.0/24",
      "51.140.197.0/24",
      "51.140.198.0/24",
      "51.140.199.0/24",
      "13.107.6.0/24",
      "13.107.9.0/24",
      "13.107.42.0/24",
      "13.107.43.0/24",
      "150.171.22.0/24",
      "150.171.23.0/24",
      "150.171.73.0/24",
      "150.171.74.0/24",
      "150.171.75.0/24",
      "150.171.76.0/24",
      "137.135.190.0/24",
      "13.74.220.0/24",
      "137.135.191.0/24",
      "20.61.71.0/24"
    ]
    virtual_network_subnet_ids = [azurerm_subnet.service.id]
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "st-blob-wp-${var.environment}"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.storageaccount]
}

resource "azurerm_private_dns_zone" "sa" {
  name                = "privatelink.sa.storage.azure.com"
  resource_group_name = var.resource_group_hp

}

resource "azurerm_private_dns_zone_virtual_network_link" "saLink" {
  name                  = "sa-vnet-link"
  resource_group_name   = var.resource_group_hp
  private_dns_zone_name = azurerm_private_dns_zone.sa.name
  virtual_network_id    = azurerm_virtual_network.webapp_vnet.id
}

resource "azurerm_private_dns_a_record" "saArecord" {
  name                = "stwebappdatadev"
  zone_name           = azurerm_private_dns_zone.sa.name
  resource_group_name = var.resource_group_hp
  ttl                 = 10
  records             = ["10.0.2.6"]
}

resource "azurerm_private_endpoint" "storage_private_endpoint" {
  name                = "pe-sa-${var.environment}-uks"
  location            = var.location
  resource_group_name = var.resource_group_hp
  subnet_id           = azurerm_subnet.service.id

  private_service_connection {
    name                           = "storage-private-connection-${var.environment}"
    private_connection_resource_id = azurerm_storage_account.storageaccount.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "sa-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sa.id]
  }


}




