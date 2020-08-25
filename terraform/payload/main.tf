terraform {
  backend "s3" {}
}

provider "aws" {
  region = "us-west-2"
}

locals {
  tags = {
    Owner       = "Jeff"
    AppID       = "1"
    Org         = "COE"
    ProjectName = var.repository_name
  }
}

/*
  --- Lambda(s) ---
*/

module "mylambda" {
  tags = local.tags
  # source      = "github.com/chrilebl/TerraformLambdaModule"
  source      = "git::ssh://git.amazon.com/pkg/TerraformLambdaModule"
  lambda_name = "mylambda"
  region      = "us-west-2"
}
