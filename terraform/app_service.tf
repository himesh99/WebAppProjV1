resource "azurerm_app_service" "webapp" {
  name                = "app-web-${var.environment}"
  resource_group_name = var.resource_group_hp
  location            = var.location
  tags                = var.tags
  app_service_plan_id = azurerm_service_plan.webappservice.id

  site_config {
    min_tls_version  = 1.2
    linux_fx_version = "DOCKER|${var.wordpress_image}"
  }




  app_settings = {
    "WORDPRESS_DB_HOST"     = "${azurerm_sql_server.sqlsvr.name}.database.windows.net"
    "WORDPRESS_DB_USER"     = "${azurerm_sql_server.sqlsvr.administrator_login}@${azurerm_sql_server.sqlsvr.name}"
    "WORDPRESS_DB_PASSWORD" = "${random_password.sqlpass.result}"
    "WORDPRESS_DB_NAME"     = "${azurerm_sql_database.sqldb.name}"
    "DOCKER_ENABLE_CI"      = "true"
  }

  connection_string {
    name  = "DATABASE_URL"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.sqlsvr.name}.database.windows.net,1433;Database=${azurerm_sql_database.sqldb.name};User ID=${azurerm_sql_server.sqlsvr.administrator_login}@${azurerm_sql_server.sqlsvr.name};Password=${random_password.sqlpass.result};Encrypt=true;Connection Timeout=30;"
  }
}
