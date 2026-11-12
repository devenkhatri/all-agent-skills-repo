---
name: youtube-video-generator
description: Generate complete, multi-platform YouTube and social media content packages from a topic, video, YouTube URL, or GitHub repo. Produces synchronized 16:9 and 9:16 videos (with screen-voiceover-caption synchronization, ElevenLabs cloned voice, low-volume background music, motion graphics, slide-relevant copyright-free images and B-roll, and proper captions), plus native content for all channels (LinkedIn, Instagram, Twitter/X, Skool, Facebook, and Cover image) with clean, copy-ready formats and strict platform guardrails.
---

# YouTube Video Generator & Multi-Platform Content Suite

Generate complete, broadcast-quality YouTube videos (16:9 widescreen and 9:16 vertical shorts/reels) with **absolute synchronization between visible screen visuals, voiceover narration, and captions**, featuring **copyright-free images and B-roll strictly relevant to the content of every slide**, alongside a full multi-channel distribution package across all social platforms (LinkedIn, Instagram, Twitter/X, Skool, Facebook, and Cover Images).

This skill enforces professional video production standards, agency-grade motion graphics, strict zero-desync timing, and copy-paste-ready social post formats tailored natively to each platform.

---

## Core Guarantees & Golden Rules

### 1. Absolute Audio-Visual-Caption Synchronization (Zero Desync Guarantee)
> [!IMPORTANT]
> **Visible Screen Must Be in Exact Sync with Voiceover and Captions:**
> It must **NEVER** happen that the voiceover is playing for a topic and the slide has already moved to the next one.
>
> - Every visual slide, diagram, UI screenshot, or B-roll segment MUST stay active on screen for the **entire duration** that its voiceover narration is speaking.
> - The duration of each slide is dynamically calculated from the exact audio length of its spoken narration:
>   $$\text{Slide Display Duration} = \text{Audio Duration} + \text{Transition Padding (0.5s–1.0s)}$$
> - Under NO circumstances may $\text{Slide Display Duration} < \text{Audio Duration}$.
> - The transition to the next slide or visual segment triggers **only after** the narration for the current slide has completely finished speaking.
> - Captions must be strictly bounded within the start and end timestamps of the active slide.

### 2. Strict Zero Extra Markdown Characters in Social Posts
> [!IMPORTANT]
> **Zero Markdown Clutter in Copyable Social Files:**
> Social media platforms (LinkedIn, Instagram, Twitter/X, Facebook, Skool) do **NOT** render markdown syntax. Raw markdown symbols (`**bold**`, `*italic*`, `### headings`, `[links](url)`, `---`, `- `) display as ugly literal clutter that harms reach and requires manual editing.
>
> - Enforce across all post files (`linkedin-post.md`, `skool-post.md`, `instagram-post.md`, `twitter-post.md`, `youtube.md`, `facebook-post.md`):
>   1. **NO markdown bolding or italics:** Never use `**bold**` or `*italic*`. Use UPPERCASE words sparingly or unicode bold for emphasis.
>   2. **NO markdown headings:** Never use `#`, `##`, or `###`. Use clean blank lines, emojis, or uppercase header lines.
>   3. **NO markdown horizontal rules:** Never use `---` or `***`.
>   4. **NO markdown links:** Write bare URLs directly (e.g., `https://www.linkedin.com/in/devengoratela/`) or use phrases like "link in bio" or "link in the first comment".
>   5. **NO markdown bullets:** Use emoji bullets (`•`, `👉`, `🔹`, `⚡`) or numbers (`1.`, `2.`), never `- ` or `* `.
>   6. **NO outer code block fences:** Never wrap entire files in ` ```markdown ... ``` `. Files must contain copy-ready text from line 1.

### 3. Banned AI Slop Words
Strictly avoid generic corporate AI buzzwords across all scripts, posts, captions, and slide copy:
`delve`, `landscape`, `unlock`, `tapestry`, `navigate`, `realm`, `leverage`, `in today's fast-paced world`, `in conclusion`, `game-changer`, `revolutionize`.

### 4. Mandatory Pre-Edit Review ("Watch Before You Edit")
When the source input is a video file or video/YouTube URL:
- **Before you edit, watch the whole video and tell the user what can be done better.**
- Programmatically inspect the full video end-to-end (probe stream metadata via `ffprobe`, sample timeline frames and generate contact sheets via `ffmpeg`, inspect transcript/audio).
- Deliver an upfront critique covering: hook strength (first 3–5 seconds), pacing and dead air, talking-head visual fatigue, motion graphics opportunities, caption styling needs, and recommended B-roll cutaway spots before generating slides or edits.

### 5. Face-Free Visuals & Screenshots Rule
When extracting visual milestones or screenshots from source videos or GitHub repos:
- Strictly focus on **software UI, terminal workflows, code snippets, architecture diagrams, and system outputs**.
- Strictly avoid or crop out talking heads, presenter webcams, or picture-in-picture (PiP) bubbles. Viewers watch to absorb the tool and workflow, not the presenter's face.

### 6. Unique Background Color for Every Video Scene / Slide
- Every slide or scene in the video sequence MUST have a **unique background color or gradient** within a harmonious palette progression (e.g., deep midnight navy → dark slate → abyssal blue → deep charcoal → cyber teal). Never use identical backgrounds on consecutive slides or across all slides.
- Text and visual elements must maintain a high contrast ratio ($\ge 4.5:1$) against each slide's specific background.

### 7. ElevenLabs Cloned Voiceover & Low-Volume Background Music
- Synthesize narration using the user's latest cloned voice from ElevenLabs.
- **Audio Ducking Rule:** Voiceover must be normalized to -16 LUFS (punchy, crisp, prominent). Background music (e.g., `youtube-shorts-bt-music.mp3`) must strictly be ducked down to **low volume** (10% volume / `volume=0.10`, approx -20dB to -24dB relative to speech). The voice must remain 100% intelligible and prominent throughout.

