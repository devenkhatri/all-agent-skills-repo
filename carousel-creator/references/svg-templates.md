# SVG Templates & Technical Rules

> Load this file when building SVG layout structures and needing reusable design patterns.

---

## SVG Document Structure

Every SVG slide should be layered in this order:

```xml
<svg width="1080" height="1350" viewBox="0 0 1080 1350" xmlns="http://www.w3.org/2000/svg">

  <!-- 1. Definitions (gradients, filters, clip paths) -->
  <defs>
    <linearGradient id="bgGrad" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0D1B2A"/>
      <stop offset="100%" stop-color="#162236"/>
    </linearGradient>
  </defs>

  <!-- 2. Background layer -->
  <rect width="1080" height="1350" fill="url(#bgGrad)"/>

  <!-- 3. Decorative / structural elements (shapes, accent lines) -->

  <!-- 4. Content layer (text, cards, icons) -->

  <!-- 5. Branding layer (footer strip, handle) -->

</svg>
```

> For LinkedIn (1:1 square), use `width="1080" height="1080" viewBox="0 0 1080 1080"` and adjust Y positions accordingly.

---

## Safe Margin Reference

| Platform | Left/Right | Top | Bottom (above footer) |
|----------|-----------|-----|----------------------|
| Instagram (4:5) | 72–96px | 80–120px | 80px |
| LinkedIn (1:1) | 72–96px | 72–100px | 72px |

---

## Common Layout Patterns

### 1. Hero / Hook Slide

```
┌──────────────────────────┐
│  [Accent shape / decor]  │
│                          │
│   BOLD HOOK HEADLINE     │
│   (2–3 lines, centered)  │
│                          │
│   Punchy supporting line │
│                          │
│  [Optional visual icon]  │
│                          │
│  ── @handle footer ──    │
└──────────────────────────┘
```

### 2. Numbered List Slide

```
┌──────────────────────────┐
│  Slide Title             │
│  ──────────────          │
│  ① Point one             │
│    Brief explanation     │
│                          │
│  ② Point two             │
│    Brief explanation     │
│                          │
│  ③ Point three           │
│    Brief explanation     │
│                          │
│  ── @handle footer ──    │
└──────────────────────────┘
```

### 3. Comparison / Split Slide

```
┌────────────┬─────────────┐
│  ❌ Wrong  │  ✅ Right   │
│  ──────── │  ─────────  │
│  Item A   │  Item A     │
│  Item B   │  Item B     │
│  Item C   │  Item C     │
│            │             │
│  ── @handle footer ──   │
└─────────────────────────┘
```

### 4. Stat / Quote Callout Slide

```
┌──────────────────────────┐
│  Section label           │
│                          │
│  ┌────────────────────┐  │
│  │  "Quote or big     │  │
│  │   stat goes here"  │  │
│  └────────────────────┘  │
│                          │
│  Supporting context line │
│                          │
│  ── @handle footer ──    │
└──────────────────────────┘
```

### 5. CTA / Final Slide

```
┌──────────────────────────┐
│                          │
│  🔔 Enjoyed this?        │
│                          │
│  Follow @devengoratela   │
│  for more content        │
│                          │
│  ─────────────────────── │
│                          │
│  💾 Save    📤 Share     │
│                          │
│  @devengoratela footer   │
└──────────────────────────┘
```

### 6. Screenshot / Visual Demo Slide (Video Input — Face-Free)

```
┌──────────────────────────┐
│  Slide Headline / Step   │
│  ──────────────────────  │
│  ┌────────────────────┐  │
│  │                    │  │
│  │ [Face-Free Video   │  │
│  │  Screenshot: UI /  │  │
│  │  Code / Workflow]  │  │
│  │                    │  │
│  └────────────────────┘  │
│  Key takeaway card       │
│  ── @handle footer ──    │
└──────────────────────────┘
```

---

## Reusable SVG Snippets

### Distinct Slide Backgrounds (Always Different Per Slide)

Every slide must use a different background color or gradient from a cohesive palette. Example sequence for Tech/AI:

