#terraform/main.tf
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

  vpc_id     = var.vpc_id       # supplied in prod.auto.tfvars
  subnet_ids = var.subnet_ids   # three private subnets

  # larger node group for blue/green traffic shifting
  eks_managed_node_groups = {
    default = {
      min_size       = 2
      max_size       = 4
      desired_size   = 2
      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Environment = "erraform.workspace"
    Project     = "weather-pro"
  }
}
