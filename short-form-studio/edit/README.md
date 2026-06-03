# Video editing pipeline

Turns a raw talking-head recording into a tightened, slightly-sped-up cut.
Local + free: **whisper.cpp** (transcription) + **ffmpeg** (cutting/speed). Nothing uploaded.

> HyperFrames is NOT part of this — it's a video *generation* tool for the later
> polish/overlay/caption stage, not footage cutting. See `../.agents/skills/`.

## The flow

```
raw/clip.mp4
   │
   ├─ 01_transcribe.py   → words.json + silences.json + transcript.txt   (whisper.cpp)
   │
   ├─ 02_detect_cuts.py  → cuts.json + cuts_review.txt                    (dead air, fillers, retakes)
   │        ↑ YOU REVIEW cuts_review.txt here and edit cuts.json
   │
   ├─ 03_apply_cuts.py   → out/clip_cut.mp4                               (ffmpeg keep-segment concat)
   │
   └─ 04_speedup.py      → out/clip_final.mp4                             (subtle speed-up)
```

## Usage

```bash
# 1. Drop your recording in raw/  then:
python edit/01_transcribe.py raw/clip.mp4
python edit/02_detect_cuts.py raw/clip.mp4

# 2. Open edit_work/clip/cuts_review.txt — delete any cut you DON'T want.
#    (cuts.json is the machine version; edit that one to change what gets removed.)

# 3. Apply:
python edit/03_apply_cuts.py raw/clip.mp4

# 4. Optional speed-up:
python edit/04_speedup.py out/clip_cut.mp4 --speed 1.15
```

## What gets auto-flagged in Stage 1

| Reason | What it catches | Tunable in `02_detect_cuts.py` |
|---|---|---|
| `dead_air` | pauses longer than 0.8s (tightened, not fully removed) | `MIN_DEADAIR`, `KEEP_PAUSE` |
| `filler` | standalone um / uh / er / hmm | `FILLERS` |
| `retake?` | a sentence you restarted (keeps the later take) | `RETAKE_SIMILARITY`, `RETAKE_WINDOW` |

Retake detection is the least reliable — it's flagged with a `?` and always worth a human glance.

## Human-in-the-loop

Nothing is ever removed without you seeing the cut list first. `02` only *proposes*;
`03` only acts on the (reviewed) `cuts.json`. Delete lines you disagree with before running `03`.

## Calibration

Defaults are starting points. After the first real clip, we tune:
- `MIN_DEADAIR` down if it's leaving awkward pauses, up if it's choppy
- `SILENCE_NOISE_DB` (in `01`) if your room tone is loud (try `-25dB`) or very quiet (`-35dB`)
- `RETAKE_SIMILARITY` up if it's over-flagging normal repetition

## Requirements (already installed)

- `whisper-cli` (brew install whisper-cpp) + model at `../models/ggml-base.en.bin`
- `ffmpeg` / `ffprobe`
- Python 3 (stdlib only)
