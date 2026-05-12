# SnapAPI Examples

Minimal, working client examples for [SnapAPI](https://numerixlabs.com) — turn any URL into a PNG or PDF screenshot with a single REST call.

Every example here hits the production endpoint at `https://api.numerixlabs.com/screenshot`, requests `format=pdf`, and writes a real PDF of [numerixlabs.com](https://numerixlabs.com) to your working directory. Nothing is mocked.

## Languages

| Folder | Runtime | What it shows |
|---|---|---|
| [curl/](curl/) | Any POSIX shell | The raw HTTP call — copy/paste-friendly. |
| [node/](node/) | Node 18+ (uses built-in `fetch`) | Async/await with no dependencies. |
| [python/](python/) | Python 3.9+ with `requests` | Idiomatic Python, error-checked. |
| [php/](php/) | PHP 8.0+ with cURL extension | Procedural cURL with a binary write. |
| [go/](go/) | Go 1.21+ | Single-file `main.go`, standard library only. |

## Quickstart (any language)

1. [Sign up for a free SnapAPI trial](https://numerixlabs.com/trial) — 100 screenshots, no credit card.
2. Copy your API key from the [portal](https://numerixlabs.com/portal).
3. Export it once per shell:

   ```sh
   export SNAPAPI_KEY=sk_your_key_here
   ```

4. Open the folder for your language, follow its README, and run the quickstart. You should see `numerixlabs.pdf` (~200 KB) appear in your working directory within a couple of seconds.

## What the examples produce

Each quickstart issues this request:

```http
POST /screenshot HTTP/1.1
Host: api.numerixlabs.com
Authorization: Bearer $SNAPAPI_KEY
Content-Type: application/json

{"url":"https://numerixlabs.com","format":"pdf","width":1280}
```

The response body is the raw PDF binary. The examples save it to `numerixlabs.pdf`.

Want a PNG instead? Change `"format":"pdf"` to `"format":"png"` and save to `numerixlabs.png`.

## Full API reference

The complete reference — every parameter, every plan limit, every response header — lives at [numerixlabs.com/docs](https://numerixlabs.com/docs). These examples cover the `/screenshot` endpoint only; SnapAPI also supports `/screenshot/batch`, `/usage`, and `/demo`.

## License

MIT — see [LICENSE](LICENSE). Use the code freely, with or without attribution.

## About

[Numerix Labs](https://numerixlabs.com) builds focused developer tools: SnapAPI (screenshots), SnapMonitor (uptime), SnapWebhook (webhook testing). One-person team operated through AI agents — see [the build log on numerixlabs.com/blog](https://numerixlabs.com/blog).

This repo is demonstration-only. Issues and pull requests are not actively triaged; please file SnapAPI feature requests or bug reports via the [support channels on numerixlabs.com](https://numerixlabs.com).