### 8. Copyright-Free Images & B-Roll Strictly Relevant to Each Slide's Content
> [!IMPORTANT]
> **Slide-Relevant Visual Assets (Images & B-Roll):**
> In the generated video, every slide must incorporate high-resolution copyright-free images and B-roll clips that are **strictly relevant to the specific content, concept, or technical point of that slide**. Generic, decorative, or disconnected stock footage is strictly prohibited.
>
> - **Slide-by-Slide Content Matching:**
>   - If a slide covers "API Rate Limiting & Gateway Architecture", the image/B-roll must visually represent network traffic, gateway nodes, server racks, or code configuration.
>   - If a slide covers "Autonomous Agent Swarms", the image/B-roll must depict distributed nodes, collaborative robotic systems, neural architectures, or multi-terminal execution.
>   - If a slide covers "Database Vector Indexing", the image/B-roll must depict high-speed data streams, vector clustering, or database query consoles.
> - **Verified Copyright-Free Sourcing Platforms on the Internet:**
>   - **Copyright-Free B-Roll Sites:** Sourced from **Pexels Videos** (`https://www.pexels.com/videos/`), **Pixabay Videos** (`https://pixabay.com/videos/`), **Coverr** (`https://coverr.co/`), **Mixkit** (`https://mixkit.co/`), or **Wikimedia Commons** (Open Video / CC0 / Public Domain).
>   - **Copyright-Free Images:** Sourced from **Unsplash** (`https://unsplash.com`), **Pexels** (`https://pexels.com`), **Pixabay** (`https://pixabay.com`), or **Wikimedia Commons**.
> - **Automated B-Roll Downloading from the Internet (`scripts/download-broll.py`):**
>   - Download slide-specific B-roll directly using the built-in downloader:
>     ```bash
>     # Download by topic/query for 16:9 landscape:
>     python3 scripts/download-broll.py --query "server cluster data center" --output YYYYMMDD-HHMMSS/assets/broll/slide_1_broll.mp4 --orientation landscape --duration 3.0
>
>     # Download by topic/query for 9:16 vertical shorts/reels:
>     python3 scripts/download-broll.py --query "coding terminal software" --output YYYYMMDD-HHMMSS/assets/broll/slide_2_broll.mp4 --orientation portrait --duration 2.5
>
>     # Download from a direct copyright-free video URL:
>     python3 scripts/download-broll.py --url "https://..." --output YYYYMMDD-HHMMSS/assets/broll/slide_3_broll.mp4 --duration 3.0
>     ```
>   - The downloader automatically queries Pexels API (if `PEXELS_API_KEY` is present), Pixabay API (if `PIXABAY_API_KEY` is present), or Wikimedia Commons (zero API key required), downloads the highest-quality MP4, normalizes it to 1080p, strips any raw audio, trims it to the exact cutaway duration, and appends the source attribution and license to `credits.md`.
> - **Strict License & Asset Integrity Rules:**
>   - **Zero Watermarks:** Strictly reject any footage or image containing watermarks, copyright badges, or stock agency logos.
>   - **100% Commercial-Safe:** Must be verified 100% royalty-free and copyright-free with zero commercial restrictions.
>   - **High Resolution:** Images at minimum 1920×1080 (or 2160×2160 for square/portrait crops); B-roll at 1080p minimum.
>   - **Punchy Pacing:** Trim B-roll into dynamic 1.5s–3.5s cutaway bursts or picture-in-picture demonstration cards; never let generic B-roll linger so long that it dilutes the educational message.
>   - **Asset Organization & Logging:** Store assets in `YYYYMMDD-HHMMSS/assets/images/` and `YYYYMMDD-HHMMSS/assets/broll/` mapped directly to their slide numbers (e.g. `slide_1_img.jpg`, `slide_1_broll.mp4`), and log all asset source URLs and licenses in `credits.md`.

### 9. Proper Captions
- Render captions in a frosted dark translucent pill (`background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(14px); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 22px;`).
- Highlight active operative keywords in vibrant yellow (`#FCD34D`) or cyan (`#38BDF8`).
- Position in the mobile safe zone (bottom 120px–180px) to clear platform UI overlays.

### 10. Clean Final Deliverables Only (Zero Intermediate File Clutter)
> [!IMPORTANT]
> **Automatic Purge of Intermediate & Scratch Files:**
> Once video rendering and post generation are complete, the output folder must contain **ONLY the final generated output files**. All intermediate working files, scratch directories, frame dumps, temporary audio cuts, and raw video fragments created during generation MUST be automatically purged:
> - Delete `assets/review/` (`thumb_*.png`, `contact_sheet.png`, `audio.mp3`)
> - Delete intermediate slide frame folders (`slides_16by9/`, `slides_9by16/`, `tmp/`)
> - Delete per-slide audio cuts (`assets/voiceover_slide_*.mp3`) and temporary render cuts (`visual_rendered.mp4`, `*_tmp.mp4`, `concat*.txt`)
> - Delete intermediate asset staging folders (`assets/images/`, `assets/broll/`, `assets/screenshot-*.png`, `assets/voiceover.mp3`) once fully baked into the final MP4 video outputs
> - The output folder must strictly contain only the final deliverables: the two MP4 videos (16:9 and 9:16), the 6 clean social post files, `cover.svg`, `cover-prompt.md`, `pinterest-motion-design.md`, and `credits.md`.

---

## Input Intake & Source Treatment

Collect or evaluate the provided input:

