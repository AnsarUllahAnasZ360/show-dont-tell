#!/usr/bin/env bash
# Report what this machine has for making videos. Changes nothing.
# Usage: bash check-env.sh
ok() { printf "  \033[32m✓\033[0m %-22s %s\n" "$1" "$2"; }
no() { printf "  \033[33m·\033[0m %-22s %s\n" "$1" "$2"; }
have() { command -v "$1" >/dev/null 2>&1; }

echo "Core"
if have node; then ok node "$(node -v)"; else no node "install Node 20+ (https://nodejs.org)"; fi
if have ffmpeg; then ok ffmpeg "$(ffmpeg -version | head -1 | cut -d' ' -f3)"; else no ffmpeg "brew install ffmpeg  (or apt install ffmpeg)"; fi
if have ffprobe; then ok ffprobe "found"; else no ffprobe "comes with ffmpeg"; fi
if have python3; then ok python3 "$(python3 --version 2>&1 | cut -d' ' -f2)"; else no python3 "needed for Manim and small audio scripts"; fi
if have git; then ok git "found"; else no git "install git"; fi

echo "Rendering"
if [ -f node_modules/remotion/package.json ]; then ok remotion "in this project ($(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' node_modules/remotion/package.json | head -1))"; else no remotion "not in this folder; new project: npx create-video@latest --yes --blank --no-tailwind my-video"; fi
found=""
for d in "$HOME/.claude/skills" ".claude/skills" "$HOME/.agents/skills" ".agents/skills" "$HOME/.gemini/config/skills" "$HOME/.codex/skills" "$HOME/.cursor/skills"; do
  if ls "$d" 2>/dev/null | grep -qi remotion; then found="$d"; break; fi
done
if [ -n "$found" ]; then ok "remotion skills" "in $found"; else no "remotion skills" "npx skills add remotion-dev/skills"; fi
if have manim; then ok manim "$(manim --version 2>/dev/null | head -1)"; else no manim "pip install manim  (only for math or concept explainers)"; fi
if have vhs; then ok vhs "found"; else no vhs "brew install vhs  (only for terminal demos)"; fi

echo "Recording"
if have node && node -e "require.resolve('playwright')" >/dev/null 2>&1; then ok playwright "package in this folder"; else no playwright "npm i playwright (in the folder you record from)"; fi
bdir="${PLAYWRIGHT_BROWSERS_PATH:-}"
for d in "$bdir" "$HOME/Library/Caches/ms-playwright" "$HOME/.cache/ms-playwright"; do
  if [ -n "$d" ] && ls "$d" 2>/dev/null | grep -q chromium; then bdir="$d"; break; else bdir=""; fi
done
if [ -n "$bdir" ]; then ok "playwright browsers" "chromium in $bdir"; else no "playwright browsers" "npx playwright install chromium"; fi

echo "Voice, images, music (API keys in the environment; MCP connectors are not listed here)"
for k in CARTESIA_API_KEY ELEVENLABS_API_KEY OPENROUTER_API_KEY GEMINI_API_KEY GOOGLE_API_KEY OPENAI_API_KEY FISH_AUDIO_API_KEY FREESOUND_API_KEY; do
  if [ -n "${!k:-}" ]; then ok "$k" "set"; else no "$k" "not set"; fi
done
echo
echo "Also check your agent's connected MCP servers (for example Cartesia, ElevenLabs, OpenRouter)."
echo "No voice provider at all? Kokoro runs locally for free: https://github.com/hexgrad/kokoro"
