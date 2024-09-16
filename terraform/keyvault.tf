resource "azurerm_key_vault" "webappkv" {
    name  = "webappkv"
    resource_group_name = var.resource_group_hp
    location = var.location
    sku_name = "standard"
    tenant_id = var.tenant_id
    tags = var.tags

}