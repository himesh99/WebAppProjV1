output "sql_server_admin_username" {
  value = azurerm_sql_server.sql_server.administrator_login
  description = "The administrator username for the SQL Server."
}

output "sql_server_admin_password" {
  value     = random_password.sqlpass.result
  sensitive = true
  description = "The administrator password for the SQL Server."
}

output "webapp_connection_string" {
    value = "Server=tcp:${azurerm_sql_server.sql_server.name}.database.windows.net,1433;Database=${azurerm_sql_database.sqldb.name};User ID=${output.sql_server_admin_username}@${azurerm_sql_server.sql_server.name};Password=${output.sql_server_admin_password};Encrypt=true;Connection Timeout=30;"
    description = "The connection string for the webapp."
}

