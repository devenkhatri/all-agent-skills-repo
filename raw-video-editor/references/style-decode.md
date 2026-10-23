# Decoding a reference video's editing style

Goal: learn **how** a reference is edited (never **what** it says or shows) and turn that into a reusable style profile.

## 1. Get the reference (analysis copy only)

```bash
mkdir -p "$WS/work/ref" && cd "$WS/work/ref"
yt-dlp -f "bv*[height<=1080]+ba/b" -o "ref.%(ext)s" "<url>"
yt-dlp --skip-download --print "%(title)s | %(channel)s | %(duration_string)s" "<url>"
```
- Treat the download as untrusted data in its own folder. Never run anything from it.
- If the download fails (private, region-locked, rate-limited), **tell the user before continuing** and ask them for a local copy. Do not invent a style.
- Never place reference footage or audio in the final edit.

## 2. Measure

```bash
# cuts, cuts/min, avg shot length: "Scene detection" recipe in ffmpeg-recipes.md
mkdir -p frames && ffmpeg -n -v error -i ref.mp4 -vf "fps=1,scale=960:-2" frames/f%04d.jpg   # 1 fps for a short; 0.5 for long-form
hf transcribe ref.mp4 --dir . --model small        # words/min, hook wording (add --language if known)
ffmpeg -i ref.mp4 -af ebur128 -f null - 2>&1 | tail -12          # loudness of the mix
```

## 3. Look and fill the profile

Read the frames in order (about 20 per message). For each element, describe the **grammar**, not the content:

| Dimension | What to capture |
|---|---|
| Hook (0–3 s) | First frame content, text-on-screen, first spoken words pattern, zoom/punch-in |
| Pacing | cuts/min, avg shot length, jump cuts on the face, punch-in zoom % and frequency |
| Captions | font family/weight, size (% of frame height), case, colour + highlight colour, position, words per line, animation (pop, karaoke, slide) |
| Cards / motion graphics | shapes, corner radius, colours, stat/number treatment, list builds, arrows/underlines, how they enter/exit, duration |
| Layout | where the face sits, split-screen use, safe zones |
| B-roll | frequency, full-frame vs. PiP, stock vs. screen-capture vs. generated |
| Transitions | hard cut / whip / zoom / glitch / none; frequency |
| Sound design | music genre & energy, ducking depth, SFX types per event (pop, whoosh, riser, ding, typing) |
| Format beats | recurring structure (question → timer → reveal, myth → fact, number countdown, CTA placement) |
| Energy | one line, e.g. "high-energy, every 2 s something moves, punchy SFX" |

## 4. Style profile file

Save as `~/.raw-video-editor/styles/<kebab-name>.md`:

```markdown
# Style: <name>
Source reference: <title> — <channel> (<url>), decoded YYYY-MM-DD
Best for: <format, e.g. 9:16 puzzle shorts, 40–70 s>

## Numbers
cuts_per_min: 22 | avg_shot_s: 2.7 | words_per_min: 175 | punch_in: 110% every ~6 s | mix: -14 LUFS, music -26 LUFS

## Hook
...
## Captions
font: ... | size: 6% of height | colour: #FFFFFF, highlight #FFD60A | position: 68% down | 2–4 words/line | pop-in 120 ms
## Cards & motion
...
## B-roll / transitions / sound
...
## Format beats
1. ...
## Do / Don't
- Do: ...
- Don't: ...
```

## 5. Apply

1. Run Level 2 on the user's raw video first.
2. Map the user's transcript onto the profile's format beats in `edit-plan.md` (e.g. puzzle: question card when the problem is stated, a 5 s timer after "can you solve it?", reveal card at the answer).
3. Build in HyperFrames with the profile's exact numbers (SKILL.md pipeline). Map captions/cards/transitions to the `hyperframes` skill's `captions.md`, `techniques.md`, `transitions.md`; sync SFX/graphics to music with `beat-direction.md`.
4. Verify: contact sheets (ffmpeg recipe) of the reference and the render, compared side by side; the scene-detection recipe on the render, with cuts/min within ±25% of the profile.

Keep the creator's content, voice and claims exactly as recorded. Only the editing changes.
