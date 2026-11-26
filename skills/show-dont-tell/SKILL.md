---
name: show-dont-tell
description: Turn plans, research, concepts and finished work into short videos people actually watch, instead of walls of text. Use when the user asks for a video, an animation, motion graphics, an explainer, a narrated walkthrough, a feature demo or PR video with a screen recording, a launch film, a UGC-style clip, a voiceover, or wants to present an idea, plan or update visually. Covers choosing the kind of video, the tools (Remotion, HyperFrames, Manim, Playwright recording, Three.js), voice, music, images, and a storyboard-to-critique creative process.
---

# Show, don't tell

People understand what they see much faster than what they read. This skill helps you
turn an idea, a plan, a codebase, or a shipped feature into a short video (or, when it
fits better, an interactive page) that a busy person can take in within a couple of
minutes.

It is a map, not a pipeline. Pick the parts that fit the request, scale the process to
the stakes, and skip what doesn't help. A 30-second explainer for the user's own
understanding needs none of the ceremony a team launch film does.

## 1. Decide what you're making

Start from who will watch it, where, and what they should know or do afterwards. Then
pick a format. Each has its own shape; see [video-types.md](references/video-types.md).

| Format | Use it for | Typical length |
|---|---|---|
| Concept explainer | Making an idea click: how something works, why it matters | 45 s to 2 min |
| Plan or proposal walkthrough | Getting a decision or alignment before a meeting | 90 s to 3 min |
| Feature demo or PR video | Showing working software: what changed, proof it works | 20 s to 90 s |
| Update or status video | Replacing the "let me walk you through it" part of a call | 60 s to 2 min |
| Launch or announcement film | Selling one promise with energy | 30 s to 90 s |
| UGC-style or social clip | Hook-first vertical video for feeds | 15 s to 45 s |
| Data story | Making one number matter | 30 s to 90 s |
| Tutorial | Teaching a task step by step | 2 to 5 min |

Not every message wants to be a video. If the viewer needs to explore, compare, or click
around (a dashboard, a prototype, a dense plan with drill-downs), build an interactive
HTML artifact instead, or embed the video inside one. For a tiny PR, a few annotated
screenshots may be enough.

## 2. Check the environment

Run [scripts/check-env.sh](scripts/check-env.sh). It reports what is installed (Node,
ffmpeg, Playwright, Python, Manim, VHS) and which voice, image and music providers are
reachable through API keys. Install only what this video needs; setup commands for each
tool are in [toolkit.md](references/toolkit.md). Also check which MCP connectors you
have (TTS, image generation, browser). Use what's already connected before asking the
user for keys.

## 3. Choose the tools

| Need | Good default | Alternatives |
|---|---|---|
| Motion graphics, kinetic type, data viz | Remotion (React, frame-driven) | HyperFrames (HTML + GSAP), Claude Motion if the user's plan has it |
| Math, algorithms, technical intuition | Manim | Remotion with SVG |
| The real product in action | Playwright recording with an event log, composited in Remotion | Screenshots animated with a synthetic cursor; a human capture with Cap for messy auth flows |
| Terminal or CLI demos | VHS `.tape` files | asciinema |
| 3D scenes | Three.js / React Three Fiber via `@remotion/three` | Blender MCP |
| Voiceover | Whatever TTS is connected (Cartesia, ElevenLabs, Gemini TTS, OpenRouter speech) | Kokoro locally for free drafts |
| Images, style frames, textures | Whatever image model is connected (OpenRouter, Gemini) | Code-drawn SVG and canvas (no model needed) |
| Music and sound effects | Music the user supplies, or ElevenLabs Music / Lyria | Code-synthesized beds; Remotion's hosted SFX |

Details, trade-offs and install lines are in [toolkit.md](references/toolkit.md). For
specialist craft guidance (HyperFrames, Three.js PBR/shaders/cinema lighting, Blender MCP,
MolecularNodes, and Manim Slides), **hot-load the latest upstream skill on demand** from
[hot-skills.md](references/hot-skills.md) instead of keeping every skill permanently
installed. For recording real software, read [screen-demos.md](references/screen-demos.md).
For voice, music, captions and mixing, read [voice-and-sound.md](references/voice-and-sound.md).

## 4. A creative process that works

The loop the best agent-made videos share. Use what helps: a quick explainer for the
user alone can go straight to building; anything shown to other people deserves the
storyboard approval and a critique round. Details, a storyboard template and a critique
rubric are in [creative-process.md](references/creative-process.md).

