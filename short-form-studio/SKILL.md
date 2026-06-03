---
name: short-form-studio
description: Run the end-to-end production loop for a short-form talking-head video (YouTube Shorts, Reels, TikTok) built with Hyperframes. Use this skill whenever the work is scripting, storyboarding, building, or finishing a short, including "let's make today's short", "write a script about this feature", "here's my recorded clip, storyboard it", "what should we put on screen", "build the Hyperframes video", "add the overlays / B-roll / SFX", or "render the final and put it in the folder". It encodes the gated loop (script, you record and cut, storyboard, approval plus assets, Hyperframes build, quiet SFX, render at delivery quality) and the two human approval gates. Do NOT use it to cut raw footage (you cut your own), for generic web or website compositions, or for plain how-to questions.
---

# short-form-studio

The repeatable loop for shipping one short-form video. **You record and cut the footage yourself** and hand back the edited file. The agent's job is the script, the storyboard, the Hyperframes build, and a clean high-quality render. Read `GUIDELINES.md` for the craft detail; this skill is the orchestration and the **gates**.

## Non-negotiables (always)

- **Research and verify first.** Web-verify every named repo, tool, or stat before locking a script. Do not scaffold a whole pipeline on turn one.
- **Teleprompter format.** The final script is pure-prose `.txt`, zero symbols or headings. Lead with it in chat.
- **Hooks are direct.** No metaphors, no decoding, no ambiguous verbs ("install", not "drop"). Use a news-drop for real launches ("X just released Y..."); otherwise the conditional-identity workhorse ("If you're doing X without Y, you're [literal pain]").
- **Ask before publishing or posting.** Show the work first.
- **Don't overcomplicate.** Smallest correct step. This is a sequential, gated process, not a multi-agent fan-out.

## The loop

```
script (agent) -> record (you) -> cut (you) -> storyboard (agent) -🚦-> assets (you) -> Hyperframes build + quiet SFX + render (agent) -🚦-> deliver to folder
```

### Step 1 — Script
Research the topic, verify resources, write the script in the creator's voice. Deliver the **teleprompter `.txt`** (lead with it) plus a structured `.md` for archive. On approval, ask before pushing anywhere.
-> **You record.**

### Step 2 — You hand back the edited cut
You deliver the **already-cut** video (mistakes, silences, retakes, and speed all done). **The agent does not cut footage.** Note its resolution, fps, and bitrate. That is the **delivery-quality target** for the final render. (A local whisper + ffmpeg fallback lives in `edit/` for when you explicitly ask the agent to cut.)

### Step 3 — Storyboard ⟶ 🚦 GATE 1
Break the cut into scenes. For each scene: the spoken line, the timing, the planned overlay or animation, and the asset it needs. Decide which assets **you screenshot** versus which the **agent generates** (stat cards, mock terminals, counters, CTA). Build a **one-page HTML storyboard** (real video frames + planned overlays + timing + the spoken line). This minimizes back-and-forth.
**STOP. Show the storyboard. Wait for the green light plus the assets.**

### Step 4 — Hyperframes build
With approval and assets in hand, build the composition in `hf/<name>/` (read the `hyperframes` skill first). House style: glass bubbles (not branded cards), lower-third clear of the face, a hook title at the top, a single accent color, a distinctive serif + grotesque font pairing via local `@font-face` (Inter is banned as an AI design tell). Sync each overlay to the 1x spoken moment. `npx hyperframes lint` must report 0 errors.

### Step 5 — Add SFX (quiet!)
Layer subtle SFX synced to entrances and animations (a whoosh on takeovers, a soft pop on cards, a rising tick on counters, a chime on a green or success beat) on their own audio track.
**Keep them quiet.** Whooshes and ambient `data-volume` around **0.05 to 0.15**, accents **at or below 0.3**. The voice-over always sits on top.

### Step 6 — Render and deliver ⟶ 🚦 GATE 2
Open Hyperframes Studio, **show the creator** for review. On approval, **render at delivery quality** and place the file in the folder:
- Feed the **highest-quality source** (do not pre-downscale; the camera's native resolution is the ceiling).
- Re-encode only if needed for reliable seeking, near-lossless: `-crf 15 -g 30 -keyint_min 30`.
- `npx hyperframes render --crf 15` (`--fps`, `--quality high`, `--video-bitrate`, `--resolution` also available).
- **The delivered file must match the quality you handed over.** Do not delete the source cut until delivery is confirmed.

## After the build, the only two jobs are
1. **Storyboard** -> approve -> assets -> **build the video** -> approve.
2. **Deliver** the video into the folder **at the same quality you handed over.**

## Gotchas
- Studio re-serializes `index.html` on drag and can corrupt dynamic elements (it can break a counter). Re-read and re-lint after Studio edits; prefer editing the HTML directly for position tweaks.
- Double compression softens footage. Feed high quality, render high-bitrate, deliver matching. Never delete the source cut first.
- Hyperframes does **not** cut footage. It only layers overlays on the already-cut video.
- Do not use `data-playback-rate` for speed inside the composition. It desyncs overlays. Speed the final export instead.
