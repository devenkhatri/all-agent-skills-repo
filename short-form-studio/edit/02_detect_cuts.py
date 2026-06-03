#!/usr/bin/env python3
"""Stage 1b — Build a reviewable CUT LIST from the transcript + silences.

Detects three things to remove:
  1. Dead air      — silence gaps longer than KEEP_PAUSE (tightened, not fully removed)
  2. Filler words  — um, uh, uhh, er, etc. (standalone)
  3. Retakes       — when you restart a sentence; the earlier (flubbed) attempt is flagged

Usage:
    python edit/02_detect_cuts.py raw/myclip.mp4

Outputs in edit_work/<basename>/:
    cuts.json         machine cut list [{start, end, reason, text}]  (EDIT THIS before applying)
    cuts_review.txt   human-readable — open this, delete any cut you DON'T want

Nothing is removed yet. Stage 3 (03_apply_cuts.py) does the actual cutting,
and only after you've reviewed cuts.json.
"""
import argparse
import json
import re
import sys
from difflib import SequenceMatcher
from pathlib import Path

ROOT = Path(__file__).parent.parent

# --- Tunables (calibrate against a real clip) ---
KEEP_PAUSE = 0.35      # seconds of pause to leave in for natural rhythm
MIN_DEADAIR = 0.7      # only cut silences longer than this
EDGE_SNAP = 0.3        # silence starting/ending within this of the video edge is removed fully
FILLERS = {"um", "uh", "uhh", "uhm", "umm", "er", "erm", "hmm", "mmm"}
RETAKE_SIMILARITY = 0.72   # how similar two consecutive phrases must be to call it a retake
RETAKE_WINDOW = 9          # words to compare for a restart
STUTTER_MAX_NGRAM = 3      # detect immediate repeats up to this many words ("and pretend and pretend")


def load(work, name):
    return json.loads((work / name).read_text())


def detect_filler_cuts(words):
    cuts = []
    for w in words:
        token = re.sub(r"[^a-z]", "", w["word"].lower())
        if token in FILLERS:
            cuts.append({
                "start": w["start"], "end": w["end"],
                "reason": "filler", "text": w["word"].strip(),
            })
    return cuts


def detect_deadair_cuts(silences, duration=None):
    cuts = []
    for s in silences:
        if s["dur"] < MIN_DEADAIR:
            continue
        # Leading dead air (video opens on silence): remove it fully, no padding.
        if s["start"] <= EDGE_SNAP:
            start = 0.0
        else:
            start = s["start"] + KEEP_PAUSE / 2
        # Trailing dead air (silence runs to the end): remove fully, no padding.
        if duration is not None and s["end"] >= duration - EDGE_SNAP:
            end = s["end"]
        else:
            end = s["end"] - KEEP_PAUSE / 2
        if end - start > 0.15:
            cuts.append({
                "start": round(start, 3), "end": round(end, 3),
                "reason": "dead_air", "text": f"({s['dur']:.1f}s pause)",
            })
    return cuts


def _norm(w):
    return re.sub(r"[^a-z0-9]", "", w["word"].lower())


def detect_stutter_cuts(words):
    """Immediate repeats: a word or short n-gram said twice in a row.
    Flags the FIRST occurrence (the flub), keeps the clean second one.
    Catches 'the the', 'and pretend and pretend', 'I want I want to'."""
    cuts = []
    n = len(words)
    consumed = [False] * n
    # Try larger n-grams first so "and pretend and pretend" beats a bare "pretend".
    for size in range(STUTTER_MAX_NGRAM, 0, -1):
        i = 0
        while i + 2 * size <= n:
            if any(consumed[i:i + 2 * size]):
                i += 1
                continue
            a = [_norm(words[j]) for j in range(i, i + size)]
            b = [_norm(words[j]) for j in range(i + size, i + 2 * size)]
            if all(a) and a == b:
                seg = words[i:i + size]
                cuts.append({
                    "start": seg[0]["start"], "end": words[i + size - 1]["end"],
                    "reason": "stutter", "text": " ".join(w["word"].strip() for w in seg),
                })
                for j in range(i, i + size):
                    consumed[j] = True
                i += size
            else:
                i += 1
    return cuts


