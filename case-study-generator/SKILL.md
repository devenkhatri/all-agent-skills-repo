---
name: case-study-generator
description: Use when a user wants to generate a professional case study from a completed project. Accepts git repo URLs, README files, project descriptions, Loom video URLs, live web pages, or PPT/PDF files as input. Produces multiple output formats including markdown, LinkedIn carousel, PDF-ready HTML, slide deck outline, Twitter thread, one-page summary, and video scripts.
---

# Case Study Generator

Generate polished, business-friendly case studies for completed projects from any combination of inputs. Every case study is written in Dhimahi Technolabs' brand voice and ends with a CTA driving prospects to book a consulting call.

## When to Use This Skill

Trigger when the user wants to:
- Document a completed project as a shareable case study
- Create client portfolio / sales assets from a finished build
- Generate personal brand content from project work
- Produce multiple publish-ready formats in one run

## Supported Inputs

Accept **one or more** of the following — the skill extracts as much as it can autonomously before asking for what is missing:

| Input Type | What to Do |
|---|---|
| **Git repo URL** | Clone or read public repo; analyse `README.md`, folder structure, tech stack, and open Issues/PRs for context |
| **Project description** (plain text) | Use directly as primary narrative input |
| **Loom video URL** | Fetch transcript via Loom embed API; summarise key narrated points |
| **Web page URL** | Crawl the live product page; extract headlines, features, and testimonials |
| **PPT / PDF file** | Read slide text and extract key messages, diagrams, and stats |
| **GitHub Issues / PR history** | Extract problem–solution arc from issue titles and PR descriptions |

---

## Intake Workflow

### Step 1 — Collect Inputs

Ask the user for the following if not already provided:

**Required (must have at least one):**
- One or more project inputs (git URL, description, Loom URL, web page, PPT/PDF)

**Project Metadata (always collect):**

| Field | Required? | Notes |
|---|---|---|
| **Project name / title** | ✅ | Used in all output filenames and headings |
| **Industry / domain** | ✅ | e.g., "FinTech", "HealthTech", "Internal Enterprise Tool" |
| **Client name** | Optional | Can be anonymised — ask: "May I name the client, or should I anonymise?" |
| **Your role** | Optional | e.g., "Lead architect & delivery manager" |
| **Go-live / completion date** | Optional | Used for context; approximate is fine |
| **Is client name public?** | Ask if client name given | Yes / No / Anonymise as "a leading [industry] company" |

### Step 2 — Extract Autonomously

From all supplied inputs, extract:

1. **Problem / Challenge** — What was broken, slow, or missing before this project?
2. **Solution / Approach** — What was built, and how?
3. **Tech Stack** — Languages, frameworks, platforms, integrations
4. **Results & Metrics** — Quantified outcomes: time saved, revenue impact, error reduction, adoption rates
5. **Challenges & Learnings** — Honest obstacles and how they were navigated

### Step 3 — Gap-Fill Interview

After extraction, ask **only** for information that could not be found in the inputs. Common gaps:

- Quantified business results (if not in repo/page)
- Client name / anonymisation preference
- The user's specific role on the project
- Any testimonial or quote from the client or stakeholder

> **Do NOT ask for information already found in the inputs.** Be specific: *"I found you used React and Supabase. What was the measurable business outcome — did the client mention time saved or cost reduced?"*

---

## Case Study Structure

Every case study must include these sections in this order:

### 1. 🎯 Project Overview
- Project name, client (or anonymised), industry, completion date
- One-sentence elevator pitch

### 2. ❗ Problem / Challenge
- What pain point, inefficiency, or gap existed?
- Business impact of the problem (cost, time, risk)

### 3. 💡 Solution / Approach
- What was built and why this approach was chosen
- Key architectural or design decisions (kept jargon-light)
- Timeline snapshot (if available)

### 4. ⚙️ Tech Stack
- Clean bullet list of technologies, platforms, and integrations used

### 5. 📈 Results & Metrics
- Quantified outcomes (e.g., "Reduced manual processing time by 60%", "Onboarded 500+ users in first month")
- Use real numbers when available; use estimates with a note if not

