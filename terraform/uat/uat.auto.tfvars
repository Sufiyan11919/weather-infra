region = "us-east-2"

# the VPC that already exists in us‑east‑2
vpc_id = "vpc-0abc123de456f7890"

# two public (or private‑with‑NAT) subnets in that VPC, in two AZs
subnet_ids = [
  "subnet-0123456789abcdef0",
  "subnet-0456789abcdef0123"
]
