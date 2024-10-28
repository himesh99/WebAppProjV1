terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.55.0"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# data "azurerm_app_service" "webapp" {
#   name = "webapp-deployment-${var.environment}-001"
#   resource_group_name = var.resource_group_hp
# }

# check "webapp" {
#   assert {
#     condition = data.azurerm_app_service.webapp == "webapp-deploymrnt-development-001"
#     error_message = "Name of web app is ${data.azurerm_app_service.webapp.name}, should be webapp-deploymrnt-development-001"
#   }
# }
