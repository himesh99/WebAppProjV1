resource "azurerm_app_service" "webapp" {
   name  = "webapp-deployment-test-001"
    resource_group_name = var.resource_group_hp
    location = var.location
    app_service_plan_id = azurerm_app_service_plan.webapp_plan.id
    tags = var.tags
  #   site_config {
  #    always_on = true
  #  }
  #  app_settings = { 
  #    "VaultName" = azurerm_key_vault.himeshkv.name
  #  }
  #  connection_string {
  #    name = "SQLAZDBConnstr"
  #    type = "SQLAzure"
  #    value = "Server=tcp:${azurerm_sql_server.hp_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_sql_server.hp_server.name};Persist Security Info=False;User ID=${azurerm_sql_server.hp_server.administrator_login};Password=${azurerm_sql_server.hp_server.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  #  }
}

