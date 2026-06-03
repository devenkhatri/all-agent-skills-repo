#!/usr/bin/env python3
"""Stage 1c — Apply the reviewed cut list: remove flagged segments, keep the rest.

Usage:
    python edit/03_apply_cuts.py raw/myclip.mp4
    python edit/03_apply_cuts.py raw/myclip.mp4 --pad 0.05   # extra padding around keeps

Reads edit_work/<basename>/cuts.json (after you've reviewed/edited it), inverts it
into KEEP segments, and concatenates them with ffmpeg into out/<basename>_cut.mp4.

Re-encodes (not stream-copy) so cuts land frame-accurate regardless of keyframes.
"""
import argparse
import json
import sys
from pathlib import Path
import subprocess

ROOT = Path(__file__).parent.parent


def get_duration(video: Path):
    out = subprocess.run(
        ["ffprobe", "-v", "error", "-show_entries", "format=duration",
         "-of", "default=nokey=1:noprint_wrappers=1", str(video)],
        capture_output=True, text=True, check=True)
    return float(out.stdout.strip())


def invert_to_keeps(cuts, duration, pad):
    """Turn remove-intervals into keep-intervals across [0, duration]."""
    cuts = sorted(cuts, key=lambda c: c["start"])
    keeps = []
    cursor = 0.0
    for c in cuts:
        start = max(0.0, c["start"] - pad)
        if start > cursor + 0.05:
            keeps.append((cursor, start))
        cursor = max(cursor, c["end"] + pad)
    if cursor < duration - 0.05:
        keeps.append((cursor, duration))
    return [(round(a, 3), round(b, 3)) for a, b in keeps if b - a > 0.1]


def build_filter(keeps):
    """filter_complex: trim each keep for video+audio, then concat."""
    parts = []
    for i, (s, e) in enumerate(keeps):
        parts.append(
            f"[0:v]trim=start={s}:end={e},setpts=PTS-STARTPTS[v{i}];"
            f"[0:a]atrim=start={s}:end={e},asetpts=PTS-STARTPTS[a{i}];")
    streams = "".join(f"[v{i}][a{i}]" for i in range(len(keeps)))
    concat = f"{streams}concat=n={len(keeps)}:v=1:a=1[outv][outa]"
    return "".join(parts) + concat


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("video")
    ap.add_argument("--pad", type=float, default=0.04, help="seconds of padding kept around each cut")
    ap.add_argument("--crf", type=int, default=18, help="x264 quality (lower=better, 18=visually lossless)")
    args = ap.parse_args()

    video = Path(args.video).resolve()
    work = ROOT / "edit_work" / video.stem
    cuts_path = work / "cuts.json"
    if not cuts_path.exists():
        sys.exit(f"No cuts.json — run 02_detect_cuts.py first ({work})")

    cuts = json.loads(cuts_path.read_text())
    duration = get_duration(video)
    keeps = invert_to_keeps(cuts, duration, args.pad)
    if not keeps:
        sys.exit("No keep segments left — cut list would remove the entire video.")

    out_dir = ROOT / "out"
    out_dir.mkdir(exist_ok=True)
    out = out_dir / f"{video.stem}_cut.mp4"

    filter_complex = build_filter(keeps)
    filter_file = work / "filter.txt"
    filter_file.write_text(filter_complex)

    kept = sum(e - s for s, e in keeps)
    print(f"Keeping {len(keeps)} segments, ~{kept:.0f}s of {duration:.0f}s "
          f"(removing ~{duration - kept:.0f}s)")

    cmd = [
        "ffmpeg", "-y", "-i", str(video),
        "-filter_complex_script", str(filter_file),
        "-map", "[outv]", "-map", "[outa]",
        "-c:v", "libx264", "-crf", str(args.crf), "-preset", "medium",
        "-c:a", "aac", "-b:a", "192k",
        str(out),
    ]
    print("Rendering cut…")
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        sys.exit(f"ffmpeg failed:\n{proc.stderr[-1500:]}")

    print(f"\nDone → {out}")
    print(f"Next (optional speed-up): python edit/04_speedup.py {out} --speed 1.15")


if __name__ == "__main__":
    main()
