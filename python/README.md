# SnapAPI — Python example

Idiomatic Python with `requests`. Error-checked.

## Prereqs

- Python 3.9 or newer
- A SnapAPI key — [grab one free](https://numerixlabs.com/trial)
- `requests` library

```sh
pip install -r requirements.txt
```

## Run

```sh
export SNAPAPI_KEY=sk_your_key_here
python quickstart.py
```

You should see `numerixlabs.pdf` (~200 KB) in your current directory.

## What's happening

`quickstart.py` POSTs JSON to `https://api.numerixlabs.com/screenshot` with `requests.post`, calls `resp.raise_for_status()`, and writes the binary content to disk. Wraps it in a `screenshot()` function you can import.

## No-dependency variant

If you don't want a `requests` dependency, the standard library's `urllib` works too — see the inline alternative at the bottom of `quickstart.py`.

## Next steps

See the [full reference at numerixlabs.com/docs](https://numerixlabs.com/docs) for batch endpoints, full-page captures, and custom viewport sizes.
