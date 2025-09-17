terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = ">= 3.100" }
  }
}

variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "cluster_name" { type = string }
variable "default_node_count" { type = number, default = 1 }

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name       = "nodepool1"
    node_count = var.default_node_count
    vm_size    = "Standard_DS2_v2"
    enable_auto_scaling = true
    min_count  = 1
    max_count  = 3
    spot_max_price = -1
    orchestrator_version = null
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive = true
}