| Source Type | Intake Action & Analysis |
|---|---|
| **Topic / Keyword** | Research the topic deeply; identify the primary problem, core solution, practical framework, and 3–5 actionable takeaways. |
| **Video File / URL** | Run the **Mandatory Pre-Edit Inspection Pass**: probe duration with `ffprobe`, sample timeline frames into `assets/review/`, extract audio to inspect cadence, and deliver a structured critique report to the user before editing. |
| **YouTube URL** | Download audio/video or extract transcript; inspect timestamps, pacing, and visual milestones; deliver pre-edit critique; extract high-res face-free screenshots for key UI moments. |
| **GitHub Repo URL** | Deeply parse `README.md`, codebase architecture, configuration files, workflows, and terminal commands. Formulate an end-to-end tutorial explaining architecture, setup, code walk, and practical outcome. |

---

## Motion Graphics Architecture & Pinterest Style Integration

High-production videos require continuous visual motion. Static slides or unmoving cards cause viewer disengagement. Every generated video must incorporate rich, multi-layered motion graphics inspired by top-tier motion studios and Pinterest visual designs.

### 1. Mandatory Motion Graphics Density Rule (Zero Static Screen Policy)
> [!IMPORTANT]
> **Zero Static Screen Policy:**
> Under no circumstances may a video display an unmoving, static screen. Every scene/slide MUST have **at least 2 to 3 active motion graphic layers** running simultaneously or in timed sequence:
> - **Layer 1: Ambient Background Motion:** Continuous subtle gradient drift, particle dust, or slow 3D Ken Burns camera push/pan (`scale: 1.0 → 1.04`).
> - **Layer 2: Core Kinetic Visual Component:** Animated system diagrams, self-typing terminal code windows, live-drawing flowcharts, or interactive floating UI cards.
> - **Layer 3: Kinetic Text & Metric Accents:** Word-by-word headline reveals, live number counters ticking up, glowing underline reveals, or self-drawing checkmarks (`✓`).
> - **Layer 4: Persistent Pacing Anchor:** Top continuous gradient progress bar (`0% → 100%`) running across the full video runtime.

---

### 2. The 6 Core Motion Graphics Categories

Every video must actively deploy elements from these six motion graphics systems:

#### A. Kinetic Typography & Title Cards
- **Staggered Word Entrances:** Headers and hook sentences reveal word-by-word with subtle vertical slide and opacity fade (`y: 20 → 0`, `opacity: 0 → 1`, stagger: `0.08s`, easing: `power3.out`).
- **Keyword Highlighter & Glow Reveals:** Critical operative words receive animated highlight strokes (yellow `#FCD34D` or cyan `#38BDF8`) or pulse glow outlines synchronized to voiceover emphasis.
- **Section & Category Badges:** Translucent glassmorphism pill badges (`SLIDE 01 / 07`, `KEY ARCHITECTURE`, `PRO TIP`) animate into the upper corner with a slide-and-bounce entrance (`back.out(1.4)`).

#### B. Animated Architecture & Flow Diagrams
- **Self-Drawing Connection Lines:** Arrows and pipelines between services animate using SVG path tracing (`stroke-dashoffset` from 100% to 0%), visually demonstrating data flow from source to destination.
- **Pulsing Nodes & Laser Data Packets:** Micro-dots or glowing laser pulses travel along connection paths to show real-time message passing and API calls.
- **Layered Service Cards:** Architecture blocks pop in sequentially (`scale: 0.85 → 1.0`, `0.4s` duration) with drop shadows and glowing neon borders.

#### C. Live-Typing Terminal & Code Animations
- **Simulated macOS Terminal Windows:** Realistic dark terminal windows with frosted glass chrome, macOS red/yellow/green control pills, and path headers.
- **Character-by-Character Typewriter Execution:** Shell commands and code snippets type out in real time with a blinking cursor (`_`), followed by simulated execution outputs and loading spinners.
- **Syntax Line Highlighting:** When discussing a specific code block, an animated glowing bracket or background highlight focuses viewer attention on that specific line.

#### D. Dynamic Metric Counters & Data Visualizations
- **Spring Number Tickers:** Numerical stats, benchmarks, and performance gains animate dynamically from zero to target value (e.g., `0% → +350%`, `12ms → 1.4ms`, `0 → 100,000 req/s`) with spring physics.
- **Animated Bar & Progress Visuals:** Comparative benchmark bars sweep smoothly from width `0%` to their final percentage with glowing caps.
- **Circular Progress Rings:** Radial metrics draw themselves clockwise (`0° → 360°`) to highlight completion rates or efficiency scores.

#### E. Floating Glassmorphism & UI Mockups
- **Multi-Layered Translucent Cards:** Information structured in frosted dark glass cards (`backdrop-filter: blur(16px)`, `border: 1px solid rgba(255, 255, 255, 0.18)`).
- **Subtle Idle Floating / Parallax:** Cards maintain gentle, continuous floating motion (`y: -6px to +6px`, `sine.inOut`, loop: infinite) so the visual space never feels dead.
- **Callout Pop-Ins:** Insight badges, warning pills, and tip boxes pop onto screen with a snappy spring (`scale: 0.7 → 1.0`, `back.out(1.5)`).

#### F. Seamless Scene Transitions & Camera Moves
- **Ken Burns Glides:** Every visual scene applies continuous slow camera motion: alternating between slow zoom-in (center push) and diagonal pan-out.
- **Whip Zooms & Directional Slides:** Transitions between topics use dynamic directional glides (`0.5s` cross-dissolve with momentum push).
- **Split-Screen Kinetic Reveals:** Smooth animated split screens pairing code/diagram on the left with relevant B-roll cutaway on the right.

---

