# readme-to-presentation

> Transform any GitHub README into a stunning, self-contained HTML slide deck in seconds.

## What it does

This skill reads a GitHub README (from a repo URL or raw URL) and generates a premium, slide-by-slide HTML presentation with:

- 🎨 **AI-inferred structure** — intelligently groups content into cover, highlights, features, code, and closing slides
- 🌙 **Dark/Light mode toggle** — ships with both themes, persists via localStorage
- ⌨️ **Keyboard + button navigation** — arrow keys and on-screen buttons
- ✨ **Syntax-highlighted code blocks** — CSS-based, no external libraries
- 🏷️ **Badges & images** — embedded from the original README
- 📦 **Zero dependencies** — one self-contained HTML file

## Usage

```
/readme-to-presentation https://github.com/user/repo
```

Or with a raw URL:

```
/readme-to-presentation https://raw.githubusercontent.com/user/repo/main/README.md
```

Or describe it in natural language:

> "Turn the GitHub README at https://github.com/vercel/next.js into a presentation"

## Output

The generated HTML file is saved to:

```
readme-to-presentation/output/<project-name>-presentation.html
```

## Slide Types Generated

| Slide | Content |
|---|---|
| **Cover** | Title, tagline, badges, hero image |
| **Highlights** | Key bullet points / TL;DR |
| **Features** | Feature cards grid (max 6 per slide) |
| **Installation** | Code block, step-by-step |
| **Usage** | Code examples, syntax highlighted |
| **API / Config** | Tables or code |
| **Contributing** | Guidelines, links |
| **Closing** | Links, CTA, star on GitHub |

## Design

- Default: dark mode with a violet accent (`#6c63ff`)
- Font: `Bricolage Grotesque` (or user-specified)
- All colors via CSS custom properties — easy to customise
- Responsive with `clamp()` sizing — looks great on laptop, projector, TV

## Customizing the Style

When invoking the skill, you can specify a style preference:

```
/readme-to-presentation https://github.com/user/repo -- style: techy, dark
```

Supported style keywords: `minimal`, `bold`, `techy`, `corporate`, `elegant`, `colorful`

## Files

```
readme-to-presentation/
├── SKILL.md                        # Main skill instructions
├── README.md                       # This file
├── references/
│   └── design-system.md            # CSS tokens, fonts, slide specs
└── output/                         # Generated HTML files (gitignored)
```