def detect_retake_cuts(words):
    """Heuristic: a restart is when a short window of words repeats soon after.
    Flag the FIRST (flubbed) occurrence for removal, keep the retake."""
    cuts = []
    n = len(words)
    i = 0
    while i < n - RETAKE_WINDOW * 2:
        win_a = [w["word"].lower().strip(".,!?") for w in words[i:i + RETAKE_WINDOW]]
        win_b = [w["word"].lower().strip(".,!?") for w in words[i + RETAKE_WINDOW:i + RETAKE_WINDOW * 2]]
        sim = SequenceMatcher(None, win_a, win_b).ratio()
        if sim >= RETAKE_SIMILARITY:
            seg = words[i:i + RETAKE_WINDOW]
            cuts.append({
                "start": seg[0]["start"], "end": seg[-1]["end"],
                "reason": "retake?", "text": " ".join(w["word"].strip() for w in seg),
            })
            i += RETAKE_WINDOW  # skip past the flubbed take
        else:
            i += 1
    return cuts


def merge_overlaps(cuts):
    cuts = sorted(cuts, key=lambda c: c["start"])
    merged = []
    for c in cuts:
        if merged and c["start"] <= merged[-1]["end"] + 0.05:
            last = merged[-1]
            last["end"] = max(last["end"], c["end"])
            if c["reason"] not in last["reason"]:
                last["reason"] = f"{last['reason']}+{c['reason']}"
            last["text"] = (last["text"] + " " + c["text"]).strip()
        else:
            merged.append(dict(c))
    return merged


def fmt_ts(sec):
    m, s = divmod(sec, 60)
    return f"{int(m):02d}:{s:05.2f}"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("video")
    args = ap.parse_args()
    video = Path(args.video).resolve()
    work = ROOT / "edit_work" / video.stem
    if not (work / "words.json").exists():
        sys.exit(f"Run 01_transcribe.py first — no transcript in {work}")

    words = load(work, "words.json")
    silences = load(work, "silences.json")
    video_dur = max((w["end"] for w in words), default=0)
    for s in silences:
        video_dur = max(video_dur, s["end"])

    cuts = []
    cuts += detect_deadair_cuts(silences, duration=video_dur)
    cuts += detect_filler_cuts(words)
    cuts += detect_stutter_cuts(words)
    cuts += detect_retake_cuts(words)
    cuts = merge_overlaps(cuts)

    (work / "cuts.json").write_text(json.dumps(cuts, indent=2))

    total_removed = sum(c["end"] - c["start"] for c in cuts)
    orig = words[-1]["end"] if words else 0
    lines = [
        "CUT LIST — review before applying.",
        "Delete any block you do NOT want removed, then run 03_apply_cuts.py.",
        f"Original ~{orig:.0f}s  |  {len(cuts)} cuts  |  ~{total_removed:.0f}s removed  "
        f"|  result ~{orig - total_removed:.0f}s",
        "=" * 70, "",
    ]
    by_reason = {}
    for c in cuts:
        by_reason[c["reason"]] = by_reason.get(c["reason"], 0) + 1
        lines.append(f"[{fmt_ts(c['start'])} → {fmt_ts(c['end'])}]  {c['reason']:14}  {c['text'][:60]}")
    lines += ["", "Summary: " + ", ".join(f"{k}={v}" for k, v in by_reason.items())]
    (work / "cuts_review.txt").write_text("\n".join(lines))

    print("\n".join(lines[:4]))
    print(f"\nReview file: {work / 'cuts_review.txt'}")
    print(f"Cut list:    {work / 'cuts.json'}  (edit this to remove unwanted cuts)")
    print(f"Next: python edit/03_apply_cuts.py {video}")


if __name__ == "__main__":
    main()
