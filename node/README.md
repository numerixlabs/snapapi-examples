# SnapAPI — Node.js example

Async/await, zero dependencies. Uses Node 18+'s built-in `fetch`.

## Prereqs

- Node 18 or newer (`node --version`)
- A SnapAPI key — [grab one free](https://numerixlabs.com/trial)

## Run

```sh
export SNAPAPI_KEY=sk_your_key_here
node quickstart.js
```

You should see `numerixlabs.pdf` (~200 KB) in your current directory.

## What's happening

`quickstart.js` calls `fetch()` against `https://api.numerixlabs.com/screenshot`, awaits the response, and writes the binary body to disk with `fs.promises.writeFile`. No `npm install` needed — built-in modules only.

## Wrapping it

The example file exports a `screenshot()` function alongside the CLI runner, so you can `require('./quickstart')` (or `import`) it from your own code:

```js
const { screenshot } = require('./quickstart');

await screenshot({
  url: 'https://github.com',
  format: 'png',
  out: 'github.png',
});
```

## Next steps

See the [full reference at numerixlabs.com/docs](https://numerixlabs.com/docs) for batch endpoints, custom headers/cookies (for authenticated screenshots), and rate-limit headers.
