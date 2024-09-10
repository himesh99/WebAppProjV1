resource "azurerm_app_service" "webapp" {
   name  = "webapp"
    resource_group_name = var.resource_group_hp
    location = var.location
    app_service_plan_id = azurerm_app_service_plan.webapp_plan.id
    tags = var.tags
    site_config {
     always_on = true
   }
   app_settings = {
     "VaultName" = azurerm_key_vault.himeshkv.name
   }
   connection_string {
     name = "SQLAZDBConnstr"
     type = "SQLAzure"
     value = azurerm_sql_server.hp_server.connection_strings[0].value
   }
}

resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webapp.id
  repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
  branch             = "master"
  use_manual_integration = true
  use_mercurial      = false
}