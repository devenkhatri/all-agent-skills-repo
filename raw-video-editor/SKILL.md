---
name: raw-video-editor
description: Use when someone hands over a raw, unedited video (talking-head, explainer, short, vlog) and asks to edit it — "edit this video", "clean up my raw recording", "remove silences and retakes", "add captions / B-roll / music / sound effects / motion graphics", "edit it in the style of this reference video", "make it Apple-style", or "use my own B-roll folder". Produces a brand-new edited video in a timestamped folder and never modifies the original file. Do NOT use for writing scripts before recording (use short-form-studio) or for generating videos with no source footage (use generate-video / remotion-generator).
argument-hint: "<path-to-raw-video> [what to do, e.g. 'clean cut + captions' or a reference video URL]"
disable-model-invocation: true
---

# Raw Video Editor

Turn a creator's **raw recording** into a finished edit, level by level, the way a tireless junior editor would: watch first, propose, edit one pass at a time, check its own frames, take feedback, and ship a new version.

The method comes from two Claude-video-editing masterclasses (Aaghaz, "Edit 10 Videos a Day With Claude", and Last Moment Tuitions, "Master AI Video Editing in 20 Minutes"). Both teach the same ladder of passes. This skill encodes it, adds hard safety around the original file, and runs everything through **ffmpeg** and the **HyperFrames CLI**. There are no Python helpers.

## Non-negotiables

1. **The original is read-only. Always.** Never write, move, rename, re-encode in place, trim, or delete the raw video, or any file in the user's B-roll folders. Every output is a **new file** inside a new workspace. Every ffmpeg command that writes a file uses **`-n`** (never overwrite). Run the hash check before you report done; if it isn't `OK`, stop and tell the user immediately.
2. **Never overwrite a previous render.** Each iteration is `<stem>-edited-v1.mp4`, `-v2.mp4`, and so on (see "Next render path").
3. **One pass per round.** Clean cut, then B-roll/music, then style. Do not cram everything into one render unless the user explicitly asks for a one-shot edit. Stacking passes is the #1 mistake both videos call out.
4. **Watch before you cut.** Transcribe and look at frames, then propose an edit plan. Edit only after a "go".
5. **Keep the face clear.** No caption, graphic, B-roll overlay, or animation may cover the speaker's face or important on-screen content. Verify it on real frames after every render.
6. **Copyright-safe assets only.** Use free-licence B-roll and music. Log every third-party asset in `credits.md` with source URL and licence, ready to paste into the video description.
7. **Review before delivery.** Never hand back a render you have not inspected frame by frame (Step 4).

## Tools

- **ffmpeg / ffprobe**: cutting, frames, silences, audio mixing. Recipes are in `references/ffmpeg-recipes.md`.
- **HyperFrames CLI**: transcription, composition, lint/inspect, preview, render, background removal. Throughout this skill, **`hf <args>`** is shorthand for:
  ```bash
  PATH="<NODE22>:$PATH" CI=1 HYPERFRAMES_SKIP_SKILLS=1 npx -y hyperframes <args>
  ```
  `<NODE22>` is the literal directory found in Step 0 (HyperFrames needs Node ≥ 22; the default `node` may be older). `CI=1` silences the spinner so logs stay readable; `HYPERFRAMES_SKIP_SKILLS=1` stops `init` re-checking skills. Shell variables don't persist between commands, so write the full prefix with the literal path every time. Invoke the `hyperframes-cli` and `hyperframes-media` skills for flags; if the HyperFrames skills are missing, ask to install them: `npx skills add heygen-com/hyperframes`.
- **shasum**: proof that the original is untouched.

Below, `SRC` = absolute path of the raw video, `WS` = workspace, `OUT` = next render path.

## Workflow

### Step 0: Workspace and safety (every job)

