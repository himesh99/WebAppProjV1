check "webapp" {
  assert {
    condition     = data.azurerm_app_service.webapp.name == "webapp-deployment-development-001"
    error_message = "Name of web app is ${data.azurerm_app_service.webapp.name}, should be webapp-deployment-development-001"
  }
  assert {
    condition     = data.azurerm_app_service.webapp.enabled == true
    error_message = "Web app enabled is ${data.azurerm_app_service.webapp.enabled}, should be true"
  }
  assert {
    condition     = data.azurerm_app_service.webapp.https_only == true
    error_message = "Web app https only is ${data.azurerm_app_service.webapp.https_only}, should be true"
  }
}