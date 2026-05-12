# SnapAPI — PHP example

Procedural PHP with the cURL extension. No Composer, no Guzzle, no dependencies.

## Prereqs

- PHP 8.0 or newer (`php --version`)
- The `php-curl` extension (preinstalled on most distros; on Debian/Ubuntu: `sudo apt install php-curl`)
- A SnapAPI key — [grab one free](https://numerixlabs.com/trial)

## Run

```sh
export SNAPAPI_KEY=sk_your_key_here
php quickstart.php
```

You should see `numerixlabs.pdf` (~200 KB) in your current directory.

## What's happening

`quickstart.php` builds a request with `curl_init`, POSTs JSON to `https://api.numerixlabs.com/screenshot`, captures the raw binary response with `CURLOPT_RETURNTRANSFER`, and writes it to disk with `file_put_contents`. Returns a non-zero exit on any non-2xx HTTP status.

## Next steps

See the [full reference at numerixlabs.com/docs](https://numerixlabs.com/docs) for the complete parameter list and rate-limit headers.
