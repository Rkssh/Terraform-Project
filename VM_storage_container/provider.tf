terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.53.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "variprojects"
    storage_account_name = "storageji"
    container_name       = "terrastorage"
    key                  = "prod.terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
}

