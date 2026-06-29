---
name: pptx-custom
description: "Use this skill whenever the user wants to create or improve a presentation — academic OR corporate/professional. Academic triggers: 'conference talk', 'seminar slides', 'thesis defense', 'research presentation', 'academic deck', 'grant proposal', 'make slides for my paper'. Corporate triggers: 'solution proposal', 'sales pitch', 'executive briefing', 'strategy deck', 'roadmap presentation', 'client presentation', 'business case', 'QBR', 'corporate deck', 'proposal'. Also triggers for any request to 'make slides' or 'build a deck' regardless of context. This skill governs CONTENT, STRUCTURE, and DESIGN decisions for both modes. For the technical work of creating or editing the .pptx file itself, also read the pptx SKILL.md."
license: Proprietary. LICENSE.txt has complete terms
---

# pptx-custom: Presentations Skill (Academic + Corporate)

This skill handles two presentation modes. Read this file fully, then route to the correct section.

---

## Quick Reference

| Task | Guide |
|------|-------|
| Academic content & argument structure | [content_guidelines.md](content_guidelines.md) — Academic sections |
| Corporate content, narrative structure, deck types | [content_guidelines.md](content_guidelines.md) — Corporate sections |
| Slide implementation patterns (all types) | [slide_patterns.md](slide_patterns.md) |
| Technical file creation | PPTX skill → `pptxgenjs.md` |
| Technical editing of an existing file | PPTX skill → `editing.md` |

---

## Step 0: Detect Mode

Before anything else, classify the request into one of two modes:

### 🎓 Academic Mode
**Triggers:** conference paper, seminar, thesis defense, dissertation, grant briefing, lab meeting, invited lecture, research presentation, academic deck, "make slides for my paper/study/dataset".

→ Follow the **Academic** sections of [content_guidelines.md](content_guidelines.md) and academic patterns in [slide_patterns.md](slide_patterns.md).

### 🏢 Corporate Mode
**Triggers:** solution proposal, sales pitch, client presentation, executive briefing, strategy deck, roadmap, business case, QBR, capability showcase, RFP response, project kickoff, client pitch.

→ Follow the **Corporate** intake workflow below, then the **Corporate** sections of [content_guidelines.md](content_guidelines.md) and corporate patterns in [slide_patterns.md](slide_patterns.md).

### When in doubt
If the user mentions a paper, study, dataset, thesis, grant, or conference → **Academic**.
If the user mentions a client, proposal, business, strategy, sales, or executive → **Corporate**.
Ask the user only if it genuinely cannot be determined.

---

## Corporate Mode: Intake Workflow

**Always follow this sequence before planning or building any corporate deck.**