### 6. 🧗 Challenges & Learnings
- 2–3 honest obstacles and how they were solved
- Shows depth and builds trust with technical buyers

### 7. 📣 CTA — Book a Consulting Call
Always end every format with this closing CTA block:

```
---
🚀 Building something similar?

Dhimahi Technolabs helps businesses design, build, and ship intelligent solutions — fast.

👉 Book a free consulting call: https://dhimahitechnolabs.com
---
```

---

## Output Formats

Generate **all 10 formats** in a single run. Save every file to a date-stamped folder.

### Folder Structure

```
YYYYMMDD-HHMMSS-{project-slug}/
├── case-study.md                    ← Format 1: Markdown
├── linkedin-post.md                 ← Format 2: LinkedIn post + carousel script
├── case-study.html                  ← Format 3: PDF-ready HTML
├── slide-deck-outline.md            ← Format 4: Slide deck outline (PPT structure)
├── twitter-thread.md                ← Format 5: Twitter/X thread
├── one-page-summary.md              ← Format 6: One-page elevator pitch
├── video-16x9.md                    ← Format 7: Landscape video script (for generate-video skill)
├── youtube-video-meta.md            ← Format 8: YouTube video title + description + tags
├── video-9x16.md                    ← Format 9: Portrait/Reels video script (for generate-video skill)
└── youtube-shorts-meta.md           ← Format 10: YouTube Shorts title + description + tags
```

---

### Format 1 — Markdown Case Study (`case-study.md`)

Full-length case study following the 7-section structure above. Aim for 600–900 words. Includes all sections, metrics, and CTA.

**Tone:** Business-friendly, outcomes-focused, jargon-light. First-person plural ("we") from Dhimahi Technolabs' perspective.

---

### Format 2 — LinkedIn Post + Carousel Script (`linkedin-post.md`)

Two parts in one file:

**Part A — LinkedIn Long-form Post (≈ 300 words)**
- Hook line (first 2 lines must create curiosity — they show before "see more")
- Story arc: problem → solution → results
- 3–5 key learnings or outcomes as bullet points
- CTA to book a consulting call
- 5–8 relevant hashtags

**Part B — Carousel Script (for `carousel-creator` skill)**
- Slide-by-slide text content (6–9 slides)
- Slide 1: Bold hook
- Slides 2–7: One insight or stat per slide
- Final slide: CTA — "Book a call with Dhimahi Technolabs → dhimahitechnolabs.com"
- Note: *"Pass this script to the `carousel-creator` skill to generate SVG slides."*

---

### Format 3 — PDF-Ready HTML (`case-study.html`)

A single-page, print-ready HTML file styled for client delivery.

**Design rules:**
- Dhimahi Technolabs brand: primary `#1A1A2E`, accent `#E94560`, white `#FFFFFF`, font `Inter`
- Logo placeholder at top-right: `[DHIMAHI TECHNOLABS LOGO]`
- Clean two-column layout on desktop, single column on print
- All 7 case study sections rendered as styled HTML
- CTA box at the bottom with a clickable link to `https://dhimahitechnolabs.com`
- Print-safe: `@media print` CSS that hides navigation/links and renders cleanly as PDF
- Self-contained: all CSS inline or in `<style>` — no external dependencies

---

### Format 4 — Slide Deck Outline (`slide-deck-outline.md`)

A structured PPT outline for presenting the case study. Each slide entry includes:
- Slide number & title
- Bullet points (the actual content to put on that slide)
- Speaker notes (what to say, 2–3 sentences)
- Visual suggestion (e.g., "icon grid", "before/after chart", "screenshot placeholder")

**Slide count:** 8–12 slides. Structure:

| # | Slide |
|---|---|
| 1 | Cover — Project Name + Client (or industry) |
| 2 | Executive Summary (1-slide overview) |
| 3 | The Problem / Challenge |
| 4 | Our Approach / Solution |
| 5 | Tech Stack (visual icon list) |
| 6–8 | Key Results & Metrics (one metric per slide if impactful) |
| 9 | Challenges & How We Solved Them |
| 10 | Testimonial / Quote (if available) |
| 11 | What's Next / Roadmap (if applicable) |
| 12 | CTA — Let's Build Yours |

---

