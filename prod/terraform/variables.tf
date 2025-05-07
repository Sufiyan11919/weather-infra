variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the dedicated Prod VPC"
  type        = string
  default     = "10.21.0.0/16"
}