### 3. Pinterest Motion Graphics Selection Workflow
Before generating visual assets or scripts:
1. Search and select a cutting-edge motion graphics design style from Pinterest matching the video topic (e.g., kinetic cyber-dark, Swiss neo-brutalism, glowing glassmorphic UI, or minimalist technical lines).
2. Document the reference URL, color palette tokens, typography scales, motion curves, and transition types in `YYYYMMDD-HHMMSS/pinterest-motion-design.md`.
3. Apply this design language consistently across both video aspect ratios (16:9 widescreen and 9:16 vertical).

---

## Screen-Voiceover-Caption Synchronization Engine

To completely prevent the issue where "voiceover is playing for some topic of the slide and the slide has already moved to next one", follow this exact step-by-step pipeline:

```
[Narration Script with Slide Boundaries]
                  │
                  ▼
┌─────────────────────────────────────────────────────────────┐
│ 1. Segmented Scripting & Slide Topic Mapping                │
│    Assign explicit narration chunk to each slide i          │
└─────────────────────────────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────────────┐
│ 2. Discrete Voiceover Generation & Precision Probing        │
│    Generate voiceover_slide_i.mp3 via ElevenLabs API        │
│    Probe exact audio length: dur_audio_i = ffprobe(...)     │
└─────────────────────────────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────────────┐
│ 3. Dynamic Visual Display Duration Calculation              │
│    slide_dur_i = max(dur_audio_i + 0.6s, min_slide_dur)    │
│    Strictly enforce: slide_dur_i >= dur_audio_i             │
└─────────────────────────────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────────────┐
│ 4. Synchronized Captions & Timeline Manifest                │
│    Map caption chunks strictly inside [slide_start, end]    │
│    Generate sync-manifest.json                              │
└─────────────────────────────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────────────┐
│ 5. Automated Pre-Export Verification Pass                   │
│    python3 scripts/verify-slide-sync.py sync-manifest.json   │
│    Aborts export if any slide duration < audio duration     │
└─────────────────────────────────────────────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────────────────────────┐
│ 6. Video Assembly (16:9 & 9:16) with Exact Timed Durations   │
│    Slide i stays visible until voiceover i finishes         │
└─────────────────────────────────────────────────────────────┘
```

### Step 1: Scripting with Explicit Slide Boundaries
Write the narration script partitioned into discrete, numbered video slide scenes:
```text
[SCENE 1: HOOK]
Scene: 1
Visual: Bold hook title + metric badge + neural mesh image
Voiceover: Stop building AI workflows that break on edge cases. Here is the exact system architecture top engineering teams use.

[SCENE 2: PROBLEM CONTEXT]
Scene: 2
Visual: Problem diagram vs brittle pipelines + server rack B-roll cutaway
Voiceover: Most developers make the mistake of chaining raw API calls without state persistence or evaluation gates. When a service fails, the entire pipeline crashes.

...

[SCENE N: SUMMARY & CTA]
Scene: N
Visual: Actionable checklist + @devengoratela handle + architecture diagram
Voiceover: Implement these three guardrails today to build bulletproof automations. Follow Deven Goratela for practical engineering blueprints.
```

### Step 2: Per-Slide Voiceover Generation & Measurement
Generate speech audio per slide or extract precise timestamps:
```python
import os, requests, subprocess

api_key = os.environ.get("ELEVENLABS_API_KEY")
voice_id = "<LATEST_CLONED_VOICE_ID>"

# Generate audio for each slide
for idx, scene in enumerate(scenes, 1):
    audio_path = f"YYYYMMDD-HHMMSS/assets/voiceover_slide_{idx}.mp3"
    response = requests.post(
        f"https://api.elevenlabs.io/v1/text-to-speech/{voice_id}",
        headers={"xi-api-key": api_key, "Content-Type": "application/json"},
        json={
            "text": scene["voiceover"],
            "model_id": "eleven_turbo_v2_5",
            "voice_settings": {"stability": 0.5, "similarity_boost": 0.85, "style": 0.15}
        }
    )
    with open(audio_path, "wb") as f:
        f.write(response.content)

    # Probe precise duration using ffprobe
    cmd = ["ffprobe", "-v", "error", "-show_entries", "format=duration", "-of", "default=noprint_wrappers=1:nokey=1", audio_path]
    scene["audio_duration"] = float(subprocess.check_output(cmd).decode().strip())
```

### Step 3: Dynamic Visual Display Duration Formula
Calculate each slide's visible display time:
$$\text{Slide Duration}_i = \text{Audio Duration}_i + \text{Transition Padding (0.6s)}$$

If a slide has 7.4 seconds of voiceover narration:
$$\text{Slide Duration} = 7.4\text{s} + 0.6\text{s} = 8.0\text{s}$$

**The slide stays on screen for the full 8.0 seconds.** The transition to the next slide only starts at $t = 8.0\text{s}$. The next topic's slide only appears when the next topic's voiceover begins.

