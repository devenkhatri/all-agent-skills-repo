---
name: youtube-video-generator
description: Generate complete, multi-platform YouTube and social media content packages from a topic, video, YouTube URL, or GitHub repo. Produces synchronized 16:9 and 9:16 videos (with code-drawn motion graphics engine f(t), procedural Web Audio SFX sound kit, camera kicks, film grain, ElevenLabs cloned voice, low-volume background music, 100% code-drawn procedural proof shots and mockups, and proper captions), plus an interactive HTML player artifact (player.html) for browser scrubbing and review, alongside native content for all channels (LinkedIn, Instagram, Twitter/X, Skool, Facebook, and Cover image) with clean, copy-ready formats and strict platform guardrails.
---

# YouTube Video Generator & Multi-Platform Content Suite

Generate complete, broadcast-quality YouTube videos (16:9 widescreen and 9:16 vertical shorts/reels) with **absolute synchronization between visible screen visuals, voiceover narration, and captions**, powered by a **code-drawn HTML5 Canvas motion graphics engine**, a **procedural Web Audio SFX synthesizer kit**, **100% code-drawn procedural proof shots & UI mockups (zero external stock footage or B-roll downloads)**, and an **interactive HTML player artifact (`player.html`) with transport controls and scrub bar**, alongside a full multi-channel distribution package across all social platforms (LinkedIn, Instagram, Twitter/X, Skool, Facebook, and Cover Images).

This skill enforces professional video production standards, agency-grade motion graphics, strict zero-desync timing, and copy-paste-ready social post formats tailored natively to each platform.

---

## Core Guarantees & Golden Rules

### 1. Absolute Audio-Visual-Caption Synchronization (Zero Desync Guarantee)
> [!IMPORTANT]
> **Visible Screen Must Be in Exact Sync with Voiceover and Captions:**
> It must **NEVER** happen that the voiceover is playing for a topic and the slide has already moved to the next one.
>
> - Every visual slide, diagram, UI screenshot, or code-drawn proof mockup MUST stay active on screen for the **entire duration** that its voiceover narration is speaking.
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
- Deliver an upfront critique covering: hook strength (first 3–5 seconds), pacing and dead air, talking-head visual fatigue, motion graphics opportunities, caption styling needs, and recommended procedural proof moments before generating slides or edits.

### 5. Face-Free Visuals & Screenshots Rule
When extracting visual milestones or screenshots from source videos or GitHub repos:
- Strictly focus on **software UI, terminal workflows, code snippets, architecture diagrams, and system outputs**.
- Strictly avoid or crop out talking heads, presenter webcams, or picture-in-picture (PiP) bubbles. Viewers watch to absorb the tool and workflow, not the presenter's face.

### 6. Unique Background Color for Every Video Scene / Slide
- Every slide or scene in the video sequence MUST have a **unique background color or gradient** within a harmonious palette progression (e.g., deep midnight navy → dark slate → abyssal blue → deep charcoal → cyber teal). Never use identical backgrounds on consecutive slides or across all slides.
- Text and visual elements must maintain a high contrast ratio ($\ge 4.5:1$) against each slide's specific background.

### 7. Audio Architecture: Cloned Voiceover, Ducked Music & Procedural Web Audio SFX Kit
- **ElevenLabs Cloned Voiceover:** Synthesize narration using the user's latest cloned voice from ElevenLabs, normalized to -16 LUFS (punchy, crisp, prominent).
- **Background Music Ducking:** Background music (`youtube-shorts-bt-music.mp3`) must strictly be ducked down to **low volume** (10% volume / `volume=0.10`, approx -20dB to -24dB relative to speech). The voiceover must remain 100% intelligible and prominent throughout.
- **Procedural Web Audio SFX Kit (Zero-Asset Sound Scoring):** Every visual motion milestone on the timeline triggers synchronized synthesized sound effects from the built-in `SFX` kit:
  - **Headlines & Text Slams:** `slam` (tight sub-bass thump with a short papery crack)
  - **Cards, Chips, Pills & Badges:** `pop` (frequency-swept sine wave, 500Hz–1200Hz)
  - **Rolling Data Tickers & Benchmarks:** `tick` (high-frequency bandpass click, max 12/s)
  - **Scene Cuts & Whip Pans:** `whoosh` (pink noise bandpass sweep with stereo panning) or `glitch` (square-wave cluster burst)
  - **Highlighter Wipes:** `marker` (grainy felt-tip drag)
  - **Mistakes & Wrong Ideas:** `strike` (bandpass slice) + `tapeStop` (sawtooth pitch deceleration) or `stamp`
  - **Live Terminal & Code Typing:** `keys` (subtle mechanical keyboard click chatter)
  - **Milestone & Number Locks:** `boom` (sub-bass drop with brown noise tail) + `shimmer` / `sparkle` (harmonic chime overtone)
