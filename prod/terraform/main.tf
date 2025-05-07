terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

#########################################################
# 1. Brand-new VPC for Prod (three private subnets)     #
#########################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.2"

  name = "weather-prod"
  cidr = var.vpc_cidr                  # 10.21.0.0/16 by default

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.21.4.0/22", "10.21.8.0/22", "10.21.12.0/22"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Project     = "weather-prod"
    Environment = "prod"
  }
}

#########################################################
# 2. EKS cluster that lives **in the VPC created above**#
#########################################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.1"

  cluster_name    = "weather-${terraform.workspace}"   # → weather-prod
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      min_size       = 2
      max_size       = 4
      instance_types = ["t3.medium"]
    }
  }

  tags = {
    Project     = "weather-prod"
    Environment = "${terraform.workspace}"    # ← fixed typo
  }
}
