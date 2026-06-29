# Slide Patterns (Academic + Corporate)

Implementation patterns for each required slide type. Use with `pptxgenjs.md` for the technical API.

All coordinates assume `LAYOUT_16x9` (10" × 5.625"). Adjust proportionally for other layouts.

---

## Global Defaults

Apply these to every slide in an academic deck:

```javascript
const COLORS = {
  bg:       "FFFFFF",   // White background
  primary:  "1F4E79",   // Dark navy — titles
  accent:   "2E75B6",   // Mid-blue — headers, highlights
  body:     "2D2D2D",   // Near-black — body text
  muted:    "777777",   // Gray — citations, captions
  rule:     "CCCCCC",   // Light gray — divider lines
  highlight:"FFF2CC",   // Yellow — callout boxes (use sparingly)
};

const FONTS = {
  face: "Arial",         // Single typeface throughout
  title: 26,             // Action title: 24–28 pt
  sectionHeader: 22,     // Within-slide section headers
  body: 20,              // Body bullets: 20 pt minimum
  label: 16,             // Chart annotations, inline labels
  cite: 13,              // In-slide citations, footnotes
};

const MARGIN = 0.5;      // Minimum margin from slide edge (inches)
```

---

## 1. Title Slide

**Purpose:** Establish the presentation; give the audience complete attribution.

```javascript
// Dark background treatment — one of the few places for it
slide.background = { color: COLORS.primary };

// Main title — framed as a statement or question
slide.addText("Treatment effect of early childhood interventions\npersists into adulthood across all income quartiles", {
  x: 0.7, y: 1.4, w: 8.6, h: 1.8,
  fontSize: 32, fontFace: FONTS.face, color: "FFFFFF",
  bold: true, align: "left", valign: "top"
});

// Subtitle / conference context
slide.addText("Annual Conference of the Society for Labor Economics  ·  May 2025", {
  x: 0.7, y: 3.2, w: 8.6, h: 0.4,
  fontSize: 16, fontFace: FONTS.face, color: "A0BBDD",
  align: "left"
});

// Author and affiliation
slide.addText("Jane Smith¹  ·  John Doe²\n¹ University of X   ²aboratory for Y", {
  x: 0.7, y: 3.7, w: 8.6, h: 0.6,
  fontSize: 15, fontFace: FONTS.face, color: "CADCFC",
  align: "left"
});

// Thin accent rule above author block
slide.addShape(pres.shapes.RECTANGLE, {
  x: 0.7, y: 3.6, w: 2.0, h: 0.04,
  fill: { color: COLORS.accent }, line: { color: COLORS.accent }
});
```

**Do not include:** Decorative images, animated logos, institution crests (unless explicitly requested), clip art.

---

## 2. Motivation / Context Slide

**Purpose:** Establish the situation and complication — why this question matters and what's missing.

Layout: Two-column (context left, gap/problem right) or single-column narrative. Use single-column for most conference talks.

```javascript
// Action title
slide.addText("Existing interventions show strong short-run effects but evidence on persistence is sparse", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.8,
  fontSize: FONTS.title, fontFace: FONTS.face, color: COLORS.primary, bold: true, valign: "top"
});

// Thin divider under title
slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 1.0, w: 9.0, h: 0.025,
  fill: { color: COLORS.rule }
});

// Body bullets
slide.addText([
  { text: "Short-run gains well established: ", options: { bold: true, breakLine: false } },
  { text: "meta-analyses confirm positive effects at ages 5–8 (Heckman et al. 2013).", options: { breakLine: true } },
  { text: "Long-run evidence is scarce: ", options: { bold: true, breakLine: false } },
  { text: "only 3 RCTs track outcomes past age 25; none cover lower-income countries.", options: { breakLine: true } },
  { text: "Mechanism is unresolved: ", options: { bold: true, breakLine: false } },
  { text: "cognitive vs. non-cognitive channels remain debated (see Appendix A).", options: { breakLine: true } },
], {
  x: MARGIN, y: 1.1, w: 9.0, h: 3.2,
  fontSize: FONTS.body, fontFace: FONTS.face, color: COLORS.body,
  bullet: true, paraSpaceAfter: 12
});

// In-slide citation
slide.addText("Heckman et al. (2013), Science; Cunha & Heckman (2007), AER", {
  x: MARGIN, y: 5.1, w: 9.0, h: 0.35,
  fontSize: FONTS.cite, fontFace: FONTS.face, color: COLORS.muted, align: "left"
});
```

---

## 3. Research Question Slide

**Purpose:** Give the audience the anchor they need to evaluate everything that follows. This slide must exist on its own.

```javascript
// Action title
slide.addText("This paper asks: do early childhood effects persist to age 35,\nand through which channels?", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.9,
  fontSize: FONTS.title, fontFace: FONTS.face, color: COLORS.primary, bold: true
});

// Divider
slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 1.1, w: 9.0, h: 0.025, fill: { color: COLORS.rule }
});

// Research question in a prominent callout box
slide.addShape(pres.shapes.ROUNDED_RECTANGLE, {
  x: 1.5, y: 1.4, w: 7.0, h: 1.6,
  fill: { color: "EBF3FA" }, line: { color: COLORS.accent, pt: 1.5 }, rectRadius: 0.1
});

slide.addText("Do effects of the X program on cognitive and socio-emotional skills\nat age 8 persist to age 35 outcomes (earnings, health, crime),\nand does the pathway run through skills or through schooling attainment?", {
  x: 1.7, y: 1.55, w: 6.6, h: 1.3,
  fontSize: 19, fontFace: FONTS.face, color: COLORS.primary,
  bold: false, align: "center", valign: "middle"
});

// Optional: brief note on what makes this paper's approach novel
slide.addText([
  { text: "Contribution: ", options: { bold: true, breakLine: false } },
  { text: "First study to follow a randomized cohort from ages 3–5 to 35; administrative earnings and health records linked to original experimental data.", options: {} }
], {
  x: MARGIN, y: 3.2, w: 9.0, h: 1.0,
  fontSize: FONTS.body, fontFace: FONTS.face, color: COLORS.body
});
```

