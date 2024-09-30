locals {
  sql_server_username = "webappadministrator"
}

resource "random_password" "sqlpass" {
  length           = 12
  special          = true
  override_special = "_%@"
}

resource "azurerm_sql_server" "sqlsvr" {
    name  = "sqldb-servers-webapp-001"
    resource_group_name = var.resource_group_hp
    location = var.location
    version = "12.0"
    administrator_login          = local.sql_server_username
    administrator_login_password = random_password.sqlpass.result
    tags = var.tags
    public_network_access_enabled = false
}