- **Unified Sync Muxing:** The visual timeline `TL` and sound score `scoreSound(k)` read the exact same event timestamps. Render SFX audio via `SFX.render(scoreSound, DURATION, 48000, { voiceover: true })` and mux with the ElevenLabs narration and ducked background music into the final video.

### 8. 100% Code-Drawn Procedural Proof Shots & UI Mockups (Patil's Engine - Zero Stock Footage)
> [!IMPORTANT]
> **Patil's Zero-Stock-Footage Rule for Real-World Proof:**
> Real-world context, technical evidence, and software demonstrations are **NEVER external stock video clips downloaded from the internet**.
> 
> Stock footage causes severe visual style clash, licensing ambiguity, watermark risks, and generic filler that detracts from technical authority. Instead, all proof shots, device screens, and workflow demonstrations are **100% code-drawn procedural mockups on Canvas**:
> 
> - **3D Perspective Browser Windows (`drawYaw` / `drawBrowserProof`):**
>   - Realistic macOS-style dark/light browser windows with window controls (traffic light dots), address bar with lock icon, tab strips, and live-rendered web pages.
>   - Tilted in 3D perspective space with horizontal yaw rotation ($\pm 10^\circ \text{ to } 18^\circ$), perspective depth scaling, soft ambient drop shadow (`shadowBlur: 48px`), and gentle floating idle motion.
> - **Smartphone Chat Threads (`scenePhone` / mobile proof):**
>   - Stylized mobile device chassis with conversational bubble threads (incoming gray/blue bubble, outgoing green/white bubble).
>   - Animated 3-dot typing indicators bouncing in sync (`Math.sin(t * 8)`), message delivery checkmarks, avatar badges, and hand-drawn focus circles (`scribble`) circling the key reply.
> - **macOS Developer Terminal Windows (`drawTerminalProof`):**
>   - Dark slate terminal frame (`#0F172A`) with top traffic lights, monospace typography (JetBrains Mono), command prompt `$` with live character typewriter pacing, stdout logs streaming below, success badges (`OK 200`), and blinking rectangular cursors.
> - **Interactive Dashboards & Rolling Counters (`drawMath` / benchmark proofs):**
>   - Live-updating line charts, latency distribution bars, spring-interpolated rolling numbers locking on the beat with sub-bass drops (`boom`), and green pill percentage metrics (`+380%`).
> - **System Architecture Pipelines & Circuit Laser Pulses:**
>   - Self-drawing Bézier pipelines with laser pulses traversing microservice nodes, API gateways, queue buffers, and state machine graphs.
> - **Stamp Overlays & Red Strikes:**
>   - For debunking flawed approaches or legacy patterns: big red angled rubber stamp (`STAMP`) slamming down with scale overshoot (e.g., `"BRITTLE"` or `"SLOW"`), accompanied by rough red textured strike lines (`strike`) crossing out legacy code blocks.
> - **Integrity & Generics:**
>   - All mockups use invented, generic names, domain handles, and illustrative numbers. Label figures as examples when illustrative. Zero real personal credentials, real receipts, or private data.

