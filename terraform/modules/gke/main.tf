terraform {
  required_providers {
    google = { source = "hashicorp/google", version = ">= 5.0" }
  }
}

variable "project" { type = string }
variable "region" { type = string }
variable "cluster_name" { type = string }
variable "network" { type = string }
variable "subnetwork" { type = string }

resource "google_container_cluster" "this" {
  name     = var.cluster_name
  location = var.region
  network    = var.network
  subnetwork = var.subnetwork

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary"
  location   = var.region
  cluster    = google_container_cluster.this.name
  node_count = 1

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    preemptible = true
  }
}

output "cluster_name" { value = google_container_cluster.this.name }
output "endpoint" { value = google_container_cluster.this.endpoint }