### 1. Confirm deck type
Identify which corporate deck type applies (match to user's request):

| Deck Type | Primary Goal | Default Length |
|-----------|-------------|----------------|
| **Solution Proposal** | Win a deal by mapping a specific solution to a client's problem | 12–18 slides |
| **Sales Pitch** | Introduce your company/offering and open a conversation | 8–12 slides |
| **Strategy / Roadmap** | Align stakeholders on direction and priorities | 14–20 slides |
| **Executive Briefing** | Give a time-pressured senior audience the key facts and decision | 6–10 slides |
| **Business Case / ROI** | Justify investment with evidence and financial analysis | 10–16 slides |
| **QBR / Status Update** | Review performance and align on next steps with an existing client | 10–14 slides |
| **Project Kickoff** | Align a new team or client on scope, plan, and ways of working | 10–14 slides |
| **Capability Showcase** | Demonstrate what your team/product/service can do | 8–12 slides |

If the deck type is ambiguous, **propose 2–3 structure options** and let the user choose before proceeding.

### 2. Ask for the client brand color
**Always ask this before building:**
> "What is the primary brand color for [Client Name]? (A hex code is ideal, but a rough description works too.) If you don't have one, I'll use a clean corporate default palette."

Store the provided color and apply it consistently as the primary color throughout the deck.

### 3. Confirm the audience
Identify the audience level and adapt tone, depth, and vocabulary accordingly:

| Audience | Tone | Depth |
|----------|------|-------|
| C-suite / executives | Confident, direct, outcome-first | High-level; lead with business impact |
| Mixed (business + technical) | Balanced; plain-language for business sections, precise for technical | Modular; use appendix for deep-dives |
| External clients / prospects | Professional, solution-focused, credibility-building | Evidence-heavy; include case studies |
| Internal stakeholders | Collaborative, transparent, honest about risks | Include risk & mitigation; show full context |

### 4. Name-based context
If the user explicitly names a client or project (e.g., "this is for Acme Corp"), **remember the client name and context for the rest of the session**. Apply it consistently in the deck content. If the user starts a new named project, update the context.

---

## Corporate Mode: Design System

### Style Selection
Select the visual style based on the deck type and audience. Do not ask the user — make the call, then state it briefly.

| Style | When to use | Palette |
|-------|------------|---------|
| **Premium / Polished** | Sales pitches, capability showcases, high-stakes client pitches | Dark backgrounds, bold gradients, white text, vibrant accent |
| **Clean Corporate** | Solution proposals, QBRs, status updates, internal decks | White/light bg, client brand color as primary, structured grid |
| **McKinsey / Analytical** | Business cases, ROI decks, strategy decks with heavy data | Black/white with selective color highlights, annotation-rich |
| **Client-Matched** | Any deck where the user provides a template or brand guide | Match provided template; override nothing without asking |

### Default Corporate Color Palettes

**Clean Corporate (default if no brand color provided):**
```
bg:        F8F9FA   (near-white)
primary:   1B2A4A   (deep navy)
accent:    0F6FBF   (corporate blue)
body:      2C3E50   (dark slate)
muted:     6C757D   (gray)
highlight: E8F4FD   (light blue tint)
cta:       E63946   (red — for CTA buttons/emphasis only)
```

**Premium / Dark:**
```
bg:        0D1117   (near-black)
primary:   FFFFFF   (white text)
accent:    6C63FF   (violet)
secondary: 00D4AA   (teal)
muted:     8B949E   (muted gray)
surface:   161B22   (card bg)
```

**McKinsey / Analytical:**
```
bg:        FFFFFF
primary:   000000
accent:    CC0000   (red — highlight only)
body:      333333
muted:     888888
rule:      DDDDDD
```

### Typography (Corporate)

| Element | Size | Weight |
|---------|------|--------|
| Slide title / headline | 28–36 pt | Bold |
| Section header | 22–24 pt | Bold |
| Body bullets | 18–20 pt | Regular |
| KPI / stat callout | 36–48 pt | Bold |
| Chart labels / annotations | 14–16 pt | Regular |
| Footnotes / caveats | 11–13 pt | Regular, muted |

Font face: **Inter** (preferred) or **Calibri** as fallback. Single face throughout.

### Layout Rules (Corporate)

- Lead with the business outcome or key message — never bury it.
- Use **KPI callout boxes** for key metrics (e.g., "3× ROI", "$2M saved").
- For solution slides: problem on the left, solution on the right.
- For timeline slides: use a horizontal swim-lane or milestone track.
- For case study slides: client logo + challenge + approach + outcome (4-quadrant or top-to-bottom flow).
- 16:9 widescreen by default. Ask the user if the deck will be projected at a known venue with a different ratio.

---

## Corporate Mode: Required Slides by Deck Type

### Solution Proposal
1. Title slide (client name, proposal title, date, your company)
2. **Executive Summary** (one-slide overview: problem, proposed solution, headline outcome)
3. Understanding the Challenge (situate the client's problem — show you listened)
4. Proposed Solution / Approach (architecture diagram or methodology visual)
5. How It Works (optional deep-dive, 1–2 slides)
6. Case Study / Proof of Concept (comparable prior engagement or reference client)
7. Timeline / Implementation Roadmap
8. Team & Credentials (for external decks)
9. Investment / Pricing (if appropriate)
10. **Next Steps / CTA** (specific, time-bound ask)
11. Appendix (technical specs, risk register, detailed pricing, FAQ)

### Sales Pitch
1. Title slide
2. The Problem (paint the pain — make it vivid and specific)
3. Why Now (urgency frame — market shift, regulatory change, cost of delay)
4. Our Solution (one crisp statement + visual)
5. Proof (metrics, logos, case study snippet)
6. How We Work Together (onboarding, process, timeline)
7. **Next Steps / CTA**
8. Appendix

### Strategy / Roadmap
1. Title slide
2. **Executive Summary** (situation, key decisions, recommended direction)
3. Current State / Baseline (where we are today)
4. Strategic Goals (what success looks like in 12–24 months)
5. Strategic Options Considered (show you evaluated alternatives)
6. Recommended Approach (rationale, trade-offs)
7. Roadmap (timeline with phases and milestones)
8. Resource & Investment Requirements
9. Risks & Mitigation
10. **Next Steps / CTA**
11. Appendix

---

## Corporate Mode: QA Checklist

```
Corporate QA checklist:
□ Deck type identified; correct template structure applied
□ Client brand color applied consistently (or clean corporate default used)
□ Executive Summary present (one slide, self-sufficient)
□ Every slide title is a headline statement (outcome or key message), not a topic label
□ No bullet-wall slides — maximum 5 bullets, ~30 words of body text per slide
□ At least one visual exhibit per 2 slides (diagram, chart, table, timeline, or callout)
□ Case study / proof slide present for external decks
□ Architecture diagram or solution visual present for solution proposals
□ Timeline / roadmap slide present for strategy and proposal decks
□ "Next Steps / CTA" is the last main slide — specific, time-bound, owner assigned
□ Appendix present with supporting detail
□ CTA on the final slide is concrete (not "let us know if you have questions")
□ No generic filler slides (no "About Us" walls of text, no "Thank You" as last slide)
□ Audience-appropriate depth and vocabulary applied throughout
□ If named client: client name and context used consistently
```

---

## Academic Mode (unchanged)

### Step 1: Identify Presentation Type

**Structured Argument (default):** conference papers, seminar talks, thesis defenses, dissertation chapters, grant briefings, internal lab presentations, policy briefings.

**Priority order: argument structure → data → layout → aesthetics.**

**Visual / Narrative:** public engagement talks, science communication, funding pitches to lay panels.

### Step 2: Plan the Deck

Produce a slide-by-slide outline and confirm with the user if the deck is > 10 slides. Use the ghost deck test: action titles alone must tell the complete argument.

### Step 3: Design Standards

- White background for all content slides.
- Single sans-serif font (Arial, Calibri, or Helvetica).
- Max three colors: dark navy primary (`1F4E79`), mid-blue accent (`2E75B6`), white background.
- No decorative gradients, no icons, no clip art.
- Max ~40 words of body text per slide. Body text ≥ 20 pt.

### Step 4: Build and QA

```
Academic QA checklist:
□ Every content slide has an action title (complete sentence stating the takeaway)
□ Ghost deck test passes (action titles alone tell the full argument)
□ One exhibit per results slide; key finding annotated directly on the chart
□ Every borrowed figure or data point has an in-slide citation
□ References slide exists at the end
□ Conclusions slide is the last non-appendix slide (not "Thank You" or blank)
□ Contact info / QR code on final slide
□ Body text ≥ 20 pt throughout
□ No decorative elements
□ Section dividers or breadcrumb bar present for decks > 15 slides
```

---

## Anti-Patterns (Both Modes — Never Do These)

- **Generic slides with no clear message** — every slide must earn its place with a specific point.
- **Weak or missing CTA** — corporate decks must end with a concrete, time-bound next step.
- **No storytelling** — information without a narrative arc loses the audience. Always pick a spine (SCR, funnel, answer-first, or problem-solution-proof).
- **Audience mismatch** — never write for a generic audience; always calibrate depth and vocabulary to who is in the room.
- **Bullet-wall slides** — if the audience is reading, they are not listening.
- **"Thank You" as the final slide** — end on conclusions (academic) or Next Steps/CTA (corporate).

---

## Cleanup (Temporary Files)

When creating a `.pptx` file, Claude writes a temporary PptxGenJS script (e.g., `create_presentation.js` or similar) and executes it with `node`. **This file is temporary and must be deleted automatically after the `.pptx` is confirmed to exist.**

After every successful `.pptx` generation, run:

```bash
rm <script_name>.js
```

**Rules:**
- Only delete the `.js` file **after** confirming the `.pptx` was created and is non-empty (`ls -lh <output>.pptx`).
- If the script fails and no `.pptx` is produced, **keep** the `.js` file so the user can inspect and debug it.
- Never delete the `.pptx`, any supporting assets, or any user-provided files.

---

## Dependencies

- `pip install "markitdown[pptx]"` — text extraction for QA
- `npm install -g pptxgenjs` — creating .pptx from scratch
- LibreOffice (`soffice`) — PDF conversion
- Poppler (`pdftoppm`) — PDF to images