### 9. Interactive HTML5 Player Artifact (`player.html` - Patil's Player System)
> [!TIP]
> **Self-Contained Browser Player Artifact:**
> Alongside the final MP4 video exports, the skill generates a single-file, self-contained **interactive HTML5 Canvas & Web Audio player** saved into `YYYYMMDD-HHMMSS/player.html`.
>
> - **Zero Dependencies:** Runs locally in Chrome, Safari, Edge, or Firefox by opening the file directly (no local web server or Node build step required).
> - **Dark Editing-Suite Layout:**
>   - Stage container automatically maintaining 16:9 Landscape or 9:16 Portrait aspect ratios with high-DPI retina canvas scaling.
>   - Full transport control bar directly beneath the stage.
> - **Interactive Controls & Keyboard Shortcuts:**
>   - **Play / Pause Button:** Toggle playback with spacebar or click.
>   - **Scrub Slider Bar:** Smooth drag-and-scrub with instantaneous canvas frame updates via `window.seek(t)`.
>   - **Real-Time Timecode:** Formatted elapsed and total runtime readout (`MM:SS / MM:SS`).
>   - **Dual-Orientation Switcher:** One-click toggle switching between `16:9 Landscape` and `9:16 Portrait` layouts in real time.
>   - **Sound Toggle:** Toggle synthesized procedural SFX (`🔊 SFX ON` / `🔇 SFX MUTED`).
>   - **Loop Toggle:** Switch between continuous loop and single play (`🔁 LOOP ON` / `➡️ ONCE`).
> - **Exposed Developer APIs:** Exposes `window.seek(t)`, `window.DURATION`, `window.scoreSound(k)`, and `window.SFX` for automated headless video rendering and QA verification.

### 10. Proper Captions
- Render captions in a frosted dark translucent pill (`background: rgba(15, 23, 42, 0.85); backdrop-filter: blur(14px); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 22px;`).
- Highlight active operative keywords in vibrant yellow (`#FCD34D`) or cyan (`#38BDF8`).
- Position in the mobile safe zone (bottom 120px–180px) to clear platform UI overlays.

### 11. Clean Final Deliverables Only (Zero Intermediate File Clutter)
> [!IMPORTANT]
> **Automatic Purge of Intermediate & Scratch Files:**
> Once video rendering and post generation are complete, the output folder must contain **ONLY the final generated output files**. All intermediate working files, scratch directories, frame dumps, temporary audio cuts, and raw video fragments created during generation MUST be automatically purged:
> - Delete `assets/review/` (`thumb_*.png`, `contact_sheet.png`, `audio.mp3`)
> - Delete intermediate slide frame folders (`slides_16by9/`, `slides_9by16/`, `tmp/`)
> - Delete per-slide audio cuts (`assets/voiceover_slide_*.mp3`) and temporary render cuts (`visual_rendered.mp4`, `*_tmp.mp4`, `concat*.txt`)
> - Delete intermediate asset staging folders (`assets/images/`, `assets/screenshot-*.png`, `assets/voiceover.mp3`, `assets/sfx.wav`) once fully baked into the final MP4 video outputs
> - The output folder must strictly contain only the final deliverables: the two MP4 videos (16:9 and 9:16), `player.html`, the 6 clean social post files, `cover.svg`, `cover-prompt.md`, `pinterest-motion-design.md`, and `credits.md`.
> - **Permanent Skill Fixtures:** Never delete or purge `pinterest-references/` or `scripts/` — these are persistent local skill assets, not scratch output files.

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

## Code-Drawn Motion Graphics Engine & Reference Library Integration

High-production videos require continuous visual motion. Static slides, frozen images, or unmoving cards cause immediate viewer drop-off. Every generated video is powered by a **code-drawn HTML5 Canvas animation engine** where every frame is a pure mathematical function of time $f(t)$, combined with a **procedural Web Audio SFX kit**, **mathematical camera physics**, **cinematic finishing shaders**, and **style parameters extracted from local reference videos in `pinterest-references/`**.

> [!IMPORTANT]
> **Use Local Reference Videos (`pinterest-references/`) — Do NOT Search Pinterest Online:**
> The skill provides a dedicated local reference repository containing 26 downloaded high-production Pinterest motion graphic videos in `pinterest-references/`.
> **Never search or browse Pinterest on the web.** Always inspect and select reference video(s) directly from `pinterest-references/` using the 7-Point Style Card framework.

---

### 1. The Code-Drawn Animation Framework (Pure $f(t)$ Engine)

