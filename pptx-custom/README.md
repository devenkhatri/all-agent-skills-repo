# pptx-custom: Presentations Skill for Claude (Academic + Corporate)

A Claude Skill for creating high-quality presentations in two modes:
- **Academic** — conference talks, seminar slides, thesis defenses, grant briefings
- **Corporate** — solution proposals, sales pitches, strategy decks, executive briefings, business cases, QBRs, capability showcases, and more

Also includes a PDF summarising general academic presentation advice (no Claude required).

## What It Does

This skill overrides Claude's default design-forward presentation style and replaces it with the right standards for the context — communication-first for academic, and business-outcome-first for corporate.

### Academic Mode
When active for academic presentations, Claude will:
- Write every slide title as a **complete sentence stating the takeaway** (action title), not a topic label
- Structure the deck as a **logical argument** (situation → complication → resolution)
- Apply the **ghost deck test**: action titles alone must tell the full story
- Place **one exhibit per results slide** and annotate the key finding directly on the chart
- Apply **citation standards**: in-text citations on every borrowed figure, a References slide at the end
- End on a **Conclusions slide** that stays on screen during Q&A

### Corporate Mode
When active for corporate presentations, Claude will:
- **Ask for the client's brand color** before building (or use a clean corporate palette)
- **Offer 2–3 structure options** and let you pick before creating any slides
- **Detect the deck type** (proposal, pitch, strategy, QBR, etc.) and apply the right slide architecture automatically
- Select the **visual style** (Premium/dark, Clean Corporate, or McKinsey analytical) based on the deck type and audience
- Write every slide title as a **business headline** (outcome, recommendation, or insight — never a topic label)
- Always include an **Executive Summary**, a **Next Steps / CTA** slide with a specific, time-bound ask, and an **Appendix**
- Include the key exhibits you need: **architecture diagrams**, **timelines with responsibility splits**, and **case studies with quantified outcomes**
- **Remember named client context** within a session so the deck stays consistent

## Installation

1. Download this repository as a zip file (click **Code → Download ZIP** above)
2. In [claude.ai](https://claude.ai), go to **Customize → Skills**
3. Upload the zip file
4. Confirm the skill appears in your skills list and is toggled on

> **Requirement:** Code execution and file creation must be enabled in **Settings → Capabilities**.

## Usage

Just ask naturally:

**Academic:**
- *"Make slides for my conference paper on X"*
- *"Build a deck for my thesis defense"*
- *"Create a seminar presentation about my research on Y"*

**Corporate:**
- *"Create a solution proposal for Acme Corp around our AI platform"*
- *"Build a sales pitch deck for the fintech market"*
- *"Make a strategy deck for our Q3 roadmap review"*
- *"Put together an executive briefing on the migration project"*
- *"Build a capability showcase for our data engineering practice"*

Claude will detect the context, load the appropriate mode, and apply all guidelines before generating any slides. You do not need to give special instructions.

This skill works alongside Anthropic's built-in PPTX skill, which handles the technical file generation.

## File Structure

```
pptx-custom/
├── SKILL.md                  # Entry point: mode detection, routing logic, design systems
├── content_guidelines.md     # Academic + Corporate content and narrative guidelines
├── slide_patterns.md         # Per-slide-type implementation patterns with PptxGenJS code
└── README.md                 # This file
```

## Background

The guidelines in this skill draw on:
- Barbara Minto's *Pyramid Principle* (structured argument, action titles, answer-first)
- Naegle (2021), "Ten simple rules for effective presentation slides," *PLOS Computational Biology*
- Standard consulting and academic presentation practice (McKinsey, conference norms)
- Community feedback on Claude's default presentation behaviour in professional contexts

## License

MIT — free to use, adapt, and share.
