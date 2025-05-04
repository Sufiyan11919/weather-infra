terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "eks" {
  source       = "terraform-aws-modules/eks/aws"
  version      = "20.0.0"
  cluster_name = "weather-${terraform.workspace}"
  vpc_id       = var.vpc_id
  subnet_ids   = var.subnet_ids
}
