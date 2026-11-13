# YouTube Video Generator & Multi-Platform Content Suite

Generate complete, broadcast-quality YouTube videos (16:9 widescreen and 9:16 vertical shorts/reels) with **absolute synchronization between visible screen visuals, voiceover narration, and captions**, powered by a **code-drawn HTML5 Canvas motion graphics engine**, a **procedural Web Audio SFX synthesizer kit**, **100% code-drawn procedural proof shots & UI mockups (zero external stock footage or B-roll downloads)**, and an **interactive HTML player artifact (`player.html`) with transport controls and scrub bar**, alongside a full multi-channel distribution package across all social platforms (LinkedIn, Instagram, Twitter/X, Skool, Facebook, and Cover Images).

This skill provides broadcast-quality video generation and cross-platform social distribution with clean, copy-paste-ready formats and strict platform guardrails.

---

## Key Features

- **Absolute Audio-Visual-Caption Synchronization:** Guarantees that a slide or visible screen never transitions while the voiceover is still speaking for that topic. Every slide display duration is calculated dynamically:
  $$\text{Slide Duration} = \text{Audio Duration} + 0.6\text{s}$$
- **Automated Sync Verification (`verify-slide-sync.py`):** Automatically audits the timeline manifest before export to catch and eliminate audio leakage or early slide transitions.
- **Dual Video Deliverables (1080p MP4):**
  - **16:9 Landscape:** 3 to 6 minutes long, designed for YouTube tutorials and deep-dives.
  - **9:16 Vertical:** 1 to 3 minutes long, designed for YouTube Shorts, Instagram Reels, and TikTok.
