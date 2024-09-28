resource "azurerm_app_service" "webapp" {
    name  = "webapp-deployment-test-001"
    resource_group_name = var.resource_group_hp
    location = var.location
    app_service_plan_id = azurerm_app_service_plan.app-deployment.id
    tags = var.tags

    app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "DATABASE_URL" = "Server=tcp:${azurerm_sql_server.sql_server.name}.database.windows.net,1433;Database=${azurerm_sql_database.sqldb.name};User ID=${output.sql_server_admin_username}@${azurerm_sql_server.sql_server.name};Password=${output.sql_server_admin_password};Encrypt=true;Connection Timeout=30;"

  }
}
