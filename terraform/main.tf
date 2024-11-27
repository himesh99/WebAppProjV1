terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.55.0"
    }
  }
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.az-subscription-id
  tenant_id       = data.azurerm_key_vault_secret.tenant_id.value
}


