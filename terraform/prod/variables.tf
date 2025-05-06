#terraform/variable.tf
variable "region" {
  description = "AWS region for the PROD workspace"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the EKS cluster will live"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}
