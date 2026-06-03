#!/usr/bin/env python3
"""Stage 1a — Transcribe a raw video with word-level timestamps + detect silences.

Usage:
    python edit/01_transcribe.py raw/myclip.mp4

Outputs (next to the video, in edit_work/<basename>/):
    audio.wav         16kHz mono PCM (what whisper consumes)
    words.json        [{start, end, word}] word-level timing (ms→seconds)
    silences.json     [{start, end, dur}] dead-air intervals from ffmpeg silencedetect
    transcript.txt    plain readable transcript

Local whisper.cpp only — nothing leaves the machine.
"""
import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).parent.parent
MODEL = ROOT / "models" / "ggml-base.en.bin"
WHISPER = "whisper-cli"

# Tunables (calibrate against a real clip)
SILENCE_NOISE_DB = "-30dB"   # below this = silence
SILENCE_MIN_DUR = "0.6"       # seconds of quiet before it counts as dead air


def run(cmd, **kw):
    return subprocess.run(cmd, check=True, capture_output=True, text=True, **kw)


def extract_audio(video: Path, wav: Path):
    run(["ffmpeg", "-y", "-i", str(video), "-ar", "16000", "-ac", "1",
         "-c:a", "pcm_s16le", str(wav)])


def transcribe_words(wav: Path, work: Path):
    """Run whisper-cli for word-level JSON (one word per segment via -ml 1 -sow)."""
    out_base = work / "whisper_words"
    run([WHISPER, "-m", str(MODEL), "-f", str(wav),
         "-oj", "-of", str(out_base), "-ml", "1", "-sow", "-wt", "0.01"])
    data = json.loads((work / "whisper_words.json").read_text())
    words = []
    for seg in data.get("transcription", []):
        text = seg.get("text", "").strip()
        if not text:
            continue
        off = seg.get("offsets", {})
        words.append({
            "start": round(off.get("from", 0) / 1000.0, 3),
            "end": round(off.get("to", 0) / 1000.0, 3),
            "word": text,
        })
    return words


def detect_silences(wav: Path):
    """Use ffmpeg silencedetect as an independent dead-air source."""
    proc = subprocess.run(
        ["ffmpeg", "-i", str(wav), "-af",
         f"silencedetect=noise={SILENCE_NOISE_DB}:d={SILENCE_MIN_DUR}", "-f", "null", "-"],
        capture_output=True, text=True)
    log = proc.stderr
    starts = [float(m) for m in re.findall(r"silence_start: ([\d.]+)", log)]
    ends = [float(m) for m in re.findall(r"silence_end: ([\d.]+)", log)]
    silences = []
    for i, s in enumerate(starts):
        e = ends[i] if i < len(ends) else None
        if e is not None:
            silences.append({"start": round(s, 3), "end": round(e, 3), "dur": round(e - s, 3)})
    return silences


def build_transcript(words):
    """Reconstruct readable sentences from words."""
    text = " ".join(w["word"] for w in words)
    text = re.sub(r"\s+([.,!?])", r"\1", text)
    text = re.sub(r"\s+", " ", text).strip()
    return text


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("video", help="path to raw video")
    args = ap.parse_args()

    video = Path(args.video).resolve()
    if not video.exists():
        sys.exit(f"Video not found: {video}")
    if not MODEL.exists():
        sys.exit(f"Whisper model missing: {MODEL}")

    work = ROOT / "edit_work" / video.stem
    work.mkdir(parents=True, exist_ok=True)
    wav = work / "audio.wav"

    print(f"[1/3] Extracting audio → {wav.name}")
    extract_audio(video, wav)

    print("[2/3] Transcribing (word-level, local whisper.cpp)…")
    words = transcribe_words(wav, work)
    (work / "words.json").write_text(json.dumps(words, indent=2))

    print("[3/3] Detecting silences (ffmpeg silencedetect)…")
    silences = detect_silences(wav)
    (work / "silences.json").write_text(json.dumps(silences, indent=2))

    (work / "transcript.txt").write_text(build_transcript(words))

    dur = words[-1]["end"] if words else 0
    print(f"\nDone. {len(words)} words, {len(silences)} silence gaps, ~{dur:.0f}s.")
    print(f"Work dir: {work}")
    print(f"Next: python edit/02_detect_cuts.py {video}")


if __name__ == "__main__":
    main()
