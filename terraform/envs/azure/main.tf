terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.100"
    }
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source = "../../modules/network/azure"

  name_prefix = var.name_prefix
  cidr_block  = var.vnet_cidr
  location    = var.location
}

output "vnet_id" {
  value = module.network.vnet_id
}


