variable "gke_cluster_name" { type = string, default = "mc-gke" }

module "gke" {
  source = "../../modules/gke"

  project      = var.project
  region       = var.region
  cluster_name = var.gke_cluster_name
  network      = module.network.network_self_link
  subnetwork   = module.network.subnetwork_name
}