### Step 4: Write `sync-manifest.json`
Save the synchronized timeline manifest into the project folder, explicitly associating each slide with its slide-relevant image and B-roll assets:
```json
{
  "project": "topic-slug",
  "slides": [
    {
      "slide_index": 1,
      "title": "Hook & System Architecture",
      "image_file": "assets/images/slide_1_neural_mesh.jpg",
      "broll_file": "assets/broll/slide_1_server_cluster.mp4",
      "broll_cutaway_start": 2.5,
      "broll_cutaway_duration": 2.5,
      "motion_graphics": [
        {"type": "animated_badge", "text": "SYSTEM ARCHITECTURE", "position": "top_left", "animation": "slide_bounce"},
        {"type": "kinetic_typography", "target": "title", "style": "stagger_words", "stagger": 0.08},
        {"type": "data_counter", "label": "Pipeline Reliability", "target": "99.99%", "trigger_offset": 2.0},
        {"type": "animated_diagram", "asset": "gateway_router", "animation": "path_draw_laser"}
      ],
      "audio_file": "assets/voiceover_slide_1.mp3",
      "audio_duration": 5.4,
      "duration": 6.0,
      "transition": 0.6
    },
    {
      "slide_index": 2,
      "title": "The Flawed Approach vs State Machines",
      "image_file": "assets/images/slide_2_broken_pipeline.jpg",
      "broll_file": "assets/broll/slide_2_terminal_debug.mp4",
      "broll_cutaway_start": 3.0,
      "broll_cutaway_duration": 3.0,
      "motion_graphics": [
        {"type": "animated_badge", "text": "EXECUTION PITFALL", "position": "top_left", "animation": "slide_bounce"},
        {"type": "terminal_code_typing", "command": "curl -X POST https://api.prod/stream", "trigger_offset": 0.5},
        {"type": "highlight_line", "target": "error_catch_block", "trigger_offset": 3.2},
        {"type": "callout_card", "text": "Zero Retries = 40% Dropoff", "animation": "pop_in_spring", "trigger_offset": 4.5}
      ],
      "audio_file": "assets/voiceover_slide_2.mp3",
      "audio_duration": 8.2,
      "duration": 8.8,
      "transition": 0.6
    }
  ],
  "captions": [
    {
      "slide_index": 1,
      "start": 0.2,
      "end": 2.6,
      "text": "Stop building AI workflows that break on edge cases."
    },
    {
      "slide_index": 1,
      "start": 2.7,
      "end": 5.3,
      "text": "Here is the exact system architecture top engineering teams use."
    }
  ]
}
```

### Step 5: Automated Pre-Export Sync Verification Pass
Run the sync verification script before rendering video:
```bash
python3 scripts/verify-slide-sync.py YYYYMMDD-HHMMSS/sync-manifest.json
```
If any slide display duration is less than its voiceover audio duration, the script fails immediately and prints the exact seconds of audio leakage. Fix timeline durations until the script exits with code 0.

---

## Video Specifications: 16:9 Landscape & 9:16 Vertical

The skill generates **two broadcast-quality video deliverables**, both rendered at 1080p, MP4, H.264, 30 fps:

| Specification | 16:9 Landscape Video | 9:16 Vertical Video (Reels / Shorts) |
|---|---|---|
| **Primary Platform** | YouTube Main Channel | YouTube Shorts, Instagram Reels, TikTok |
| **Output Path** | `YYYYMMDD-HHMMSS/{slug}-16by9.mp4` | `YYYYMMDD-HHMMSS/{slug}-9by16.mp4` |
| **Canvas Dimensions** | 1920 × 1080 px (16:9) | 1080 × 1920 px (9:16) |
| **Target Runtime** | 3 to 6 minutes | 1 to 3 minutes |
| **Visual Structure** | Wide hero graphics, code split-screens, architecture diagrams, and slide-relevant visuals | Portrait cards, kinetic callouts, bold stat pop-ins, and slide-relevant visuals |
| **Slide-Relevant Images** | High-res copyright-free images (Unsplash/Pexels) strictly matching the concept of that slide | Mobile-framed copyright-free images strictly matching the concept of that slide |
| **Slide-Relevant B-Roll** | 1.5–3.5s punchy cutaways from Pexels/Coverr/Mixkit illustrating the active spoken point | Rapid vertical B-roll cutaways directly illustrating the active spoken point |
| **Motion Graphics (Continuous)** | 4-layer active motion: continuous top gradient progress bar, kinetic staggered typography, self-drawing architecture diagrams with pulsing laser lines, live-typing terminal windows with blinking cursor, spring data counters (`0 → +350%`), floating glassmorphic cards, and Ken Burns camera glides | 4-layer active motion: top progress bar, animated slide counter badges (`01 / 07`), kinetic pop-in stat cards, vertical code reveal typing, rapid metric counters, and dynamic split-screen transitions |
| **Captions** | Lower-third frosted pill, centered, active keyword yellow highlight (`#FCD34D`) | Safe-zone positioned (bottom 160px), frosted glass pill, active keyword highlight |
| **Audio Mix** | ElevenLabs voiceover at volume 1.0 (-16 LUFS), background music looped at volume 0.10 | ElevenLabs voiceover at volume 1.0 (-16 LUFS), background music looped at volume 0.10 |

### Video Audio Mixing Command (FFmpeg)
```bash
ffmpeg -y \
  -i visual_rendered.mp4 \
  -i assets/voiceover.mp3 \
  -stream_loop -1 -i scripts/youtube-shorts-bt-music.mp3 \
  -filter_complex "[1:a]volume=1.0[voice];[2:a]volume=0.10,afade=in:st=0:d=1[bg];[voice][bg]amix=inputs=2:duration=first:dropout_transition=2[aout]" \
  -map 0:v -map "[aout]" \
  -c:v copy -c:a aac -b:a 192k -ar 48000 -ac 2 \
  -shortest -movflags +faststart \
  output_video.mp4
```

---

## Multi-Channel Content Deliverables (All Channels Roster)

Generate the complete suite of deliverables for all channels directly into the date-wise folder `YYYYMMDD-HHMMSS/`:

