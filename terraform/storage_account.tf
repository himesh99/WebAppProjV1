resource "azurerm_storage_account" "storageaccount" {
  name                            = "stwebappdata${var.environment}"
  resource_group_name             = var.resource_group_hp
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false
  tags                            = var.tags
  network_rules {
    default_action = "Allow"
    #virtual_network_subnet_ids = [azurerm_subnet.service.id]
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "st-blob-webapp-${var.environment}"
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
  records             = [azurerm_private_dns_zone.sa.id]
}

resource "azurerm_private_endpoint" "storage_private_endpoint" {
  name                = "pe-sa-${var.environment}-uks"
  location            = var.location
  resource_group_name = var.resource_group_hp
  subnet_id           = azurerm_subnet.service.id

  private_service_connection {
    name                           = "storage-private-connection-${var.environment}-001"
    private_connection_resource_id = azurerm_storage_account.storageaccount.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "sa-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sa.id]
  }


}




