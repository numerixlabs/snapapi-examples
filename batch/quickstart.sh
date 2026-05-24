#!/usr/bin/env sh
# SnapAPI batch quickstart — capture up to 10 URLs in a single request.
# Docs: https://numerixlabs.com/docs

set -eu

if [ -z "${SNAPAPI_KEY:-}" ]; then
  echo "error: set SNAPAPI_KEY first (export SNAPAPI_KEY=sk_...)"
  echo "       grab a free trial key at https://numerixlabs.com/trial"
  exit 1
fi

for cmd in curl jq base64; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "error: '$cmd' is required but not installed"
    exit 1
  fi
done

curl --fail-with-body -X POST "https://api.numerixlabs.com/screenshot/batch" \
  -H "Authorization: Bearer $SNAPAPI_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "urls": [
      "https://numerixlabs.com",
      "https://numerixlabs.com/blog",
      "https://numerixlabs.com/docs"
    ],
    "format": "png",
    "width": 1280
  }' \
  -o batch-response.json

jq -r '.results | to_entries[] | "\(.key)\t\(.value.url)\t\(.value.status)"' batch-response.json \
| while IFS=$(printf '\t') read -r idx url status; do
    if [ "$status" = "success" ]; then
      out="batch-${idx}.png"
      jq -r ".results[$idx].data" batch-response.json | base64 -d > "$out"
      echo "Saved $out ($url)"
    else
      err=$(jq -r ".results[$idx].error" batch-response.json)
      echo "Skipped $url — $err"
    fi
  done

echo "Quota: $(jq -r '"\(.shots_used) / \(.shots_limit // "unlimited")"' batch-response.json) shots used"
