resource "azurerm_app_service" "webapp" {
  for_each   = toset(var.environments)
  name                = "webapp-deployment-${var.environment}-001"
  resource_group_name = var.resource_group_hp
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.app-deployment[each.key].id
  tags                = var.tags


  # connection_string {
  #   name  = "DATABASE_URL"
  #   type  = "SQLServer"
  #   value = "Server=tcp:${azurerm_sql_server.sqlsvr.name}.database.windows.net,1433;Database=${azurerm_sql_database.sqldb.name};User ID=${azurerm_sql_server.sqlsvr.administrator_login}@${azurerm_sql_server.sqlsvr.name};Password=${random_password.sqlpass.result};Encrypt=true;Connection Timeout=30;"
  # }

}