---

## 4. Methods Slide

**Purpose:** Give the audience what they need to evaluate the findings — not procedural completeness.

Target: 1–2 slides. Move all detail the audience doesn't need to Appendix.

```javascript
// Action title
slide.addText("Regression discontinuity exploits a sharp household income threshold\nfor program eligibility — treatment is as-good-as-random near the cutoff", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.9,
  fontSize: FONTS.title, fontFace: FONTS.face, color: COLORS.primary, bold: true
});

// Divider
slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 1.1, w: 9.0, h: 0.025, fill: { color: COLORS.rule }
});

// Two-column: design on left, key variables on right
// Left column header
slide.addText("Design", {
  x: MARGIN, y: 1.25, w: 4.2, h: 0.35,
  fontSize: FONTS.sectionHeader, fontFace: FONTS.face, color: COLORS.accent, bold: true
});

slide.addText([
  { text: "Cohort: ", options: { bold: true, breakLine: false } },
  { text: "2,400 children born 1985–90 in three counties", options: { breakLine: true } },
  { text: "Assignment: ", options: { bold: true, breakLine: false } },
  { text: "income < 185% FPL at age 3 → eligible (N = 1,150)", options: { breakLine: true } },
  { text: "Follow-up: ", options: { bold: true, breakLine: false } },
  { text: "ages 5, 8, 18, 25, 35 — admin records linked", options: { breakLine: true } },
], {
  x: MARGIN, y: 1.65, w: 4.2, h: 2.4,
  fontSize: FONTS.body, fontFace: FONTS.face, color: COLORS.body,
  bullet: true, paraSpaceAfter: 10
});

// Right column header
slide.addText("Key outcomes", {
  x: 5.3, y: 1.25, w: 4.2, h: 0.35,
  fontSize: FONTS.sectionHeader, fontFace: FONTS.face, color: COLORS.accent, bold: true
});

slide.addText([
  { text: "Primary: ", options: { bold: true, breakLine: false } },
  { text: "age-35 earnings (log), employment", options: { breakLine: true } },
  { text: "Secondary: ", options: { bold: true, breakLine: false } },
  { text: "health index, criminal record indicator", options: { breakLine: true } },
  { text: "Mechanism: ", options: { bold: true, breakLine: false } },
  { text: "cognitive score age 8, years of schooling", options: { breakLine: true } },
], {
  x: 5.3, y: 1.65, w: 4.2, h: 2.4,
  fontSize: FONTS.body, fontFace: FONTS.face, color: COLORS.body,
  bullet: true, paraSpaceAfter: 10
});

// Appendix pointer
slide.addText("Full identification assumptions and robustness checks → Appendix B", {
  x: MARGIN, y: 5.1, w: 9.0, h: 0.35,
  fontSize: FONTS.cite, fontFace: FONTS.face, color: COLORS.muted, align: "left"
});
```

---

## 5. Results Slide

**Purpose:** Present one finding, make it impossible to miss.

Layout: Figure left (~5.5"), interpretive text right (~3.5"). Action title states the result.

