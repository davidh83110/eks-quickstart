provider "aws" {
  version = "~> 2.0"
  region  = var.AWS_REGION
}

terraform {
  backend "s3" {
    bucket = "terraform-xrex-dev"
    key    = "exchange-eks/terraform.tfstate"
    region = "ap-northeast-1"
  }
}


data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "terraform-xrex-dev"
    key    = "exchange-vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}