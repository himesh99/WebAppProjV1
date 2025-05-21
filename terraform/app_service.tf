resource "azurerm_app_service" "webapp" {
  name                = "wp-app-${var.environment}"
  resource_group_name = var.resource_group_hp
  location            = var.location
  tags                = var.tags
  app_service_plan_id = azurerm_service_plan.webappservice.id

  site_config {
    always_on        = true
    min_tls_version  = 1.2
    linux_fx_version = "DOCKER|mcr.microsoft.com/appsvc/wordpress-debian-php:8.3"
  }




  app_settings = {
    "DATABASE_HOST"                         = "${azurerm_mysql_flexible_server.sqlsvr.name}.mysql.database.azure.com"
    "DATABASE_USERNAME"                     = "${azurerm_mysql_flexible_server.sqlsvr.administrator_login}"
    "DATABASE_PASSWORD"                     = "${azurerm_key_vault_secret.sql_server_admin_password.value}"
    "DATABASE_NAME"                         = "${azurerm_mysql_flexible_database.sqldb.name}"
    "SETUP_PHPMYADMIN"                      = true
    "WEBSITES_CONTAINER_START_TIME_LIMIT"   = 1800
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"   = true
    "WORDPRESS_LOCAL_STORAGE_CACHE_ENABLED" = true
    "WORDPRESS_LOCALE_CODE"                 = "en_US"
    "DOCKER_REGISTRY_SERVER_URL"            = "https://mcr.microsoft.com"
    "AZURE_STORAGE_CONNECTION_STRING"       = azurerm_storage_account.storageaccount.primary_connection_string
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
    value = random_password.wppass.result
  }
  connection_string {
    name  = "WORDPRESS_ADMIN_USER"
    type  = "Custom"
    value = "himesh.patel"
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "wp-vnet-connect" {
  app_service_id = azurerm_app_service.webapp.id
  subnet_id      = azurerm_subnet.integration_service.id
}