```javascript
// Action title — MUST state the finding, not just the topic
slide.addText("Treated children earn 18% more at age 35 — effect is largest in the bottom income quartile", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.85,
  fontSize: FONTS.title, fontFace: FONTS.face, color: COLORS.primary, bold: true
});

// Divider
slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 1.05, w: 9.0, h: 0.025, fill: { color: COLORS.rule }
});

// FIGURE (left side) — rebuilt from paper, not copy-pasted
// Replace with actual chart or image
slide.addChart(pres.charts.BAR, [{
  name: "Treatment effect (%)",
  labels: ["Q1 (lowest)", "Q2", "Q3", "Q4 (highest)"],
  values: [28, 22, 15, 8]
}], {
  x: MARGIN, y: 1.15, w: 5.4, h: 3.8,
  barDir: "col",
  chartColors: [COLORS.accent],
  chartArea: { fill: { color: COLORS.bg } },
  catAxisLabelColor: COLORS.muted,
  valAxisLabelColor: COLORS.muted,
  valGridLine: { color: "E2E8F0", size: 0.5 },
  catGridLine: { style: "none" },
  showValue: true,
  dataLabelColor: "1E293B",
  showLegend: false,
  valAxisTitle: "Log earnings effect (%)",
  showValAxisTitle: true,
  valAxisTitleColor: COLORS.muted,
  valAxisTitleFontSize: 12,
});

// KEY FINDING ANNOTATION — tell the audience exactly what to see
// (In practice, add a call-out arrow/box over the chart image or use addText overlay)
slide.addShape(pres.shapes.ROUNDED_RECTANGLE, {
  x: 0.55, y: 1.2, w: 1.8, h: 0.5,
  fill: { color: COLORS.highlight }, line: { color: "E6C800", pt: 1 }, rectRadius: 0.06
});
slide.addText("↑ 28% for Q1", {
  x: 0.55, y: 1.2, w: 1.8, h: 0.5,
  fontSize: 14, fontFace: FONTS.face, color: "7A5200", bold: true, align: "center", valign: "middle"
});

// INTERPRETIVE TEXT (right side)
slide.addText("What to take away", {
  x: 6.2, y: 1.15, w: 3.3, h: 0.35,
  fontSize: FONTS.sectionHeader, fontFace: FONTS.face, color: COLORS.accent, bold: true
});

slide.addText([
  { text: "Average effect: 18% earnings gain (p < 0.001)", options: { breakLine: true } },
  { text: "Heterogeneity: effects are 3.5× larger for Q1 vs Q4", options: { breakLine: true } },
  { text: "Precision: 95% CI = [14%, 22%] for pooled estimate", options: { breakLine: true } },
], {
  x: 6.2, y: 1.55, w: 3.3, h: 2.5,
  fontSize: FONTS.body - 1, fontFace: FONTS.face, color: COLORS.body,
  bullet: true, paraSpaceAfter: 12
});

// In-slide citation
slide.addText("Administrative earnings records, Social Security Administration (accessed 2024)", {
  x: MARGIN, y: 5.15, w: 9.0, h: 0.3,
  fontSize: FONTS.cite, fontFace: FONTS.face, color: COLORS.muted
});
```

**Critical checks for results slides:**
- Action title states the finding, not the topic
- Key result is annotated directly on the chart (arrow, box, highlight, or call-out label)
- Source cited at the bottom
- No second chart or second finding on the same slide

---

## 6. Discussion / Implications Slide

**Purpose:** Interpret the findings; connect back to the opening question; address the main limitation.

```javascript
// Action title
slide.addText("Results support a skill-formation pathway: the earnings effect is fully mediated\nby cognitive scores at age 8, not by schooling attainment", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.9,
  fontSize: FONTS.title, fontFace: FONTS.face, color: COLORS.primary, bold: true
});

// Divider
slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 1.1, w: 9.0, h: 0.025, fill: { color: COLORS.rule }
});

// Interpretation
slide.addText("Interpretation", {
  x: MARGIN, y: 1.2, w: 9.0, h: 0.35,
  fontSize: FONTS.sectionHeader, fontFace: FONTS.face, color: COLORS.accent, bold: true
});

slide.addText([
  { text: "Consistent with Cunha-Heckman (2007) skill complementarity: early investment compounds through the schooling years.", options: { breakLine: true } },
  { text: "Schooling channel: coefficient falls to zero when conditioning on age-8 cognitive score (mediation analysis, Appendix C).", options: { breakLine: true } },
], {
  x: MARGIN, y: 1.6, w: 9.0, h: 1.3,
  fontSize: FONTS.body, fontFace: FONTS.face, color: COLORS.body,
  bullet: true, paraSpaceAfter: 10
});

// Main limitation — address it directly
slide.addText("Main limitation", {
  x: MARGIN, y: 3.0, w: 9.0, h: 0.35,
  fontSize: FONTS.sectionHeader, fontFace: FONTS.face, color: COLORS.accent, bold: true
});

slide.addText([
  { text: "External validity: ", options: { bold: true, breakLine: false } },
  { text: "program was implemented in three U.S. counties; generalizability to other settings requires caution.", options: { breakLine: true } },
  { text: "Partial identification: ", options: { bold: true, breakLine: false } },
  { text: "earnings records unavailable for 11% of cohort (attrition analysis → Appendix D).", options: { breakLine: true } },
], {
  x: MARGIN, y: 3.4, w: 9.0, h: 1.3,
  fontSize: FONTS.body, fontFace: FONTS.face, color: COLORS.body,
  bullet: true, paraSpaceAfter: 10
});
```

---

## 7. Conclusions Slide

**Purpose:** Restate the 2–4 key takeaways. **This slide stays on screen for the entire Q&A.**

Do not follow it with "Thank You," a blank slide, or a transition to appendix slides during Q&A.

```javascript
// Dark background treatment — mirrors the title slide (sandwich structure)
slide.background = { color: COLORS.primary };

// "Conclusions" label
slide.addText("Conclusions", {
  x: MARGIN, y: 0.25, w: 9.0, h: 0.45,
  fontSize: 20, fontFace: FONTS.face, color: "A0BBDD", bold: false, align: "left"
});

// Accent rule
slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 0.7, w: 9.0, h: 0.04, fill: { color: COLORS.accent }
});

// Key takeaways — numbered for easy reference during Q&A
slide.addText([
  { text: "1. Early childhood effects are persistent: ", options: { bold: true, breakLine: false } },
  { text: "a significant earnings premium is detectable at age 35, 30 years after treatment.", options: { breakLine: true, breakLine: true } },
  { text: "2. Effects are largest for the most disadvantaged: ", options: { bold: true, breakLine: false } },
  { text: "the Q1 earnings premium (28%) is 3.5× the Q4 effect (8%).", options: { breakLine: true, breakLine: true } },
  { text: "3. The pathway is cognitive, not schooling-mediated: ", options: { bold: true, breakLine: false } },
  { text: "consistent with skill complementarity models.", options: { breakLine: true } },
], {
  x: MARGIN, y: 0.85, w: 9.0, h: 3.5,
  fontSize: FONTS.body + 1, fontFace: FONTS.face, color: "FFFFFF",
  paraSpaceAfter: 20
});

// Contact + link
slide.addText("jane.smith@university.edu  |  Working paper: bit.ly/smith2025", {
  x: MARGIN, y: 4.8, w: 7.0, h: 0.4,
  fontSize: 14, fontFace: FONTS.face, color: "A0BBDD", align: "left"
});

// Optional QR code (add as image)
// slide.addImage({ path: "qr_preprint.png", x: 8.5, y: 4.5, w: 0.9, h: 0.9 });
```

