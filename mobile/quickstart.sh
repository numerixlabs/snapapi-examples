#!/usr/bin/env sh
# SnapAPI mobile-viewport quickstart — capture a page at iPhone-class width (375px).
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
  -d '{"url":"https://numerixlabs.com","format":"png","width":375}' \
  --output numerixlabs-mobile.png

echo "Saved numerixlabs-mobile.png"
