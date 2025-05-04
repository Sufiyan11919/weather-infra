#!/usr/bin/env bash
#-------------------------------------------------------------------------------
# cloud-init for QA EC2: installs Docker, clones infra, runs compose/qa/docker‑compose.yml
#-------------------------------------------------------------------------------
set -eux

# install docker & compose
yum update -y
amazon-linux-extras install docker -y
service docker start
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# clone infra
cd /home/ec2-user
git clone https://github.com/${REPOSITORY_OWNER}/weather-infra.git infra
cd infra/compose/qa

# run Docker‑Compose
docker-compose pull
docker-compose up -d --remove-orphans