---

## 8. Section Divider (for decks > 15 slides)

**Purpose:** Orient the audience at the start of each major section.

```javascript
// Use same dark treatment as title/conclusions
slide.background = { color: "1A3A5C" };  // Slightly lighter navy for variety

// Section number / label
slide.addText("Part 2", {
  x: MARGIN, y: 1.8, w: 9.0, h: 0.4,
  fontSize: 16, fontFace: FONTS.face, color: "7BAFD4", bold: false, align: "left"
});

// Section title
slide.addText("Empirical Strategy", {
  x: MARGIN, y: 2.2, w: 9.0, h: 1.0,
  fontSize: 36, fontFace: FONTS.face, color: "FFFFFF", bold: true, align: "left"
});

// Accent rule
slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 3.3, w: 2.5, h: 0.06, fill: { color: COLORS.accent }
});
```

---

## 9. Breadcrumb Bar (optional, for long talks)

A persistent header strip showing the current section. Add to every content slide for talks > 15 minutes.

```javascript
// Add to each slide after the title/divider set
const sections = ["Motivation", "Data", "Strategy", "Results", "Discussion"];
const currentSection = "Results";  // Changes per slide

const barY = 0.0;
const barH = 0.28;

// Background bar
slide.addShape(pres.shapes.RECTANGLE, {
  x: 0, y: barY, w: 10, h: barH,
  fill: { color: "F0F4F8" }, line: { color: "F0F4F8" }
});

// Section labels
const sectionW = 10 / sections.length;
sections.forEach((section, i) => {
  const isActive = section === currentSection;
  slide.addText(section, {
    x: i * sectionW, y: barY, w: sectionW, h: barH,
    fontSize: 10, fontFace: FONTS.face,
    color: isActive ? COLORS.accent : COLORS.muted,
    bold: isActive,
    align: "center", valign: "middle"
  });
  // Active section underline
  if (isActive) {
    slide.addShape(pres.shapes.RECTANGLE, {
      x: i * sectionW + sectionW * 0.1, y: barY + barH - 0.04, w: sectionW * 0.8, h: 0.04,
      fill: { color: COLORS.accent }
    });
  }
});

// Shift all other content down by barH to avoid collision
// (adjust y coordinates in the rest of the slide by +barH)
```

---

## 10. References Slide

**Purpose:** Complete citations for all sources cited in the deck. Required.

```javascript
slide.background = { color: COLORS.bg };

slide.addText("References", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.5,
  fontSize: 24, fontFace: FONTS.face, color: COLORS.primary, bold: true
});

slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 0.72, w: 9.0, h: 0.025, fill: { color: COLORS.rule }
});

const refs = [
  "Cunha, F. & Heckman, J.J. (2007). The Technology of Skill Formation. American Economic Review, 97(2), 31–47.",
  "Heckman, J.J., Moon, S.H., Pinto, R., Savelyev, P.A., & Yavitz, A. (2013). The Rate of Return to the HighScope Perry Preschool Program. Journal of Public Economics, 94(1), 114–128.",
  "Smith, J. & Doe, J. (2025). Long-Run Returns to Early Childhood Intervention: Evidence from a Randomized Trial. Working paper.",
];

const refItems = refs.flatMap((r, i) => [
  { text: r, options: { breakLine: true } },
  ...(i < refs.length - 1 ? [{ text: "", options: { breakLine: true } }] : [])
]);

slide.addText(refItems, {
  x: MARGIN, y: 0.85, w: 9.0, h: 4.5,
  fontSize: 13, fontFace: FONTS.face, color: COLORS.body,
  paraSpaceAfter: 8
});
```

---

## 11. Appendix Slide

**Purpose:** Pre-built answer slides. Label clearly so they can be navigated to quickly during Q&A.

```javascript
// Appendix label — muted to distinguish from main deck
slide.addText("Appendix B — Robustness Checks", {
  x: MARGIN, y: 0.15, w: 9.0, h: 0.4,
  fontSize: 14, fontFace: FONTS.face, color: COLORS.muted, bold: false, italics: true
});

// Action title (still required — appendix slides also use action titles)
slide.addText("Earnings effect is stable across bandwidth choices and polynomial specifications", {
  x: MARGIN, y: 0.6, w: 9.0, h: 0.75,
  fontSize: FONTS.title - 2, fontFace: FONTS.face, color: COLORS.primary, bold: true
});

// Content follows normal slide patterns
```

---

## Quick Checks Before Delivery

