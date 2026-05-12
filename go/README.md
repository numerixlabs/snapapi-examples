# SnapAPI — Go example

Single-file `main.go`. Standard library only — no `go get`, no third-party deps.

## Prereqs

- Go 1.21 or newer (`go version`)
- A SnapAPI key — [grab one free](https://numerixlabs.com/trial)

## Run

```sh
export SNAPAPI_KEY=sk_your_key_here
go run .
```

Or build a binary first:

```sh
go build -o snapapi-quickstart
./snapapi-quickstart
```

You should see `numerixlabs.pdf` (~200 KB) in your current directory.

## What's happening

`main.go` constructs the request with `http.NewRequest`, sends it via `http.DefaultClient`, and copies the response body straight to a file with `io.Copy`. Streaming-safe — works for arbitrarily large PDFs without buffering them in memory.

## Next steps

See the [full reference at numerixlabs.com/docs](https://numerixlabs.com/docs) for batch requests, response headers (`X-Shots-Used`, `X-Shots-Limit`), and per-plan quotas.
