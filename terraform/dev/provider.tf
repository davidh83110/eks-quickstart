provider "aws" {
  version = "~> 2.0"
  region  = var.AWS_REGION
}

terraform {
  backend "s3" {
    bucket = "xxxxxxxxx"
    key    = "eks/terraform.tfstate"
    region = "ap-northeast-1"
  }
}


data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "xxxxxxx"
    key    = "vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}