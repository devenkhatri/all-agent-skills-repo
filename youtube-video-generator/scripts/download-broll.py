#!/usr/bin/env python3
"""
download-broll.py
Download and process copyright-free B-roll video clips from the internet.
Supports:
  1. Pexels Videos API (via PEXELS_API_KEY)
  2. Pixabay Videos API (via PIXABAY_API_KEY)
  3. Wikimedia Commons Open Video API (zero API key required)
  4. Direct video URL download (from Pexels, Pixabay, Coverr, Mixkit, etc.)

Automatically normalizes resolution (1080p), strips audio, trims to target duration (e.g. 2.5s-3.5s),
and logs source attribution to credits.md.

Usage:
  python3 download-broll.py --query "data center server" --output assets/broll/slide_1_broll.mp4 --orientation landscape --duration 3.0
  python3 download-broll.py --url "https://..." --output assets/broll/slide_2_broll.mp4 --duration 3.0
"""

import sys
import os
import argparse
import urllib.request
import urllib.parse
import json
import subprocess
import tempfile
from pathlib import Path

USER_AGENT = "VideoGeneratorBot/1.0 (https://github.com/devenkhatri; deven@dhimahitechnolabs.com)"

def log_credit(credits_file, item_title, source_url, license_type="Free / Copyright-Free"):
    if not credits_file:
        return
    credits_path = Path(credits_file)
    header = "# Asset Credits & Copyright-Free License Log\n\n| Asset | Topic / Query | Source URL | License |\n|---|---|---|---|\n"
    if not credits_path.exists():
        credits_path.parent.mkdir(parents=True, exist_ok=True)
        with open(credits_path, "w", encoding="utf-8") as f:
            f.write(header)
    
    with open(credits_path, "a", encoding="utf-8") as f:
        f.write(f"| B-Roll Video | {item_title} | {source_url} | {license_type} |\n")

def download_file(url, target_path):
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=30) as resp, open(target_path, "wb") as out:
        while True:
            chunk = resp.read(65536)
            if not chunk:
                break
            out.write(chunk)

def search_pexels(query, orientation="landscape"):
    api_key = os.environ.get("PEXELS_API_KEY") or os.environ.get("PEXELS_KEY")
    if not api_key:
        return None
    url = f"https://api.pexels.com/videos/search?query={urllib.parse.quote(query)}&per_page=5&orientation={orientation}"
    req = urllib.request.Request(url, headers={"Authorization": api_key, "User-Agent": USER_AGENT})
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode())
            videos = data.get("videos", [])
            if not videos:
                return None
            for v in videos:
                v_files = v.get("video_files", [])
                # find 1080p or hd mp4
                for vf in v_files:
                    if vf.get("file_type") == "video/mp4" and (vf.get("quality") == "hd" or vf.get("height", 0) >= 720):
                        return {
                            "url": vf["link"],
                            "source_page": v.get("url"),
                            "provider": "Pexels (CC0 / Free License)"
                        }
                if v_files:
                    return {
                        "url": v_files[0]["link"],
                        "source_page": v.get("url"),
                        "provider": "Pexels (CC0 / Free License)"
                    }
    except Exception as e:
        print(f"Pexels API notice: {e}")
    return None

def search_pixabay(query):
    api_key = os.environ.get("PIXABAY_API_KEY") or os.environ.get("PIXABAY_KEY")
    if not api_key:
        return None
    url = f"https://pixabay.com/api/videos/?key={api_key}&q={urllib.parse.quote(query)}&video_type=film&per_page=5"
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read().decode())
            hits = data.get("hits", [])
            if not hits:
                return None
            first = hits[0]
            v_dict = first.get("videos", {})
            chosen = v_dict.get("large", {}) or v_dict.get("medium", {}) or v_dict.get("small", {})
            if chosen and chosen.get("url"):
                return {
                    "url": chosen["url"],
                    "source_page": first.get("pageURL"),
                    "provider": "Pixabay (Free Commercial License)"
                }
    except Exception as e:
        print(f"Pixabay API notice: {e}")
    return None

