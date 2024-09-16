resource "azurerm_app_service" "webapp" {
    name  = "webapp-deployment-test-001"
    resource_group_name = var.resource_group_hp
    location = var.location
    app_service_plan_id = azurerm_app_service_plan.app-deployment.id
    tags = var.tags

}
