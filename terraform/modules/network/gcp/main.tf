variable "name_prefix" { type = string }
variable "cidr_block"  { type = string }

resource "google_compute_network" "this" {
  name                    = "${var.name_prefix}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "primary" {
  name          = "${var.name_prefix}-subnet"
  ip_cidr_range = var.cidr_block
  region        = var.region
  network       = google_compute_network.this.id
}

variable "region" { type = string, default = "us-central1" }

output "network_self_link" { value = google_compute_network.this.self_link }


