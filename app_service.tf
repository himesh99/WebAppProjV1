resource "azurerm_windows_web_app" "wordpresswebapp" {
   name  = "wordpresswebapp"
    resource_group_name = var.resource_group_hp
    location = var.location
    service_plan_id = azurerm_app_service_plan.wordpress_plan

    site_config {
      
    }
}