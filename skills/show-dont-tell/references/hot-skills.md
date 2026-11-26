# Hot-loaded specialist skills (on demand)

Do not install every graphics, 3D, and animation skill globally — that bloats every
conversation's context and creates a maintenance burden. Instead, **hot-load the latest
upstream skill temporarily** right when a project actually needs it.

Fetch only the specific raw `SKILL.md` or `README.md` you need with `curl -sL` (or save
it into the current project's scratch folder while building), read it, apply its rules,
and move on.

## 1. HyperFrames (HTML + GSAP video engine)

Repo: `https://github.com/heygen-com/hyperframes`

Fetch on demand when building HTML/GSAP motion graphics, editorial explainers, or
animated captions:

```bash
# Core craft and motion doctrine skills
curl -sL https://raw.githubusercontent.com/heygen-com/hyperframes/main/.agents/skills/motion-doctrine/SKILL.md
curl -sL https://raw.githubusercontent.com/heygen-com/hyperframes/main/.agents/skills/seam-craft/SKILL.md
curl -sL https://raw.githubusercontent.com/heygen-com/hyperframes/main/.agents/skills/cut-the-curve/SKILL.md
curl -sL https://raw.githubusercontent.com/heygen-com/hyperframes/main/.agents/skills/captions-overlay/SKILL.md
curl -sL https://raw.githubusercontent.com/heygen-com/hyperframes/main/.agents/skills/oversized-cursor/SKILL.md
curl -sL https://raw.githubusercontent.com/heygen-com/hyperframes/main/.agents/skills/changelog-video/SKILL.md
```

For a standalone HyperFrames project that wants the full local skill pack, run inside
that project folder only: `npx skills add heygen-com/hyperframes`.

## 2. Three.js core skills (PBR, lighting, shaders, R3F)

Repo: `https://github.com/CloudAI-X/threejs-skills`

Fetch only the module(s) relevant to the current scene:

```bash
# Replace <topic> with: fundamentals, lighting, materials, shaders, postprocessing,
# react-three-fiber, animation, geometry, interaction, loaders, performance, textures, asset-pipeline
curl -sL https://raw.githubusercontent.com/CloudAI-X/threejs-skills/main/skills/threejs-<topic>/SKILL.md
```

**Compatibility guardrail:** Keep `WebGL2 + pmndrs/postprocessing` strictly separate
from `Three.js WebGPU + TSL`. On `THREE.WebGPURenderer`, use native TSL
`RenderPipeline` (`pass()`, `bloom()`, `dof()`) — never `pmndrs/postprocessing`.

## 3. Three.js cinema graphics (bloom, camera direction, color grading)

Repo: `https://github.com/scottstts/Threejs-Awesome-Graphics-Agent-Skills`

Fetch when upgrading a Three.js scene from basic geometry to cinema lighting and
procedural shaders:

```bash
# Replace <topic> with: bloom, camera-direction, exposure-color-grading,
# atmosphere-aerial-perspective, procedural-materials, procedural-geometry,
# procedural-animation, procedural-fields, image-pipeline
curl -sL https://raw.githubusercontent.com/scottstts/Threejs-Awesome-Graphics-Agent-Skills/main/skills/threejs-<topic>/SKILL.md
```

## 4. Blender MCP (AI-directed 3D scenes & Metal Cycles renders)

Repo: `https://github.com/ahujasid/mcp-for-blender`

```bash
curl -sL https://raw.githubusercontent.com/ahujasid/mcp-for-blender/main/README.md
```

Local MCP server command: `uvx mcp-for-blender` (with the Blender addon enabled inside
Blender).

## 5. MolecularNodes (Pixar-grade protein & molecular cinema in Blender)

Repo: `https://github.com/BradyAJohnston/MolecularNodes`

Fetch when importing PDB, mmCIF, AlphaFold, or MD trajectory files into Blender
Geometry Nodes for high-craft scientific animations:

```bash
curl -sL https://raw.githubusercontent.com/BradyAJohnston/MolecularNodes/main/skills/mn-nodes/SKILL.md
curl -sL https://raw.githubusercontent.com/BradyAJohnston/MolecularNodes/main/skills/mn-render/SKILL.md
```

## 6. ManimCE + Manim Slides (3Blue1Brown explainers & animated decks)

Repo: `https://github.com/jeertmans/manim-slides`

```bash
curl -sL https://raw.githubusercontent.com/jeertmans/manim-slides/main/README.md
```

Pair with **Typst** (`typst`) for crisp TeX-free equations and vector diagrams, and use
ManimCE's native Pango text unless LaTeX is strictly required.

## 7. Web molecular viewers & auto-laid-out diagrams

When publishing interactive 3D biology or system architecture pages to the web:

- **Web 3D proteins/molecules:** Use `molstar` or `3dmol` (standard Three.js does not
  parse `.cif`/`.pdb` ribbons or ligands natively).
- **Auto-laid-out graphs & pathways:** Pair `@xyflow/react` with `elkjs` so nodes and
  edges route cleanly without manual overlap.
- **Scrollytelling & charts:** Combine `gsap` (`ScrollTrigger`) + `lenis` with `d3`,
  `@observablehq/plot`, `echarts`, or `deck.gl` + `maplibre-gl`.
