/*
  -----------------------------------------------------------------------------
                           CENTRALIZED HOME FOR STATE
                           inerpolations NOT allowed
  -----------------------------------------------------------------------------
*/
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
# https://github.com/hashicorp/terraform-provider-google
# https://github.com/hashicorp/terraform-provider-google-beta
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.70.0"
    }
  }
  backend "gcs" {
    bucket = "tfstate-infras-gke-stage"
  }
}

provider "google" {
  #prefix  = "env/state"
  project = "infras-gke-stage"
  #region      = "us-west2"
}
