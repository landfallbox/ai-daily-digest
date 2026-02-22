#!/usr/bin/env bash
set -euo pipefail

DATE_STR="$(date +%Y%m%d)"
OUTPUT_DIR="${DIGEST_OUTPUT_DIR:-/app/output}"
OUTPUT_FILE="${DIGEST_OUTPUT_FILE:-${OUTPUT_DIR}/digest-${DATE_STR}.md}"

mkdir -p "${OUTPUT_DIR}"

echo "[digest] Starting run at $(date -Iseconds)"
bun /app/scripts/digest.ts \
  --hours "${DIGEST_HOURS:-48}" \
  --top-n "${DIGEST_TOP_N:-15}" \
  --lang "${DIGEST_LANG:-zh}" \
  --output "${OUTPUT_FILE}"

echo "[digest] Finished run at $(date -Iseconds), output=${OUTPUT_FILE}"
