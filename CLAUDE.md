# Neat Utils

This repo contains Claude Code custom utility skills.

## Conventions

- Reusable scripts go in the skill's `scripts/` folder. SKILL.md references them via `<skill-dir>/scripts/<name>` (e.g., `<skill-dir>/scripts/render-mermaid.js`).
- Skill output is saved under `docs/` in the target project directory. Each skill defines its output path in SKILL.md.

## Project structure

```text
neat-utils/
  CLAUDE.md
  README.md
  .markdownlint.jsonc
  scripts/
    install.sh
    uninstall.sh
  neat_util_<skill>/               # utility skills

Each skill folder contains:
  SKILL.md
  README.md
  scripts/                         # optional
```

## SKILL.md frontmatter

```yaml
---
name: neat-util-<name>
description: Use when <trigger condition> - <what it does> - <prerequisites if any>
---
```
