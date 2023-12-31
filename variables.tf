/*
  ---------------------------------------------------------|------------------------------------------------------------
                                                     Global Variables
  ---------------------------------------------------------|------------------------------------------------------------
*/
#variable "envBuild" {
#  description = "Build Environment; from ENV; E.G.: envBuild=stage"
#  type        = string
#}
#
#variable "myCo" {
#  description = "Expands to Company Name; E.G.: my-company"
#  type        = string
#}

variable "project_id" {
  description = "Project Name: should be set to something like: eks-test"
  type        = string
}

variable "region" {
  description = "Deployment Region; from ENV; E.G.: us-west2"
  type        = string
}

variable "zone" {
  description = "Deployment Zone; from ENV; E.G.: us-west2-a"
  type        = string
}

#variable "dns_zone" {
#  description = "Root DNS Zone for myCo; I.E.: example.tld."
#  type        = string
#}
#
#variable "builder" {
#  description = "Evaluates to $USER; there must be key-pair (with the same name) in EC2 prior to apply."
#  type        = string
#}
#
#variable "operator" {
#  description = "Inserts an email address to be passed to the cloud provider; E.G.: emailID@domain.tld"
#  type        = string
#}

#variable "cluster_apps" {
#  description = "The Cluster Name; I.E.: $myProject-$envBuild"
#  type        = string
#}
#
#variable "myDomain" {
#  description = "Root DNS Zone for myCo; I.E.: example.tld; minus the trailing dot"
#  type        = string
#}
#
#variable "host_cidr" {
#  description = "CIDR block reserved for networking; E.G.: 10.172.0.0/16"
#  type        = string
#}

#variable "officeIPAddr" {
#  description = "The IP address of the Current (outbound) Gateway: individual A.B.C.D/32 or block A.B.C.D/29"
#  type        = string
#}

/*
  ---------------------------------------------------------|------------------------------------------------------------
                                                   Kubernetes Variables
  ---------------------------------------------------------|------------------------------------------------------------
*/
#variable "kubeNode_type" {
#  description = "EKS worker node type, from ENV; E.G.: export TF_VAR_kubeNode_type=t3.medium"
#  type        = string
#}
#
#variable "minDistSize" {
#  description = "ENV Integer; initial count of distributed subnets, workers, etc; E.G.: export TF_VAR_minDistSize=3"
#  type        = number
#}
#
#variable "maxDistSize" {
#  description = "ENV Integer; max count of distributed EKS workers; E.G.: export TF_VAR_minDistSize=12"
#  type        = number
#}
#
#variable "DATADOG_UUID" {
#  description = "Preferably a v4 UUID; E.G.: cb3600cb-23bc-4d05-b841-6825e7a3daf5"
#  type        = string
#}
