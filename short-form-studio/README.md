# short-form-studio

A Claude Code skill for turning a raw talking-head recording into a polished short (YouTube Shorts, Reels, TikTok) with clean on-screen graphics, all without a video editor. It uses [Hyperframes](https://hyperframes.heygen.com) (HTML to video) for the overlays and render, and ships a small local fallback for cutting footage.

The skill encodes a **gated** loop so the agent never runs away with your video:

```
script (agent) -> record (you) -> cut (you) -> storyboard (agent) -🚦-> assets (you) -> Hyperframes build + quiet SFX + render (agent) -🚦-> deliver
```

You record and cut. The agent scripts, storyboards, builds the Hyperframes composition, and renders at delivery quality. Two human approval gates: the storyboard, and the final render.

## Install

```bash
# 1. add the Hyperframes skills (the rendering engine the agent drives)
npx skills add heygen-com/hyperframes

# 2. add this skill
npx skills add josue-commits/short-form-studio
```

Or just drop `.claude/skills/short-form-studio/` into your project's `.claude/skills/`.

Then, in Claude Code:

> Let's make today's short about [topic]. Use short-form-studio.

## Requirements

- **Node.js 22+** and **FFmpeg** (Hyperframes needs both)
- For the optional local cut fallback: `whisper-cpp` (`brew install whisper-cpp`) with a model at `models/ggml-base.en.bin`

## What's in here

| Path | What |
|---|---|
| `.claude/skills/short-form-studio/SKILL.md` | the gated production loop |
| `GUIDELINES.md` | the full craft playbook: hooks, length, glass-bubble style, SFX, quality rules |
| `edit/` | optional local cut tools (whisper + ffmpeg) for when you want the agent to cut |
| `hf/template/` | a reference Hyperframes composition showing the glass-bubble overlay style |

## The house style

Translucent frosted "glass bubble" overlays floating over the video, not solid branded cards. Serif display font (Newsreader) + grotesque sans (Schibsted Grotesk), one warm accent color, everything in the lower third so it never covers your face. See `hf/template/index.html`.

## License

MIT. Use it, change it, ship your own shorts.
