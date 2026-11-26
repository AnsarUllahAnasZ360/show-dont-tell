# Toolkit

What each tool is good at, how agent-friendly it is, and how to set it up. Prefer the
tool the project already uses; otherwise pick by the kind of video.

## Rendering frameworks

### Remotion (React)

The most established option and the default for motion graphics, data-driven
explainers, product demos and anything with captions. Every frame is a React render of
`useCurrentFrame()`, so output is deterministic.

- Start: `npx create-video@latest --yes --blank --no-tailwind my-video`
- Official agent skills (install these alongside this one):
  `npx skills add remotion-dev/skills` or `npx remotion skills add` inside a project.
  The `remotion-best-practices` skill routes to markup, transitions, audio, captions,
  3D, rendering and more.
- Preview while you work: `npx remotion studio`. Render stills to check frames:
  `npx remotion still <id> out.png --frame=120`. Render the video:
  `npx remotion render <id> out/video.mp4`.
- Useful packages: `@remotion/transitions`, `@remotion/media` (`<Audio>`, `<Video>`),
  `@remotion/google-fonts`, `@remotion/captions`, `@remotion/three`, `@remotion/shapes`,
  `@remotion/paths`, `@remotion/noise`.
- Remotion Elements is a catalog of ready-made components (titles, backgrounds, charts,
  captions): `npx remotion elements use <url>`.
- License: free for individuals and companies of up to three people; larger companies
  need a company license (remotion.dev/docs/license).
- Gotchas: CSS transitions and keyframe animations don't render; drive everything with
  `interpolate()` and `spring()`. Get `fps` from `useVideoConfig()` and write timings as
  seconds times fps.

### HyperFrames (HTML + GSAP, by HeyGen)

Plain HTML and CSS scenes animated with a paused GSAP timeline, rendered frame by frame
in headless Chrome. Very agent-friendly because models write HTML well, and your video
can share tokens and components with your web artifacts. Apache-2.0.

- `npx skills add heygen-com/hyperframes` (ships its own skills, a linter, and snapshot
  review commands).
- Rules it enforces: one paused timeline registered on `window.__timelines`; no
  `Date.now()`, unseeded randomness, network fetches, or infinite repeats.

### Manim (Python)

The standard for math, algorithms and technical intuition, in the style of 3Blue1Brown.
Agents fix their own layout errors well with quick low-quality renders.

- `pip install manim` (ManimCE). ManimGL is a different, incompatible API; pick one.
- Fast preview: `manim -pql scene.py SceneName`.
- Not a fit for branded marketing or product UI.

### Plain HTML + GSAP + Playwright + ffmpeg

The no-framework route: one HTML file where every style is computed from a time value
inside a `seek(t)` function, captured frame by frame with Playwright and encoded with
ffmpeg. Good for short, single-scene motion pieces. Rendering four sub-frames per frame
and blending them with ffmpeg's `tmix` filter gives real motion blur.

### Claude Motion

If the user is on a Claude Team or Enterprise plan with Motion turned on, Claude can
build a short animated explainer as an artifact from a report, chart or walkthrough and
export an MP4. It is code-driven (no video model), so words, numbers and timing stay
editable. It is the fastest route for a quick chart or exec explainer; it does not record
live software or mix multi-track audio.

### Others worth knowing

- **Motion Canvas**: generator-based canvas animation, good for hand-made procedural
  explainers. Agents make more API mistakes here than with React or HTML.
- **Lottie**: vector animations that can also ship inside an app; models can write
  Lottie JSON directly ([diffusionstudio/lottie](https://github.com/diffusionstudio/lottie)), and `@remotion/lottie` plays it.
- **Rive**: play existing `.riv` files; authoring still needs the Rive editor.
- **Editframe, Revideo, Twick**: renderer or editor SDKs; useful for building video
  products, rarely needed for a one-off video.

## Infographics and code-driven visuals

Charts, diagrams and numbers are where coded video beats everything else, because the
data stays real and editable.

- Draw charts as SVG from a data array inside the scene. Use D3 only for the math
  (`d3-scale`, `d3-shape` for paths); let React render the elements.
- Animate the way the eye reads: bars grow from the baseline with a small stagger, lines
  draw on with `stroke-dashoffset`, numbers count up with `tabular-nums` so they don't
  jitter, and the final state holds for at least a second and a half.
- Label directly on the marks, highlight the one series that matters in the accent
  color, and keep the rest quiet. State the finding as the scene's title.
- For diagrams and flows, build nodes and edges from data and reveal them in the order
  the narration walks them. A token that travels the path explains a pipeline better
  than arrows appearing all at once.
- Mermaid or Excalidraw is fine for a quick static diagram; Manim for math; Remotion
  for everything that has to move with the voice.
- Use the real numbers from the source, and check them against it before rendering.

## Recording software

See [screen-demos.md](screen-demos.md). In short: Playwright (`page.screencast` or
`recordVideo`) with an event log for zooms, VHS for terminals, a human-recorded clip in
Cap when auth flows make automation fragile.

## 3D

- `@remotion/three` with React Three Fiber for 3D inside a Remotion scene. Drive camera
  and objects from the frame number (`useCurrentFrame()`), not from `useFrame` clocks.
- Keep **WebGL2 + `pmndrs/postprocessing`** strictly separate from **Three.js WebGPU +
  TSL** (`THREE.WebGPURenderer` uses native TSL `RenderPipeline` — `pass()`, `bloom()`,
  `dof()` — and breaks with `pmndrs/postprocessing`).
- **Blender via `mcp-for-blender`** (`uvx mcp-for-blender`) for studio-lit raytraced 3D,
  plus **MolecularNodes** for PDB/AlphaFold protein cinema.
- **Web molecular viewers:** Use `molstar` or `3dmol` when publishing interactive 3D
  protein/ligand structures on web pages.
- Hot-load the latest upstream Three.js, Blender MCP, MolecularNodes, HyperFrames, and
  Manim Slides skills on demand from [hot-skills.md](hot-skills.md).

## Images

Use images for style frames, backgrounds, textures, illustrations and storyboard
thumbnails, not for UI or text that must be exact.

- Whatever image model is connected: OpenRouter (one key for many image models), Gemini
  image models, or an in-house service.
- Keep one consistent prompt preamble (palette, lighting, medium) across a set, match
  the aspect ratio to where the image sits in the frame, and leave clean negative space
  where text will go.
- Code-drawn SVG, canvas and shaders often look more on-brand than generated images and
  never contain garbled text.
- Generate two or three options for a hero image and pick; don't regenerate endlessly.

## Audio

Voice, music, sound effects, captions and mixing are covered in
[voice-and-sound.md](voice-and-sound.md).

## Useful command-line tools

- `ffmpeg` and `ffprobe` for trimming, converting, measuring and mixing
  (`brew install ffmpeg`).
- `yt-dlp` to pull clips the user has rights to use; archive.org's free API for public
  domain footage and recordings.
- `gh` to attach videos to pull requests (`gh pr comment <n> --attach demo.mp4`).
