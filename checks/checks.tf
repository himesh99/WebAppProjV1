check "webapp" {
  assert {
    condition     = data.azurerm_app_service.webapp == "webapp-deployment-development-001"
    error_message = "Name of web app is ${data.azurerm_app_service.webapp.name}, should be webapp-deployment-development-001"
  }
}