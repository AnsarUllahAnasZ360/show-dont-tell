# Creative process

A storyboard you agree on, a defined look, audio-led timing, and a critique loop on real
renders. Scale each step to the job.

## 1. Brief

Write these down, even for a small video:

- **Promise:** one sentence. From what state, through what change, to what result.
- **Audience and setting:** who watches, where (a meeting, Slack, a PR, a feed), with
  sound or without.
- **Format, length, aspect ratio, frame rate.**
- **The ask:** what the viewer should do or decide afterwards.
- **Sources:** the code, docs, data and screens the video must be true to.

## 2. Storyboard

Use a scene table. Keep each scene to one beat.

```
VIDEO: title | format | audience | length | aspect | fps
PROMISE: from <state> -> <change> -> <result>
STRUCTURE: StoryBrand | context-proof-impact | SCQA | problem-solve | tutorial | data story

SCENE n  [start-end s]
  Beat:
  Narration (about seconds x 2.5 words):
  On-screen words (headline 4 or fewer, body 7 or fewer):
  Focal element (one):
  Motion and transition out:
  Evidence or asset (recording, screenshot, chart, image):
```

Show the storyboard to the user before building anything over 30 seconds or anything
other people will see. A rough animatic (stills with the voice) is an even better check
for long pieces.

## 3. Look and brand

- Find the brand: CSS variables, Tailwind theme, `DESIGN.md`, logo files, the marketing
  site. Capture real colors and fonts rather than describing them.
- Write `STYLE.md`: background, text, one accent, at most two font families, the spring
  and easing settings, standard durations (for example: enter 12 to 18 frames, exit 8,
  stagger 3 to 4 frames), and a banned list.
- Make one or two style frames of the hardest scene first. Agree on those, then build the
  rest to match.
- Steer away from the defaults models drift toward (beige with rust, dark slate with
  neon purple) unless the brand asks for them.

## 4. Build

- One component per scene and a shared tokens file.
- Name the key moments and compute everything else from them, so changing the voice or
  the music doesn't break later scenes.
- Use real assets: recordings, screenshots, data, logos.
- Keep a preview running (Remotion Studio or a local page) and check stills as you go.

## 5. Critique

Render a contact sheet (one frame per beat, or every second) with
[scripts/contact-sheet.sh](../scripts/contact-sheet.sh) and review it against the rubric
below. Separate lenses find more than one general pass; subagents work well as critics.
Fix the worst problems, re-render, and stop after two or three rounds. Check timing from
the timeline numbers in code; models judging timing from frames are unreliable.

| Criterion | What good looks like |
|---|---|
| Hook and promise | The problem or result is visible in the first three seconds; the viewer could repeat the promise. |
| Structure | The beats arrive in order; removing any scene would leave a gap; the ask is specific. |
| Clarity | One idea and one focal element per scene; it makes sense on mute; text within word limits. |
| Pacing | About 150 words a minute; no scene holds more than about six seconds without a change; text stays up long enough to read. |
| Layout | Safe margins, generous empty space, no overlaps or clipping, clear hierarchy, every frame works as a still. |
| Motion | No linear easing, consistent durations, staggered groups, transitions that mean something, visuals cued just before the words. |
| Brand and originality | Tokens used consistently, one accent color, real UI, nothing that looks like a template. |
| Accuracy and access | Every claim is true and shown; captions; readable contrast; no more than three flashes a second. |

## Transitions and effects

- Default to a hard cut on the beat. Use a transition only when it means something: a
  push or slide for "next", a fade for time passing or a new section, a match cut or
  morph when the same object carries into the next scene.
- Keep transitions short (8 to 15 frames at 30 fps) and consistent. In Remotion,
  `TransitionSeries` with `@remotion/transitions` gives fade, slide, wipe, flip and
  clock wipe.
- Crossfading a dark scene into a light one passes through muddy grey. Use a slide or a
  cut between scenes of opposite brightness.
- Effects that earn their place: a slow camera push on a still, parallax between two
  layers, subtle film grain, motion blur on fast moves (`@remotion/motion-blur`).
  Effects that look generated: glows, lens flares, particle bursts, everything
  bouncing in.

## 6. Review with the user

Share early cuts, not just the final render. Ask specific questions ("Is the second scene
too slow?", "Is this the right number to highlight?"). When they react to a variant, make
the next ones more like the one they liked.

## 7. Finish

Music ducked under narration, a handful of sound moments, captions, loudness normalized,
an H.264 MP4 with `yuv420p` pixel format, and the project source kept for edits. Write a
one-line summary to send with the video.

Before you send it:

- A contact sheet of the final render has been reviewed, start to end.
- Captions match the audio word for word; names and numbers are spelled right.
- No text sits in the outer 5% of the frame or under the captions.
- Audio is about -14 LUFS with peaks at or below -1 dBTP, with no clicks at cuts.
- The first frame works as a thumbnail, and so does the poster frame if you set one.
- Size fits where it's going. For a PR under 10 MB:
  `ffmpeg -i in.mp4 -vf scale=1280:-2 -c:v libx264 -crf 28 -preset slow -pix_fmt yuv420p -c:a aac -b:a 96k -movflags +faststart pr.mp4`.
