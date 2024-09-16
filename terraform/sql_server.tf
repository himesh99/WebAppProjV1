resource "azurerm_sql_server" "sqldb" {
    name  = "sqldb-servers"
    resource_group_name = var.resource_group_hp
    location = var.location
    version = "12.0"
    administrator_login          = "hpadministrator"
    administrator_login_password = "thisLion99"
    tags = var.tags
}