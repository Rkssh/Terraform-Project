terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.37.2"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}