```
□ Title slide: full title as statement/question, author, affiliation, venue, date
□ Every content slide: action title (complete sentence, states takeaway)
□ Ghost deck test: titles alone tell the complete argument
□ Results slides: one exhibit each, key finding annotated on the chart
□ Every borrowed figure/data point: in-slide citation
□ References slide: complete, consistently formatted
□ Conclusions slide: last main slide, stays on screen during Q&A
□ Contact info / QR code on conclusions or final slide
□ Body text ≥ 20 pt throughout
□ No slide has > ~40 words of body text
□ Appendix slides labeled, with pre-built Q&A answers
□ Deck runs 1–2 minutes under the time limit when practiced aloud
```

---

---

# Corporate Slide Patterns

Implementation patterns for corporate deck types. Use with `pptxgenjs.md` for the full API reference.

All coordinates assume `LAYOUT_16x9` (10" × 5.625").

---

## Corporate Global Defaults

Three preset palettes — select based on deck type and audience (see SKILL.md Style Selection table).

```javascript
// CLEAN CORPORATE (default for proposals, QBRs, strategy decks)
const CORP_CLEAN = {
  bg:        "F8F9FA",
  primary:   "1B2A4A",   // deep navy — titles, headlines
  accent:    "0F6FBF",   // corporate blue — headers, highlights, rules
  body:      "2C3E50",   // dark slate — body text
  muted:     "6C757D",   // gray — footnotes, captions
  highlight: "E8F4FD",   // light blue — callout bg
  cta:       "E63946",   // red — CTA button/emphasis only
  surface:   "FFFFFF",   // card/box background
};

// PREMIUM / DARK (sales pitches, capability showcases)
const CORP_PREMIUM = {
  bg:        "0D1117",
  primary:   "FFFFFF",
  accent:    "6C63FF",   // violet
  secondary: "00D4AA",   // teal
  muted:     "8B949E",
  surface:   "161B22",   // card bg
  rule:      "30363D",
};

// MCKINSEY / ANALYTICAL (business cases, ROI decks, data-heavy strategy)
const CORP_MK = {
  bg:        "FFFFFF",
  primary:   "000000",
  accent:    "CC0000",   // red — highlight only, use sparingly
  body:      "333333",
  muted:     "888888",
  rule:      "DDDDDD",
};

const CORP_FONTS = {
  face:      "Inter",      // preferred; fall back to "Calibri" if unavailable
  headline:  32,           // slide headline / title
  sectionH:  22,           // within-slide section headers
  body:      18,           // body bullets
  kpi:       44,           // KPI / stat callout number
  label:     14,           // chart labels, diagram annotations
  footnote:  12,           // caveats, sources
};

const MARGIN = 0.5;
```

---

## C1. Corporate Title Slide

**Purpose:** Establish context; show the client's name front-and-centre.

```javascript
// Clean Corporate style shown — swap palette for Premium/dark or McKinsey as needed
const C = CORP_CLEAN;  // alias for current palette

slide.background = { color: C.primary };  // dark background on title

// Client name or deck subject (top, smaller)
slide.addText("Prepared for: Acme Corporation", {
  x: MARGIN, y: 0.5, w: 9.0, h: 0.4,
  fontSize: 14, fontFace: CORP_FONTS.face, color: "A0BBDD",
  align: "left"
});

// Main title — the proposal/deck headline, not a topic label
slide.addText("Reducing Operational Overhead by 40%\nThrough Intelligent Process Automation", {
  x: MARGIN, y: 1.1, w: 9.0, h: 2.0,
  fontSize: 36, fontFace: CORP_FONTS.face, color: "FFFFFF",
  bold: true, align: "left", valign: "top"
});

// Accent rule
slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 3.2, w: 3.0, h: 0.05,
  fill: { color: C.accent }
});

// Presenter / company + date
slide.addText("YourCo  ·  June 2025  ·  CONFIDENTIAL", {
  x: MARGIN, y: 3.4, w: 9.0, h: 0.35,
  fontSize: 13, fontFace: CORP_FONTS.face, color: "A0BBDD",
  align: "left"
});
```

**Do not include:** Generic stock imagery, decorative icons, clip art.

---

## C2. Executive Summary Slide

**Purpose:** One-slide brief. A senior executive reads only this slide and understands everything.

Layout: 4-box 2×2 grid. Each box covers one of: Situation, Solution, Outcome, Ask.

```javascript
slide.background = { color: C.bg };

// Headline
slide.addText("Executive Summary", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.5,
  fontSize: CORP_FONTS.headline, fontFace: CORP_FONTS.face,
  color: C.primary, bold: true
});

slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 0.72, w: 9.0, h: 0.04,
  fill: { color: C.accent }
});

// Helper: draw one summary box
const summaryBox = (label, text, x, y, w, h, accentColor) => {
  // Box background
  slide.addShape(pres.shapes.ROUNDED_RECTANGLE, {
    x, y, w, h,
    fill: { color: C.surface },
    line: { color: accentColor, pt: 2 },
    rectRadius: 0.08
  });
  // Box label
  slide.addText(label, {
    x: x + 0.15, y: y + 0.1, w: w - 0.3, h: 0.3,
    fontSize: 11, fontFace: CORP_FONTS.face, color: accentColor,
    bold: true, align: "left"
  });
  // Box content
  slide.addText(text, {
    x: x + 0.15, y: y + 0.42, w: w - 0.3, h: h - 0.55,
    fontSize: 14, fontFace: CORP_FONTS.face, color: C.body,
    align: "left", valign: "top", wrap: true
  });
};

summaryBox(
  "SITUATION",
  "Acme's finance team spends 120 hrs/month on manual reconciliation across 6 legacy systems — error rate is 8%, causing audit delays.",
  MARGIN, 0.85, 4.35, 2.1, C.accent
);
summaryBox(
  "SOLUTION",
  "YourCo will deploy an AI-powered reconciliation layer that connects all 6 systems via API — no rip-and-replace.",
  5.15, 0.85, 4.35, 2.1, C.accent
);
summaryBox(
  "OUTCOME",
  "70% reduction in manual effort. Error rate < 0.5%. Break-even at month 7. Full ROI in year 1.",
  MARGIN, 3.1, 4.35, 2.1, "1B7A4A"  // green for positive outcome
);
summaryBox(
  "NEXT STEP",
  "Confirm Phase 1 scope by July 15 to begin onboarding in August.",
  5.15, 3.1, 4.35, 2.1, C.cta
);
```