Animations are drawn programmatically on HTML5 Canvas using deterministic time calculation:
- **Pure Function of Time:** Every frame is rendered as `drawFrame(ctx, t)` where `t` is the exact timeline timestamp in seconds. Randomness is strictly seeded (`CM.rng(seed)`, `CM.noise1(seed)`); never use `Math.random()`.
- **Core Math & Easing Helpers (`CM`):**
  - `clamp(v, a, b)`, `lerp(a, b, u)`, `span(t, a, b)`
  - `rng(seed)`: xoshiro128** seeded PRNG with `.in(lo, hi)` and `.pick(arr)`
  - `noise1(seed)`: Smooth 1D gradient value noise function
  - `ez`: Easing library: `out3` (cubic out), `in3` (cubic in), `inout3`, `outExpo` (exponential settle), `back(u, s)` (overshoot pop), `spring(u)` (physics dampening)
  - `layer(w, h)`: Creates offscreen scratch canvas buffers

---

### 2. Procedural 2D Drawing Primitives

The engine deploys signature procedural drawing primitives to eliminate static slides:

#### A. Kinetic Word Slams (`slam`)
- Words land one at a time on precise narration beats.
- Scale drops from $1.45\times \to 1.0\times$ with `ez.outExpo` easing, combined with dynamic canvas motion blur (`filter = blur(Xpx)`) that snaps sharp upon landing.
- Operative keywords receive a radiant glow (`shadowColor`, `shadowBlur: 35`).

#### B. Dynamic Highlighter Swipes (`swipe` & `slamMarked`)
- Procedural organic highlighter strokes sweep smoothly behind key emphasis words.
- Uses `Path2D` with subtle edge jitter (`rng`) to simulate real marker strokes.
- Inside the highlight path, text dynamically clips and renders in contrast dark ink (`slamMarked`).

#### C. Rough Strike-Throughs & Rejection Stamps (`strike` & `stampLayer`)
- Negative concepts, common misconceptions, or flawed architectures receive a rough angled red strike line (`col = #F87171`, `lineWidth = 14`, `tilt = -0.02`).
- Flat rejections receive an ink-stamped `NO.` badge with procedural erosion specks.

#### D. Organic Hand-Drawn Loops & Arrows (`scribble` & `handArrow`)
- Important diagram nodes or callouts are circled using procedural multi-turn organic loops (`scribble`) modulated by 1D value noise (`noise1`).
- Directional relationships and flows are indicated by quadratic Bézier hand-drawn arrows (`handArrow`) that trace themselves smoothly before popping an angled arrowhead.

#### E. 3D Perspective Tilt Projection (`drawYaw`)
- Flat 2D layers (browser mockups, code windows, architecture diagrams, chat screens) are rotated in 3D perspective along their vertical Y-axis.
- Rendered on 2D canvas using vertical slice projection with distance scaling ($f / (f + Z)$), soft blurred ambient drop shadows, and diagonal glass reflection gradients.

#### F. Live-Typing Terminal & Code Execution
- Dark macOS-style terminal windows with frosted glass chrome and traffic-light control pills (`#FF5F57`, `#FEBC2E`, `#28C840`).
- Shell commands and code snippets type out in real time with a blinking cursor (`_`), followed by simulated execution outputs and loading spinners.

#### G. Dynamic Metric Counters & Progress Rings
- Numerical metrics and benchmark percentages sweep smoothly from initial value to target with `ez.out3` or spring physics.
- High-contrast green glow (`#34D399`) with trailing spark streaks when the number locks.

---

### 3. Dual-Orientation Canvas Architecture (16:9 Landscape & 9:16 Portrait)

The engine natively supports both video aspect ratios from a shared timeline:

| Aspect Ratio | Canvas Dimensions | Layout & Composition Strategy |
|---|---|---|
| **16:9 Landscape** | 1920 × 1080 px (or 1280 × 720 px) | Widescreen hero stage; horizontal multi-column splits (code/diagram on left, 3D yaw mockup or procedural dashboard on right); wide headline rows; lateral whip cuts (`whip`). |
| **9:16 Portrait** | 1080 × 1920 px (or 720 × 1280 px) | Vertical mobile stage; stacked information hierarchy; centered statement text; mobile-safe top progress bar; high-contrast stat cards; vertical whip cuts (`whipV`). |

A continuous top gradient progress bar (`0% → 100%`) runs across the top edge throughout the full runtime on both formats.

---

### 4. Mathematical Camera System & Finishing Shaders