```bash
# Node >= 22 for HyperFrames: prints the bin dir to use as <NODE22>. If nothing prints, ask the user to install it (e.g. `nvm install 22`).
for n in "$(command -v node)" $(find ~/.nvm/versions/node ~/.fnm/node-versions ~/.volta/tools/image/node -maxdepth 4 -path '*/bin/node' 2>/dev/null | sort -rV); do
  [ "$("$n" -p 'process.versions.node.split(".")[0]' 2>/dev/null || echo 0)" -ge 22 ] && { dirname "$n"; break; }; done

SRC="<absolute path to raw video>"        # strip quotes from drag-drop / "Copy as Path"
STEM=$(basename "${SRC%.*}")
WS="$PWD/$(date +%Y%m%d-%H%M)-$STEM-edit"  # in the CURRENT directory, never next to the original
mkdir -p "$WS"/{work,assets,renders}
shasum -a 256 "$SRC" > "$WS/original.sha256"
ffprobe -v error -print_format json -show_format -show_streams "$SRC" > "$WS/probe.json"
printf '# Credits\n\nPaste into the video description.\n\n| Asset | Type | Source URL | License | Attribution required |\n|---|---|---|---|---|\n' > "$WS/credits.md"
hf doctor            # first overlay job only: Chrome, FFmpeg, Node, memory
```

From `probe.json`, note duration, width×height, fps (`r_frame_rate`), audio rate and orientation.

**Verify the original (Step 4 and any time in doubt):** `shasum -a 256 -c "$WS/original.sha256"`. It must print `…: OK`.

**Next render path:**
```bash
n=1; while [ -e "$WS/renders/$STEM-edited-v$n.mp4" ]; do n=$((n+1)); done
OUT="$WS/renders/$STEM-edited-v$n.mp4"
```

If the user gives a folder instead of a file, list the videos in it and ask which one.

### Step 1: Intake (one message, only for what's missing)

Infer what you can from the request and `probe.json`. Ask only for missing essentials:

- **Which pass(es)?** Show the level ladder below and recommend the next sensible one.
- **Platform/format:** YouTube 16:9, or Shorts/Reels 9:16 (crop or reframe needed?).
- **Spoken language** (sets `--language`) and **caption language**: same as spoken (default) or English.
- **Reference video URL** (for Level 5), **brand colours/fonts** (Level 6), **own B-roll folder + a photo of the creator** (Level 4).

### Step 2: Watch and propose (always, before any edit)

**Transcribe** with HyperFrames (word-level `transcript.json`, then a readable SRT):
```bash
hf transcribe "$SRC" --dir "$WS/work/raw-tx" --model small --language <hi|ur|en> --timeout 14400000
hf transcribe "$WS/work/raw-tx/transcript.json" --to srt -o "$WS/work/raw-tx/captions.srt"
ffmpeg -hide_banner -i "$SRC" -af silencedetect=noise=-30dB:d=0.5 -f null - 2>&1 \
  | grep -oE "silence_(start|end): [0-9.]+" > "$WS/work/silences.txt"
```
Transcription rules (see `hyperframes-media` → "Language Rule"):
- **Never use a `.en` model for non-English speech.** `.en` models *translate* to English. Use that on purpose only when the user wants English captions for Hindi/Urdu speech (`--model small.en`).
- **It is slow on CPU** (measured ~30× realtime with `small` on an Intel Mac). Run it in the background, tell the user the expected wait, and use `--model base` for a quick planning pass on long videos.
- **Check for corrupted text:** `grep -c $'\xef\xbf\xbd' "$WS/work/raw-tx/transcript.json"`. Any count above 0 means whisper.cpp split Devanagari/Urdu characters (seen in testing). Timings are still usable for silences and cut boundaries, but the text is not. Tell the user and offer: (a) English captions via `small.en`, (b) importing a correct SRT/VTT they provide, e.g. YouTube Studio's auto-captions, with `hf transcribe <file>.srt --dir …`, or (c) planning cuts by timing + your own listening of flagged spots only.