---

## C3. Solution / Architecture Slide

**Purpose:** Show *how* the solution works — not just what it is.

```javascript
slide.background = { color: C.bg };

slide.addText("Our integration layer connects all 6 systems without replacing existing infrastructure", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.8,
  fontSize: CORP_FONTS.headline - 4, fontFace: CORP_FONTS.face,
  color: C.primary, bold: true
});

slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 1.0, w: 9.0, h: 0.04, fill: { color: C.accent }
});

// NOTE: For architecture diagrams, generate the diagram as an image (PNG/SVG)
// using a diagramming tool (draw.io, Lucidchart, Mermaid) and add it:
slide.addImage({
  path: "./architecture_diagram.png",
  x: MARGIN, y: 1.15, w: 9.0, h: 3.8
});

// Annotation callout — highlight the key integration point
slide.addShape(pres.shapes.ROUNDED_RECTANGLE, {
  x: 4.2, y: 1.4, w: 2.6, h: 0.5,
  fill: { color: "FFF3CD" }, line: { color: "FFC107", pt: 1.5 }, rectRadius: 0.06
});
slide.addText("← Zero-touch sync every 15 min", {
  x: 4.25, y: 1.42, w: 2.5, h: 0.45,
  fontSize: 12, fontFace: CORP_FONTS.face, color: "856404", bold: true,
  align: "center", valign: "middle"
});

// Diagram caption / source
slide.addText("YourCo reference architecture v2.3  ·  Simplified for client review", {
  x: MARGIN, y: 5.2, w: 9.0, h: 0.3,
  fontSize: CORP_FONTS.footnote, fontFace: CORP_FONTS.face, color: C.muted
});
```

**Architecture diagram rules:**
- Always annotate the diagram; never show an unlabelled box diagram.
- Client's existing environment: use the `C.highlight` color tint.
- Your solution layer: use the `C.accent` color.
- Move full technical spec to the appendix.

---

## C4. KPI / Metric Callout Slide

**Purpose:** When 2–4 numbers *are* the story — lead with them at impact size.

```javascript
slide.background = { color: C.bg };

slide.addText("The business impact is measurable from day one", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.6,
  fontSize: CORP_FONTS.headline - 2, fontFace: CORP_FONTS.face,
  color: C.primary, bold: true
});

slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 0.82, w: 9.0, h: 0.04, fill: { color: C.accent }
});

// Helper: draw one KPI tile
const kpiTile = (value, label, context, x) => {
  const tileW = 2.7;
  const tileH = 3.2;
  const tileY = 1.1;

  slide.addShape(pres.shapes.ROUNDED_RECTANGLE, {
    x, y: tileY, w: tileW, h: tileH,
    fill: { color: C.surface }, line: { color: C.accent, pt: 1.5 }, rectRadius: 0.1
  });
  // KPI number
  slide.addText(value, {
    x, y: tileY + 0.35, w: tileW, h: 1.1,
    fontSize: CORP_FONTS.kpi, fontFace: CORP_FONTS.face, color: C.accent,
    bold: true, align: "center"
  });
  // KPI label
  slide.addText(label, {
    x: x + 0.1, y: tileY + 1.55, w: tileW - 0.2, h: 0.65,
    fontSize: 15, fontFace: CORP_FONTS.face, color: C.body,
    align: "center", bold: true
  });
  // Context / baseline
  slide.addText(context, {
    x: x + 0.1, y: tileY + 2.25, w: tileW - 0.2, h: 0.6,
    fontSize: CORP_FONTS.footnote, fontFace: CORP_FONTS.face, color: C.muted,
    align: "center"
  });
};

kpiTile("70%",  "Effort reduction",       "vs. current manual process", 0.5);
kpiTile("<0.5%", "Error rate",            "vs. 8% baseline",            3.65);
kpiTile("Mth 7", "Break-even",            "fully loaded investment",    6.8);

// Source footnote
slide.addText("Source: YourCo analysis based on Acme process audit, May 2025", {
  x: MARGIN, y: 5.2, w: 9.0, h: 0.3,
  fontSize: CORP_FONTS.footnote, fontFace: CORP_FONTS.face, color: C.muted
});
```

---

## C5. Timeline / Roadmap Slide

**Purpose:** Show implementation phases, milestones, and quick wins.