High-energy visuals rely on camera kicks and film-finishing effects:

#### A. Camera Dynamics (`camera`)
- **Slow Push (`PUSH`):** Continuous subtle camera creep ($z: 1.0 \to 1.035$) across each scene so the picture never freezes.
- **Punch Zooms (`PUNCH`):** Snappy scale pulses ($z += 0.03 \text{ to } 0.12$) triggered on the hardest spoken emphasis words, settling with exponential decay.
- **Screen Shake (`SHAKE`):** Multi-axis jitter ($dx, dy, rot$) driven by 1D noise (`NX`, `NY`, `NR`) during explosions, errors, or heavy impacts.

#### B. Finishing Shaders (`finishing`)
- **Procedural Film Grain:** 4 seeded noise tiles cycled at 24 fps with `globalCompositeOperation = 'overlay'`, giving clean digital vector art an organic cinematic feel.
- **Radial Vignette:** Subtle edge darkening ($r: 0.22W \to 0.65W$) focusing viewer attention toward the center.
- **Dynamic Light Leaks (`LEAK`):** Warm golden/orange radial gradients sweeping diagonally across the canvas on milestone transitions.
- **Flash Transitions (`FLASH`):** Fast single-frame white or colored flash cuts with exponential fade.

#### C. Transition Compositor
- **Directional Whip Pans (`whip` & `whipV`):** Multi-pass directional cross-slams with sinusoidal motion blur across horizontal or vertical axes.
- **RGB Channel Split Glitch (`glitch`):** Separates red (`#FF0000`) and cyan (`#00FFFF`) channels with horizontal slice displacements and white scanlines.
- **Flash Cuts:** High-contrast luminous white pops.

---

### 5. Curated Local Reference Library (`pinterest-references/`) & 7-Point Style Card

The skill references 26 downloaded high-production motion design videos stored in `pinterest-references/`:
- **Kinetic Typography, 3D Text & Card Physics:** `Burzaev_studio_*.mp4`, `divyanshfx_*.mp4`, `dspatel7664_*.mp4`, `Rishabh_Verma13_*.mp4`, `rvxeditor52_*.mp4`.
- **SaaS UI, Modern Glassmorphism & Web Mockups:** `socialheavenio_*.mp4`, `solution_wagon_*.mp4`, `exar_digital_*.mp4`, `rovixstudios_*.mp4`, `saifeecreations_*.mp4`.
- **Technical Infographics, Flowcharts & System Diagrams:** `insiderforce_*.mp4`, `mostafaazv_*.mp4`, `creatingwithakash_*.mp4`, `thekulveer_*.mp4`.
- **Minimalist Editorial, Typography Scale & Smooth Transitions:** `Grace_Studio57_*.mp4`, `motiondesigners2d_*.mp4`, `mukithasan997_*.mp4`, `roykanti420_*.mp4`.

#### The 7-Point Style Card Extraction Framework
When preparing to generate a video:
1. **Palette:** 4 to 7 exact hex tokens (Background `bg`, Panel `panel`, Border `line`, Text `ink`, Mute `dim`, Accent `hi`, Alert `red`, Success `green`).
2. **Surface:** Background treatment, drifting grid size, ambient radial glow colors, film grain strength.
3. **Typography:** Primary display font (e.g. Anton, Bebas Neue), serif accent (Instrument Serif italic), body & labels (Inter), mono/code (JetBrains Mono).
4. **Shapes & Layout:** Corner radiuses, card paddings, stroke widths, safe zones for 16:9 and 9:16.
5. **Emphasis:** How emphasis is highlighted (word slam scale, yellow highlighter swipe, hand-drawn scribble loop, red strike).
6. **Motion:** Easing curves, card entrance physics (`ez.back`), camera punch/shake intensity, transition types (`whip`, `glitch`, `flash`).
7. **Sound:** Mapping of timeline events to the procedural Web Audio SFX kit.

