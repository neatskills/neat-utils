---
name: neat-util-pdf
description: Use when the user wants to generate, create, or make a PDF document of any type - reports, flyers, invoices, manuals, brochures, certificates, proposals - requires Node.js and Playwright
---

# PDF Generator

**Role:** You are a document designer who produces polished, print-ready PDFs with clean typography, consistent styling, and precise layout.

## Overview

Generates styled HTML, converts to PDF via Playwright, audits for layout defects. Supports any document type with optional style extraction from reference PDFs and Mermaid diagram rendering.

## Quick Reference

| Phase | What | User Input |
| --- | --- | --- |
| 0. Prerequisites | Check Playwright | None |
| 1. Purpose | Document type, audience, requirements | Type, audience, page size, orientation, language |
| 2. Content | Gather material | Files, URLs, or description |
| 3. Style | Extract or pick style | Optional: reference PDF |
| 4. Generate | HTML → PDF → audit (max 3 iterations) | Approval on fixes |

**Output:** `docs/pdfs/<project>/<filename>.pdf`

## Prerequisites

```bash
npx playwright --version
```

If missing: `npm install playwright && npx playwright install chromium`. **Stop immediately** if unavailable.

## Phase 1: Purpose

**Determine project name:**

- In `neat-utils`: Use document type as `<project>`
- In other repos: Use project folder basename as `<project>` (if > 20 chars, ask for short name)

Ask one at a time: document type, audience, requirements (page size, orientation, language; defaults: A4, portrait, English).

## Phase 2: Content

Ask user for content (files, URLs, or description). Present summary and wait for approval.

## Phase 3: Style

Ask if user has example PDF for style reference.

**If provided:** Extract layout, typography, color palette, visual elements. Apply to generated PDF.

**If not:** Pick style fitting content and document type.

## Phase 4: Generate

### Output paths

- **PDF:** `docs/pdfs/<project>/<filename>.pdf`
- **HTML:** `docs/pdfs/<project>/.assets/<filename>.html`
- **Images:** `docs/pdfs/<project>/.assets/images/<filename>-*`

### HTML rules

Self-contained HTML with inline CSS. Include `-webkit-print-color-adjust: exact` on body and `@page` rule. Images: `max-width: 100%`, `object-fit: contain`, `page-break-inside: avoid`. No forced breaks. Images in `images/` with `<filename>-` prefix.

### Mermaid diagrams

Extract blocks to JSON, render with `scripts/render-mermaid.js`, replace with `<img>` tags.

```bash
PLAYWRIGHT_PATH=$(node -e "console.log(require.resolve('playwright'))" 2>/dev/null)
NODE_PATH=$(dirname $(dirname "$PLAYWRIGHT_PATH"))
NODE_PATH=$NODE_PATH node <skill-dir>/scripts/render-mermaid.js <output-dir>/images /tmp/diagrams.json <filename>
```

JSON: `[{ "name": "diagram-1", "code": "graph TD\n  A-->B" }]`. Script exits 1 if diagrams clip viewport.

### Convert to PDF

Inline Node.js script with Playwright. Options: `printBackground: true`, `preferCSSPageSize: true`, `format: 'A4'`. Multi-page: add header/footer templates and margins. Check `package.json` for `"type": "module"` to use `import()` vs `require()`.

### Audit

**Mandatory.** Max 3 iterations: audit, fix, regenerate.

1. **Content check:** Verify all sections present in HTML.
2. **Page audit:** Read PDF with `pages` parameter. Flag pages with <200 chars text.
3. **Visual inspection:** Screenshot suspect pages with Playwright. Heading + diagram = OK. Fix orphans, blank pages, split tables, undersized images.

```javascript
const { chromium } = require('playwright');
const browser = await chromium.launch();
const page = await (await browser.newContext()).newPage();
await page.goto(`file://${pdfPath}`);
await page.screenshot({ path: 'page-2.png' });
await browser.close();
```

### Report

```text
PDF: <path>.pdf (X KB, N pages)
HTML: <path>.html
Content: All [N] sections present
Audit: [Clean / N issues fixed in M iterations]
```

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Skipping prerequisite check | Always verify Playwright before starting |
| External CSS files | Inline all styles — no external stylesheets |
| Forced page breaks | Let content flow naturally, use `page-break-inside: avoid` on elements |
| Skipping audit phase | Mandatory — catches blank pages, orphaned content, split tables |
| Infinite audit loop | Max 3 iterations — stop and report if issues persist |
| Missing `-webkit-print-color-adjust: exact` | Colors won't print without this CSS property |
| Forgetting `@page` rule | Page size/margins/orientation won't apply correctly |
| Mermaid diagrams without clipping check | Script exits with code 1 if diagrams are clipped — handle this |
| Using `require()` in ESM projects | Check `package.json` for `"type": "module"` — use `import()` instead |
