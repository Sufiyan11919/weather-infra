terraform {
  required_version = ">= 1.6"
}

provider "aws" {
  region = "us-east-2"
}

# lightweight EC2 used by ci/qa.yml (or uat.yml)
resource "aws_instance" "stage_vm" {
  ami                    = data.aws_ami.al2.id
  instance_type          = "t3.micro"
  key_name               = "weather-key"          # <-- create once in AWS‑EC2 → Key Pairs
  subnet_id              = data.aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ssh.id]

  tags = { Name = "weather‑${terraform.workspace}" }
}

data "aws_ami" "al2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# pick first public subnet in the default VPC
data "aws_subnet" "public" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

resource "aws_security_group" "ssh" {
  name        = "ssh-stage-${terraform.workspace}"
  description = "SSH from anywhere"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.stage_vm.public_ip
}