```javascript
slide.background = { color: C.bg };

slide.addText("Phase 1 delivers first value in 8 weeks — full deployment complete by Q3", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.7,
  fontSize: CORP_FONTS.headline - 4, fontFace: CORP_FONTS.face,
  color: C.primary, bold: true
});

slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 0.9, w: 9.0, h: 0.04, fill: { color: C.accent }
});

// Timeline track
const trackY = 2.5;
const trackH = 0.06;
slide.addShape(pres.shapes.RECTANGLE, {
  x: 0.8, y: trackY, w: 8.4, h: trackH,
  fill: { color: C.accent }, line: { color: C.accent }
});

// Phases — each has a start x, width, label, and deliverables
const phases = [
  { label: "Phase 1: Foundation",  duration: "Wks 1–8",  x: 0.8,  w: 2.5,  color: C.accent,
    items: ["API connectors live", "Pilot on 1 system", "✓ Quick win: 20% manual effort saved"] },
  { label: "Phase 2: Scale",       duration: "Wks 9–18", x: 3.5,  w: 2.8,  color: "1B5E20",
    items: ["All 6 systems connected", "Automated reconciliation live", "Dashboards deployed"] },
  { label: "Phase 3: Optimise",    duration: "Wks 19–26",x: 6.5,  w: 2.7,  color: "4A148C",
    items: ["ML anomaly detection", "Full audit trail", "Handover & training"] },
];

phases.forEach(ph => {
  // Phase bar above track
  slide.addShape(pres.shapes.ROUNDED_RECTANGLE, {
    x: ph.x, y: trackY - 1.25, w: ph.w - 0.1, h: 1.1,
    fill: { color: ph.color + "22" },  // semi-transparent fill
    line: { color: ph.color, pt: 1.5 }, rectRadius: 0.06
  });
  // Phase label
  slide.addText(`${ph.label}\n${ph.duration}`, {
    x: ph.x + 0.08, y: trackY - 1.2, w: ph.w - 0.2, h: 0.45,
    fontSize: 11, fontFace: CORP_FONTS.face, color: ph.color,
    bold: true, align: "left"
  });
  // Deliverables
  slide.addText(ph.items.map(i => ({ text: i, options: { breakLine: true } })), {
    x: ph.x + 0.08, y: trackY - 0.75, w: ph.w - 0.2, h: 0.55,
    fontSize: 9.5, fontFace: CORP_FONTS.face, color: C.body,
    align: "left"
  });
  // Milestone diamond on track
  slide.addShape(pres.shapes.DIAMOND, {
    x: ph.x + ph.w - 0.18, y: trackY - 0.1, w: 0.24, h: 0.24,
    fill: { color: ph.color }, line: { color: ph.color }
  });
});

// Responsibility note below track
slide.addText(
  "YourCo leads: integration build, testing, deployment   |   Acme provides: system access, 1 technical lead, UAT sign-off", {
  x: MARGIN, y: trackY + 0.3, w: 9.0, h: 0.4,
  fontSize: 11, fontFace: CORP_FONTS.face, color: C.muted, italic: true
});
```

---

## C6. Case Study Slide

**Purpose:** Prove you've done this before for a comparable client.

Layout: 4-section flow (top-to-bottom or 2×2 grid).

```javascript
slide.background = { color: C.bg };

slide.addText("Global Tier-1 bank cut reconciliation costs by $1.2M in year one", {
  x: MARGIN, y: 0.2, w: 9.0, h: 0.7,
  fontSize: CORP_FONTS.headline - 4, fontFace: CORP_FONTS.face,
  color: C.primary, bold: true
});

slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 0.9, w: 9.0, h: 0.04, fill: { color: C.accent }
});

// Client context badge (top-right)
slide.addShape(pres.shapes.ROUNDED_RECTANGLE, {
  x: 7.5, y: 0.2, w: 2.0, h: 0.65,
  fill: { color: C.highlight }, line: { color: C.accent, pt: 1 }, rectRadius: 0.06
});
slide.addText("Tier-1 Bank\n40,000 employees", {
  x: 7.52, y: 0.22, w: 1.96, h: 0.6,
  fontSize: 10, fontFace: CORP_FONTS.face, color: C.primary,
  align: "center", bold: true
});

// 4 sections in a 2×2 grid
const csBox = (label, text, x, y, color) => {
  slide.addShape(pres.shapes.ROUNDED_RECTANGLE, {
    x, y, w: 4.3, h: 1.9,
    fill: { color: C.surface }, line: { color: color, pt: 1.5 }, rectRadius: 0.07
  });
  slide.addText(label, {
    x: x + 0.12, y: y + 0.1, w: 4.0, h: 0.3,
    fontSize: 10, fontFace: CORP_FONTS.face, color, bold: true
  });
  slide.addText(text, {
    x: x + 0.12, y: y + 0.42, w: 4.06, h: 1.35,
    fontSize: 13, fontFace: CORP_FONTS.face, color: C.body,
    valign: "top", wrap: true
  });
};

csBox(
  "CHALLENGE",
  "8 siloed core banking systems with no shared data layer. Monthly reconciliation took 15 analysts 3 weeks.",
  MARGIN, 1.1, C.accent
);
csBox(
  "APPROACH",
  "YourCo deployed a non-invasive API integration layer in 12 weeks. No legacy system changes required.",
  5.2, 1.1, C.accent
);
csBox(
  "OUTCOME",
  "$1.2M saved in year 1. Reconciliation cycle: 3 weeks → 4 hours. Error rate: 6% → 0.3%.",
  MARGIN, 3.15, "1B7A4A"  // green
);
csBox(
  "WHY IT MATTERS FOR YOU",
  "Acme's profile is comparable: 6 systems, similar data volumes, same audit compliance requirements.",
  5.2, 3.15, C.cta
);
```

