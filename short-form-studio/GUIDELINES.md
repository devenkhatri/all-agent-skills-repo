# Short-Form Content Editing Guidelines

The distilled playbook for producing a short-form talking-head video with an AI agent: research, script, record, edit, polish, publish. Tuned for the AI / Claude Code niche, but the craft transfers to any talking-head short.

---

## 0. Pipeline and division of labor

```
Script (agent) -> Record (you) -> Edit/cut (you) -> Storyboard (agent) -> Assets (you) -> Hyperframes build + SFX + render (agent) -> Deliver to folder
```

**You own:** recording, and the **rough cut** (cutting mistakes, silences, retakes, plus any speed). You hand back the **already-edited video**. The agent does **not** cut footage. It was inconsistent at it, so that step is yours. (The local cut tools in `edit/` stay as a fallback only. See section 4.)

**The agent owns:** the script, the storyboard, the Hyperframes composition (overlays, animations, SFX), and rendering the final at **delivery quality** into the folder.

**Two hard gates. The agent stops and waits at each:**
1. **Storyboard + assets.** After you hand over the edited cut, the agent proposes on-screen assets and builds the HTML storyboard, then **stops**. You approve it and hand over the screenshots.
2. **Render.** The agent builds the composition, adds quiet SFX, previews in Studio, and **shows you**. On approval it renders in high quality and drops it in the folder, **at the same quality you gave it**.

Nothing auto-publishes; nothing skips a gate.

---

## 1. Scripting — hooks, length, depth

- **Keep the niche narrow.** One clear lane (for example Claude Code and its tooling), not "AI" broadly. The top performers are specific.
- **Hook in the first ~3 seconds, no decoding required.** Reliable patterns:
  1. `conditional_identity` — "If you're doing X without Y, [literal pain]" (the workhorse)
  2. `news_drop` — "[Brand] just [verb] [bold claim]" (highest ceiling, high variance, use only for real launches)
  3. `listicle` — "Here are 3 [things] for [use case]"
- **Avoid in hooks:** metaphors and cultural shorthand (they need decoding), directionally-ambiguous verbs ("drop these" = install or abandon?), and leading with "I".
- **Length:** target 40 to 75 seconds. The median viral short is around 62 seconds. Past ~90 seconds shows no view benefit. Pace is roughly 3.2 words per second (~190 words is about 60 seconds).
- **Depth, two safe modes only:**
  - Deep on ONE thing (~150 to 200 words), or
  - 3 items at ~60 words each.
  - Avoid the dead zone (2 items, deeply explained).
- **CTA:** pick one philosophy and stick to it. Lead-magnet ("Comment EDIT") or share-driven ("Send this to someone who...").

## 2. Teleprompter format (delivery)

Every script ships as **pure prose `.txt`** with zero symbols. No markdown, headings, bullets, asterisks, or brackets. Use "First, / Second, / Third," instead of numbered headings. Spell tricky numbers ("four point eight"). The structured `.md` (with hook, setup, CTA labels plus word counts) is for archive only. **Lead with the teleprompter version.**

## 3. Recording

- Vertical 9:16. Face upper-center, hands gesture lower.
- Read off the teleprompter `.txt`.
- Don't stress about flubs. Pausing cleanly between takes helps silence detection during the cut.

## 4. Stage 1 — Rough cut (raw -> clean) — *your step / fallback only*

> **You deliver the edited cut.** This stage is yours. When you hand back an already-cut video, **skip straight to section 6**. Everything below is kept only as a fallback for when the agent is explicitly asked to cut.

Tools: `whisper.cpp` (local transcription) + `ffmpeg`. Scripts in `edit/`.

```bash
python edit/01_transcribe.py raw/clip.mov     # word-level transcript + silence map
python edit/02_detect_cuts.py raw/clip.mov    # proposes cuts -> edit_work/<clip>/cuts.json + cuts_review.txt
# REVIEW: open cuts_review.txt, delete any cut you do NOT want
python edit/03_apply_cuts.py raw/clip.mov     # renders out/<clip>_cut.mp4
python edit/04_speedup.py out/clip_cut.mp4 --speed 1.15   # optional subtle speed-up
```

**Cut types detected:** `dead_air` (silence), `filler` (um/uh), `retake?` (a restarted sentence, keeps the later take). Tunables live at the top of `02_detect_cuts.py` (`MIN_DEADAIR`, `KEEP_PAUSE`, `FILLERS`, `RETAKE_SIMILARITY`).

**Always review before applying.** The detector proposes; you approve.

### Known failure mode — false silence on mumbled speech
`silencedetect` can flag low-volume real words as a pause and cut them. When a cut sounds wrong, re-transcribe just that slice to ground-truth it before editing `cuts.json`.

## 5. Stage 2 — Speed — *part of your edit*

> Speed lives in your cut now (you deliver the edited video at final pace). Kept here as fallback. If the agent ever speeds a clip: apply a subtle global speed-up (1.1x to 1.3x; above ~1.4x sounds rushed). **Do it last, over the whole rendered video**, so picture and overlays speed up together and never drift.

**Do NOT** use `data-playback-rate` on the clip inside the Hyperframes composition to get speed. It desyncs overlays (Studio previews at 1x while overlays sit on a sped timeline, so they fire early). Keep the composition at 1x and speed the final export.

## 6. Stage 3 — Polish / B-roll overlays (Hyperframes)

Hyperframes turns an HTML composition into MP4. It does NOT cut footage. It layers overlays and animations on the already-cut video. Studio previews live on localhost.

