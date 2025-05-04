#weather-infra/scripts/uat_apply.sh
#!/usr/bin/env bash
# ------------------------------------------------------------------
# Deploy or refresh the UAT docker‑compose stack on the UAT EC2 host
# ------------------------------------------------------------------
set -euo pipefail
STAGE=uat                      # <‑‑ hard‑coded for clarity

cd "$(dirname "$0")/../compose/${STAGE}"
docker compose pull
docker compose up -d --remove-orphans
echo "✅  ${STAGE^^} deployment done"