---

## C7. Next Steps / CTA Slide

**Purpose:** The last main slide. Drives the specific, time-bound action you want the audience to take.

```javascript
// Dark treatment — mirrors the title slide for visual closure
slide.background = { color: C.primary };

slide.addText("Next Steps", {
  x: MARGIN, y: 0.25, w: 9.0, h: 0.45,
  fontSize: 18, fontFace: CORP_FONTS.face, color: "A0BBDD", bold: false
});

slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 0.7, w: 9.0, h: 0.05, fill: { color: C.accent }
});

// 3-step action plan (numbered, specific, owned)
const steps = [
  { num: "01", action: "Confirm Phase 1 scope", detail: "Acme technical lead reviews architecture doc and signs off — by July 15", owner: "Acme" },
  { num: "02", action: "Kick off discovery workshop", detail: "2-hour session with Acme finance + IT team to map current data flows — week of July 21", owner: "YourCo + Acme" },
  { num: "03", action: "Issue SOW and begin onboarding", detail: "YourCo issues Statement of Work within 5 business days of scope confirmation", owner: "YourCo" },
];

steps.forEach((s, i) => {
  const y = 0.9 + i * 1.35;

  // Number badge
  slide.addShape(pres.shapes.ELLIPSE, {
    x: MARGIN, y, w: 0.55, h: 0.55,
    fill: { color: C.accent }, line: { color: C.accent }
  });
  slide.addText(s.num, {
    x: MARGIN, y, w: 0.55, h: 0.55,
    fontSize: 16, fontFace: CORP_FONTS.face, color: "FFFFFF",
    bold: true, align: "center", valign: "middle"
  });

  // Action title
  slide.addText(s.action, {
    x: 1.2, y: y + 0.02, w: 6.0, h: 0.35,
    fontSize: 17, fontFace: CORP_FONTS.face, color: "FFFFFF", bold: true
  });

  // Detail
  slide.addText(s.detail, {
    x: 1.2, y: y + 0.38, w: 6.5, h: 0.45,
    fontSize: 13, fontFace: CORP_FONTS.face, color: "CADCFC"
  });

  // Owner badge
  slide.addShape(pres.shapes.ROUNDED_RECTANGLE, {
    x: 8.0, y: y + 0.05, w: 1.5, h: 0.38,
    fill: { color: C.accent + "55" }, line: { color: C.accent, pt: 1 }, rectRadius: 0.05
  });
  slide.addText(s.owner, {
    x: 8.0, y: y + 0.05, w: 1.5, h: 0.38,
    fontSize: 10, fontFace: CORP_FONTS.face, color: "CADCFC",
    bold: true, align: "center", valign: "middle"
  });
});

// Contact line
slide.addText("Questions? contact@yourco.com  ·  +1 (555) 000-0000", {
  x: MARGIN, y: 5.1, w: 7.0, h: 0.35,
  fontSize: 13, fontFace: CORP_FONTS.face, color: "A0BBDD"
});
```

**CTA rules:**
- Always name a specific action, a deadline, and an owner for each step.
- 2–3 steps maximum on this slide. Put any further detail in the appendix.
- Never replace this slide with "Thank You" or a company logo slide.

---

## C8. Corporate Appendix Slide

**Purpose:** Pre-built answer to likely questions. Each appendix section has a clear label.

```javascript
// Muted header to distinguish from main deck
slide.addText("Appendix B — Detailed Pricing Breakdown", {
  x: MARGIN, y: 0.15, w: 9.0, h: 0.4,
  fontSize: 13, fontFace: CORP_FONTS.face, color: C.muted, italic: true
});

// Business headline (appendix slides also use headline titles)
slide.addText("Phase 1 investment totals $180K; ongoing licence is $4,500/month from month 3", {
  x: MARGIN, y: 0.6, w: 9.0, h: 0.7,
  fontSize: CORP_FONTS.headline - 6, fontFace: CORP_FONTS.face, color: C.primary, bold: true
});

slide.addShape(pres.shapes.RECTANGLE, {
  x: MARGIN, y: 1.3, w: 9.0, h: 0.04, fill: { color: C.accent }
});

// Content follows normal corporate slide patterns
// (tables, charts, etc. — reference pptxgenjs.md for addTable API)
```

---

## Corporate Quick Checks Before Delivery

```
□ Client brand color applied consistently (or approved default palette used)
□ Title slide includes client name and date
□ Executive Summary is one slide, self-sufficient, ≤ 80 words
□ Every slide title is a business headline (outcome / recommendation), not a topic label
□ Architecture diagram is annotated — every component is labelled
□ Timeline shows responsibility split (client vs. your team) per phase
□ Case study is quantified and comparable to the recipient's profile
□ KPI tiles have a value, a label, and a baseline context
□ Next Steps / CTA is the last main slide — specific, time-bound, owner assigned
□ No slide has > ~30 words of body text or > 5 bullets
□ Appendix is present and labelled by section
□ No "Thank You" or blank slide at the end
□ Deck reviewed for audience-appropriate vocabulary and depth
```
