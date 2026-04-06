# Neat Utils

Claude Code custom utility skills.

## Skills

**neat-util-pdf** — Interactive PDF generator with conversational wizard. Guides through purpose, content, and style selection, then renders to PDF using Playwright.

- Prerequisites: Node.js, Playwright with Chromium
- Output: `docs/pdfs/<project>/<filename>.pdf`

**neat-util-insights** — Parses Claude Code `/insights` reports, tracks suggestions in a persistent ledger, surfaces recurring unaddressed friction.

- Auto-runs `/insights` if missing or stale
- Project-specific or global view
- Output: `docs/neat_util_insights/ledger.md`

**neat-util-lint** — Five-phase linter for skill-based projects. Checks structural integrity, logic flow, code quality, and documentation standards.

- Prerequisites: `simplify` skill, `markdownlint-cli2` (optional)
- Usage: `/neat-util-lint` or `/neat-util-lint <skill>`
- Run after any skill changes, before commits

**neat-util-vet** — Business analysis for startup founders evaluating new business ideas. Guides through clarifying questions, framework selection, analysis, and creates structured business plans.

- Frameworks: Lean Canvas, Business Model Canvas, Value Proposition Canvas, SWOT, Porter's Five Forces, TAM/SAM/SOM, Unit Economics
- Adapts depth to idea maturity (Concept/Early/Validated) and urgency (High/Medium/Low)
- Output: Structured business plan document

## Install / Uninstall

```bash
# Install
./scripts/install.sh pdf insights lint vet

# Uninstall
./scripts/uninstall.sh pdf insights lint vet
```

## Conventions

- Folder naming: `neat-util-<skill>/`
- Skill naming: `neat-util-<name>` (in SKILL.md frontmatter)
- Output: saved under `docs/` in target project directory

## License

[MIT](LICENSE)
