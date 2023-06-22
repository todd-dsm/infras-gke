/*
  ---------------------------------------------------------|------------------------------------------------------------
                                                 Google Kubernetes Engine
                                                       Autopilot
  ---------------------------------------------------------|------------------------------------------------------------
*/
# Create a GKE Cluster via Autopilot
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#enable_autopilot
resource "google_container_cluster" "apps" {
  name     = var.project_id
  location = var.region

  # Workaround for https://github.com/hashicorp/terraform-provider-google/issues/10782
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = ""
    services_ipv4_cidr_block = ""
  }

  network    = data.google_compute_network.vpc_network.name
  subnetwork = data.google_compute_subnetwork.vpc_subnet.name

  # Enabling Autopilot for this cluster
  enable_autopilot = true
}
