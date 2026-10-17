
#starts terraform config block
terraform {
  required_version = "= 1.16.6"
  required_providers {
    azurerm = {
      source  = "hashico rp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "launchpad" {
  name     = "rg-launchpad-dev"
  loca tion = "westus2"
}
