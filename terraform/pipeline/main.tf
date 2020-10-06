terraform {
  backend "s3" {}
}

locals {
  tags = {
    Order       = "70038033"
    Owner       = "MRAD"
    AppID       = "1795"
    Org         = "MRAD"
    ProjectName = "${var.repository_name}-Pipeline"
  }
}

module "pipeline" {
  source          = "git::https://github.com/pmotyka/TerraformCodePipelineModule.git"
  tags            = local.tags
  region          = "us-west-2"
  repository_name = var.repository_name
}
