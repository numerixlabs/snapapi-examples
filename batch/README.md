# SnapAPI — batch (up to 10 URLs in one call)

Capture several pages with a single request. SnapAPI's `/screenshot/batch` endpoint accepts an array of up to **10** URLs, runs them in parallel server-side, and returns a JSON document with one base64-encoded image per URL.

Each URL in the batch counts as one screenshot against your quota — the same as if you'd called `/screenshot` 10 times — but you save the round-trip latency and only authenticate once.

## Prereqs

- `curl`, `jq`, and `base64` (all preinstalled on macOS and most Linux distros)
- A SnapAPI key — [grab one free](https://numerixlabs.com/trial)

## Run

```sh
export SNAPAPI_KEY=sk_your_key_here
./quickstart.sh
```

You should see `batch-0.png`, `batch-1.png`, `batch-2.png` in your current directory — one per URL — plus a `batch-response.json` showing the raw API envelope.

## What's different from the [base curl example](../curl/)

The endpoint and the response shape:

```diff
- POST /screenshot               → raw binary (image bytes)
+ POST /screenshot/batch         → JSON: { results: [{ url, status, data }], shots_used, shots_limit }
```

Each `results[].data` is a base64-encoded image in the format you requested. The script uses `jq` + `base64 -d` to decode each one to a file.

## Request shape

```json
{
  "urls": ["https://a.example", "https://b.example"],
  "format": "png",
  "width": 1280
}
```

The same shot-settings supported by `/screenshot` (`width`, `fullPage`, `delay`, `selector`, `headers`, `cookies`, `quality`, `media`) apply to every URL in the batch.

## Partial failures

If one URL in the batch is unreachable, you still get a 200 response — the failing item just has `status: "error"` and an `error` message instead of `data`. The script reports it and moves on. This is the main reason to prefer `/screenshot/batch` over a `xargs`-style loop: one bad URL doesn't kill the run, and the quota accounting is exact.

## Use cases

- Nightly capture of every page in your sitemap.
- A grid of "before-deploy" thumbnails posted to Slack from CI.
- Smoke-test a handful of marketing pages after a CDN config change.

## Next steps

- Try `"format":"pdf"` to get a base64-encoded PDF per URL.
- Add `"width":375` to get mobile-viewport captures for the whole batch — see [../mobile/](../mobile/).
- See the [full reference at numerixlabs.com/docs](https://numerixlabs.com/docs) for every parameter.
