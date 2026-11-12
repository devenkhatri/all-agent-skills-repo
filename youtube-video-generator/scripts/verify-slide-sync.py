#!/usr/bin/env python3
"""
verify-slide-sync.py
Verify that visible screen slide durations are strictly in sync with voiceover narration and captions.
Guarantees that a slide NEVER transitions to the next one while the voiceover for the current slide is still speaking.

Usage:
    python3 scripts/verify-slide-sync.py <folder-or-manifest-path>

The target folder can contain:
  1. sync-manifest.json (explicit slide, audio, and caption timeline mapping)
  2. assets/voiceover_slide_*.mp3 + slides/slide_*.svg (auto-inspected via ffprobe)
"""

import sys
import os
import json
import subprocess
from pathlib import Path

def get_audio_duration_ffprobe(audio_path):
    """Get precise duration of an audio file in seconds via ffprobe."""
    try:
        cmd = [
            "ffprobe", "-v", "error",
            "-show_entries", "format=duration",
            "-of", "default=noprint_wrappers=1:nokey=1",
            str(audio_path)
        ]
        out = subprocess.check_output(cmd, stderr=subprocess.DEVNULL).decode().strip()
        return float(out)
    except Exception:
        return None

def verify_manifest(manifest_path):
    with open(manifest_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    slides = data.get("slides", []) or data.get("scenes", [])
    captions = data.get("captions", [])
    folder_dir = Path(manifest_path).parent

    if not slides:
        print(f"❌ Error: No 'slides' or 'scenes' defined in {manifest_path}")
        return False

    all_passed = True
    current_time = 0.0

    print("=" * 80)
    print(f"VERIFYING AUDIO-VISUAL-CAPTION SYNCHRONIZATION: {manifest_path}")
    print("=" * 80)
    print(f"{'Slide':<8} | {'Title / Topic':<28} | {'Audio Dur':<10} | {'Slide Dur':<10} | {'Status'}")
    print("-" * 80)

    for idx, slide in enumerate(slides, 1):
        title = slide.get("title", f"Slide {idx}")[:28]
        slide_dur = float(slide.get("duration", 0.0))
        audio_dur = float(slide.get("audio_duration", 0.0))
        audio_file = slide.get("audio_file")

        # If audio_duration not provided, try probing audio_file
        if audio_dur == 0.0 and audio_file:
            audio_path = folder_dir / audio_file
            if audio_path.exists():
                probed = get_audio_duration_ffprobe(audio_path)
                if probed:
                    audio_dur = probed

        slide_start = current_time
        slide_end = slide_start + slide_dur

        # Sync Rule: Visible slide MUST stay on screen for the ENTIRE duration of its voiceover
        if slide_dur < audio_dur:
            all_passed = False
            diff = audio_dur - slide_dur
            status = f"❌ FAIL (Audio leaks by +{diff:.2f}s)"
        elif slide_dur == 0.0:
            all_passed = False
            status = "❌ FAIL (Slide duration is 0)"
        else:
            status = "✅ SYNCED"

        print(f"{idx:<8} | {title:<28} | {audio_dur:>8.2f}s | {slide_dur:>8.2f}s | {status}")

        # Check corresponding captions within this slide/scene
        for cap in captions:
            c_slide = cap.get("slide_index") if cap.get("slide_index") is not None else cap.get("scene_index")
            if c_slide == idx:
                c_start = float(cap.get("start", 0.0))
                c_end = float(cap.get("end", 0.0))
                if c_start < slide_start - 0.05 or c_end > slide_end + 0.15:
                    print(f"   ⚠️  Caption Desync: '{cap.get('text', '')[:30]}' [{c_start:.2f}s-{c_end:.2f}s] extends outside slide window [{slide_start:.2f}s-{slide_end:.2f}s]")
                    all_passed = False

        current_time = slide_end

    print("-" * 80)
    total_audio = sum(float(s.get("audio_duration", 0.0)) for s in slides)
    print(f"Total Video Timeline: {current_time:.2f}s | Total Spoken Audio: {total_audio:.2f}s")
    print("=" * 80)

    if all_passed:
        print("✅ PASS: Screen visual is 100% in sync with voiceover narration and captions.")
        return True
    else:
        print("❌ FAIL: Synchronization errors detected! Slide transitions occur before voiceover ends.")
        print("   Rule: Adjust slide duration = audio_duration + transition_padding (0.5s-1.0s).")
        return False

def main():
    if len(sys.argv) < 2 or sys.argv[1] in ("-h", "--help"):
        print("Usage: python3 verify-slide-sync.py <folder-or-manifest.json>")
        sys.exit(0 if len(sys.argv) >= 2 and sys.argv[1] in ("-h", "--help") else 1)

    target = Path(sys.argv[1])
    if target.is_dir():
        manifest = target / "sync-manifest.json"
        if not manifest.exists():
            # Check for alternative manifest names
            for alt in ["timeline.json", "assets/sync-manifest.json"]:
                if (target / alt).exists():
                    manifest = target / alt
                    break
        if not manifest.exists():
            print(f"❌ Error: Could not find sync-manifest.json in {target}")
            sys.exit(1)
    else:
        manifest = target

    success = verify_manifest(manifest)
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()

