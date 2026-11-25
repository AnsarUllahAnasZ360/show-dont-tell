#!/usr/bin/env node
// Record a scripted browser flow with Playwright and log every action, so a
// cursor, click ripples and zooms can be added later (for example in Remotion).
//
// Tested with Playwright 1.65 (page.screencast with fps). Older versions may lack it.
// Usage:
//   npm i playwright && npx playwright install chromium
//   node record-demo.mjs steps.json out-dir [--width 1600 --height 1000 --scale 2]
//
// steps.json is a list of steps. Each step has one action and an optional wait (ms):
//   { "goto": "http://localhost:3000" }
//   { "click": "#save", "label": "Save" }
//   { "hover": "text=Pricing" }
//   { "type": "#email", "text": "demo@example.com" }
//   { "scrollTo": "#features", "duration": 900 }
//   { "scrollBy": 600 }
//   { "wait": 1500 }
//
// Output: out-dir/demo.webm, out-dir/events.json (times in ms from the first frame,
// coordinates in CSS pixels of the viewport), and out-dir/meta.json.
// Use local or staging data: the clicks are real.

import { chromium } from 'playwright';
import fs from 'node:fs';
import path from 'node:path';

const args = process.argv.slice(2);
const flags = {};
const positional = [];
for (let i = 0; i < args.length; i++) {
  if (args[i].startsWith('--')) flags[args[i].slice(2)] = args[++i];
  else positional.push(args[i]);
}
const [stepsFile, outDir = 'recording'] = positional;
if (!stepsFile) {
  console.error('usage: node record-demo.mjs steps.json out-dir [--width W --height H --scale S]');
  process.exit(1);
}
const opt = (name, def) => {
  const v = Number(flags[name]);
  return Number.isFinite(v) && v > 0 ? v : def;
};
const width = opt('width', 1600);
const height = opt('height', 1000);
const scale = opt('scale', 2);
const steps = JSON.parse(fs.readFileSync(stepsFile, 'utf8'));
fs.mkdirSync(outDir, { recursive: true });

// Headless Chromium captures screencast frames at CSS-pixel size even with
// deviceScaleFactor 2; forcing the scale factor at launch gives true 2x frames,
// so zooms stay sharp in post.
const browser = await chromium.launch({ args: [`--force-device-scale-factor=${scale}`] });
const context = await browser.newContext({ viewport: { width, height }, deviceScaleFactor: scale });
const page = await context.newPage();
// A missing selector fails after 10 s instead of filling the recording with 30 s of waiting.
page.setDefaultTimeout(10_000);
const dest = path.join(outDir, 'demo.webm');
await page.screencast.start({ path: dest, size: { width: width * scale, height: height * scale }, fps: 30, quality: 90 });
const t0 = Date.now();
const events = [];
const now = () => Date.now() - t0;
const center = (b) => (b ? { x: b.x + b.width / 2, y: b.y + b.height / 2, w: b.width, h: b.height } : {});

async function box(selector) {
  const loc = page.locator(selector).first();
  await loc.scrollIntoViewIfNeeded();
  const b = await loc.boundingBox();
  return { loc, b };
}

// Eased scroll so the footage glides instead of jumping.
async function smoothScrollTo(targetY, duration = 900) {
  await page.evaluate(
    ([y, d]) =>
      new Promise((resolve) => {
        const start = window.scrollY;
        const delta = y - start;
        const t = performance.now();
        const ease = (p) => 1 - Math.pow(1 - p, 3);
        const tick = (n) => {
          const p = Math.min(1, (n - t) / d);
          window.scrollTo(0, start + delta * ease(p));
          if (p < 1) requestAnimationFrame(tick);
          else resolve();
        };
        requestAnimationFrame(tick);
      }),
    [targetY, duration],
  );
}

try {
for (const s of steps) {
  const label = s.label ?? '';
  if (s.goto) {
    // 'load' rather than 'networkidle': pages with autoplaying video never go idle.
    await page.goto(s.goto, { waitUntil: s.waitUntil ?? 'load' });
    events.push({ t: now(), type: 'goto', label, url: s.goto });
  } else if (s.click || s.hover) {
    const sel = s.click ?? s.hover;
    const { loc, b } = await box(sel);
    events.push({ t: now(), type: s.click ? 'click' : 'hover', label, selector: sel, ...center(b) });
    if (s.click) await loc.click();
    else await loc.hover();
  } else if (s.type) {
    const { loc, b } = await box(s.type);
    events.push({ t: now(), type: 'type', label, selector: s.type, ...center(b) });
    await loc.click();
    await loc.pressSequentially(s.text ?? '', { delay: s.delay ?? 60 });
  } else if (s.scrollTo || s.scrollBy) {
    const from = await page.evaluate(() => window.scrollY);
    const to = s.scrollTo
      ? await page.locator(s.scrollTo).first().evaluate((el, off) => el.getBoundingClientRect().top + window.scrollY - off, s.offset ?? 40)
      : from + s.scrollBy;
    const duration = Math.max(1, s.duration ?? 900);
    events.push({ t: now(), type: 'scroll', label, from, to, duration });
    await smoothScrollTo(to, duration);
  }
  if (s.wait) await page.waitForTimeout(s.wait);
}
} finally {
  // Always stop and close, so the video file is complete even if a step fails.
  const durationMs = now();
  events.push({ t: durationMs, type: 'end' });
  await page.screencast.stop().catch(() => {});
  await context.close();
  await browser.close();
  fs.writeFileSync(path.join(outDir, 'events.json'), JSON.stringify(events, null, 2));
  fs.writeFileSync(path.join(outDir, 'meta.json'), JSON.stringify({ width, height, scale, durationMs }, null, 2));
  console.log(`saved ${dest} and events.json (${events.length} events)`);
}
