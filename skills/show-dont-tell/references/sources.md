# Sources

What this skill draws on. Star counts were read from the GitHub API on 2026-11-25 and
will drift; treat them as a rough signal of adoption, not of quality.

## Official

- Claude Motion and Claude Dashboards announcement (Anthropic, 2026-10-08):
  https://claude.com/resources/articles/dashboards-and-motion . Claude writes animations
  as code (no video model), so words, numbers and timing stay editable; MP4 export; beta
  on Team and Enterprise plans.
- Claude Motion help article: https://support.claude.com/en/articles/17454997-get-started-with-claude-motion
- Remotion agent skills: https://www.remotion.dev/docs/agents/skills and
  https://github.com/remotion-dev/skills (about 8k stars). Remotion itself:
  https://github.com/remotion-dev/remotion (about 76k stars).
- Making videos with coding agents (Remotion docs): https://www.remotion.dev/docs/ai/coding-agents
- Remotion license and pricing: https://www.remotion.dev/docs/license
- HyperFrames (HeyGen, HTML + GSAP to video, Apache-2.0): https://github.com/heygen-com/hyperframes
- Manim Community: https://github.com/ManimCommunity/manim
- Playwright screencast API: https://playwright.dev/docs/api/class-screencast
- VHS terminal recorder: https://github.com/charmbracelet/vhs
- Anthropic, building effective agents (evaluator and optimizer loops):
  https://www.anthropic.com/engineering/building-effective-agents
- Anthropic, harness design for long-running apps (a skeptical separate evaluator):
  https://www.anthropic.com/engineering/harness-design-long-running-apps

## Community skills worth reading

