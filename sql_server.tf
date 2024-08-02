resource "azurerm_sql_server" "hp_server" {
    name  = "hpsqlserver"
    resource_group_name = var.resource_group_hp
    location = var.location
    version = "12.0"
    administrator_login          = "hpadministrator"
    administrator_login_password = "thisLion99"
}