locals {
  environment = "develop"
}

remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "htquang-terragrunt"
    key = "${local.environment}/${path_relative_to_include()}/terraform.tfstate"
    region = "ap-southeast-1"
    encrypt = true
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.15.1"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
  profile = "default"
}
EOF
}