Save the completed Style Card into `YYYYMMDD-HHMMSS/pinterest-motion-design.md`.

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
Visual: Problem diagram vs brittle pipelines + 3D yaw server mockup and red STAMP strike
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
Save the synchronized timeline manifest into the project folder, explicitly associating each slide with its code-drawn procedural proof shot and motion graphic components:
```json
{
  "project": "topic-slug",
  "slides": [
    {
      "slide_index": 1,
      "title": "Hook & System Architecture",
      "proof_shot": {
        "type": "browser_3d_yaw",
        "title": "Distributed Pipeline Dashboard",
        "yaw_deg": 14,
        "trigger_offset": 2.2
      },
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
      "title": "Live Terminal Execution & Retry Logic",
      "proof_shot": {
        "type": "terminal_macos",
        "command": "curl -X POST https://api.prod/stream",
        "stdout": "✓ Stream connected (200 OK)",
        "trigger_offset": 0.5
      },
      "motion_graphics": [
        {"type": "animated_badge", "text": "CODE WALKTHROUGH", "position": "top_left", "animation": "slide_bounce"},
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
| **Visual Structure** | Wide hero stage, code split-screens, architecture diagrams, and 100% code-drawn proof mockups | Vertical mobile stage, kinetic callouts, bold stat pop-ins, and stacked proof cards |
| **Procedural Proof Shots (Zero Stock B-Roll)** | 100% code-drawn 3D perspective browser mockups (`drawYaw`), macOS terminal windows (`drawTerminalProof`), live metric charts. Zero external stock video downloads. | 100% code-drawn smartphone chat threads (`scenePhone`), vertical terminal windows, stacked metric tickers, pop-in badges. Zero external stock video downloads. |
| **Motion Graphics (Code-Drawn)** | Patil code-drawn Canvas engine: pure function f(t), kinetic typography slams, highlighter swipes, 3D perspective yaw mockups, live terminal typing, spring metric tickers, camera punch/shake, film grain, light leaks, and directional whip pans | Patil code-drawn Canvas engine: pure function f(t) in 9:16 vertical orientation, top progress bar, vertical stacked cards, rapid word slams, pop-in stat badges, vertical whip cuts (`whipV`), film grain, and camera punch zooms |
| **Captions** | Lower-third frosted pill, centered, active keyword yellow highlight (`#FCD34D`) | Safe-zone positioned (bottom 160px), frosted glass pill, active keyword highlight |
| **Audio Mix** | ElevenLabs voiceover at volume 1.0 (-16 LUFS) + synthesized Web Audio SFX (slams, whooshes, ticks) + background music looped at volume 0.10 | ElevenLabs voiceover at volume 1.0 (-16 LUFS) + synthesized Web Audio SFX (slams, pops, glitches) + background music looped at volume 0.10 |

### Video Audio Mixing Command (FFmpeg with SFX Track)
```bash
ffmpeg -y \
  -i visual_rendered.mp4 \
  -i assets/voiceover.mp3 \
  -i assets/sfx.wav \
  -stream_loop -1 -i scripts/youtube-shorts-bt-music.mp3 \
  -filter_complex "[1:a]volume=1.0[voice];[2:a]volume=0.85[sfx];[3:a]volume=0.10,afade=in:st=0:d=1[bg];[voice][sfx][bg]amix=inputs=3:duration=first:dropout_transition=2[aout]" \
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
| **Interactive Player Artifact** | `player.html` | Self-contained HTML5 Canvas & Web Audio player with scrub bar, dual-orientation switcher, timecode, and sound controls. Opens locally in any browser. |
| **YouTube Metadata** | `youtube.md` | 3 clickable titles (<60 chars), SEO description with hook, video timestamps, links, tags. Clean text. |
| **LinkedIn Post** | `linkedin-post.md` | Mobile hook (<8 words), re-hook, 1–2 sentence paragraphs, emojis, soft CTA, ♻️ Repost, ➕ Follow Deven Goratela, 3–5 hashtags. Clean text. |
| **Cover Image & Prompt**| `cover.svg` & `cover-prompt.md` | 1200×627 SVG (1.91:1) with central 1000×500 safe zone, hero insight text, `@devengoratela` branding + AI prompt. |
| **Skool Community** | `skool-post.md` | 30–40% shorter than LinkedIn, casual peer tone, tool/tip focus, zero hashtags, bold closing question. Clean text. |
| **Instagram Post** | `instagram-post.md` | Visual hook (<10 words), curiosity hook extension, spaced paragraphs, emoji bullets, save/share CTA, 10–15 hashtags at bottom. Clean text. |
| **Twitter / X** | `twitter-post.md` | Standalone tweet (<280 chars) PLUS full numbered thread (`1/` to `N/`), summary, follow + retweet CTA. Clean text. |
| **Facebook Post** | `facebook-post.md` | Conversational, storytelling, short paragraphs, emoji anchors, discussion question, 0–2 hashtags. Clean text. |
| **Pinterest Motion Style**| `pinterest-motion-design.md` | Selected reference video from pinterest-references/, motion design breakdown, color palette tokens, and transition specs. |
| **Credits & Attribution**| `credits.md` | Voiceover profile, fonts, procedural sound specs, and background music license log. |

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
├── player.html                     ← Interactive HTML5 Canvas & Web Audio player artifact (transport, scrub, aspect switcher)
├── youtube.md                      ← YouTube metadata: 3 titles, SEO description, timestamps, tags
├── linkedin-post.md                ← Clean copy-paste LinkedIn post (zero markdown)
├── skool-post.md                   ← Clean copy-paste Skool community post (zero markdown)
├── instagram-post.md               ← Clean copy-paste Instagram caption & hashtags (zero markdown)
├── twitter-post.md                 ← Standalone tweet + numbered thread (zero markdown)
├── facebook-post.md                ← Clean copy-paste Facebook post (zero markdown)
├── cover.svg                       ← 1200×627 SVG cover image (1.91:1)
├── cover-prompt.md                 ← AI image prompt for Midjourney / DALL-E / Flux
├── pinterest-motion-design.md      ← Selected reference video from pinterest-references/ & motion specs
└── credits.md                      ← Voiceover profile, fonts, procedural sound specs, and music license log
```