- **Interactive HTML Player Artifact (`player.html` - Patil's Player System):** Single-file, self-contained interactive HTML5 Canvas & Web Audio player delivered directly in the output folder. Runs locally in Chrome, Safari, Edge, or Firefox without any server. Includes:
  - Play / Pause transport toggle (with spacebar keyboard shortcut)
  - Smooth scrub slider bar with instant frame-accurate canvas seek (`window.seek(t)`)
  - Formatted elapsed & total timecode readout (`MM:SS / MM:SS`)
  - Dual-Orientation Switcher: instantly toggles between 16:9 Landscape and 9:16 Portrait
  - Synthesized SFX sound toggle (`🔊 SFX ON` / `🔇 SFX MUTED`)
  - Loop toggle (`🔁 LOOP ON` / `➡️ ONCE`)
- **Code-Drawn Motion Graphics Engine ($f(t)$ Framework):** Animations are drawn mathematically on HTML5 Canvas where every frame is a pure function of time. Uses seeded PRNG (`CM.rng`), 1D value noise (`CM.noise1`), and easing curves (`ez`). Primitives include kinetic word slams (`slam`), highlighter swipes (`swipe`), 3D perspective yaw mockups (`drawYaw`), hand-drawn arrows (`handArrow`) and loops (`scribble`), rough strikes (`strike`), live terminal typewriter execution, and spring metric tickers.
- **100% Code-Drawn Procedural Proof Shots (Zero Stock B-Roll):** Real-world proof, software context, and technical demonstrations are never external stock video clips. Instead, all proof shots, device screens, and workflow demonstrations are 100% code-drawn procedural mockups on Canvas:
  - 3D perspective browser mockups (`drawYaw` / `drawBrowserProof`) with macOS traffic lights, URL bar, tab strips, and 3D yaw tilt.
  - Smartphone chat threads (`scenePhone`) with animated 3-dot typing indicators, message bubbles, and hand-drawn focus loops.
  - macOS developer terminal windows (`drawTerminalProof`) with character typing, stdout streams, and success badges.
  - Benchmark counters and latency charts (`drawMath`) with green glowing milestone numbers.
  - Red rubber stamps (`STAMP`) and rough strikes (`strike`) for debunking flawed approaches.
- **Procedural Web Audio SFX Kit:** Built-in synthesizer generating 16+ micro sound effects (`slam`, `boom`, `pop`, `tick`, `whoosh`, `glitch`, `marker`, `keys`, `tapeStop`, `shimmer`) mapped directly to timeline visual events, muxed alongside ElevenLabs cloned voiceover (-16 LUFS) and ducked background music (`volume=0.10`).
- **Mathematical Camera & Finishing Shaders:** Camera punch zooms on emphasis words (`PUNCH`), screen shake with 1D noise (`SHAKE`), slow scene push (`PUSH`), procedural film grain stepped at 24fps, radial vignette, light leaks (`LEAK`), and directional whip pans (`whip`, `whipV`) with sinusoidal motion blur.
- **7-Point Style Card from Local References (`pinterest-references/`):** Extracts Palette, Surface, Typography, Shapes/Layout, Emphasis, Motion, and Sound from 26 curated local reference videos—never searching Pinterest online.
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

## Code-Drawn Motion Graphics Engine Architecture

Generated videos are built using a **code-drawn HTML5 Canvas engine** where every frame is a deterministic mathematical function of time $f(t)$ (`scripts/motion-engine-template.html`), eliminating static slides:

1. **Pure Function of Time ($t$):** Renders dynamically on canvas using seeded PRNG (`CM.rng`) and 1D gradient noise (`CM.noise1`), guaranteeing zero desync and frame-accurate reproducibility.
2. **Procedural 2D Drawing Primitives:**
   - **Kinetic Word Slams (`slam`):** Words land with scale overshoot and motion blur (`blur(Xpx)`), settling with `ez.outExpo`.
   - **Highlighter Swipes (`swipe`):** Dynamic marker paths sweeping behind text with clip paths that flip text to dark contrast ink (`slamMarked`).
   - **Rough Strike-Throughs (`strike`):** Textured red strike lines crossing out negative concepts or pitfalls.
   - **3D Perspective Yaw Mockups (`drawYaw`):** Rotates 2D UI layers, terminal windows, or dashboards along the vertical Y-axis with distance projection, soft shadows, and glass reflection sheens.
   - **Organic Hand Loops & Arrows:** Procedural noise-modulated circles (`scribble`) and Bézier arrows (`handArrow`) highlighting key points.
   - **Live Terminal & Code Execution (`drawTerminalProof`):** Simulated macOS dark terminals with real-time character typing, blinking cursor, and stdout stream.
   - **Spring Metric Tickers (`drawMath`):** Live number counters sweeping from zero to target with glowing lock milestones.
3. **Mathematical Camera Dynamics & Finishing Shaders:**
   - **Camera Physics (`camera`):** Scene-level slow push (`PUSH`), punch zooms on emphasis words (`PUNCH`), and screen shake driven by 1D noise (`SHAKE`).
   - **Cinematic Shaders (`finishing`):** 4-tile procedural film grain stepped at 24fps, radial vignette, warm light leaks (`LEAK`), and flash transitions (`FLASH`).
   - **Scene Transitions:** Multi-pass directional whip pans (`whip`, `whipV`) with sinusoidal motion blur, and RGB channel-split glitch (`glitch`).
4. **Procedural Web Audio SFX Kit:** Synthesizes 16+ sound effects (`slam`, `boom`, `pop`, `tick`, `whoosh`, `glitch`, `marker`, `keys`) mapped to timeline visual events, muxed with ElevenLabs cloned voiceover (-16 LUFS) and ducked music (10% volume).
5. **Dual-Orientation Engine (16:9 & 9:16):**
   - **16:9 Landscape (`1920×1080`):** Widescreen stage, horizontal code/diagram split screens, lateral whip cuts.
   - **9:16 Portrait (`1080×1920`):** Vertical mobile stage, stacked typography, centered hero statements, vertical whip cuts (`whipV`).

### Curated Local Reference Library (`pinterest-references/`) & 7-Point Style Card
Instead of searching Pinterest online, motion graphics styles are chosen directly from the local `pinterest-references/` folder and formalized into a 7-Point Style Card:
- **Kinetic Typography & 3D Text:** `Burzaev_studio_*.mp4`, `divyanshfx_*.mp4`, `dspatel7664_*.mp4`, `Rishabh_Verma13_*.mp4`.
- **SaaS UI & Glassmorphic Cards:** `socialheavenio_*.mp4`, `solution_wagon_*.mp4`, `exar_digital_*.mp4`, `rovixstudios_*.mp4`.
- **Technical Infographics & Architecture:** `insiderforce_*.mp4`, `mostafaazv_*.mp4`, `creatingwithakash_*.mp4`.
- **Minimalist Editorial & Smooth Glides:** `Grace_Studio57_*.mp4`, `motiondesigners2d_*.mp4`, `mukithasan997_*.mp4`.

---

## Deliverables in Output Folder (`YYYYMMDD-HHMMSS/`)

After the automated cleanup pass, the output folder strictly contains **ONLY the final generated deliverables**:

```
YYYYMMDD-HHMMSS/
├── {topic-slug}-16by9.mp4          # 16:9 widescreen YouTube video (1080p, 3-6 mins, synced)
├── {topic-slug}-9by16.mp4          # 9:16 vertical video (YouTube Shorts / Reels, 1080p, 1-3 mins, synced)
├── player.html                     # Interactive HTML5 Canvas & Web Audio player artifact (scrub, aspect switcher, sound)
├── youtube.md                      # YouTube metadata: 3 titles, SEO description, timestamps, tags
├── linkedin-post.md                # Clean copy-paste LinkedIn post (zero markdown)
├── skool-post.md                   # Clean copy-paste Skool community post (zero markdown)
├── instagram-post.md               # Clean copy-paste Instagram caption & hashtags (zero markdown)
├── twitter-post.md                 # Standalone tweet + numbered thread (zero markdown)
├── facebook-post.md                # Clean copy-paste Facebook post (zero markdown)
├── cover.svg                       # 1200×627 SVG cover image (1.91:1)
├── cover-prompt.md                 # AI image prompt for Midjourney / DALL-E / Flux
├── pinterest-motion-design.md      # Selected reference video from pinterest-references/ & motion specs
└── credits.md                      # Voiceover profile, fonts, procedural sound specs, and music license log
```

> All intermediate files and scratch working directories (`assets/`, `slides_*`, `tmp*`, and temporary render fragments) are automatically purged after the final videos and posts are created. Permanent skill directories (`pinterest-references/` and `scripts/`) are preserved.

---

## Scripts & Utilities

- **Interactive Motion Engine Template & Browser Player (`scripts/motion-engine-template.html`):**
  Self-contained HTML5 Canvas and Web Audio template with transport controls, scrub slider, aspect ratio switcher, and procedural drawing primitives.
- **Slide-Voiceover Synchronization Audit (`scripts/verify-slide-sync.py`):**
  ```bash
  python3 scripts/verify-slide-sync.py YYYYMMDD-HHMMSS/sync-manifest.json
  ```