| Channel / Deliverable | Output File | Rules & Style Highlights (Zero Markdown Syntax) |
|---|---|---|
| **YouTube 16:9 Video** | `{slug}-16by9.mp4` | 1920×1080 widescreen, 3–6 mins, fully synchronized visuals, voiceover, and captions. |
| **YouTube 9:16 Shorts** | `{slug}-9by16.mp4` | 1080×1920 vertical, 1–3 mins, high-energy mobile cut, fully synchronized. |
| **YouTube Metadata** | `youtube.md` | 3 clickable titles (<60 chars), SEO description with hook, video timestamps, links, tags. Clean text. |
| **LinkedIn Post** | `linkedin-post.md` | Mobile hook (<8 words), re-hook, 1–2 sentence paragraphs, emojis, soft CTA, ♻️ Repost, ➕ Follow Deven Goratela, 3–5 hashtags. Clean text. |
| **Cover Image & Prompt**| `cover.svg` & `cover-prompt.md` | 1200×627 SVG (1.91:1) with central 1000×500 safe zone, hero insight text, `@devengoratela` branding + AI prompt. |
| **Skool Community** | `skool-post.md` | 30–40% shorter than LinkedIn, casual peer tone, tool/tip focus, zero hashtags, bold closing question. Clean text. |
| **Instagram Post** | `instagram-post.md` | Visual hook (<10 words), curiosity hook extension, spaced paragraphs, emoji bullets, save/share CTA, 10–15 hashtags at bottom. Clean text. |
| **Twitter / X** | `twitter-post.md` | Standalone tweet (<280 chars) PLUS full numbered thread (`1/` to `N/`), summary, follow + retweet CTA. Clean text. |
| **Facebook Post** | `facebook-post.md` | Conversational, storytelling, short paragraphs, emoji anchors, discussion question, 0–2 hashtags. Clean text. |
| **Pinterest Motion Style**| `pinterest-motion-design.md` | Reference URL, motion design breakdown, color palette, and transition specs. |
| **Credits & Attribution**| `credits.md` | Image & B-roll sources, background music license, ElevenLabs voice profile. |

---

## Detailed Templates & Channel Specifications

### 1. YouTube Metadata Package (`youtube.md`)
**Role:** YouTube SEO & Audience Growth Specialist.
**Format Rule:** 100% clean copy-paste text. No markdown bolding (`**`), no heading hashes (`#`).

```text
TITLE OPTIONS
1. [Curiosity Title under 60 chars]
2. [How-To / Search Title under 60 chars]
3. [Contrarian / High-Impact Title under 60 chars]


VIDEO DESCRIPTION
[Hook and 2-sentence summary of the video topic — visible above the fold before clicking "...more"]

In this video, we break down [core topic] and how you can implement it step by step.

WHAT YOU WILL LEARN:
• [Key learning 1]
• [Key learning 2]
• [Key learning 3]

TIMESTAMPS:
00:00 - Introduction
00:45 - [The Problem / Core Challenge]
02:15 - [Architecture & Step-by-Step Setup]
04:30 - [Real-World Demonstration / Code]
06:15 - [Common Mistakes to Avoid]
07:40 - [Summary & Next Steps]

RESOURCES & LINKS:
• Practical AI Community: [Skool Community Link]
• GitHub Repository: [Link or placeholder]
• Connect on LinkedIn: https://www.linkedin.com/in/devengoratela/

ABOUT DEVEN GORATELA:
Sharing practical AI workflows, automation architectures, and agentic engineering patterns that save real hours.

Subscribe for new AI tutorials and automation blueprints every week.


TAGS
[tag 1], [tag 2], [tag 3], [tag 4], [tag 5], [tag 6], [tag 7], [tag 8], [tag 9], [tag 10], [tag 11], [tag 12], [tag 13], [tag 14], [tag 15]
```

---

### 2. LinkedIn Post (`linkedin-post.md`)
**Role:** Senior LinkedIn Content Strategist.
**Rules:** Line 1 hook <8 words. Line 2 re-hook. Short 1–2 sentence paragraphs. Emojis at sentence ends where natural. Soft CTA question. Mandatory ♻️ Repost and ➕ Follow lines. 3–5 hashtags.
**Format Rule:** 100% clean text. ZERO markdown syntax (`**`, `#`, `---`, `[link](url)`).

```text
[Post Title with relevant emoji]

[Hook line 1 — under 8 words]
[Re-hook line 2 — punchy sentence earning the expand click]

[Body paragraph 1 — 1 to 2 sentences with emoji]

[Body paragraph 2 — 1 to 2 sentences with emoji]

[Key takeaways using emoji bullets]
• [Point 1]
• [Point 2]
• [Point 3]

[Soft CTA — engaging question or invitation]

♻️ [Repost line explaining why reader's network benefits from seeing this]
➕ Follow Deven Goratela (https://www.linkedin.com/in/devengoratela/) for practical AI workflows and automation systems.

#[Tag1] #[Tag2] #[Tag3] #[Tag4]
```

---

### 3. Cover Image & Prompt (`cover.svg` & `cover-prompt.md`)
**Role:** Senior Visual Designer.
- **Dimensions:** 1200 × 627 px (1.91:1 widescreen).
- **Safe Zone:** Central 1000 × 500 px.
- **Hero Text:** Core insight in 6–12 words.
- **Branding:** Subtle `@devengoratela` handle in bottom-left or corner. No author photo.
- **Verification:** Must parse cleanly with Python XML parser.
- **`cover-prompt.md`:** Detailed image generation prompt for Midjourney / DALL-E / Flux with composition, style, lighting, color palette, and negative prompt.

---

### 4. Skool Community Post (`skool-post.md`)
**Role:** Practical AI Community Peer.
**Rules:** Casual peer-to-peer tone ("here's what worked for me"). 30–40% shorter than LinkedIn. Tool/tip leads. Zero hashtags. Ends with one strong, open-ended question.
**Format Rule:** 100% clean text. No markdown syntax.

```text
[Curiosity-driven hook line]

[Body paragraph 1 — casual peer explanation of what happened or what was built]

[Practical breakdown / what worked]
• [Step or insight 1]
• [Step or insight 2]
• [Step or insight 3]

[One strong open-ended question to spark community discussion]
```

---

