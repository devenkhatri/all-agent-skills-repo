# YouTube Video Generator & Multi-Platform Content Suite

Generate complete, broadcast-quality YouTube videos (16:9 widescreen and 9:16 vertical shorts/reels) with **absolute synchronization between visible screen visuals, voiceover narration, and captions**, featuring **copyright-free images and B-roll strictly relevant to the content of every slide**, alongside a full multi-channel distribution package across all social platforms (LinkedIn, Instagram, Twitter/X, Skool, Facebook, and Cover Images).

This skill provides broadcast-quality video generation and cross-platform social distribution with clean, copy-paste-ready formats and strict platform guardrails.

---

## Key Features

- **Absolute Audio-Visual-Caption Synchronization:** Guarantees that a slide or visible screen never transitions while the voiceover is still speaking for that topic. Every slide display duration is calculated dynamically:
  $$\text{Slide Duration} = \text{Audio Duration} + 0.6\text{s}$$
- **Automated Sync Verification (`verify-slide-sync.py`):** Automatically audits the timeline manifest before export to catch and eliminate audio leakage or early slide transitions.
- **Dual Video Deliverables (1080p MP4):**
  - **16:9 Landscape:** 3 to 6 minutes long, designed for YouTube tutorials and deep-dives.
  - **9:16 Vertical:** 1 to 3 minutes long, designed for YouTube Shorts, Instagram Reels, and TikTok.
- **ElevenLabs Cloned Voiceover:** High-presence narration (-16 LUFS) with background music strictly ducked down to 10% volume (`volume=0.10`).
- **Automated B-Roll Downloading from the Internet (`download-broll.py`):** Automatically searches, downloads, trims (1.5s–3.5s), normalizes to 1080p, and strips audio from copyright-free B-roll clips from Pexels Videos, Pixabay Videos, and Wikimedia Commons (zero API key required for Wikimedia), logging full attribution into `credits.md`.
- **Agency-Grade Motion Graphics, Images & B-Roll:** Pinterest-inspired motion graphic design, dynamic top progress bar, slide counter pills, and **copyright-free images and B-rolls strictly relevant to the content of each slide** from Unsplash/Pexels/Pixabay/Mixkit/Coverr (zero watermarks).
- **Complete Multi-Channel Social Content:**
  - **YouTube:** 3 clickable title options, SEO video description with hook, chapters/timestamps matching the video, tags (`youtube.md`).
  - **LinkedIn:** Hook <8 words, punchy re-hook, 1–2 sentence paragraphs, emojis, soft CTA, ♻️ Repost, ➕ Follow Deven Goratela, 3–5 hashtags (`linkedin-post.md`).
  - **Cover Image:** 1200×627 SVG with central 1000×500 safe zone (`cover.svg`) + Midjourney/Flux prompt (`cover-prompt.md`).
  - **Skool Community:** Casual peer-to-peer reframe, tool/tip focus, zero hashtags, open-ended question (`skool-post.md`).
  - **Instagram:** Visual hook <10 words, emoji bullets, save/share CTA, 10–15 hashtags at bottom (`instagram-post.md`).
  - **Twitter / X:** Single punchy tweet (<280 chars) PLUS full numbered thread (`twitter-post.md`).
  - **Facebook:** Conversational, relatable storytelling post with discussion question (`facebook-post.md`).
- **Strict Zero Markdown Rule:** All social copy files are 100% copy-paste ready into native apps with zero markdown clutter (`**bold**`, `*italic*`, `###`, `---`, `[link](url)`).
- **Zero Intermediate Clutter (Automatic Cleanup):** Automatically purges all intermediate working files (review thumbnails, frame folders, per-slide voiceover splits, temporary video cuts, and scratch directories) upon completion so the folder strictly holds the final generated output files.
- **Mandatory Pre-Edit Video Review:** When given a source video, watches and critiques the entire video end-to-end (hook, pacing, dead air, visual fatigue) before editing.
- **Face-Free Visuals:** Prioritizes software UI, architecture diagrams, code, terminal workflows, and tools over talking heads.

---

## Deliverables in Output Folder (`YYYYMMDD-HHMMSS/`)

After the automated cleanup pass, the output folder strictly contains **ONLY the final generated deliverables**:

```
YYYYMMDD-HHMMSS/
├── {topic-slug}-16by9.mp4          # 16:9 widescreen YouTube video (1080p, 3-6 mins, synced)
├── {topic-slug}-9by16.mp4          # 9:16 vertical video (YouTube Shorts / Reels, 1080p, 1-3 mins, synced)
├── youtube.md                      # YouTube metadata: 3 titles, SEO description, timestamps, tags
├── linkedin-post.md                # Clean copy-paste LinkedIn post (zero markdown)
├── skool-post.md                   # Clean copy-paste Skool community post (zero markdown)
├── instagram-post.md               # Clean copy-paste Instagram caption & hashtags (zero markdown)
├── twitter-post.md                 # Standalone tweet + numbered thread (zero markdown)
├── facebook-post.md                # Clean copy-paste Facebook post (zero markdown)
├── cover.svg                       # 1200×627 SVG cover image (1.91:1)
├── cover-prompt.md                 # AI image prompt for Midjourney / DALL-E / Flux
├── pinterest-motion-design.md      # Selected Pinterest motion graphics design URL & styling
└── credits.md                      # Free copyright-free images & B-roll sources and license log
```

> All intermediate files and scratch working directories (`assets/`, `slides_*`, `tmp*`, and temporary render fragments) are automatically purged after the final videos and posts are created.

---

## Scripts & Utilities

- **Download Copyright-Free B-Roll from the Internet:**
  ```bash
  # Search & download by topic/query (landscape 16:9 or portrait 9:16)
  python3 scripts/download-broll.py --query "server data center" --output YYYYMMDD-HHMMSS/assets/broll/slide_1_broll.mp4 --orientation landscape --duration 3.0

  # Download from direct copyright-free video URL
  python3 scripts/download-broll.py --url "https://..." --output YYYYMMDD-HHMMSS/assets/broll/slide_2_broll.mp4 --duration 3.0
  ```
- **Slide-Voiceover Synchronization Audit:**
  ```bash
  python3 scripts/verify-slide-sync.py YYYYMMDD-HHMMSS/sync-manifest.json
  ```
