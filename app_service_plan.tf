resource "azurerm_app_service_plan" "wordpress_plan" {
    name  = "wordpressapp"
    resource_group_name = var.resource_group_hp
    location = var.location
    sku{
      tier = "Standard"
      size = "S1"
    }
    tags = var.tags
}