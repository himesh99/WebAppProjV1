resource "azurerm_app_service" "wordpresswebapp" {
   name  = "wordpresswebapp"
    resource_group_name = var.resource_group_hp
    location = var.location
    app_service_plan_id = azurerm_app_service_plan.wordpress_plan.id
}