### 5. Instagram Post / Reel Caption (`instagram-post.md`)
**Role:** Visual Platform Content Specialist.
**Rules:** Hook <10 words. Hook extension. Spaced paragraphs. Bullet points with clean visual icons (`👉`, `⚡`). Save & Share CTA. 10–15 hashtags at bottom after spaced dot breaks.
**Format Rule:** 100% clean text. No markdown syntax.

```text
[Hook line 1 — under 10 words]
[Hook line 2 — curiosity-driven]

[Body context — 1 to 2 lines]

[Key insights or steps]
👉 [Point 1]
👉 [Point 2]
👉 [Point 3]

[Actionable takeaway or conclusion]

Save this post so you can reference it later 📌
Follow @devengoratela for practical AI workflows that actually save hours.

.
.
.

#[tag1] #[tag2] #[tag3] #[tag4] #[tag5] #[tag6] #[tag7] #[tag8] #[tag9] #[tag10] #[tag11] #[tag12]
```

---

### 6. Twitter / X Post (`twitter-post.md`)
**Role:** High-Signal Tech Writer.
**Rules:** Dual format containing both a standalone tweet (<280 chars) AND a full numbered thread (`1/` to `N/`). One insight per tweet. Summary tweet with follow `@devengoratela` + retweet CTA.
**Format Rule:** 100% clean text. No markdown syntax.

```text
SINGLE TWEET VARIANT
--------------------
[Punchy standalone tweet under 280 characters including hook, core insight, and quick takeaway]


FULL THREAD VARIANT
-------------------
1/ [Hook tweet — sharp claim, problem, or proof that compels reader to click the thread]

2/ [Core context or the big mistake most people make]

3/ [Actionable step 1 or key insight]

4/ [Actionable step 2 or key insight]

5/ [Actionable step 3 or pro-tip]

6/ SUMMARY:
• [Takeaway 1]
• [Takeaway 2]
• [Takeaway 3]

If you found this useful:
1. Follow @devengoratela for practical AI and automation systems
2. Repost the first tweet to share with your network
```

---

### 7. Facebook Post (`facebook-post.md`)
**Role:** Social Community Strategist.
**Rules:** Conversational, relatable, storytelling/educational tone. Short paragraphs with natural whitespace. Bullet points using clean emoji anchors (`•`, `👉`, `🔹`). Low-friction discussion question. 0–2 hashtags maximum.
**Format Rule:** 100% clean text. No markdown syntax.

```text
[Conversational hook line — relatable problem or interesting observation]

[Context paragraph — 1 to 2 sentences explaining what happened or what was tested]

[Core insights or practical takeaways]
• [Key takeaway 1]
• [Key takeaway 2]
• [Key takeaway 3]

[Short wrap-up or practical advice]

[Friendly discussion question to spark comments]

Drop your thoughts below 👇
```

---

## Output Folder Structure

After the automated cleanup pass, the output folder strictly contains **ONLY the final generated deliverables**:

```
YYYYMMDD-HHMMSS/
├── {topic-slug}-16by9.mp4          ← Final 16:9 widescreen YouTube video (1080p, 3-6 mins, synced)
├── {topic-slug}-9by16.mp4          ← Final 9:16 vertical video (YouTube Shorts / Reels, 1080p, 1-3 mins, synced)
├── youtube.md                      ← YouTube metadata: 3 titles, SEO description, timestamps, tags
├── linkedin-post.md                ← Clean copy-paste LinkedIn post (zero markdown)
├── skool-post.md                   ← Clean copy-paste Skool community post (zero markdown)
├── instagram-post.md               ← Clean copy-paste Instagram caption & hashtags (zero markdown)
├── twitter-post.md                 ← Standalone tweet + numbered thread (zero markdown)
├── facebook-post.md                ← Clean copy-paste Facebook post (zero markdown)
├── cover.svg                       ← 1200×627 SVG cover image (1.91:1)
├── cover-prompt.md                 ← AI image prompt for Midjourney / DALL-E / Flux
├── pinterest-motion-design.md      ← Selected Pinterest motion graphics design URL & styling
└── credits.md                      ← Free copyright-free images & B-roll sources and license log
```

> [!NOTE]
> All intermediate scratch files and working directories (such as `assets/review/`, `assets/broll/`, `assets/images/`, `slides_16by9/`, `slides_9by16/`, `tmp/`, per-slide voiceover segments, and temporary render cuts) are automatically removed upon completion so the folder strictly holds the final generated deliverables.

---

## Step-by-Step Execution Sequence

When triggered, execute all stages sequentially without pausing for unnecessary permission prompts:

1. **Intake & Source Evaluation:**
   - Evaluate topic, video URL, YouTube URL, or GitHub repo.
   - If video input: run pre-edit inspection pass (`ffprobe`, contact sheets, audio check) and output an upfront critique before editing.
   - Compute timestamp folder `YYYYMMDD-HHMMSS/`.
2. **Pinterest Motion Graphics Selection & Design Specification:**
   - Select matching cutting-edge motion design aesthetic from Pinterest and document in `pinterest-motion-design.md`.
   - Define the 4-layer motion graphics plan (ambient background drift, kinetic core visuals, text/counter accents, top progress bar).
3. **Scripting with Slide-Topic & Motion Graphics Boundaries:**
   - Write structured narration chunks mapped 1:1 to visual slides/scenes.
   - Explicitly assign motion graphic triggers (kinetic typography, terminal typewriter, animated diagram flow, metric counters) to each scene.
