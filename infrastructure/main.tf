terraform {
  required_version = ">= 1.4.0"

  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "satfbackend1234"
    container_name       = "tfstates"
    key                  = "walletanalyser.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}
