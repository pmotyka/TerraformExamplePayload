#!/bin/bash
set -ex

export BRANCH=$TF_WORKSPACE
export ACCOUNT_NAME=$(sh ./account_name_from_branch.sh)
export NAMESPACE="pmotyka"

cd terraform/payload
ls
echo "Repo is $REPO"
echo "Branch is $BRANCH"
echo "ACCOUNT_NAME is $ACCOUNT_NAME"
echo "TERRAFORM_WORKSPACE is $TERRAFORM_WORKSPACE"

terraform init \
  -backend-config="bucket=$NAMESPACE-terraform-backend-$ACCOUNT_NAME" \
  -backend-config="region=us-west-2" \
  -backend-config="dynamodb_table=terraform-state-lock" \
  -backend-config="key=$REPO/payload.tfstate"

set +e
terraform workspace new $TERRAFORM_WORKSPACE
set -e

terraform workspace select $TERRAFORM_WORKSPACE

terraform apply plan
     
