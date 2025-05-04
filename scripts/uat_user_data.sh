#!/usr/bin/env bash
#-------------------------------------------------------------------------------
# cloud‑init for UAT EC2: installs Docker, clones infra, runs compose/uat/docker-compose.yml
#-------------------------------------------------------------------------------
set -eux

# 1) install Docker & Compose
yum update -y
amazon-linux-extras install docker -y
service docker start
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# 2) grab your infra
cd /home/ec2-user
git clone "https://github.com/${REPOSITORY_OWNER}/weather-infra.git" infra
cd infra/compose/uat

# 3) fire up the UAT stack
docker-compose pull
docker-compose up -d --remove-orphans
