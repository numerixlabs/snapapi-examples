"""SnapAPI Python quickstart — turn https://numerixlabs.com into a PDF.

Docs: https://numerixlabs.com/docs
"""

import os
import sys

import requests

API_URL = "https://api.numerixlabs.com/screenshot"


def screenshot(api_key: str, url: str, out: str, *, fmt: str = "pdf", width: int = 1280) -> str:
    resp = requests.post(
        API_URL,
        headers={"Authorization": f"Bearer {api_key}"},
        json={"url": url, "format": fmt, "width": width},
        timeout=60,
    )
    resp.raise_for_status()
    with open(out, "wb") as f:
        f.write(resp.content)
    return out


def main() -> int:
    api_key = os.environ.get("SNAPAPI_KEY")
    if not api_key:
        print("error: set SNAPAPI_KEY first (export SNAPAPI_KEY=sk_...)", file=sys.stderr)
        print("       grab a free trial key at https://numerixlabs.com/trial", file=sys.stderr)
        return 1

    out = screenshot(api_key, "https://numerixlabs.com", "numerixlabs.pdf")
    print(f"Saved {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())


# --- No-dependency variant (standard library only) ---------------------------
# import json, os, urllib.request
#
# req = urllib.request.Request(
#     "https://api.numerixlabs.com/screenshot",
#     data=json.dumps({"url": "https://numerixlabs.com", "format": "pdf", "width": 1280}).encode(),
#     headers={
#         "Authorization": f"Bearer {os.environ['SNAPAPI_KEY']}",
#         "Content-Type": "application/json",
#     },
#     method="POST",
# )
# with urllib.request.urlopen(req, timeout=60) as resp, open("numerixlabs.pdf", "wb") as f:
#     f.write(resp.read())
