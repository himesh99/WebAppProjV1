resource "azurerm_service_plan" "webappservice" {
  name                = "webappservice${var.environment}plan"
  resource_group_name = var.resource_group_hp
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "webapp-deployment-${var.environment}-001"
  resource_group_name = var.resource_group_hp
  location            = var.location
  tags                = var.tags
  site_config {

  }
  service_plan_id = azurerm_service_plan.webappservice.id



  connection_string {
    name  = "DATABASE_URL"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.sqlsvr.name}.database.windows.net,1433;Database=${azurerm_sql_database.sqldb.name};User ID=${azurerm_sql_server.sqlsvr.administrator_login}@${azurerm_sql_server.sqlsvr.name};Password=${random_password.sqlpass.result};Encrypt=true;Connection Timeout=30;"
  }

}
