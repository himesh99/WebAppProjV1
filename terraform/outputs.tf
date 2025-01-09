# output "web_app" {
#   value       = azurerm_linux_web_app.webapp.name
#   description = "The URL of the deployed web application."
# }

output "sql_server_name" {
  value       = azurerm_sql_server.sqlsvr.name
  description = "The name of the SQL Server."
}

output "sql_database_name" {
  value       = azurerm_sql_database.sqldb.name
  description = "The name of the SQL Database."
}

output "storage_account_name" {
  value       = azurerm_storage_account.storageaccount.name
  description = "The name of the Storage Account."
}

output "key_vault_name" {
  value       = azurerm_key_vault.webappkv.name
  description = "The name of the Key Vault."
}

output "service_plan_id" {
  value       = azurerm_service_plan.webappservice.id
  description = "The ID of the App Service Plan."
}