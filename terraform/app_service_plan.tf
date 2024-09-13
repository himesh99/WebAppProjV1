resource "azurerm_app_service_plan" "webapp_plan" {
    name  = "wordpressapp"
    resource_group_name = var.resource_group_hp
    location = var.location
    sku{
      tier = "Standard"
      size = "S1"
    }
    tags = var.tags
}