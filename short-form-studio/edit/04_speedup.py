#!/usr/bin/env python3
"""Stage 2 — Speed the video up slightly (keeps audio pitch natural).

Usage:
    python edit/04_speedup.py out/myclip_cut.mp4 --speed 1.15
    python edit/04_speedup.py out/myclip_cut.mp4 --speed 1.25

video: setpts=PTS/speed   audio: atempo=speed (pitch-preserving)
Keep it subtle — 1.1 to 1.3 reads as "tightened", above ~1.4 starts sounding rushed.
"""
import argparse
import sys
from pathlib import Path
import subprocess

ROOT = Path(__file__).parent.parent


def atempo_chain(speed):
    """atempo only accepts 0.5–2.0 per filter; chain for larger factors."""
    factors = []
    remaining = speed
    while remaining > 2.0:
        factors.append(2.0)
        remaining /= 2.0
    while remaining < 0.5:
        factors.append(0.5)
        remaining /= 0.5
    factors.append(round(remaining, 4))
    return ",".join(f"atempo={f}" for f in factors)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("video")
    ap.add_argument("--speed", type=float, default=1.15)
    ap.add_argument("--crf", type=int, default=18)
    args = ap.parse_args()

    if not (0.5 <= args.speed <= 4.0):
        sys.exit("--speed should be between 0.5 and 4.0 (subtle: 1.1–1.3)")

    video = Path(args.video).resolve()
    if not video.exists():
        sys.exit(f"Not found: {video}")

    out = ROOT / "out" / f"{video.stem.replace('_cut','')}_final.mp4"
    out.parent.mkdir(exist_ok=True)

    vf = f"setpts=PTS/{args.speed}"
    af = atempo_chain(args.speed)

    cmd = [
        "ffmpeg", "-y", "-i", str(video),
        "-filter:v", vf, "-filter:a", af,
        "-c:v", "libx264", "-crf", str(args.crf), "-preset", "medium",
        "-c:a", "aac", "-b:a", "192k",
        str(out),
    ]
    print(f"Speeding up {args.speed}× …")
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        sys.exit(f"ffmpeg failed:\n{proc.stderr[-1500:]}")
    print(f"Done → {out}")


if __name__ == "__main__":
    main()
