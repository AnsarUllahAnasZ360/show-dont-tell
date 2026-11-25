# Voice, music, sound effects and captions

Audio decides whether a video feels finished. Narration carries the story, music sets the
energy, and a few well-placed sounds make motion feel physical.

## Writing narration

- Plan on about 150 words per minute (2.5 words a second). Measure the real audio after
  generating and adjust.
- One idea per sentence, mostly under 20 words, but vary the length. A string of
  three-word fragments is the fastest way to sound machine-made.
- Use "you", active voice and contractions. Prefer concrete nouns and real numbers to
  adjectives.
- Write things the way they're spoken: "twenty twenty-six", "A P I", "doctor". No
  symbols, slashes or parentheses.
- Commas give a breath and periods a stop. Use explicit pause tags sparingly.
- Emphasis: one word per sentence, usually by putting it last.
- Avoid hype words and narrator tics: "game-changer", "unlock", "supercharge",
  "seamless", "let that sink in", "here's the thing".
- Writing as the user: borrow their phrases and rhythm from what they've written or
  dictated, keep their opinions intact, and remove filler words.

### Story structures for narration

- **StoryBrand (pitches, explainers, launches):** the viewer is the hero with a problem;
  you are the guide with a simple plan; show the success they get and make one clear ask.
- **Context, proof, impact (PR and status videos):** what this is, watch it work, why it
  matters. Engineers prefer this plain shape.
- **SCQA (plans and proposals):** situation, complication, question, then the answer
  first and the reasons after.
- **Problem, agitate, solve (ads and short explainers):** keep the agitation short.

A StoryBrand rewrite, before and after. The first version talks about the product; the
second puts the viewer in the story, names the cost of the problem, and ends on one ask.

> Before: "Our new triage tool uses AI to classify support tickets and route them to
> the right team. It supports many channels and integrates with your helpdesk."
>
> After: "Your best people spend the first hour of every shift sorting tickets, and the
> urgent ones still wait. Connect your inbox, and every ticket lands with the right
> person, already tagged. Try it on yesterday's queue."

The shape: the viewer and their problem, what it costs them, the guide and a simple plan,
what success looks like, one clear call to action. Keep each part to a sentence or two.

## Text to speech

Use the provider that is already connected. All of these work well for narration:

| Provider | Notes |
|---|---|
| Cartesia (Sonic) | Official MCP server; fast, natural voices; speed, volume and emotion controls; pronunciation dictionaries for product names; voice cloning on paid plans; word timestamps from the API. |
| ElevenLabs | Hosted MCP server; very expressive models with audio tags like `[laughs]` and `[whispers]`; character-level timestamps; also does music and sound effects. |
| Gemini TTS | Style prompts and inline tags, free tier, up to two speakers. |
| OpenRouter speech | One key for dozens of TTS models, including free options. |
| Kokoro (local) | Free, open weights, runs on a laptop; good for drafts and internal videos. |

Practical habits:

- Generate one file per scene so retakes are cheap and scene lengths come straight from
  the files. Leave a quarter second of silence at each end.
- Fix product names with a pronunciation dictionary or phonetic spelling.
- Get word timestamps when you can (from the TTS API, or by transcribing the clip with a
  Whisper model) and use them to land visuals and captions on exact words.
- If the user wants their own voice, ask for a clean 20 to 30 second recording and use
  the provider's voice cloning. Never clone anyone else's voice.

## Music

- Best: a track the user provides or has rights to.
- Generated: ElevenLabs Music and Google Lyria produce licensed beds from a prompt
  ("warm minimal electronic, 100 BPM, no vocals, steady build").
- Code-made: a simple bed synthesized in code (pads and a soft pulse) has no licensing
  questions at all and is fine for internal videos.
- Royalty-free libraries (YouTube Audio Library, Pixabay, Mixkit) usually have to be
  downloaded by hand; ask the user to drop files into `public/audio/`.
- Pick tempo for the edit: frames per beat = fps x 60 / BPM. Cut on beats where you can.

## Sound effects

Three to five sound moments per minute is plenty. Start a whoosh three to six frames
before a cut, put a pop or tick exactly on the frame where something lands, and end a
riser on the reveal. Remotion hosts a few basic ones (`https://remotion.media/whoosh.wav`,
`mouse-click.wav`, `switch.wav`, `ding.wav`); ElevenLabs can generate any you describe;
Freesound has many under CC0.

## Captions

Burn captions in for anything watched on mute. Use the narration text with word
timestamps (`@remotion/captions` turns them into pages with `createTikTokStyleCaptions`),
or transcribe the final voice track with Whisper (`@remotion/install-whisper-cpp`) when
timestamps aren't available. Keep lines under about 42 characters.

## Mixing

- Levels to start from: voice at full, music around 0.15 to 0.25 under speech, effects
  around 0.3 to 0.6.
- Duck the music under the voice. In Remotion, compute the music volume from the frame
  and the voice segments; in ffmpeg, use `sidechaincompress`.
- Normalize the final mix to about -14 LUFS with true peak at or below -1 dBTP for web
  playback ([scripts/master-audio.sh](../scripts/master-audio.sh) does a two-pass
  `loudnorm`).
- Add short fades at every cut so audio never clicks.
- You can't hear the result. Ask the user to listen once before it goes out.

```bash
# Duck a music bed under a voice track. The mix ends when the voice ends; pad the voice
# with apad=pad_dur=3 first if the music should ring out. Both inputs are converted to
# 48 kHz stereo so the sidechain gets matching formats.
ffmpeg -i voice.wav -i music.mp3 -filter_complex \
"[0:a]aformat=sample_rates=48000:channel_layouts=stereo,asplit=2[v][sc];\
[1:a]aformat=sample_rates=48000:channel_layouts=stereo,volume=0.5[m];\
[m][sc]sidechaincompress=threshold=0.03:ratio=8:attack=20:release=400[duck];\
[v][duck]amix=inputs=2:duration=first:normalize=0[a]" \
-map "[a]" mix.wav
# Then master loudness on the finished video: scripts/master-audio.sh video.mp4 final.mp4
```
