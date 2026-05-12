#!/usr/bin/env sh
# SnapAPI cURL quickstart — turn https://numerixlabs.com into a PDF.
# Docs: https://numerixlabs.com/docs

set -eu

if [ -z "${SNAPAPI_KEY:-}" ]; then
  echo "error: set SNAPAPI_KEY first (export SNAPAPI_KEY=sk_...)"
  echo "       grab a free trial key at https://numerixlabs.com/trial"
  exit 1
fi

curl --fail-with-body -X POST "https://api.numerixlabs.com/screenshot" \
  -H "Authorization: Bearer $SNAPAPI_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url":"https://numerixlabs.com","format":"pdf","width":1280}' \
  --output numerixlabs.pdf

echo "Saved numerixlabs.pdf"
