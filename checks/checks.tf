check "webapp" {
  assert {
    condition     = data.azurerm_app_service.webapp.name == "app-web-${var.environment}-001"
    error_message = "Name of web app is ${data.azurerm_app_service.webapp.name}, should be webapp-deployment-development-001"
  }
  assert {
    condition     = data.azurerm_app_service.webapp.enabled == true
    error_message = "Web app enabled is ${data.azurerm_app_service.webapp.enabled}, should be true"
  }
}

check "vnet" {
  assert {
    condition     = data.azurerm_virtual_network.webapp.location == "uksouth"
    error_message = "Location of the virtual network is ${data.azurerm_virtual_network.webapp.location}, should be uksouth"
  }
}

check "kv" {
  assert {
    condition     = data.azurerm_key_vault.webapp.enable_rbac_authorization == false
    error_message = "RBAC authorization should be false, please change rbac autorization if enabled"
  }
}

