# Screen-recorded demos and PR videos

The goal: a short video of the real software doing the real thing, with a smooth cursor,
zooms into what matters, and narration, made without a human at the keyboard.

## Pick a tier

- **Quick proof for a PR.** Record the flow with Playwright and attach the file. Recent
  Playwright versions can draw the action cursor and chapter titles for you
  (`page.screencast` with `showActions()` and `showChapter()`).
- **Polished demo.** Record clean footage plus a log of every action, then add the cursor,
  zooms, captions and voice in Remotion. Steps below.
- **Screenshot walkthrough.** For small changes, a few high-resolution screenshots with a
  synthetic cursor and slow zooms often look better than live footage and never flicker.

## The polished pipeline

1. **Script the actions.** Write the flow as a Playwright script or a JSON list of steps.
   Run it once without recording to make sure it passes. Use local or staging data:
   the clicks are real, so a "Send" click sends.
2. **Write and voice the narration first.** One line per step. Measure each clip with
   `ffprobe` and let each step take the longer of its action time and its narration, so
   you never have to stretch audio afterwards.
3. **Record at high resolution and log the timeline.** Record at twice the viewport size
   so zooms stay sharp. What worked in testing (Playwright 1.65, Chromium): launch with
   `args: ['--force-device-scale-factor=2']`, set `deviceScaleFactor: 2` on the context,
   and record with `page.screencast.start({ path, size: { width: 2 * w, height: 2 * h } })`.
   Without the launch flag, both `recordVideo` and the screencast came out at CSS-pixel
   resolution, padded with grey to the requested size. For each action, log the time and
   the element's bounding box on the same clock as the recording.

   ```js
   const t0 = Date.now(); const events = [];
   async function act(label, locator, fn) {
     await locator.scrollIntoViewIfNeeded();
     const b = await locator.boundingBox();
     events.push({ t: Date.now() - t0, label, x: b.x + b.width / 2, y: b.y + b.height / 2, w: b.width, h: b.height });
     await fn(locator);
   }
   ```

   [scripts/record-demo.mjs](../scripts/record-demo.mjs) is a small starting point that
   records a list of steps and writes `events.json` beside the video.
4. **Plan the camera.** Turn events into zoom segments: around 1.4x for typing, 1.2x to
   1.8x for clicks, springs that are snappier going in than coming out, and a pan rather
   than a zoom-out when two targets are close together in time.
5. **Composite in Remotion.** Put the recording in `<Video>` (from `@remotion/media`)
   inside a wrapper whose `scale` and `transformOrigin` follow the zoom plan. Draw the
   cursor and click ripples from the same events. Frame it with padding, rounded
   corners and a shadow on a quiet background. Add each narration clip in its own
   `<Sequence>`.
6. **Review and deliver.** Look at a contact sheet of frames before posting. Export H.264
   MP4. For GitHub, keep it under 10 MB on free plans and attach it with
   `gh pr comment <n> --attach demo.mp4`.

## Pitfalls

- Cropping to zoom looks soft unless the source was recorded at 2x. Check the first frame
  of the file: if the page sits in the top-left quarter on a grey field, the scale flag
  didn't take.
- Navigate with `waitUntil: 'load'`, not `'networkidle'`: pages with autoplay video or
  polling never go idle, and the recording fills with half a minute of waiting.
- Anchor the event clock when recording starts; the first second is often a white frame,
  so trim it.
- The video file is only complete after `context.close()`.
- Keep CSS pixels, device pixels and output pixels straight; read bounding boxes at
  action time because scrolling moves things.
- In-page overlays disappear on navigation and can block clicks; draw the cursor in post
  instead.
- Hide or mask secrets, emails and customer data before recording, and use seeded
  accounts rather than the user's real session.
- Don't speed up footage in a way that implies a measured result.

## Terminals and CLIs

Don't screen-record a terminal. Write a VHS `.tape` file (`brew install vhs`) that types
the commands, then run `vhs demo.tape` for a crisp, repeatable MP4 or GIF.

## When automation fights you

OAuth pop-ups, flaky selectors and empty staging databases break automated recordings.
In those cases ask the user for a 20-second raw capture (Cap is a free, open-source
recorder; OpenScreen also works but its repo was archived in 2026) and do the trimming,
narration and captions yourself.

## Click-through demos

When people should explore at their own pace (onboarding, docs, sales follow-ups), a
click-through HTML demo or an interactive artifact can beat video. For reviews, changelogs
and meetings, video wins.