4. **Download Slide-Relevant Copyright-Free Images & B-Roll from the Internet:**
   - For each slide, search and download high-resolution copyright-free images (Unsplash/Pexels/Pixabay) and B-roll video clips from the internet (Pexels, Pixabay, Coverr, Mixkit, Wikimedia Commons) directly matching that slide's specific topic.
   - Run `python3 scripts/download-broll.py --query "<slide topic>" --output YYYYMMDD-HHMMSS/assets/broll/slide_{i}_broll.mp4 --orientation <landscape|portrait> --duration 3.0` (or download from direct copyright-free video URLs).
   - Ensure all B-roll clips are normalized (1080p, H.264, audio-stripped, trimmed to 1.5s–3.5s).
   - Verify zero watermarks and zero commercial restrictions. Save into `assets/images/` and `assets/broll/` mapped to slide numbers, and log all asset source URLs and licenses in `credits.md`.
5. **Voiceover Generation & Precision Probing:**
   - Generate audio via ElevenLabs cloned voice for each slide segment.
   - Probe exact audio durations using `ffprobe`.
6. **Timeline Calculation & Synchronization Manifest:**
   - Calculate slide display durations: $\text{Slide Duration} = \text{Audio Duration} + 0.6\text{s}$.
   - Ensure every slide stays on screen for the full duration of its voiceover.
   - Map image files, B-roll cutaway windows, motion graphic triggers, and captions into `sync-manifest.json` and `captions.json`.
7. **Pre-Export Sync Verification Pass:**
   - Run `python3 scripts/verify-slide-sync.py YYYYMMDD-HHMMSS/sync-manifest.json`.
   - Abort and adjust if any slide transitions before voiceover completes.
8. **Render Videos (16:9 & 9:16) with Continuous High-Density Motion Graphics:**
   - Render 16:9 widescreen video (`{slug}-16by9.mp4`) and 9:16 vertical video (`{slug}-9by16.mp4`) integrating all 4 motion graphics layers (continuous top gradient progress bar, self-drawing architecture lines, live-typing terminal windows, spring metric counters, floating glassmorphic cards, and Ken Burns camera glides), paired with slide-relevant B-roll cutaways and ducked background music (10% volume).
9. **Generate All Native Social Posts (Zero Markdown):**
   - Write `youtube.md`, `linkedin-post.md`, `skool-post.md`, `instagram-post.md`, `twitter-post.md`, `facebook-post.md`, `cover.svg`, and `cover-prompt.md`.
10. **Automatic Intermediate File Cleanup:**
    - Purge all scratch directories, temporary render files, frame dumps, and intermediate audio/video cuts:
      ```bash
      rm -rf YYYYMMDD-HHMMSS/assets \
             YYYYMMDD-HHMMSS/slides_* \
             YYYYMMDD-HHMMSS/tmp* \
             YYYYMMDD-HHMMSS/*_tmp.mp4 \
             YYYYMMDD-HHMMSS/visual_rendered.mp4 \
             YYYYMMDD-HHMMSS/sync-manifest.json \
             YYYYMMDD-HHMMSS/captions.json \
             YYYYMMDD-HHMMSS/concat*.txt
      ```
11. **Final Verification & Reporting:**
    - Verify that only the final generated output files exist in `YYYYMMDD-HHMMSS/`.
    - Present a clean completion summary table to the user.

---

## Quality Control Checklist

Before completing execution, verify:

**Synchronization & Video Production (Mandatory):**
- [ ] Visible screen is 100% in sync with voiceover and captions throughout both videos
- [ ] No slide transitions to the next topic while voiceover is still speaking for the current topic
- [ ] `verify-slide-sync.py` exits with code 0 (all slide durations $\ge$ audio durations) ✅
- [ ] Both 16:9 (3–6 mins) and 9:16 (1–3 mins) MP4 videos generated at 1080p
- [ ] User's latest cloned ElevenLabs voice used for voiceover narration (-16 LUFS)
- [ ] Background music strictly ducked to low volume (10% / `volume=0.10`), voice crisp and audible
- [ ] High-contrast captions rendered in frosted translucent pill with active keyword highlighting
- [ ] Every slide has copyright-free images and B-roll strictly relevant to the content of that slide
- [ ] Images and B-roll verified 100% watermark-free from Unsplash, Pexels, Pixabay, Mixkit, or Coverr
- [ ] Sources logged in `credits.md`

**Motion Graphics Density (Zero Static Screen Policy - Mandatory):**
- [ ] Every scene incorporates at least 2 to 3 active motion graphic layers running simultaneously (no static screens)
- [ ] Top continuous animated gradient progress bar spans full video runtime
- [ ] Kinetic typography reveals (staggered words, active keyword highlights) synchronized with narration
- [ ] Dynamic visual components active: animated architecture paths, live-typing terminal windows, spring data counters, or floating UI cards
- [ ] Continuous ambient motion (subtle Ken Burns camera glide / background drift) active across every scene

**Pre-Edit Review (If Input is Video):**
- [ ] Full video inspected end-to-end with contact sheets and transcript before editing
- [ ] Critique report covering hook, pacing, dead air, visual fatigue, and improvement plan delivered

**Visuals & Background Styling:**
- [ ] Screenshots strictly face-free (focused on UI, code, terminal, architecture)
- [ ] Every slide/scene has a different background color/gradient within a harmonious palette

**Cross-Platform Social Formatting (Mandatory):**
- [ ] ZERO raw markdown syntax (`**bold**`, `*italic*`, `###`, `---`, `[link](url)`) in social post files
- [ ] NO outer code block fences (` ```markdown `) wrapping any output file
- [ ] All channel deliverables generated into `YYYYMMDD-HHMMSS/`

**Folder Cleanliness & Intermediate Cleanup (Mandatory):**
- [ ] All intermediate files and scratch working directories (`assets/`, `slides_*`, `tmp*`, raw video fragments) purged
- [ ] Output folder contains ONLY the final generated deliverables (videos, social posts, cover files, design spec, and credits.md)
