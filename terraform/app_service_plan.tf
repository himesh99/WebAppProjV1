resource "azurerm_service_plan" "webappservice" {
  name                = "asp-wp-app-${var.environment}"
  resource_group_name = var.resource_group_hp
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P0v3"
}