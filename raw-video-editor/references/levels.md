# The Level Ladder: how to run each pass

Each level lists: **intent** (what the creator asks for), **steps**, **defaults**, and **done when** (acceptance criteria checked in SKILL.md Step 4). `$WS` = workspace, `$SRC` = original, `$OUT` = next render path. `hf …` is the HyperFrames shorthand defined in SKILL.md "Tools".

---

## Level 1: Quick polish (one-prompt edit)

**Intent:** "It's an explainer video. Add motion graphics, proper captions and the sound effects it needs. Watch it first and tell me what could be better."

**Steps**
1. Step 2 of SKILL.md: transcribe, contact sheet, `edit-plan.md` with improvement suggestions. Wait for "do it".
2. If there are obvious dead pauses or retakes, propose running Level 2 first (recommended). If the user declines, keep the footage as is.
3. Build a HyperFrames composition over the video (SKILL.md "HyperFrames" pipeline: `hf init --skip-transcribe` → author → `lint` → `inspect`):
   - **Explainer cards** for every number, term, comparison or list in the speech (e.g. "CTC = Cost To Company", a salary breakdown as stacked boxes, a 3-step list). One idea per card.
   - **Captions:** word-level from `transcript.json`, max 2 lines, highlight the key word (`hyperframes` → `references/captions.md`).
   - **SFX:** soft pop on card entrances, whoosh on full-screen takeovers, tick on counters, chime on a reveal. Volume 0.05–0.15, accents ≤ 0.3.
4. `hf render --quality draft` → review → `--quality high` → loudnorm to the `next` path → self-verify.

**Done when:** every key number/term has a visual; captions in sync within ±100 ms; SFX never louder than voice; face clear.

---

## Level 2: Clean cut (the most tedious job, fully automated)

**Intent:** "Remove all silences, filler words like um/uh and repeated takes. When I said a sentence twice, keep only the best one. Don't cut in the middle of a sentence."

**Inputs** (from Step 2): `work/raw-tx/transcript.json` (words with `start`/`end`), `work/raw-tx/captions.srt` (readable sentences), `work/silences.txt`.

**Steps**
1. **Build the cut plan yourself** by reading the SRT and word timings, applying these rules:
   - **Dead air:** every silence > 0.6 s is tightened to a 0.25 s natural pause (cut from `start + 0.125` to `end − 0.125`). A silence at the very start or end of the video is removed fully.
   - **Fillers** (um, uh, er, hmm; Hindi/Urdu matlab, haan, toh, achha used as hesitation): remove only when the word **borders a pause ≥ 0.15 s** on at least one side, with 0.04 s padding. A filler said fluently mid-sentence ("filler words like um and uh") is content: keep it.
   - **Retakes:** when the same sentence (or its opening words) is said 2+ times within the next few sentences, keep **one** take and remove the others **as whole sentences**, plus any false start between them. Default keeper: the **last complete take** (creators re-say a line because the earlier one went wrong). If the last take trails off (clearly fewer words than the longest), keep the previous complete one.
   - **Never cut inside a sentence** except for a bordered filler. Cut boundaries sit in the gaps between words.
   - Optional `--aggressive` style on request: also drop crutch words (like, basically, actually, you know).
2. Write `work/keep.txt` (the segments to KEEP, one `start end` per line in seconds, sorted, non-overlapping) and `work/cuts_review.md`: before → after duration, a table of every cut (time, reason, removed text, kept-instead text for retakes).
3. Show the user the summary. Proceed unless they object.
4. Render the cut with the "Cut from keep.txt" recipe in `ffmpeg-recipes.md` → `work/clean-cut.mp4` (click-free 12 ms fades, near-lossless, `-n`).
5. Re-transcribe the clean cut into `work/cut-tx/` (`--model base` is enough) and read its SRT top to bottom: no sentence twice, no clipped first/last word.
6. **No clean take?** If every take of a line is flubbed, propose a short patch in the creator's cloned voice (SKILL.md "Voice"), verify it by transcription, and splice it at a sentence boundary. Only with a yes.
7. If this is the only pass requested, `cp work/clean-cut.mp4 "$OUT"` (never `mv`).

**If the transcript text is corrupted** (Step 2 check found U+FFFD characters): silences and word *timings* are still reliable, so dead-air cuts are safe. For fillers and retakes, rely on timing patterns (a burst of speech, a pause, then a similar-length burst) and extract the flagged spots as short clips for the user to confirm, or ask for a correct SRT.

**Defaults:** 0.25 s pause kept; pauses < 0.6 s untouched; fillers only when bordering a hesitation gap.

**Done when:** the transcript of the render reads as one clean take; joins are inaudible; typical result is 20–35% shorter.

**Tuning on feedback:** "too choppy" → keep 0.35 s pauses; "still slow" → keep 0.15 s plus a 1.05–1.1× export speed-up (ffmpeg recipe); "it cut a word" → widen that boundary in `keep.txt` by 0.1 s.

---

## Level 3: Stock B-roll + background music + captions

**Intent:** "Add proper captions, B-roll from copyright-free sources, and background music from the YouTube Audio Library. Give me a credits list."

