#!/usr/bin/env bash
set -euo pipefail

svc="$1"
tag="$2"

# 1) update the k8s/base manifest for this service
sed -i -E "s|(${svc}:).*|\1${tag}|g" k8s/base/${svc}-*.yaml

# 2) configure a Git user so the next commit isn’t rejected
git config --global user.email "github-actions[bot]@users.noreply.github.com"
git config --global user.name "GitHub Actions"

# 3) commit & leave pushing and PR creation to the ci script
git add k8s/base/${svc}-*.yaml
git commit -m "Promote ${svc}:${tag} [skip ci]"
