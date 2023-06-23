#!/usr/bin/env make
# vim: tabstop=8 noexpandtab
SHELL := /bin/bash 

# Grab some ENV stuff
KUBECONFIG		?= $(shell $((KUBECONFIG))
TF_VAR_envBuild		?= $(shell $(TF_VAR_envBuild))
TF_VAR_cluster_apps	?= $(shell $(TF_VAR_cluster_apps))
TF_VAR_cluster_vault	?= $(shell $(TF_VAR_cluster_vault))
planFile		?= $(shell $(planFile))

prep:	## Prepare for the build
	@scripts/setup/set-project-params.sh
	@printf '\n\n%s\n\n' "IF THIS LOOKS CORRECT YOU ARE CLEAR TO TERRAFORM"

all:    init plan apply creds

init:	## Initialize the build
	terraform init -get=true -backend=true -reconfigure

plan:   ## Plan the build with output log                           
	terraform fmt -recursive=true
	terraform plan -no-color 2>&1 | \
		tee /tmp/tf-$(TF_VAR_myProject)-plan.out

apply:  ## Build Terraform project with output log
	terraform apply --auto-approve -no-color \
		-input=false 2>&1 | \
		tee /tmp/tf-$(TF_VAR_myProject)-apply.out 

creds:	## Pull KUBECONFIG file(s) and select one
	@scripts/get-creds.sh 

# ------------------------ 'make all' ends here ------------------------------#

clean:	## Clean WARNING Message
	@echo ""
	@echo "Destroy $(TF_VAR_myProject)?"
	@echo ""
	@echo "    ***** STOP, THINK ABOUT THIS *****"
	@echo "You're about to DESTROY ALL that we have built"
	@echo ""
	@echo "IF YOU'RE CERTAIN, THEN 'make clean-all'"
	@echo ""
	@exit

clean-all:	## Destroy Terraformed resources and all generated files with output log
	terraform apply -destroy -auto-approve -no-color 2>&1 | \
	 	tee /tmp/tf-$(TF_VAR_myProject)-destroy.out
	rm -f "$(KUBECONFIG)"
	rm -rf .terraform/ .terraform.lock.hcl

#-----------------------------------------------------------------------------#
#------------------------   MANAGERIAL OVERHEAD   ----------------------------#
#-----------------------------------------------------------------------------#
print-%  : ## Print any variable from the Makefile (e.g. make print-VARIABLE);
	@echo $* = $($*)

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

