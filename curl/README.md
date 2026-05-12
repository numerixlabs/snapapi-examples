# SnapAPI — cURL example

The raw HTTP call. Useful for testing your key and for piping into other tools.

## Prereqs

- `curl` (preinstalled on macOS and most Linux distros)
- A SnapAPI key — [grab one free](https://numerixlabs.com/trial)

## Run

```sh
export SNAPAPI_KEY=sk_your_key_here
./quickstart.sh
```

You should see `numerixlabs.pdf` (~200 KB) in your current directory. Open it: it's a PDF of the [numerixlabs.com](https://numerixlabs.com) landing page rendered at 1280px wide.

## What's happening

`quickstart.sh` POSTs JSON to `https://api.numerixlabs.com/screenshot`, passes your key via `Authorization: Bearer`, and streams the binary PDF response straight to a file with `--output`.

## Next steps

- Try `"format":"png"` for an image instead of a PDF.
- Add `"fullPage": false` to capture only the viewport.
- See the [full reference at numerixlabs.com/docs](https://numerixlabs.com/docs) for every parameter and response header.