> [!NOTE]
> All intermediate scratch files and working directories (such as `assets/review/`, `assets/images/`, `slides_16by9/`, `slides_9by16/`, `tmp/`, per-slide voiceover segments, and temporary render cuts) are automatically removed upon completion so the folder strictly holds the final generated deliverables. (Note: Permanent skill fixtures `pinterest-references/` and `scripts/` are never deleted).

---

## Step-by-Step Execution Sequence

When triggered, execute all stages sequentially without pausing for unnecessary permission prompts:

1. **Intake & Source Evaluation:**
   - Evaluate topic, video URL, YouTube URL, or GitHub repo.
   - If video input: run pre-edit inspection pass (`ffprobe`, contact sheets, audio check) and output an upfront critique before editing.
   - Compute timestamp folder `YYYYMMDD-HHMMSS/`.
2. **Reference Video Selection from `pinterest-references/` & 7-Point Style Card Extraction:**
   - Inspect the downloaded reference videos in `pinterest-references/` (do NOT search Pinterest online).
   - Select the reference video that matches the topic and aesthetic (e.g., kinetic typography, SaaS glassmorphic UI, technical flowcharts, or minimalist editorial).
   - Extract the 7-Point Style Card: Palette (hex tokens), Surface (grain, vignette, glows), Typography (display, serif, body, mono), Shapes/Layout, Emphasis, Motion (easing curves, camera punch/shake), and Sound (SFX mapping).
   - Save the Style Card into `YYYYMMDD-HHMMSS/pinterest-motion-design.md`.
   - Configure the dual-orientation layout plans (16:9 Landscape widescreen and 9:16 Portrait mobile).
3. **Scripting with Slide-Topic & Motion Graphics Boundaries:**
   - Write structured narration chunks mapped 1:1 to visual slides/scenes.
   - Explicitly assign motion graphic triggers (kinetic typography slams, terminal typewriter, 3D yaw mockups, diagram flows, metric tickers) to each scene.
4. **100% Code-Drawn Procedural Proof Shots & UI Mockups Setup (Zero Stock Footage):**
   - Configure code-drawn proof mockups for each technical concept:
     - 3D perspective browser mockups (`drawYaw` / `drawBrowserProof`) for web dashboards, SaaS interfaces, and documentation.
     - Smartphone conversational chat threads (`scenePhone`) for messaging flows, notifications, and mobile interactions.
     - macOS developer terminal windows (`drawTerminalProof`) with character typing, stdout streams, and success badges for code walkthroughs.
     - Benchmark counters and latency charts (`drawMath`) with green glowing milestone numbers for metrics.
   - Zero stock video downloading (no external B-roll dependencies, zero watermarks, zero license issues).
