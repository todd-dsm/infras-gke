/*
  ---------------------------------------------------------|------------------------------------------------------------
                                                       Networking
  ---------------------------------------------------------|------------------------------------------------------------
*/

# Discover the Google Compute Engine default network
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network
data "google_compute_network" "vpc_network" {
  name    = "default"
  project = var.project_id
}

# Discover the Google Compute Engine default subnets
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_subnetwork
data "google_compute_subnetwork" "vpc_subnet" {
  name    = "default"
  region  = var.region
  project = var.project_id
}