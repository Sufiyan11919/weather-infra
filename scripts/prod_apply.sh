#!/usr/bin/env bash
# Usage: ./scripts/prod_apply.sh <service-name> <new-tag>
set -euo pipefail

svc="$1"          # e.g. weather-frontend
tag="$2"          # full SHA or vX.Y.Z
files="k8s/base/${svc}-*.yaml"

# replace only the *image tag*; registry+repo stay unchanged
sed -i -E "s|(/${svc}:)([^ \"']+)|\1${tag}|g" $files

git add $files
git commit -m "Promote ${svc}:${tag} [skip ci]"