5. **Voiceover Generation & Precision Probing:**
   - Generate audio via ElevenLabs cloned voice for each slide segment.
   - Probe exact audio durations using `ffprobe`.
6. **Timeline Calculation, Manifest & Synthesized SFX Score:**
   - Calculate slide display durations: $\text{Slide Duration} = \text{Audio Duration} + 0.6\text{s}$.
   - Ensure every slide stays on screen for the full duration of its voiceover.
   - Map code-drawn proof shots, visual animations, procedural SFX triggers (`slam`, `pop`, `tick`, `whoosh`, `marker`, `keys`, `boom`), and captions into `sync-manifest.json` and `captions.json`.
7. **Pre-Export Sync Verification Pass:**
   - Run `python3 scripts/verify-slide-sync.py YYYYMMDD-HHMMSS/sync-manifest.json`.
   - Abort and adjust if any slide transitions before voiceover completes.
8. **Build Interactive `player.html` Artifact & Render Dual Videos (16:9 & 9:16):**
   - Assemble the self-contained interactive browser player artifact `YYYYMMDD-HHMMSS/player.html` built on Patil's reference player architecture (`scripts/motion-engine-template.html`):
     - Interactive stage supporting real-time switching between 16:9 Landscape and 9:16 Portrait.
     - Full transport controls: Play/Pause button (spacebar toggle), scrub slider bar (`window.seek(t)`), timecode readout, sound mute/unmute, and loop toggle.
   - Synthesize the procedural Web Audio SFX track (`assets/sfx.wav`) via `SFX.render(scoreSound, DURATION, 48000, { voiceover: true })`.
   - Render 1080p video frames from the Canvas engine, and mux with ElevenLabs cloned voiceover (-16 LUFS), synthesized SFX track (volume 0.85), and ducked background music (10% volume) into `{slug}-16by9.mp4` and `{slug}-9by16.mp4`.
9. **Generate All Native Social Posts (Zero Markdown):**
   - Write `youtube.md`, `linkedin-post.md`, `skool-post.md`, `instagram-post.md`, `twitter-post.md`, `facebook-post.md`, `cover.svg`, and `cover-prompt.md`.
10. **Automatic Intermediate File Cleanup:**
    - Purge all scratch directories, temporary render files, frame dumps, and intermediate audio/video cuts while strictly retaining `player.html`:
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
    - Verify that only the final generated output files (including `player.html`) exist in `YYYYMMDD-HHMMSS/`.
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
- [ ] Real-world proof and demonstrations are 100% code-drawn on Canvas (3D perspective browser mockups, mobile chat threads, macOS terminals, live metric tickers) with zero external stock footage or B-roll downloads
- [ ] Interactive player artifact `player.html` generated with working transport bar, real-time scrub slider, timecode, orientation switcher, and sound toggle

**Motion Graphics & Code-Drawn Engine (Mandatory):**
- [ ] 7-Point Style Card extracted from reference video in `pinterest-references/` and documented in `pinterest-motion-design.md`
- [ ] Code-drawn Canvas animation engine used: pure function of time f(t), seeded PRNG, and mathematical easing
- [ ] Visual primitives active: kinetic word slams, highlighter swipes, 3D perspective yaw mockups, live terminal typing, and spring metric tickers
- [ ] Mathematical camera physics active: continuous slow push, punch zooms on emphasis words, screen shake on impacts
- [ ] Finishing shaders applied: film grain stepped at 24fps, radial vignette, light leaks, and dynamic transitions (whip pans, glitches)
- [ ] Dual aspect ratios generated: 16:9 widescreen ({slug}-16by9.mp4) and 9:16 vertical ({slug}-9by16.mp4)
- [ ] Procedural Web Audio synthesized SFX track generated and mixed with ElevenLabs voiceover and ducked background music
- [ ] Top continuous animated gradient progress bar spans full video runtime
- [ ] Zero static screen policy enforced: every scene incorporates continuous motion layers without freezing

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
- [ ] Output folder contains ONLY the final generated deliverables (videos, player.html, social posts, cover files, design spec, and credits.md)
