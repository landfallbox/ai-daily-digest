#!/usr/bin/env bash
set -euo pipefail

mkdir -p /app/output /app/logs

CRON_EXPR="${DIGEST_CRON:-0 8 * * *}"
echo "${CRON_EXPR} /usr/local/bin/run-digest.sh >> /app/logs/cron.log 2>&1" > /etc/crontabs/root

if [[ "${RUN_ON_START:-false}" == "true" ]]; then
  /usr/local/bin/run-digest.sh >> /app/logs/cron.log 2>&1 || true
fi

echo "[digest] Cron schedule: ${CRON_EXPR}"
echo "[digest] Timezone: ${TZ:-UTC}"

exec crond -f -l 8
