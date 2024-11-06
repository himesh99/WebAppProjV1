resource "azurerm_service_plan" "webappservice" {
  name                = "webapp-deployment-${var.environment}-001"
  resource_group_name = var.resource_group_hp
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"
}