| Repo | What to learn from it |
|---|---|
| [zhuyansen/awesome-claude-video-skills](https://github.com/zhuyansen/awesome-claude-video-skills) (2.7k) | A graded list of video skills and a benchmark. Its key finding: a bare agent already passes basic checks, so a skill earns its place through taste, workflow and QA, not boilerplate. |
| [OpenMontageInc/OpenMontage](https://github.com/OpenMontageInc/OpenMontage) (83k, AGPL) | A full production system with human approval gates at proposal, script, scene and publish. Good reference architecture, too heavy to copy. |
| [browser-use/video-use](https://github.com/browser-use/video-use) (32k) | Editing real footage from word-level transcripts and filmstrips; renders and checks its own output up to three times. |
| [Vincentwei1021/video-shotcraft](https://github.com/Vincentwei1021/video-shotcraft) (23k) | 124 shot recipe cards for Remotion product promos, with beat analysis and frame checks. |
| [latent-spaces/brag](https://github.com/latent-spaces/brag) (23k) | Turns a repo into a launch video on HyperFrames. |
| [lemomo-ai/lemo-opuscar](https://github.com/lemomo-ai/lemo-opuscar) (21k) | Dozens of film styles as short style files; shows that style direction beats scaffolding. |
| [feitangyuan/onetake](https://github.com/feitangyuan/onetake) (4.5k) | Films with no hard cuts: every beat grows out of the last. |
| [Vincentwei1021/anything2explainer](https://github.com/Vincentwei1021/anything2explainer) (3.6k) | Topic in, narrated explainer out. |
| [alchaincyf/huashu-motion](https://github.com/alchaincyf/huashu-motion) (3.2k) | Launch films that compose their own music. |
| [bangtutorial/bang-motion](https://github.com/bangtutorial/bang-motion) (3k) | Style brief approved before any code; "anti-slide" checks. |
| [digitalsamba/claude-code-video-toolkit](https://github.com/digitalsamba/claude-code-video-toolkit) (2.8k) | Commands for recording demos with Playwright, voiceover, brand and scene review. |
| [cth9191/animate](https://github.com/cth9191/animate) (2.3k) | Approve story, look and storyboard before it animates. |
| [showheyohtaki/motion-prompt](https://github.com/showheyohtaki/motion-prompt) (2.5k) | A clickable library of moving samples with ready prompts. |
| [Remocn/remocn](https://github.com/Remocn/remocn) (1.9k) | Copy-paste Remotion scenes and transitions. |
| [Tejashmakwana/motionmaxxing](https://github.com/Tejashmakwana/motionmaxxing) (1.8k) | Motion rules written as when, do, because; quality gates such as no long runs of still frames. |
| [vincentsch/explainroo](https://github.com/vincentsch/explainroo) (1.5k) | Fast local pipeline: Kokoro voice, Whisper word timing, canvas. |
| [adithya-s-k/manim_skill](https://github.com/adithya-s-k/manim_skill) (1.4k) | Separate rules for ManimCE and ManimGL. |
| [haidrrrry/claude-remotion-skill](https://github.com/haidrrrry/claude-remotion-skill) (1.3k) | Motion rules, patterns and a render, inspect, fix loop. |
| [diffusionstudio/lottie](https://github.com/diffusionstudio/lottie) (5.8k) | Text to Lottie animations. |
| [yihui-dev/awesome-opus5-5-videos](https://github.com/yihui-dev/awesome-opus5-5-videos) (16k) | Hundreds of videos made with Claude, each with its original prompt. Good for inspiration. |

Design taste skills that pair well with video work:
[pbakaus/impeccable](https://github.com/pbakaus/impeccable),
[Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill),
[Nutlope/hallmark](https://github.com/Nutlope/hallmark).

## Screen recording

| Repo | Notes |
|---|---|
| [gmpetrov/agent-screenplay](https://github.com/gmpetrov/agent-screenplay) | Agent writes a JSON scenario; spring zooms, cursor, captions, voice; ships an MCP server. |
| [shreyaskarnik/argo](https://github.com/shreyaskarnik/argo) | Playwright plus Kokoro; narration-aligned timing. |
| [greentfrapp/testreel](https://github.com/greentfrapp/testreel) | JSON steps to a polished demo with cursor and ripples. |
| [ThePatriczek/playwright-recast](https://github.com/ThePatriczek/playwright-recast) | Playwright traces to MP4 with auto-zoom and TTS. |
| [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) | `record` command with cursor and contact sheet. |
| [CapSoftware/Cap](https://github.com/CapSoftware/Cap) | Open-source recorder for when a human should capture. |
| [siddharthvaddem/openscreen](https://github.com/siddharthvaddem/openscreen) | Open-source Screen Studio alternative; archived as of 2026-11. |

## Voice, music and captions

- Cartesia MCP: https://docs.cartesia.ai/tools/ai/mcp ; timestamps:
  https://docs.cartesia.ai/examples/tts-sse-with-timestamps
- ElevenLabs hosted MCP: https://elevenlabs.io/docs/eleven-api/resources/mcp-server ;
  timestamps: https://elevenlabs.io/docs/api-reference/text-to-speech-with-timestamps ;
  music: https://elevenlabs.io/docs/capabilities/music ; sound effects:
  https://elevenlabs.io/docs/capabilities/sound-effects
- OpenRouter speech: https://openrouter.ai/docs/guides/overview/multimodal/tts
- Kokoro (local TTS): https://github.com/hexgrad/kokoro
- Remotion captions: https://www.remotion.dev/docs/captions/ and
  https://www.remotion.dev/docs/captions/create-tiktok-style-captions
- Freesound API: https://freesound.org/docs/api/overview.html
- ffmpeg filters (loudnorm, sidechaincompress): https://ffmpeg.org/ffmpeg-filters.html

## Practitioner write-ups (X, 2026)

- Florence, 18 repos for motion with Claude (570k views): https://x.com/flxrnc/status/2124231511499026436
- Deedy, a tuned video workflow: OpenRouter for media models, an animatic before the full
  video, a caption skill, a critic skill that checks screenshots and transcripts, and
  "avoid Claudisms": https://x.com/deedydas/status/2104957026199900220
- Javi, the honest counterpoint: viral "one prompt" videos were often fake; real results
  took days; parameterize keyframes: https://x.com/rameerez/status/2015859121661059569
- Theo, free formats for Claude Code videos, with a blind Claude rater:
  https://x.com/theoardley/status/2116684286837330374
- zero, a UI motion prompt template: every frame a pure function of time, springs,
  a beat grid, one test frame per beat before the full render:
  https://x.com/twoclipping/status/2103273003555402193
- Remotion's Agent Skills launch thread: https://x.com/Remotion/status/2013626968386765291

## Story and craft

- StoryBrand overview: https://www.gravityglobal.com/blog/complete-guide-storybrand-framework
- SCQA: https://slidemodel.com/scqa-framework-guide/
- Story Spine: https://www.tckpublishing.com/story-spine/
- UX in Motion principles: https://uxmag.com/articles/creating-usability-with-motion-the-ux-in-motion-manifesto
- Code2Video (planner, coder, visual critic): https://arxiv.org/abs/2510.01174
- WCAG flash threshold: https://www.w3.org/WAI/WCAG22/Understanding/three-flashes-or-below-threshold.html
