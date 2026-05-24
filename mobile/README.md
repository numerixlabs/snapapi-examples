# SnapAPI — mobile viewport (width=375)

Capture a page the way it renders on a small phone. SnapAPI accepts any viewport `width` in pixels; this example uses **375** — the canonical iPhone-class width used by most responsive-design test suites.

## Prereqs

- `curl` (preinstalled on macOS and most Linux distros)
- A SnapAPI key — [grab one free](https://numerixlabs.com/trial)

## Run

```sh
export SNAPAPI_KEY=sk_your_key_here
./quickstart.sh
```

You should see `numerixlabs-mobile.png` in your current directory: a full-page PNG of [numerixlabs.com](https://numerixlabs.com) rendered at 375px wide, exactly the way it appears on an iPhone.

## What's different from the [base curl example](../curl/)

Only the request body changes:

```diff
- {"url":"https://numerixlabs.com","format":"pdf","width":1280}
+ {"url":"https://numerixlabs.com","format":"png","width":375}
```

`width` controls the browser viewport SnapAPI uses to render the page. Any positive integer works — common values include `375` (mobile), `768` (tablet), `1280` (desktop default), `1920` (full HD).

## Use cases

- Smoke-test that your marketing site doesn't break on phones.
- Embed mobile previews in PR comments via CI (pair with [SnapDiff](https://numerixlabs.com) for regression detection).
- Build a "what does this look like on mobile?" preview button into your CMS.

## Next steps

- Try `"width":768` for tablet, or `"width":1920` for a wide-desktop capture.
- Add `"fullPage": false` to clip the screenshot to just the visible viewport.
- See the [full reference at numerixlabs.com/docs](https://numerixlabs.com/docs) for every parameter.
