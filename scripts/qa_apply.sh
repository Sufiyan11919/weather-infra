#weather-infra/scripts/qa_apply.sh
#!/usr/bin/env bash
# ------------------------------------------------------------------
# Deploy or refresh the QA docker‑compose stack on the QA EC2 host
# ------------------------------------------------------------------
set -euo pipefail
STAGE=qa                       # <‑‑ hard‑coded for clarity

cd "$(dirname "$0")/../compose/${STAGE}"
docker compose pull
docker compose up -d --remove-orphans
echo "✅  ${STAGE^^} deployment done"
