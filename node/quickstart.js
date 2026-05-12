// SnapAPI Node.js quickstart — turn https://numerixlabs.com into a PDF.
// Requires Node 18+ for built-in fetch. Docs: https://numerixlabs.com/docs

'use strict';

const fs = require('node:fs/promises');

const API_URL = 'https://api.numerixlabs.com/screenshot';

async function screenshot({ apiKey, url, format = 'pdf', width = 1280, out }) {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ url, format, width }),
  });

  if (!res.ok) {
    throw new Error(`SnapAPI ${res.status}: ${await res.text()}`);
  }

  await fs.writeFile(out, Buffer.from(await res.arrayBuffer()));
  return out;
}

async function main() {
  const apiKey = process.env.SNAPAPI_KEY;
  if (!apiKey) {
    console.error('error: set SNAPAPI_KEY first (export SNAPAPI_KEY=sk_...)');
    console.error('       grab a free trial key at https://numerixlabs.com/trial');
    process.exit(1);
  }

  const out = await screenshot({
    apiKey,
    url: 'https://numerixlabs.com',
    format: 'pdf',
    out: 'numerixlabs.pdf',
  });

  console.log(`Saved ${out}`);
}

if (require.main === module) {
  main().catch((err) => {
    console.error(err.message);
    process.exit(1);
  });
}

module.exports = { screenshot };
