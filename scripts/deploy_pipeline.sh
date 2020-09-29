#!/bin/bash
set -e

# Export some key variables to drive the automation
# allowing this script to be used across seperate repos

# The repo name
export REPO=${PWD##*/}
# The Branch Name
export BRANCH="$(git branch | grep \* | cut -d ' ' -f2)"
# Terraform workspace for isolation, we use the branch name here
export TERRAFORM_WORKSPACE=$BRANCH
# Get the aws account name from the helper script
# This is used to scipe the state bucket name (per account)
export ACCOUNT_NAME=$(./scripts/account_name_from_branch.sh)
# A global identifier for scoping bucket names
export NAMESPACE="pmotyka"

echo "REPO is $REPO"
echo "BRANCH is $BRANCH"
echo "ACCOUNT_NAME is $ACCOUNT_NAME"
echo "TERRAFORM_WORKSPACE is $TERRAFORM_WORKSPACE"

cd terraform/pipeline/ && \
     rm -f .terraform/terraform.tfstate && \
     rm -f .terraform/environment && \
     terraform get -update && \
    #  terraform init -backend-config=backendConfig.tfvars && \
     terraform init \
     -backend-config="bucket=$NAMESPACE-terraform-backend-$ACCOUNT_NAME" \
     -backend-config="region=us-west-2" \
     -backend-config="dynamodb_table=terraform-state-lock" \
     -backend-config="key=$REPO/pipeline.tfstate"&& \
     (terraform workspace new $TERRAFORM_WORKSPACE || true) && \
     terraform workspace select $TERRAFORM_WORKSPACE && \
     terraform apply -var repository_name=$REPO
cd -