```bash
cd hf && npx hyperframes init <name> --video ../out/clip_cut.mp4 --non-interactive
cd <name> && npx hyperframes preview --port 3030   # Studio at localhost:3030 (long-running, run in background)
# edit index.html, then:
npx hyperframes lint        # 0 errors before render
npx hyperframes render      # -> MP4
```

### Overlay timing — sync to the 1x spoken moment
Compute the edited-timeline timestamp of each trigger phrase from the transcript:
```
edited(t) = t - (sum of cut durations that end before t)
```
Place each overlay's `data-start` at (or a hair before) the moment the line is spoken. After a cut-list change, recompute. The timeline shifts.

### Glass bubble style (the house look)
Translucent frosted bubbles that float over the video, NOT solid branded cards. See `hf/template/index.html` for the full CSS.
- Container: `background: rgba(18,18,24,0.32)`, `backdrop-filter: blur(22px) saturate(135%)`, `border: 1px solid rgba(255,255,255,0.18)`, `border-radius: 40px`, soft shadow + `inset 0 1px 0 rgba(255,255,255,0.22)`.
- Text: white. Display words (titles, big numbers) get a subtle white-to-warm gradient via `background-clip: text` plus a `drop-shadow` glow. Accent words in your one accent color with a soft glow. Keep the glow subtle.
- Entrance: pop in with slight overshoot (`back.out(1.4)`), ~0.5s. Exit: fade + small rise, ~0.4s.
- Screenshots: frame them in a glass card (`padding:14px`, blurred translucent background, rounded inner image).

### Placement
- Vertical 9:16: the face is upper-center, hands gesture around y1250. **Put cards in the lower third (top around 1240 to 1420)** so they never cover the face. A hook title can sit at the very top, above the head.
- Keep one expressive overlay on screen at a time. About one card per 6 to 8 seconds reads well.

### Fonts
- Hyperframes auto-embeds only common fonts, and **Inter, Roboto, and the like are banned as AI design tells.** For a distinctive look, fetch a Google Font's CSS, download the `.woff2` locally, and `<link>` it (see `hf/template/assets/fonts.css`).
- A strong pairing: a serif for display and numbers + a grotesque sans for labels and body. Extreme weight contrast. The template ships with **Newsreader** + **Schibsted Grotesk**.

### B-roll asset selection
- Show the actual thing being mentioned (the real chart, the real terminal, the real docs) over generic cards. Concrete beats decorative.
- Landscape screenshots at 1200px or wider sit best over vertical video.
- Build only what you can't screenshot (stat cards, CTA) as glass bubbles.

### Sound effects (SFX) — keep them quiet
After the composition is built, add subtle SFX synced to overlay entrances: a whoosh on full-screen takeovers, a soft pop on cards, a rising tick on a counter, a short chime on a success or green beat.
- **Keep them quiet.** Defaults: whooshes and ambient `data-volume` around **0.05 to 0.15**, accents (pops, chimes) **at or below 0.3**. The voice-over always sits on top. SFX support it, never compete.
- Put SFX on their own audio track. Synthesize with `ffmpeg` (no licensing) so they bake into the render.

### Deliver at the quality you received
Footage softens when it is compressed twice (cut, re-encode, render). Rules:
- Feed Hyperframes the **highest-quality cut you have**. Do **not** pre-downscale it.
- If a re-encode is needed for reliable seeking, keep it near-lossless and native resolution: `-crf 15`, dense keyframes `-g 30 -keyint_min 30`.
- Render high-bitrate: `npx hyperframes render --crf 15` (also `--fps`, `--quality high`, `--video-bitrate`, `--resolution`).
- **The file delivered to the folder must match the quality you handed over.** Keep the source cut until delivery is confirmed. Never delete it first.

## 7. Captions and posting

Hyperframes can generate captions, but a fast manual route also works: render the polished video, airdrop it to your phone, and add burned-in captions in a free mobile app (the Instagram "edits" app does this well) before posting to Shorts, Reels, or TikTok.

## 8. Branding and voice

- **Voice:** study the top creators in your niche and model their hook structure and framing. Refine from your own edits over time.
- **Verify every named repo, tool, or stat** before locking a script. Web-search the GitHub README, confirm the install command, the stat, and the star count. Never cite an unverifiable number.

## 9. Gotchas / lessons

- `data-playback-rate` desyncs overlays -> speed the final export instead (section 5).
- `silencedetect` false-positives on mumbled speech -> re-transcribe the slice (section 4).
- Inter is a banned font. Use distinctive Google Fonts via local `@font-face` (section 6).
- Leading and trailing dead air should be cut to the very edge (no padding). Mid-clip pauses keep a small `KEEP_PAUSE` so they don't sound clipped.
- **SFX default too loud** -> whooshes 0.05 to 0.15 volume, accents at or below 0.3, voice-over on top (section 6).
- **Double compression softens footage** -> feed the highest-quality cut, render at high bitrate (`--crf 15`), deliver matching quality. **Don't delete the source cut before delivery.**
- **Studio re-serializes `index.html` when you drag elements** and can mangle dynamic bits (it can corrupt a counter). After editing in Studio, re-read the file and re-lint; for position tweaks, prefer editing the HTML directly.

## 10. Tools reference

| Path | What |
|---|---|
| `.claude/skills/short-form-studio/SKILL.md` | the gated production loop (this skill) |
| `edit/01_transcribe.py` | audio -> word-level transcript + silence map (whisper.cpp) |
| `edit/02_detect_cuts.py` | propose cuts (dead_air / filler / retake) |
| `edit/03_apply_cuts.py` | render the cut (ffmpeg keep-segment concat) |
| `edit/04_speedup.py` | subtle global speed-up |
| `hf/template/` | reference Hyperframes composition (glass-bubble overlays) |
