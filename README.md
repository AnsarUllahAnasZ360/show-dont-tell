# show-dont-tell

A lightweight agent skill for turning plans, research, concepts and finished work into
short videos people actually watch, instead of walls of text.

It is a map, not a pipeline: it helps your agent pick the right kind of video, the right
tools for what's installed, and a creative process that fits the stakes. It never forces
a fixed workflow on you.

## Install

```bash
npx skills add AnsarUllahAnasZ360/show-dont-tell
```

The installer asks which agents to add it to (Claude Code, Antigravity, Codex, Cursor and
others). To install for Claude Code only, globally:

```bash
npx skills add AnsarUllahAnasZ360/show-dont-tell -g -a claude-code -y
```

For coded motion graphics, also add Remotion's own skills:

```bash
npx skills add remotion-dev/skills
```

## Then just ask

- "Make a 90-second video that walks the team through this plan before Thursday's call."
- "Record a short PR video of the new checkout flow running locally, with narration."
- "Explain how our retry queue works as an animation."
- "Turn this research doc into a two-minute explainer in my voice."
- "Make a 20-second vertical clip announcing the launch."

## What's inside

```
skills/show-dont-tell/
├── SKILL.md                    the map: formats, tools, process, craft defaults
├── references/
│   ├── video-types.md          eight formats, their structure and length
│   ├── toolkit.md              Remotion, HyperFrames, Manim, Playwright, 3D, images
│   ├── screen-demos.md         recording real software with cursor, zooms, narration
│   ├── voice-and-sound.md      narration, TTS options, music, SFX, captions, mixing
│   ├── creative-process.md     storyboard template, STYLE.md, critique rubric
│   └── sources.md              the guides, skills and repos this draws on
└── scripts/
    ├── check-env.sh            what's installed and which providers are reachable
    ├── record-demo.mjs         Playwright: steps.json in, 2x video + events.json out
    ├── contact-sheet.sh        one image of frames from a render, for critique
    └── master-audio.sh         two-pass loudness normalization to -14 LUFS
```

## What it needs

Nothing is required up front. Node and ffmpeg cover most videos. Playwright is for
screen recordings, Manim for math-heavy explainers, VHS for terminal demos. For
narration, any connected TTS works (Cartesia, ElevenLabs, Gemini, OpenRouter speech), and
Kokoro runs locally for free. Run `skills/show-dont-tell/scripts/check-env.sh` (or ask your agent to) to see what you have.

## Made with it

The skill's own explainer video was made from one dictated prompt: written with Gemini,
directed and built by Claude in Claude Code, voiced by Cartesia, rendered with Remotion,
with a live product recorded by Playwright and music synthesized in code.

## License

MIT
