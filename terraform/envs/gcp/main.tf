terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

module "network" {
  source = "../../modules/network/gcp"

  name_prefix = var.name_prefix
  cidr_block  = var.vpc_cidr
}

output "network_self_link" {
  value = module.network.network_self_link
}

output "subnetwork_name" {
  value = module.network.subnetwork_name
}

output "subnetwork_self_link" {
  value = module.network.subnetwork_self_link
}


