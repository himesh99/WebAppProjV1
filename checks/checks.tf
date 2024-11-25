check "webapp" {
  assert {
    condition     = data.azurerm_linux_web_app.webapp.name == "app-web-${var.environment}-001"
    error_message = "Name of web app is ${data.azurerm_linux_web_app.webapp.name}, should be app-web-${var.environment}-001"
  }
  assert {
    condition     = data.azurerm_linux_web_app.webapp.enabled == true
    error_message = "Web app enabled is ${data.azurerm_linux_web_app.webapp.enabled}, should be true"
  }
  assert {
    condition     = data.azurerm_linux_web_app.webapp.https_only == true
    error_message = "Web app https only is ${data.azurerm_linux_web_app.webapp.https_only}, should be true"
  }
}

check "vnet" {
  assert {
    condition     = data.azurerm_virtual_network.webapp.location == "uksouth"
    error_message = "Location of the virtual network is ${data.azurerm_virtual_network.webapp.location}, should be uksouth"
  }
}

check "db" {
  assert {
    condition     = data.azurerm_sql_database.webapp.edition == "Standard"
    error_message = "All SQL databases should have an Standard edition, please change edition if not stnadard"
  }
}

