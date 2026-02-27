# This is collection of custom claude code skills created for various use cases

## Skill Builder
Use when creating new skills, optimizing existing skills, or auditing skill quality. Guides skill development following Claude Code official best practices.

**How to install the Skill Builder skill:**
1. In your project folder, create the directory `.claude/skills/skill-builder/`
2. Drop both files into that folder:
    - `SKILL.md` (the main skill)
    - `reference.md` (the technical reference)
3. Open Claude Code in that project. Type `/skill-builder` to confirm it shows up.
4. Say "help me build a skill" or `/skill-builder` to start building.

That's it. Claude will walk you through the rest.

## Excalidraw Diagrams
Use when someone asks to draw a diagram, make an Excalidraw diagram, or build an editable diagram. Default for all diagram requests.

**How to install the Excalidraw Diagram skill:**
1. In your project folder, create the directory `.claude/skills/excalidraw-diagram/`
2. Drop the `SKILL.md` file into that folder.
3. Open Claude Code in that project. Type `/excalidraw-diagram` to confirm it shows up.
4. Say "draw me a diagram of..." or `/excalidraw-diagram` and describe what you want.

That's it. Claude will ask clarifying questions if needed, build the diagram, and tell you exactly how to open it in Excalidraw.