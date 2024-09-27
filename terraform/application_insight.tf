resource "azurerm_application_insights" "app_insights" {
  name                = "app-insights-001"
  location            = var.location
  resource_group_name = var.resource_group_hp
  application_type    = "web"
  tags                = var.tags
}