**Look:** contact sheet of the raw video (recipe "Contact sheet" in `references/ffmpeg-recipes.md`), then Read the jpg. Note where the face sits in frame.

Then write `$WS/edit-plan.md`, a time-coded plan for this pass:
- What can be done better: weak hook, dead stretches, repeated points, pacing.
- Each planned beat: `[mm:ss–mm:ss] spoken line → what goes on screen (graphic / caption style / B-roll / SFX) → asset source`.
- The "safe zone" for overlays given the face position.

Show the plan summary in chat and **wait for a go**. "Do it" is enough. The user may edit the plan.

### Step 3: Run the pass (see the ladder)

Do exactly the pass(es) agreed. Work in `$WS/work/`. Copy any asset you download into `$WS/assets/`. The final output always goes to `$OUT` from "Next render path".

### Step 4: Self-verify (mandatory, before showing anything)

Extract review frames from the render: every 2 s, plus one at each overlay start + 0.3 s (recipes "Review frames" and "Frame at a time"). Look at them and check:
- [ ] No caption, graphic or B-roll covers the face or key content
- [ ] Caption text readable on a phone (big enough, contrast, max 2 lines, not cut off at edges or under platform UI on 9:16)
- [ ] Graphics appear **on** the spoken word, not late (compare with `transcript.json`)
- [ ] No repeated sentence or chopped word survived the cut (re-transcribe the render with `--model base` and read the SRT top to bottom)
- [ ] Audio: voice clearly on top of music; no clicks at joins; loudness about -14 LUFS (see `references/ffmpeg-recipes.md`)
- [ ] `hf lint` 0 errors and `hf inspect --json` reports `"ok": true` (overlay passes)
- [ ] Same resolution and fps as the source (`ffprobe`); no downscale
- [ ] `shasum -a 256 -c "$WS/original.sha256"` → `OK`

Fix anything that fails and re-render to a **new** version number before reporting.

### Step 5: Deliver and iterate

For overlay passes, offer the HyperFrames Studio (`hf preview hf --port <port>`, then share `http://localhost:<port>/#project/hf`). The user can scrub the timeline there before you spend time on a `--quality high` render. Report: the render path, what changed in this version, the before/after duration, the `credits.md` contents (if any third-party assets were used), and the `OK` hash line. Then invite plain-language feedback ("text too small", "graphics late", "first 10s faster"). Apply it as the next version. Do not ask the user which setting to change; translate their feedback into parameters yourself. Remember the fix for the rest of the session so the same mistake never repeats.

## The level ladder

Full steps, defaults and acceptance criteria for each level are in `references/levels.md`. Read it before running a level.

| Level | Pass | Core tools |
|---|---|---|
| 1 | **Quick polish.** Watch, suggest, then add motion graphics, proper captions and the needed SFX | HyperFrames (`hyperframes` skill) |
| 2 | **Clean cut.** Remove silences, fillers and repeated takes; keep only the best take; never cut mid-sentence | `hf transcribe` + silencedetect → your cut plan → ffmpeg trim/concat |
| 3 | **Stock B-roll + music + captions.** Copyright-free B-roll, background music ducked under the voice, styled captions, credits list | Pexels/Pixabay/Mixkit, HyperFrames, ffmpeg |
| 4 | **Personal B-roll library.** Index the creator's own clips once (find the clips they're in, label each by action), then pick B-roll from that catalog | ffmpeg contact sheets, vision |
| 5 | **Reference-style edit.** Decode a reference video's editing style (graphics, cards, cuts, pacing, captions, transitions, music, SFX), save it as a reusable style, then apply it to this content | yt-dlp, ffmpeg scene detection, HyperFrames |
| 6 | **Premium / Apple-style.** Clean, minimal motion design timed to the transcript; B-roll, screenshots, screen recordings, generated visuals | HyperFrames + `remove-background` |

