resource "azurerm_linux_web_app" "webapp" {
  name                = "app-web-${var.environment}"
  resource_group_name = var.resource_group_hp
  location            = var.location
  tags                = var.tags
  service_plan_id     = azurerm_service_plan.webappservice.id

  site_config {
    always_on = true
    application_stack {
      docker_image_name = "DOCKER|mcr.microsoft.com/appsvc/wordpress-debian-php:8.3"
    }
  }




  app_settings = {
    "WORDPRESS_DB_HOST"                     = "${azurerm_mysql_flexible_server.sqlsvr.name}.mysql.database.azure.com"
    "WORDPRESS_DB_USER"                     = "${azurerm_mysql_flexible_server.sqlsvr.administrator_login}"
    "WORDPRESS_DB_PASSWORD"                 = "${random_password.sqlpass.result}"
    "WORDPRESS_DB_NAME"                     = "${azurerm_mysql_flexible_database.sqldb.name}"
    "SETUP_PHPMYADMIN"                      = true
    "WEBSITES_CONTAINER_START_TIME_LIMIT"   = 1800
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"   = true
    "WORDPRESS_LOCAL_STORAGE_CACHE_ENABLED" = true
    "DOCKER_REGISTRY_SERVER_URL"            = "https://mcr.microsoft.com"
  }

  connection_string {
    name  = "DATABASE_URL"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_mysql_flexible_server.sqlsvr.name}.database.windows.net,1433;Database=${azurerm_mysql_flexible_database.sqldb.name};User ID=${azurerm_mysql_flexible_server.sqlsvr.administrator_login}@${azurerm_mysql_flexible_server.sqlsvr.name};Password=${random_password.sqlpass.result};Encrypt=true;Connection Timeout=30;"
  }
  connection_string {
    name  = "WORDPRESS_ADMIN_EMAIL"
    type  = "Custom"
    value = "himesh.patel@version1.com"
  }
  connection_string {
    name  = "WORDPRESS_ADMIN_PASSWORD"
    type  = "Custom"
    value = azurerm_mysql_flexible_server.sqlsvr.administrator_password
  }
  connection_string {
    name  = "WORDPRESS_ADMIN_USER"
    type  = "Custom"
    value = "himesh.patel"
  }
}