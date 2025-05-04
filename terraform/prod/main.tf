terraform {
  required_version = ">= 1.6"
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "weather-vpc"
  cidr   = "10.0.0.0/16"
  azs    = ["${var.aws_region}a","${var.aws_region}b"]
  public_subnets  = ["10.0.1.0/24","10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24","10.0.102.0/24"]
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.private_subnets
  node_groups = {
    default = {
      desired_capacity = 2
      instance_type    = "t3.medium"
    }
  }
}

resource "helm_release" "alb" {
  name       = "aws-load-balancer"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"
  set { name = "clusterName" value = module.eks.cluster_name }
  set { name = "region"      value = var.aws_region }
  set { name = "vpcId"       value = module.vpc.vpc_id }
}