Default order for a fresh raw video: **2 → 3 or 4 → 5 or 6**, with 1 as the one-prompt shortcut. Level 2 always runs before any overlay pass, because overlays are timed to the *cut* timeline. After cutting, re-transcribe `work/clean-cut.mp4` into `work/cut-tx/` and time all overlays to that transcript.

## Reusable styles and libraries (the "10 videos a day" part)

- **Styles:** after a Level 5/6 decode, save the style profile to `~/.raw-video-editor/styles/<name>.md` (format in `references/style-decode.md`). On later jobs, check that folder first and offer the saved styles by name.
- **B-roll catalogs:** Level 4 writes `~/.raw-video-editor/broll/<folder-name>/clips.json`. Reuse it; only index clips added since last time.
- **Feedback memory:** append durable preferences ("captions bottom-third, yellow highlight", "no whoosh SFX") to `~/.raw-video-editor/preferences.md` and read it at Step 1 of every job.

## HyperFrames (motion graphics, captions, overlays)

Levels 1, 3, 5 and 6 build every visual layer (captions, cards, B-roll cutaways, SFX) as a HyperFrames composition on top of the cut video. **Invoke the `hyperframes` skill before authoring** and follow it. Its references map onto this skill's levels:

| Need | `hyperframes` reference |
|---|---|
| Word-by-word / highlighted captions | `references/captions.md`, `references/transcript-guide.md` |
| Base video + B-roll layers, picture-in-picture | `references/video-composition.md` |
| Explainer cards, stat counters, lists | `references/techniques.md`, `references/dynamic-techniques.md` |
| Type scale, Apple-style motion, easing | `references/typography.md`, `references/motion-principles.md` |
| Cuts/whips/zooms between beats | `references/transitions.md` |
| Graphics on music beats | `references/beat-direction.md`, `references/audio-reactive.md` |

**The pipeline:**

```bash
cd "$WS/work"
# Base = clean cut (with music already ducked in, see "Audio order"). init copies it; never pass the original.
hf init hf --video with-music.mp4 --skip-transcribe --non-interactive --example blank
cp cut-tx/transcript.json hf/            # transcript of the CUT video; reuse it instead of re-transcribing in init
# ... author hf/index.html per the hyperframes skill ...
hf lint hf                         # must be 0 errors
hf inspect hf --json --samples 30  # text overflowing cards, off-canvas captions: fix all errors
hf render hf --quality draft --output hf-draft.mp4   # iterate on drafts
hf preview hf --port 3017          # optional Studio for the user: http://localhost:3017/#project/hf
hf render hf --quality high --fps <24|30|60> --output hf-final.mp4
```

Rules:
- HyperFrames does **not** cut footage. Cut with ffmpeg first (Level 2); the composition's base video is the cut.
- Never use `data-playback-rate` for speed changes (it desyncs overlays). Speed up the final export with ffmpeg instead.
- `init` sizes the canvas to 1080 on the short side. For 4K sources pass `--resolution landscape-4k` / `portrait-4k` so nothing is downscaled.
- `render --fps` accepts 24, 30 or 60. Pick the source's fps; for 25/50 fps sources choose the nearest and mention it.
- Rendering is slow: about 8–9 s of compute per second of video on draft in testing, more on `high`. Tell the user before a long render, and use `--quality draft` until the edit is approved.
- `remove-background` gives a transparent cutout of the speaker for **text-behind-subject** titles and for keeping graphics visually behind the face (Level 6). Use `--quality best` when compositing over the same footage.
- If captions come from a corrupted transcript (Step 2 check), don't render them. Fix the source of the text first.

