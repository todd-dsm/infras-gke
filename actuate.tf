/*
  This module will discover/use an existing Azure Active Directory instance and
  configure it to behave as the IdP (Identity Provider/origin) for Federated Identities.
*/
module "apps" {
  source     = "./mods/apps"
  project_id = var.project_id
  region     = var.region
  zone       = var.zone
}

# ----------------------------------------------------------------------------

/*
  This module is a simple test to show local Terraform credentials work.
  Should take approx. 20s to roll out and 20s to roll back.
*/
#module "tf_test" {
#  source   = "./mods/test"
#  dns_zone = var.dns_zone
#  builder  = var.builder
#  envBuild = var.envBuild
#  myCo     = var.myCo
#  project  = var.project
#  region   = var.region
#}
