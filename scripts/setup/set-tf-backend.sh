#!/usr/bin/env bash
# shellcheck disable=SC2317,SC2154
# -----------------------------------------------------------------------------
# PURPOSE:  Creates a Terraform provider with backend configuration and drops
#           the file in the root of the project.
#             * Some controls are necessary at the Organization and project level.
# -----------------------------------------------------------------------------
# PREREQS:  source-in all your environment variables from build.env
# -----------------------------------------------------------------------------
#    EXEC:  scripts/setup/create-tf-backend.sh
# -----------------------------------------------------------------------------
: "${TF_VAR_envBucket?  I dont have my vars, bro!}"
set -x

###----------------------------------------------------------------------------
### FUNCTIONS
###----------------------------------------------------------------------------
function pMsg() {
    theMessage="$1"
    printf '%s\n' "$theMessage"
}

###----------------------------------------------------------------------------
### MAIN
###----------------------------------------------------------------------------
### Create the Terraform bucket definition for the backend
###---
cat > provider.tf <<EOF
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
      version = "~> $gcpProviderVersion"
    }
  }
  backend "gcs" {
    bucket = "$TF_VAR_envBucket"
  }
}

provider "google" {
  project = "$TF_VAR_project_id"
  #prefix = "env/state"
  #region = "us-west2"
}
EOF


###---
### fin~
###---
exit 0