### Format 5 — Twitter/X Thread (`twitter-thread.md`)

8–12 tweets in a numbered thread. Format:

```
🧵 THREAD: [Hook tweet — bold claim or surprising stat] (1/N)

2/ [Problem setup — 1–2 sentences]

3/ [Solution overview — 1–2 sentences]

...

N/ 🚀 Building something similar?

Dhimahi Technolabs ships intelligent solutions fast.

Book a free call → https://dhimahitechnolabs.com

[5–8 hashtags]
```

Each tweet ≤ 280 characters. Number every tweet. Use emojis sparingly but effectively.

---

### Format 6 — One-Page Summary (`one-page-summary.md`)

An executive elevator-pitch document. Fits on one printed page (≈ 350–400 words). Structure:

- **Header:** Project name, client (or anonymised), industry, date
- **The Challenge (2–3 sentences)**
- **What We Built (3–4 sentences)**
- **Key Outcomes (3–5 bullet points with numbers)**
- **Technologies Used (comma-separated list)**
- **CTA box**

Designed to be emailed to a prospect or printed for a meeting.

---

### Format 7 — Video Script 16:9 Landscape (`video-16x9.md`)

A narration script for a landscape (YouTube / LinkedIn) explainer video. 60–90 seconds of spoken content.

**Structure:**
```
TITLE: [Project Name] Case Study
FORMAT: 16:9 Landscape
DURATION: ~75 seconds
STYLE: Professional, confident, business-friendly

---
[SCENE 1 — 0:00–0:10] HOOK
Visual: [describe on-screen graphic / text overlay]
Narration: "..."

[SCENE 2 — 0:10–0:25] THE PROBLEM
Visual: [describe]
Narration: "..."

[SCENE 3 — 0:25–0:50] THE SOLUTION & RESULTS
Visual: [describe]
Narration: "..."

[SCENE 4 — 0:50–0:75] CTA
Visual: dhimahitechnolabs.com URL card
Narration: "Ready to build something like this? Book a free consulting call with Dhimahi Technolabs at dhimahitechnolabs.com"
```

> 📌 **Agent note:** After saving this file, invoke the `generate-video` skill with `video-16x9.md` as input to produce the actual video.

---

### Format 9 — Video Script 9:16 Portrait / Reels (`video-9x16.md`)

A narration script for a vertical short-form video (Instagram Reels / YouTube Shorts / LinkedIn Short). 30–45 seconds of spoken content.

**Structure:**
```
TITLE: [Project Name] — [Punchy subtitle]
FORMAT: 9:16 Portrait / Reels
DURATION: ~35 seconds
STYLE: Fast-paced, punchy, social-native

---
[0:00–0:05] HOOK (on-screen text + narration)
Visual: Bold text overlay
Narration: "..."

[0:05–0:20] RESULTS FIRST (lead with the outcome)
Visual: Key metric cards
Narration: "..."

[0:20–0:30] HOW WE DID IT (brief)
Visual: Tech/solution visual
Narration: "..."

[0:30–0:35] CTA
Visual: @dhimahitechnolabs handle + link card
Narration: "DM us or visit dhimahitechnolabs.com"
```

> 📌 **Agent note:** After saving this file, invoke the `generate-video` skill with `video-9x16.md` as input to produce the actual video.

---

### Format 8 — YouTube Video Metadata (`youtube-video-meta.md`)

SEO-optimised title, description, and tags for uploading the 16:9 case study video to YouTube.

**File structure:**

```markdown
# YouTube Video Metadata — [Project Name]

## Title (max 100 characters)
[Project Name]: How We [Key Outcome] for [Client/Industry] | Dhimahi Technolabs

## Description
[First 2–3 lines are the hook — shown before "Show more"; make them stand-alone compelling]

In this video, we walk through how Dhimahi Technolabs helped [client/industry] solve [core problem] and achieve [key result].

📌 What you'll learn:
- [Insight 1]
- [Insight 2]
- [Insight 3]

🛠️ Tech Stack: [comma-separated list]

📈 Key Results:
- [Metric 1]
- [Metric 2]

🚀 Building something similar? Book a free consulting call with Dhimahi Technolabs:
👉 https://dhimahitechnolabs.com

---
🔔 Subscribe for more case studies, builds, and tech insights from Dhimahi Technolabs.

Timestamps:
0:00 – Introduction
0:10 – The Problem
0:25 – Our Solution
0:50 – Results & Impact
1:10 – Book a Call

## Tags (comma-separated, max 500 characters total)
[project domain], [tech stack keywords], case study, Dhimahi Technolabs, [industry], [outcome keyword], software development, [specific tech], AI development, custom software
```

