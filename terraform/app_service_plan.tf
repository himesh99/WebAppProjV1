resource "azurerm_app_service_plan" "app-deployment" {
    name  = "app-deployment-001.azurewebsites.net"
    resource_group_name = var.resource_group_hp
    location = var.location
    sku{
      tier = "Standard"
      size = "S1"
    }
    tags = var.tags
}