**Audio order:** (1) ffmpeg cut → `clean-cut.mp4` → (2) ffmpeg music ducking under the voice → `with-music.mp4` (if there's no music, `cp clean-cut.mp4 with-music.mp4`) → (3) SFX as `<audio>` elements inside HyperFrames (`data-volume` 0.05–0.15, accents ≤ 0.3) → (4) ffmpeg `loudnorm` on `hf-final.mp4`, written with `-n` to `$OUT`. Ducking before HyperFrames means sound effects are never ducked by accident.

## Voice (any time new speech is needed)

**Priority, always in this order:**
1. **The creator's real recording.** Never replace speech that exists in the raw video.
2. **The creator's cloned voice via local Chatterbox**, one line per call (it defaults to the cloned reference `~/tools/chatterbox/voices/deven.wav`):
   ```bash
   ~/tools/chatterbox/.venv/bin/python ~/tools/chatterbox/say.py "One short sentence." "$WS/assets/voice/line01.wav"
   ```
   First choice for every generated line. If `~/tools/chatterbox/.venv/bin/python` or `say.py` doesn't exist, Chatterbox isn't set up; go to option 3.
3. **Kokoro via `hf tts`** (e.g. `--voice hf_alpha` for Hindi, `am_adam` for English), only if Chatterbox is missing, and only after telling the user it won't be their voice. Kokoro is also fine for a quick *timing draft* if the user wants speed, but the delivered render uses the clone.

**When new speech is needed:**
- **Patching a line** when every take of it is flubbed (Level 2), or a single misspoken word/number. Show the exact replacement text and get a yes first, because it changes what the creator "said".
- **Narration** over B-roll-only stretches, a cold-open hook, a "comment your answer" or reveal beat (Level 5 formats), or an outro/CTA, but only when the user asks or approves it in `edit-plan.md`.

**Rules:**
- **Chatterbox is slow on this CPU (~30–80× realtime, plus a model load per call).** Keep lines short, run each `say.py` call with `run_in_background`, tell the user the expected wait, and do other work (B-roll, cards) meanwhile.
- `say.py` uses the English Chatterbox model. For Hindi/Urdu lines, warn the user that the clone may mispronounce, and keep patches short.
- **Verify every clip:** `hf transcribe line01.wav --dir … --model small.en` (English) and compare with the intended text; regenerate any line with missing or wrong words. Ask the user to listen to names (e.g. "Goratela") at least once.
- Match it to the recording: resample to the source's audio rate, loudness-match it to the surrounding speech (`loudnorm`), add 60–120 ms of room tone or silence padding so the join doesn't sound pasted in. Then re-transcribe the final cut so captions include the new words.
- Log generated lines in `credits.md` as `Voice | generated (Chatterbox clone) | — | own voice | No` so the edit history is honest.
- Never edit files in `~/tools/chatterbox` and never `pip install -U` in its venv (it is hand-pinned for Intel Macs).

## Assets and copyright

Read `references/assets-and-copyright.md` before Level 3/4/5. Short version: B-roll from Pexels, Pixabay, Mixkit or the creator's own footage; music from the YouTube Audio Library, Pixabay Music or similar. Never rip music or clips from other creators' videos, and download a reference video only to *analyze* it, never to reuse its footage or audio. Some licences require attribution, so every asset goes into `credits.md`. The YouTube Audio Library needs the user's own sign-in: ask the user to download the chosen track themselves and give you the path. Never sign in on their behalf.

## Common mistakes (from both videos)

1. Asking for everything in one prompt → do one pass per round.
2. No reference → for style work, always ask for a reference video or a saved style.
3. Ignoring copyright → licence-checked assets and `credits.md`, always.
4. Uploading without watching → Step 4 self-verify, then the user's own final watch.
5. No backup of the raw file → this skill never touches it, and the hash check proves it.

## Output

```
./YYYYMMDD-HHMM-<stem>-edit/
├── original.sha256      the original's hash (proof it's untouched)
├── probe.json           the original's ffprobe info
├── edit-plan.md         time-coded plan per pass
├── credits.md           paste into the description
├── work/                raw-tx/, cut-tx/, silences.txt, keep.txt, cuts_review.md, clean-cut.mp4, review frames, hf/
├── assets/              downloaded B-roll / music / SFX / voice lines actually used
└── renders/
    ├── <stem>-edited-v1.mp4
    └── <stem>-edited-v2.mp4 ...
```
