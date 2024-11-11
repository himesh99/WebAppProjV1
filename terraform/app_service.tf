resource "azurerm_linux_web_app" "webapp" {
  name                = "app-web-${var.environment}-001"
  resource_group_name = var.resource_group_hp
  location            = var.location
  tags                = var.tags
  site_config {
    minimum_tls_version = "1.2"
  }
  service_plan_id = azurerm_service_plan.webappservice.id



  connection_string {
    name  = "DATABASE_URL"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.sqlsvr.name}.database.windows.net,1433;Database=${azurerm_sql_database.sqldb.name};User ID=${azurerm_sql_server.sqlsvr.administrator_login}@${azurerm_sql_server.sqlsvr.name};Password=${random_password.sqlpass.result};Encrypt=true;Connection Timeout=30;"
  }

}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id                 = azurerm_linux_web_app.webapp.id
  repo_url               = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
  branch                 = "master"
  use_manual_integration = true
  use_mercurial          = false
}
