variable "aks_cluster_name" { type = string, default = "mc-aks" }

module "aks" {
  source = "../../modules/aks"

  resource_group_name = "${var.name_prefix}-rg"
  location            = var.location
  cluster_name        = var.aks_cluster_name
}


