# Storm Research

Turn any topic into a verified, multi-perspective HTML research briefing. The skill simulates five expert lenses (Practitioner, Academic, Skeptic, Economist, Historian), maps where they contradict each other, synthesizes everything into a self-contained HTML report, then adversarially peer-reviews its own output and verifies every citation against its primary source before delivering.

## Target Audience

Decision-makers, researchers, analysts, or anyone who needs a fact-checked, multi-viewpoint briefing where blind spots and source quality matter.

## Pipeline

```
Phase 0: Scope
  → Phase 1: 5 parallel expert agents
    → Phase 2: Contradiction map
      → Phase 3: Synthesize HTML report
        → Phase 4: Peer review + citation verification
```

## Output

A self-contained HTML report (`storm-reports/{topic-slug}-briefing.html`) including:

- **60-second executive summary** — lead with the settled fact, then the contested interpretation
- **5 key findings ranked by reliability** with confidence scores (1–10)
- **Supported-by / Challenged-by evidence chips** per finding (drawn from contradiction map)
- **Hidden connection** — the non-obvious link that only appears across all five lenses
- **Missing 6th lens** — the blind spot that could change conclusions
- **Actionable insights** — 3–6 specific moves for the reader's role
- **Claim safety guide** — assert / caveat / avoid, based on verification verdicts
- **Frontier question** — the single question that would change everything
- **Full references** with per-citation verification status tags (CONFIRMED / PARTIALLY CONFIRMED / UNVERIFIED / FALSE)

## Key Features

- **~9–11 agents per run** — 5 expert lenses + ~4–6 citation verifier clusters
- **Real research only** — every claim must trace to a real, fetched source
- **Mandatory adversarial Phase 4** — report is not delivered until citations are verified
- **Confidence scores** based on source hierarchy: peer-reviewed causal > official policy/financial data > single commissioned survey > analogy > preprint
- **Cross-platform opener** — macOS `open`, Linux `xdg-open`, Windows `start`
- **Self-disclosed methodology** — the panel is author-built; convergence is strong hypothesis, not independent consensus

## Trigger Phrases

- `storm research this: [topic]`
- `storm report on [topic]`
- `give me a STORM briefing on [topic]`
- `run the STORM method on [topic]`
- `multi-perspective research on [topic]`

## Installation

```bash
npx skills add devenkhatri/all-agent-skills-repo/storm-research
```

## Files

```
storm-research/
├── SKILL.md               # Main skill instructions (4-phase pipeline + verification guardrails)
├── README.md              # This file
└── report-template.html   # HTML report template (clone and fill — do not rebuild CSS)
```

## Portability

This skill is self-contained. It depends only on built-in Claude Code tools (`Agent` with `general-purpose`, `Write`, and web search/fetch used inside agents) plus `report-template.html` in this same folder. No external scripts, APIs, paid services, or other skills are required. Drop the folder into any `.claude/skills/` directory and it works.

## Cost Note

This is a heavyweight skill — it spawns ~9–11 agents per run. That is expected and is the point. Do not use it for simple factual lookups; use it when multiple viewpoints and fact-checked claims genuinely matter.
