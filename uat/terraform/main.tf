#weather-infra/terraform/uat/main.tf
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name    = "weather-${terraform.workspace}"
  cluster_version = "1.29"
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids


  # single cheap node group (one t3.small; scale to 1–2 pods for UAT)
  eks_managed_node_groups = {
    default = {
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      instance_types = ["t3.small"]
    }
  }

  tags = {
    Environment = terraform.workspace # shows up in AWS console
    Project     = "weather"
  }
}