def search_wikimedia(query):
    """Search Wikimedia Commons for open video files without requiring any API key."""
    search_terms = [
        f"{query} filemime:video/webm",
        f"{query} filemime:video/mp4",
        f"{query} video"
    ]
    for st in search_terms:
        url = f"https://commons.wikimedia.org/w/api.php?action=query&list=search&srsearch={urllib.parse.quote(st)}&srnamespace=6&format=json"
        req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
        try:
            with urllib.request.urlopen(req, timeout=10) as resp:
                data = json.loads(resp.read().decode())
                results = data.get("query", {}).get("search", [])
                for item in results:
                    title = item.get("title", "")
                    if any(title.lower().endswith(ext) for ext in [".webm", ".mp4", ".ogv"]):
                        info_url = f"https://commons.wikimedia.org/w/api.php?action=query&titles={urllib.parse.quote(title)}&prop=imageinfo&iiprop=url|mime|size&format=json"
                        req_info = urllib.request.Request(info_url, headers={"User-Agent": USER_AGENT})
                        with urllib.request.urlopen(req_info, timeout=10) as info_resp:
                            info_data = json.loads(info_resp.read().decode())
                            pages = info_data.get("query", {}).get("pages", {})
                            for _, p in pages.items():
                                img_info = p.get("imageinfo", [])
                                if img_info and img_info[0].get("url"):
                                    size_bytes = img_info[0].get("size", 0)
                                    if size_bytes > 50 * 1024 * 1024:
                                        continue
                                    return {
                                        "url": img_info[0]["url"],
                                        "source_page": f"https://commons.wikimedia.org/wiki/{urllib.parse.quote(title)}",
                                        "provider": "Wikimedia Commons (Public Domain / CC0)"
                                    }
        except Exception:
            continue
    return None

def post_process_video(input_path, output_path, duration=3.5, orientation="landscape"):
    """Trim duration, normalize to 1080p resolution, strip audio, and encode to high-compat H.264 MP4."""
    out_dir = Path(output_path).parent
    out_dir.mkdir(parents=True, exist_ok=True)

    if orientation == "portrait":
        # 1080x1920 (9:16)
        vf = "scale=1080:1920:force_original_aspect_ratio=decrease,pad=1080:1920:(ow-iw)/2:(oh-ih)/2,setsar=1"
    else:
        # 1920x1080 (16:9)
        vf = "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2,setsar=1"

    cmd = [
        "ffmpeg", "-y",
        "-ss", "0",
        "-t", str(duration),
        "-i", str(input_path),
        "-vf", vf,
        "-c:v", "libx264",
        "-preset", "fast",
        "-crf", "20",
        "-pix_fmt", "yuv420p",
        "-an",
        "-movflags", "+faststart",
        str(output_path)
    ]
    subprocess.check_call(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

def main():
    parser = argparse.ArgumentParser(description="Download and process copyright-free B-roll videos")
    parser.add_argument("--query", help="Search query (e.g. 'code terminal', 'server data center')")
    parser.add_argument("--url", help="Direct video URL from Pexels/Pixabay/Coverr/Mixkit/Wikimedia")
    parser.add_argument("--output", required=True, help="Destination file path (e.g. YYYYMMDD-HHMMSS/assets/broll/slide_1_broll.mp4)")
    parser.add_argument("--duration", type=float, default=3.5, help="Target cutaway duration in seconds (default: 3.5)")
    parser.add_argument("--orientation", choices=["landscape", "portrait"], default="landscape", help="landscape (16:9) or portrait (9:16)")
    parser.add_argument("--credits", default=None, help="Path to credits.md file to log attribution")

    args = parser.parse_args()

    # Determine default credits path if not supplied
    credits_path = args.credits
    if not credits_path:
        out_p = Path(args.output)
        if "assets" in out_p.parts:
            # e.g. YYYYMMDD-HHMMSS/assets/broll/file.mp4 -> YYYYMMDD-HHMMSS/credits.md
            root_idx = out_p.parts.index("assets")
            credits_path = Path(*out_p.parts[:root_idx]) / "credits.md"

    video_info = None

    if args.url:
        video_info = {
            "url": args.url,
            "source_page": args.url,
            "provider": "Direct URL (Copyright-Free Site)"
        }
    elif args.query:
        print(f"🔍 Searching copyright-free sites for: '{args.query}' ({args.orientation})...")
        # Try Pexels -> Pixabay -> Wikimedia
        video_info = search_pexels(args.query, args.orientation)
        if not video_info:
            video_info = search_pixabay(args.query)
        if not video_info:
            video_info = search_wikimedia(args.query)

    if not video_info or not video_info.get("url"):
        print(f"❌ Error: Could not locate a copyright-free video for query: '{args.query or args.url}'")
        sys.exit(1)

    print(f"⬇️ Downloading B-roll from {video_info['provider']}...")
    with tempfile.NamedTemporaryFile(suffix=".mp4", delete=False) as raw_tmp:
        raw_path = raw_tmp.name

    try:
        download_file(video_info["url"], raw_path)
        print(f"✂️ Normalizing resolution ({args.orientation}) & trimming to {args.duration:.1f}s...")
        post_process_video(raw_path, args.output, duration=args.duration, orientation=args.orientation)
        log_credit(credits_path, args.query or "Custom B-Roll", video_info["source_page"], video_info["provider"])
        print(f"✅ B-roll ready: {args.output} (logged in {credits_path})")
    finally:
        if os.path.exists(raw_path):
            os.remove(raw_path)

if __name__ == "__main__":
    main()

