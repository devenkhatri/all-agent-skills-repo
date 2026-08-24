# Design System Reference — readme-to-presentation

This file is loaded by the skill during Phase 3 (generation). It defines the full token set, font catalog, slide variant specs, and code syntax theme.

---

## CSS Custom Property Tokens

All values must be set on both `[data-theme="dark"]` and `[data-theme="light"]`. Never hardcode color values outside these declarations.

```css
/* Root defaults (dark mode) */
[data-theme="dark"] {
  /* Backgrounds */
  --bg:          #0a0a0f;
  --bg-card:     #12121a;
  --bg-code:     #0d0d14;
  --bg-overlay:  rgba(10,10,15,0.85);

  /* Text */
  --text:        #f0f0ff;
  --text-muted:  #8888aa;
  --text-code:   #c9c9f0;

  /* Accent palette */
  --accent:      #6c63ff;
  --accent-2:    #ff6b6b;
  --accent-glow: rgba(108,99,255,0.25);

  /* Borders & surfaces */
  --border:      rgba(255,255,255,0.08);
  --shadow:      0 8px 32px rgba(0,0,0,0.4);

  /* Navigation */
  --nav-bg:      rgba(18,18,26,0.9);
  --nav-text:    #f0f0ff;

  /* Syntax highlight (dark) */
  --syn-keyword:  #c792ea;
  --syn-string:   #c3e88d;
  --syn-comment:  #546e7a;
  --syn-number:   #f78c6c;
  --syn-function: #82aaff;
  --syn-operator: #89ddff;
  --syn-type:     #ffcb6b;
}

[data-theme="light"] {
  /* Backgrounds */
  --bg:          #f8f8fc;
  --bg-card:     #ffffff;
  --bg-code:     #f0f0f8;
  --bg-overlay:  rgba(248,248,252,0.9);

  /* Text */
  --text:        #0a0a1a;
  --text-muted:  #555566;
  --text-code:   #333355;

  /* Accent palette */
  --accent:      #5048e5;
  --accent-2:    #e5483a;
  --accent-glow: rgba(80,72,229,0.15);

  /* Borders & surfaces */
  --border:      rgba(0,0,0,0.08);
  --shadow:      0 4px 24px rgba(0,0,0,0.1);

  /* Navigation */
  --nav-bg:      rgba(255,255,255,0.92);
  --nav-text:    #0a0a1a;

  /* Syntax highlight (light) */
  --syn-keyword:  #7c3aed;
  --syn-string:   #16a34a;
  --syn-comment:  #9ca3af;
  --syn-number:   #ea580c;
  --syn-function: #2563eb;
  --syn-operator: #0891b2;
  --syn-type:     #d97706;
}
```

---

## Typography

### Font Catalog

| Font | CDN URL | Best For |
|---|---|---|
| Bricolage Grotesque | `https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:wght@400;600;800&display=swap` | Bold, editorial, eye-catching |
| Syne | `https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&display=swap` | Geometric, techy, futuristic |
| Cabinet Grotesk | `https://api.fontshare.com/v2/css?f[]=cabinet-grotesk@400,500,700&display=swap` | Clean, premium, minimal |
| DM Sans | `https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;600;700&display=swap` | Elegant, readable, versatile |
| DM Mono | `https://fonts.googleapis.com/css2?family=DM+Mono:wght@300;400;500&display=swap` | Code-heavy, terminal, techy |

### Type Scale (all use `clamp()` — never fixed px)

```css
--text-xs:   clamp(0.65rem, 1vw, 0.75rem);
--text-sm:   clamp(0.8rem, 1.2vw, 0.9rem);
--text-base: clamp(0.95rem, 1.5vw, 1.1rem);
--text-lg:   clamp(1.1rem, 1.8vw, 1.35rem);
--text-xl:   clamp(1.3rem, 2.2vw, 1.65rem);
--text-2xl:  clamp(1.6rem, 2.8vw, 2.1rem);
--text-3xl:  clamp(2rem, 3.5vw, 2.8rem);
--text-4xl:  clamp(2.5rem, 5vw, 4rem);
--text-hero: clamp(3rem, 7vw, 6rem);
```

---

## Slide Variant Specifications

### Cover Slide
```
Layout: centered column
Elements: [badge row] → [hero image or accent shape] → [H1 title] → [tagline paragraph] → [optional badge pills]
Title font size: --text-4xl to --text-hero
Tagline font size: --text-lg
Background: gradient or subtle pattern using --bg and --accent-glow
```

### Highlights Slide
```
Layout: left-aligned content column (60% width) + right-side accent stripe or icon
Elements: [label tag] → [H2 heading] → [bullet list as styled rows]
Bullet style: each bullet has a colored left border (--accent) and icon prefix
Max bullets: 7
```

### Features Slide
```
Layout: CSS Grid, 2x3 or 3x2 depending on count
Card style: bg-card background, border, border-radius: 12px, padding: 1.5rem
Each card: [icon or emoji] → [feature name bold] → [1-line description muted]
Max cards: 6 per slide
```

