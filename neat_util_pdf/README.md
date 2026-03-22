# PDF Generator Skill

A Claude Code skill for generating PDF documents through an interactive conversational wizard. Guides users through purpose definition, content gathering, and style selection, then produces a styled PDF using Playwright.

## Workflow

| Phase       | Focus              | Goal                                                                    |
|-------------|--------------------|-------------------------------------------------------------------------|
| **Phase 0** | Prerequisite Check | Verify Playwright and poppler are installed                             |
| **Phase 1** | Purpose            | Document type, audience, requirements                                   |
| **Phase 2** | Content            | Gather reference material, assemble content                             |
| **Phase 3** | Style              | Extract style from example PDF, or pick a fitting style for the content |
| **Phase 4** | Generate           | Create HTML, render to PDF, audit output                                |

Output is saved to `docs/neat_util_pdf/<project>/pdfs/<filename>.pdf` (HTML to `.assets/<filename>.html`, images to `.assets/images/`) in the current working directory.

## Prerequisites

- Node.js installed
- Playwright with Chromium: `npm install playwright && npx playwright install chromium`
- poppler: `brew install poppler` (macOS) or `apt install poppler-utils` (Linux)

## Install / Uninstall

From the repo root:

```bash
./scripts/install.sh pdf
./scripts/uninstall.sh pdf
```