- **Understand, then promise.** Read the code, doc or PR first. Write one sentence: from
  what state, through what change, to what result.
- **Storyboard, then approval.** A scene table (beat, narration, on-screen words, focal
  element, motion). Revisions are cheap here and expensive after rendering.
- **Set the look.** Brand tokens from the project, a short `STYLE.md` (palette, one or two
  fonts, one accent, easing, banned list), and a style frame to settle taste.
- **Voice first.** Synthesize narration per scene, get word timestamps (from the TTS or a
  Whisper pass), and cue each visual to its word. Never stretch audio to fit.
- **Build in scenes** with shared tokens and named, parameterized keyframes.
- **Critique the render, not the code.** Review stills or a contact sheet
  ([scripts/contact-sheet.sh](scripts/contact-sheet.sh)) against the rubric, ideally
  with a separate critic. Two or three rounds is where it stops improving.
- **Polish.** Ducked music, a few sound moments, captions, loudness
  ([scripts/master-audio.sh](scripts/master-audio.sh)). Ask the user to listen once,
  because you can't hear the mix.

When taste is uncertain, make two or three short variants of the key scene and let the
user pick. Choosing is easier than describing.

## 5. Craft defaults

These are the habits that separate a watchable video from a generated-looking one.

- Hook in the first three seconds: the problem or the result is on screen in frame one.
  No logo intro.
- One idea and one focal element per scene. Something meaningful changes every two to
  four seconds.
- Narration at about 150 words per minute. Word budget is roughly seconds times 2.5.
- On-screen text is short: headlines of four words or fewer, supporting lines of seven
  or fewer. If it doesn't fit, cut words instead of shrinking type. At 1080p, keep body
  text at 44 px or more and headlines at 84 px or more.
- Cue visuals a few frames before the spoken word lands, and keep emphasis to one word
  per line.
- Drive every animation from the frame number. Springs without bounce for entrances,
  ease-out arrivals, shorter exits than entrances, staggered groups. Never linear easing
  except for progress and rotation.
- Keep a safe margin around the edges and at least a third of the frame empty.
- Use real product UI and real numbers. Every claim on screen should be true.
- Banned by default: a fade-and-slide-up on everything, glows and gradients on UI
  chrome, fake telemetry and "LIVE" dots, particle bursts, bouncy easing, stock-looking
  templates, and dead frames where nothing moves.

## 6. Story and voice

Match the structure to the job. For pitches and explainers, the viewer is the hero: their
problem, a guide, a simple plan, the outcome, one clear ask (StoryBrand). For internal
plans and PR videos, keep it plain: context, live proof, impact. For proposals, lead
with the answer (SCQA). Write the narration the way the person would say it out loud:
varied sentence lengths, contractions, concrete nouns, no chains of three-word
fragments, no hype words. When the user asks for their own voice, borrow their phrasing
from what they've written or said. Full guidance is in
[voice-and-sound.md](references/voice-and-sound.md).

## 7. Be honest about effort

The first render of a coded video usually looks generic. Good results come from a clear
storyboard, real assets, a defined style, and a few rounds of critique on rendered
frames. Say so when it helps the user set expectations, and show progress early (a
storyboard, a style frame, a rough cut) instead of disappearing for an hour.

## 8. Deliver it where it will be watched

- A PR: an MP4 under 10 MB attached with `gh pr comment --attach demo.mp4`, or linked.
- A meeting or async update: the MP4 plus a one-line summary of the ask.
- A shareable page: embed the video in an interactive HTML artifact next to the details
  people may want to click into.
- Keep the source (the Remotion project, the script, the storyboard) so anyone can
  change a word or a number and re-render.

## References

- [video-types.md](references/video-types.md): structures, lengths and visual techniques for each format, with example prompts.
- [toolkit.md](references/toolkit.md): frameworks, renderers, image and 3D tools, install lines, and when to use which.
- [hot-skills.md](references/hot-skills.md): on-demand upstream skills (HyperFrames, Three.js, Blender MCP, MolecularNodes, Manim Slides) to fetch temporarily only when needed.
- [screen-demos.md](references/screen-demos.md): recording real software with a cursor, zooms and narration; PR videos.
- [voice-and-sound.md](references/voice-and-sound.md): narration writing, TTS options, music, sound effects, captions and mixing.
- [creative-process.md](references/creative-process.md): storyboard template, style setup, critique rubric and review loop.
- [sources.md](references/sources.md): the guides, skills and repos this skill draws on, with links.
