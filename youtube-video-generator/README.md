# YouTube Video Generator & Multi-Platform Content Suite

Generate complete, broadcast-quality YouTube videos (16:9 widescreen and 9:16 vertical shorts/reels) with **absolute synchronization between visible screen visuals, voiceover narration, and captions**, featuring **purpose-fit copyright-free images and selective B-roll used only when it naturally fits the scene (never forced)**, alongside a full multi-channel distribution package across all social platforms (LinkedIn, Instagram, Twitter/X, Skool, Facebook, and Cover Images).

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
- **Agency-Grade High-Density Motion Graphics (Modeled on Local References):** Motion design is modeled directly after the 26 curated reference videos stored in `pinterest-references/` (never searching Pinterest online). Enforces a Zero Static Screen Policy with at least 2 to 3 active motion graphic layers running simultaneously in every scene (ambient background motion, kinetic core visuals, text/counter accents, persistent gradient progress bar). Zero frozen or unmoving screens.
- **6 Core Motion Graphics Categories:** Kinetic typography, animated architecture diagrams with laser pulse data packets, live-typing terminal code windows, dynamic spring metric counters, floating glassmorphic UI cards, and dynamic camera moves / seamless transitions.
- **Selective, Purpose-Fit B-Roll (Zero Forced B-Roll):** B-roll video cutaways and photographic assets are deployed selectively—only when they naturally contextualize and fit the scene (hooks, transitions, physical hardware, real-world analogies). B-roll is never forced onto code walkthroughs, terminal demos, or architecture diagrams where high-density motion graphics deliver superior clarity. When used, all footage is copyright-free from Pexels, Pixabay, Mixkit, Coverr, or Wikimedia Commons with zero watermarks.
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

## Motion Graphics Architecture & Categories

Generated videos enforce a **Zero Static Screen Policy** using a multi-layer composition pipeline modeled directly after the **curated reference videos in `pinterest-references/`** (never searching Pinterest online):

1. **Layer 1: Ambient Background Motion** — Continuous subtle gradient drift, particle dust, or Ken Burns 3D camera pan/zoom (`scale: 1.0 → 1.04`).
2. **Layer 2: Core Kinetic Visual Component** — Animated flow diagrams, self-typing terminal code windows, live-drawing architecture paths, or floating UI cards.
3. **Layer 3: Kinetic Text & Metric Accents** — Staggered word reveals, live number counters ticking up with spring physics, glowing highlight strokes, and dynamic checkmark draws.
4. **Layer 4: Persistent Pacing Anchor** — Continuous top gradient progress bar (`0% → 100%`) running across the full video runtime.

### Curated Local Reference Library (`pinterest-references/`)
Instead of browsing Pinterest on the web, motion graphics styles are chosen directly from the local `pinterest-references/` folder:
- **Kinetic Typography & 3D Text:** `Burzaev_studio_*.mp4`, `divyanshfx_*.mp4`, `dspatel7664_*.mp4`, `Rishabh_Verma13_*.mp4`.
- **SaaS UI & Glassmorphic Cards:** `socialheavenio_*.mp4`, `solution_wagon_*.mp4`, `exar_digital_*.mp4`, `rovixstudios_*.mp4`.
- **Technical Infographics & Architecture:** `insiderforce_*.mp4`, `mostafaazv_*.mp4`, `creatingwithakash_*.mp4`.
- **Minimalist Editorial & Smooth Glides:** `Grace_Studio57_*.mp4`, `motiondesigners2d_*.mp4`, `mukithasan997_*.mp4`.

### The 6 Core Motion Graphics Categories:
- **Kinetic Typography:** Staggered word entrances, voiceover-synchronized keyword glows, translucent glassmorphism badge pills.
- **Animated Architecture Diagrams:** Self-drawing connection lines (`stroke-dashoffset`), pulsing nodes, and glowing laser data packets moving along paths.
- **Live-Typing Terminal Windows:** Dark macOS terminal frames with real-time character typing, blinking cursor, and simulated execution outputs.
- **Dynamic Metric Counters:** Spring number tickers (`0% → +350%`, `12ms → 1.4ms`), animated bar sweeps, and radial circular progress rings.
- **Floating Glassmorphism & UI Mockups:** Frosted glass cards (`backdrop-filter: blur(16px)`), subtle 3D parallax tilting, and glowing neon borders.
- **Dynamic Transitions & Camera Glides:** Whip pans, directional light sweeps, and continuous Ken Burns drift between visual scenes.

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
├── pinterest-motion-design.md      # Selected reference video from pinterest-references/ & motion specs
└── credits.md                      # Free copyright-free images & B-roll sources and license log
```

> All intermediate files and scratch working directories (`assets/`, `slides_*`, `tmp*`, and temporary render fragments) are automatically purged after the final videos and posts are created. Permanent skill directories (`pinterest-references/` and `scripts/`) are preserved.

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
