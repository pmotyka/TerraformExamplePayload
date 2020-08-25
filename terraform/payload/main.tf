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
  tags        = local.tags
  source      = "github.com/cleblanc/TerraformLambdaModule"
  lambda_name = "mylambda"
  region      = "us-west-2"
}