```xml
<!-- Slide 1 Background: Deep Midnight Navy -->
<defs>
  <linearGradient id="bgSlide1" x1="0%" y1="0%" x2="0%" y2="100%">
    <stop offset="0%" stop-color="#0B132B"/>
    <stop offset="100%" stop-color="#1C2541"/>
  </linearGradient>
</defs>
<rect width="1080" height="1350" fill="url(#bgSlide1)"/>

<!-- Slide 2 Background: Dark Slate -->
<rect width="1080" height="1350" fill="#1E293B"/>

<!-- Slide 3 Background: Deep Ocean Charcoal -->
<defs>
  <linearGradient id="bgSlide3" x1="0%" y1="0%" x2="0%" y2="100%">
    <stop offset="0%" stop-color="#0F172A"/>
    <stop offset="100%" stop-color="#1E1B4B"/>
  </linearGradient>
</defs>
<rect width="1080" height="1350" fill="url(#bgSlide3)"/>

<!-- Slide 4 Background: Deep Cyber Emerald / Teal -->
<rect width="1080" height="1350" fill="#064E3B"/>
```

### Embedded Face-Free Screenshot (Video Input)

When video input is provided, extract relevant frames with `ffmpeg` (showing UI, code, diagrams, tools, and workflows without speaker faces) into `assets/`, then embed with rounded clipping:

```xml
<defs>
  <!-- Rounded corner clipping path -->
  <clipPath id="screenClip1">
    <rect x="72" y="320" width="936" height="526" rx="16"/>
  </clipPath>
</defs>

<!-- Embedded face-free screenshot (relative or base64 data URI) -->
<image href="../assets/screenshot-1.png" x="72" y="320" width="936" height="526"
       preserveAspectRatio="xMidYMid slice" clip-path="url(#screenClip1)"/>

<!-- Subtle border stroke overlay -->
<rect x="72" y="320" width="936" height="526" rx="16" fill="none"
      stroke="#FFFFFF" stroke-opacity="0.2" stroke-width="2"/>
```

### Accent Highlight Box (left border style)
```xml
<rect x="72" y="300" width="936" height="130" rx="16" fill="#3A86FF" opacity="0.12"/>
<rect x="72" y="300" width="6" height="130" rx="3" fill="#3A86FF"/>
```

### Number Badge (circle with centered number)
```xml
<circle cx="120" cy="400" r="36" fill="#3A86FF"/>
<text x="120" y="412" font-family="sans-serif" font-size="32"
      font-weight="700" fill="white" text-anchor="middle">1</text>
```

### Footer Brand Strip — Instagram
```xml
<rect x="0" y="1300" width="1080" height="50" fill="#0D1B2A"/>
<text x="540" y="1332" font-family="sans-serif" font-size="22"
      font-weight="600" fill="#FFFFFF" text-anchor="middle" opacity="0.85">
  @handle
</text>
```

### Footer Brand Strip — LinkedIn
```xml
<rect x="0" y="1030" width="1080" height="50" fill="#0D1B2A"/>
<text x="540" y="1062" font-family="sans-serif" font-size="22"
      font-weight="600" fill="#FFFFFF" text-anchor="middle" opacity="0.85">
  @handle
</text>
```

### Divider Line
```xml
<line x1="72" y1="500" x2="1008" y2="500" stroke="#FFFFFF" stroke-width="1" opacity="0.2"/>
```

### Rounded Content Card
```xml
<rect x="72" y="300" width="936" height="200" rx="20" fill="#FFFFFF" opacity="0.08"/>
```

### Bold Stat Callout
```xml
<!-- Large number -->
<text x="540" y="700" font-family="sans-serif" font-size="120" font-weight="900"
      fill="#3A86FF" text-anchor="middle">87%</text>
<!-- Supporting label -->
<text x="540" y="770" font-family="sans-serif" font-size="32" font-weight="400"
      fill="#FFFFFF" text-anchor="middle" opacity="0.8">of users saw results</text>
```

---

## SVG Validation Checklist

After writing each SVG, verify:

- [ ] `<svg>` tag is present, opened, and closed
- [ ] `width`, `height`, and `viewBox` attributes are set correctly for the platform
- [ ] All tags are properly closed (`<rect/>`, `<text></text>`, etc.)
- [ ] All `<defs>` IDs referenced in `fill="url(#id)"` are defined
- [ ] No attribute values are missing quotes
- [ ] No unclosed `<style>` or `<defs>` blocks

**Agent-executable XML validation:**
```bash
python3 -c "
import xml.etree.ElementTree as ET
ET.parse('{filename}.svg')
print('Valid SVG: {filename}.svg')
"
```