**Steps**
1. Start from `work/clean-cut.mp4` (run Level 2 first if not done) and its transcript.
2. In `edit-plan.md`, mark **B-roll beats**: concrete nouns and actions in the speech ("money", "Mumbai skyline", "typing code", "failed many times"). Aim for one beat every 5–10 s on YouTube, every 2–4 s on Shorts. Leave the hook and emotional lines on the face.
3. Find clips per `assets-and-copyright.md`; download into `$WS/assets/broll/`; log each in `credits.md`.
4. Music: pick a mood from the content (upbeat explainer, calm story, tense puzzle). Ask the user to download a YouTube Audio Library track (their sign-in) or use a Pixabay Music track. Duck it under the voice (ffmpeg recipe "music ducking"), music bed around -24 to -28 LUFS.
5. B-roll placement as muted `<video>` clips on their own track in the HyperFrames composition (`hyperframes` → `references/video-composition.md`): full-frame cutaway (voice continues) or picture-in-picture in the safe zone. Duration 1.5–4 s, entering on word boundaries from `transcript.json`.
6. Captions: style per user (default: word-by-word, key word highlighted, bottom third, outside the face box).

**Done when:** every B-roll clip matches what's being said at that moment; no watermark/logo in any clip; music never masks a word; `credits.md` complete.

---

## Level 4: Personal B-roll library

**Intent:** "This folder has my old clips and this is my photo. Find the clips I'm in, label each by what's happening (walking, talking, office, travel) and make a list so you can use them as B-roll."

**Steps**
1. **Do not rename, move or edit anything in the user's folder.** (The videos say "rename". Use catalog aliases instead and explain why in one line.)
2. Make one 6-frame contact sheet per clip with the "B-roll library sheets" recipe in `ffmpeg-recipes.md`, into `~/.raw-video-editor/broll/<folder-name>/sheets/`.
3. Read the reference photo, then each clip's contact sheet. Write `~/.raw-video-editor/broll/<folder-name>/clips.json`, one entry per clip: `{id, path, duration, sheet, alias, tags, has_me, description}`, filling:
   - `has_me` (true/false/unsure, comparing against the photo)
   - `alias`: a descriptive slug, e.g. `office-typing-laptop-01`
   - `tags`: action, place, mood, shot type (`walking`, `travel`, `snow`, `selfie`, `wide`, `close-up`, `vertical`)
   - `description`: one line
   Batch it: about 20 sheets per message, saving `clips.json` after each batch so a long folder survives interruptions.
4. Write `clips.md` (a readable table) next to `clips.json`. Optionally create an `aliases/` folder of **symlinks** named by alias pointing at the originals, for easy browsing.
5. Tell the user: skip very personal clips. Anything in the folder may end up on screen.
6. **Using it:** for each B-roll beat, choose from `clips.json` by tags; trim the best 1.5–4 s (look at the sheet to pick the moment); copy the trimmed piece to `$WS/assets/broll/`.

**Done when:** every clip catalogued; picks are relevant to the line being spoken; original folder byte-for-byte unchanged.

---

## Level 5: Reference-style edit

**Intent:** "Take this reference short and decode its editing style: motion graphics, cards, pacing, captions, transitions, music and sound effects. Then edit my raw video in the same style with the same energy. Keep my content original."

Follow `references/style-decode.md` end to end. Key points:
- If the reference link can't be opened or downloaded, say so **before continuing**. Never guess a style.
- Copy the *style* (timing, layout grammar, type, motion, sound design), never the footage, music, or words.
- Format templates transfer well: e.g. a **puzzle/interview-question** reference → question card, countdown timer, "comment your answer" beat, reveal card.
- Save the decoded style to `~/.raw-video-editor/styles/<name>.md` so the next 10 videos reuse it without a reference.

**Done when:** a side-by-side contact sheet (reference vs. render) shows the same visual grammar; cuts/min within ±25% of the reference.

---

## Level 6: Premium / Apple-style

**Intent:** "Make this super engaging and clean with HyperFrames, Apple style. Transcribe first so you know exactly when each animation, text or image should appear. Add B-roll, screenshots, screen recordings or generated visuals where needed. Keep my face clearly visible at all times, and review the frames afterwards."

**Style rules:** lots of negative space; one accent colour; large, tight sans-serif headlines (SF Pro Display–like; use a licensed or open alternative such as Inter Tight); white or near-black backgrounds; motion is slow-in/fast-out easing (≈ cubic-bezier(0.2, 0.8, 0.2, 1)), 400–700 ms, slides from left/right/bottom; subtle depth (soft shadows, blur-behind); no clutter, no emoji, never more than one moving thing at a time.

**Steps:** Level 2 → transcript of the cut → beat plan (one visual idea per sentence) → HyperFrames build (read `typography.md`, `motion-principles.md`, `transitions.md` in the `hyperframes` skill) → `lint` + `inspect` → draft render → frame review with special attention to the face box → `--quality high`.

**Text-behind-subject** (the signature premium look: a big headline sits *behind* the speaker):
```bash
hf remove-background "$WS/work/with-music.mp4" -o "$WS/work/hf/speaker.webm" --quality best
```
Layer: base video (track 0) → headline → `speaker.webm` in a non-timed wrapper `<div>` above it, both videos at `data-start="0"`. Animate the wrapper's opacity, not the video's (pattern in `hyperframes-media`). Keep it to 1–3 hero moments; it's expensive to render.

**Expect iterations.** Both creators needed 3–7 versions. Typical feedback and the fix:
| Feedback | Fix |
|---|---|
| "Text is too small" | +30–50% type scale; check on a 390 px wide frame |
| "Graphics come in late" | shift entrances 150–250 ms *before* the word |
| "First 10 seconds slow" | tighter cuts + 1.1× speed in the hook only, a hook title card at 0 s |
| "Too busy" | drop every other overlay; keep only number/term cards |