### Code Slide
```
Layout: [heading] → [code block, full width]
Code block: bg-code, border-radius: 8px, padding: 1.5rem, monospace font, syntax colors from --syn-* vars
Max lines: 12 (truncate with comment if longer)
Include language label badge top-right of the code block
```

### Text/Content Slide
```
Layout: centered column, max-width 65ch
Elements: [label tag] → [H2 heading] → [paragraph(s) or bullet list]
Max content: 2 paragraphs OR 6 bullets
```

### Architecture/Diagram Slide
```
Layout: centered
If diagram is available: embed as SVG or image
If no diagram: represent architecture as a styled flowchart using pure CSS/HTML boxes and connectors
```

### Closing Slide
```
Layout: centered, vertically centered
Elements: [project name large] → [tagline] → [link pills: GitHub, docs, etc.] → [CTA text]
CTA: e.g., "Star us on GitHub ⭐" or "Get started today →"
```

---

## Navigation Chrome

### Prev/Next Buttons
```css
.nav-btn {
  position: fixed;
  top: 50%;
  transform: translateY(-50%);
  width: 48px; height: 48px;
  background: var(--nav-bg);
  border: 1px solid var(--border);
  border-radius: 50%;
  color: var(--nav-text);
  font-size: 1.2rem;
  cursor: pointer;
  backdrop-filter: blur(12px);
  transition: all 0.2s ease;
  z-index: 1000;
}
.nav-btn.prev { left: 1.5rem; }
.nav-btn.next { right: 1.5rem; }
.nav-btn:hover { background: var(--accent); color: #fff; border-color: var(--accent); }
.nav-btn:disabled { opacity: 0.3; cursor: not-allowed; }
```

### Dot Indicators
```css
.dots { position: fixed; bottom: 1.5rem; left: 50%; transform: translateX(-50%); display: flex; gap: 8px; z-index: 1000; }
.dot { width: 8px; height: 8px; border-radius: 50%; background: var(--border); cursor: pointer; transition: all 0.2s ease; border: none; }
.dot.active { background: var(--accent); transform: scale(1.3); }
```

### Slide Counter
```css
.slide-counter { position: fixed; top: 1.5rem; left: 50%; transform: translateX(-50%); font-size: var(--text-sm); color: var(--text-muted); z-index: 1000; font-family: monospace; }
```

### Theme Toggle
```css
.theme-toggle { position: fixed; top: 1.5rem; right: 1.5rem; width: 40px; height: 40px; background: var(--nav-bg); border: 1px solid var(--border); border-radius: 50%; cursor: pointer; font-size: 1.1rem; z-index: 1000; backdrop-filter: blur(12px); transition: all 0.2s ease; }
.theme-toggle:hover { background: var(--accent); border-color: var(--accent); }
```

---

## CSS-Based Syntax Highlighting

Apply syntax classes via JavaScript string replacement on the code block content before inserting into HTML:

```js
function highlightCode(code, lang) {
  // Escape HTML first
  code = code.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');
  // Keywords
  const keywords = /\b(const|let|var|function|return|if|else|for|while|import|export|from|class|new|this|async|await|def|print|public|private|static|void|int|string|bool|true|false|null|undefined|type|interface|extends|implements)\b/g;
  code = code.replace(keywords, '<span class="syn-keyword">$1</span>');
  // Strings
  code = code.replace(/(["'`])(?:(?!\1)[^\\]|\\.)*?\1/g, '<span class="syn-string">$&</span>');
  // Comments
  code = code.replace(/(\/\/[^\n]*|\/\*[\s\S]*?\*\/|#[^\n]*)/g, '<span class="syn-comment">$1</span>');
  // Numbers
  code = code.replace(/\b(\d+\.?\d*)\b/g, '<span class="syn-number">$1</span>');
  // Functions
  code = code.replace(/\b([a-zA-Z_]\w*)\s*(?=\()/g, '<span class="syn-function">$1</span>');
  return code;
}
```

Apply CSS:
```css
.syn-keyword  { color: var(--syn-keyword); font-weight: 600; }
.syn-string   { color: var(--syn-string); }
.syn-comment  { color: var(--syn-comment); font-style: italic; }
.syn-number   { color: var(--syn-number); }
.syn-function { color: var(--syn-function); }
.syn-operator { color: var(--syn-operator); }
.syn-type     { color: var(--syn-type); }
```

---

## Style Adaptation Guide

When the user specifies a design style, adapt these settings:

| User says | Font | Accent | Card Style | Background |
|---|---|---|---|---|
| "minimal" | Cabinet Grotesk | muted gray-blue | flat, no shadow | solid --bg |
| "bold" | Syne | vivid purple or orange | thick border | dark gradient |
| "techy" | DM Mono | cyan or lime green | terminal-style | deep dark, grid lines |
| "corporate" | DM Sans | navy blue | clean, shadow | light mode default |
| "elegant" | Bricolage Grotesque | gold or violet | glassmorphism | dark with subtle noise |
| "colorful" | Syne | rotating per slide | bold card fills | vibrant gradient per slide |
