resource "azurerm_key_vault" "himeshkv" {
    name  = "himeshkv"
    resource_group_name = var.resource_group_hp
    location = var.location
    sku_name = "standard"
    tenant_id = var.tenant_id

}