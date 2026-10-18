terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.0"
    }
  }

   required_version = "1.16.6"

  cloud {
    
    organization = "ntmsorg"

    workspaces {
      name = "hcp-test-demo"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {

  }
  subscription_id = "1dc07c30-4f02-476a-98b4-89b0d8304e01"
}