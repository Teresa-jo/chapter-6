# Initialises Terraform providers and sets their version numbers.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.71.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "2.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "tls" {
  // No need to specify version here
}