**Rules:**
- Title must be ≤ 100 characters; front-load the most compelling keyword
- First 157 characters of description appear in Google search snippets — make them count
- Include `https://dhimahitechnolabs.com` as the first clickable link
- Timestamps must align with scenes defined in `video-16x9.md`
- Aim for 10–15 tags; mix broad and niche

---

### Format 10 — YouTube Shorts Metadata (`youtube-shorts-meta.md`)

SEO-optimised title, description, and tags for uploading the 9:16 script as a YouTube Short.

**File structure:**

```markdown
# YouTube Shorts Metadata — [Project Name]

## Title (max 100 characters — punchy, front-loaded)
We [Key Outcome] in [Timeframe] 🚀 | [Project Name] #Shorts

## Description
[Hook line — 1 sentence, creates curiosity or leads with the result]

Full case study → https://dhimahitechnolabs.com

[2–3 sentences on what was built and the outcome]

🚀 Want results like this? Book a free call: https://dhimahitechnolabs.com

#Shorts #[Industry] #[TechKeyword] #CaseStudy #DhimahiTechnolabs #SoftwareDevelopment

## Tags (comma-separated)
shorts, [industry], [tech keyword], case study, Dhimahi Technolabs, software development, [outcome keyword], [specific tech]
```

**Rules:**
- Title ≤ 100 characters; end with `#Shorts` to signal the format to YouTube
- Description is short — Shorts viewers rarely expand it; lead with the hook and the CTA link
- Always link `https://dhimahitechnolabs.com` as the primary CTA
- Use `#Shorts` as the first hashtag (YouTube algorithm requirement)
- 5–8 total hashtags; do not exceed 15

---

## Brand & Tone Guidelines

| Attribute | Guideline |
|---|---|
| **Tone** | Business-friendly, outcomes-first, confident but not arrogant |
| **Voice** | First-person plural ("we built", "our team") from Dhimahi Technolabs' POV |
| **Jargon** | Tech terms allowed in the Tech Stack section only; everywhere else, translate to business impact |
| **Brand colors** | Primary `#1A1A2E` · Accent `#E94560` · White `#FFFFFF` |
| **Font** | Inter (Google Fonts) |
| **CTA URL** | Always `https://dhimahitechnolabs.com` |
| **CTA Placement** | End of every format — no exceptions |

---

## Execution Checklist

- [ ] At least one input source provided
- [ ] Project metadata collected (name, industry, client anonymisation preference)
- [ ] Autonomous extraction completed from all inputs
- [ ] Gap-fill interview done (only asked for what was missing)
- [ ] All 7 case study sections written
- [ ] CTA block included in every format
- [ ] All 10 output files saved to `YYYYMMDD-HHMMSS-{project-slug}/`
- [ ] `video-16x9.md` → `youtube-video-meta.md` generated alongside it and flagged for `generate-video` skill
- [ ] `video-9x16.md` → `youtube-shorts-meta.md` generated alongside it and flagged for `generate-video` skill
- [ ] `linkedin-post.md` carousel script flagged for `carousel-creator` skill

---

## Common Mistakes

| Mistake | Fix |
|---|---|
| Asking for info that's already in the README | Extract first, ask only for gaps |
| Writing in technical jargon throughout | Tech Stack section only; translate everywhere else |
| Vague results ("improved performance") | Push for numbers: "by how much? over what period?" |
| Forgetting to anonymise client when requested | Check `client-public` flag before every output |
| Omitting CTA from any format | CTA is mandatory in every format — always check |
| Starting LinkedIn hook with "We built..." | First 2 lines must create curiosity before "see more" break |
| Using different CTA URLs | Always and only `https://dhimahitechnolabs.com` |

