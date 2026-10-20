terraform {
  required_version = "= 1.16.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "State_Storage" {
  name     = "rg-state-storage"
  location = "westus2"
}