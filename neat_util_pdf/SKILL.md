---
name: neat-util-pdf
description: Use when the user wants to generate, create, or make a PDF document of any type - reports, flyers, invoices, manuals, brochures, certificates, proposals - requires Node.js, Playwright, and poppler
---

# PDF Generator

**Role:** You are an expert document designer who produces polished, print-ready PDFs with clean typography, consistent styling, and precise layout.

Produces a styled HTML file, converts it to PDF via Playwright, and audits the output for layout defects.

## Prerequisites

```bash
npx playwright --version
pdftotext -v 2>&1 | head -1
```

If Playwright is missing: `npm install playwright && npx playwright install chromium`
If poppler is missing: `brew install poppler` (macOS) or `apt install poppler-utils` (Linux)

**Stop immediately** if either tool is missing.

## Phase 1: Purpose

Ask **one at a time**: document type, audience, requirements (page size, orientation, language — defaults: A4, portrait, English).

## Phase 2: Content

Ask user to provide content — files, URLs, or a description. Present assembled content summary. Wait for approval.

## Phase 3: Style

Ask the user if they have an example PDF to use as a style reference.

**If provided:** Read the example PDF. Extract layout structure, typography, color palette, visual elements, and overall feel. Apply these to the generated PDF.

**If not provided:** Pick a style that fits the content and document type — layout, color palette, typography, visual elements. Go directly to Phase 4.

## Phase 4: Generate

### Output paths

- **Filename:** kebab-case from title (e.g., "Q1 Sales Report" -> `q1-sales-report`)
- **PDF:** `docs/neat_util_pdf/<project>/pdfs/<filename>.pdf`
- **HTML:** `docs/neat_util_pdf/<project>/pdfs/.assets/<filename>.html`
- **Images:** `docs/neat_util_pdf/<project>/pdfs/.assets/images/` (prefixed: `<filename>-diagram-1.png`)

### HTML rules

Single self-contained HTML file. Inline CSS only, no external stylesheets. Include `-webkit-print-color-adjust: exact` on body and `@page` rule for size/margins/orientation. Images use `max-width: 100%`, `object-fit: contain`, `page-break-inside: avoid`. No forced page breaks — let content flow naturally. All images go in `images/` directory with `<filename>-` prefix, referenced from HTML with `images/<filename>-` relative paths.

### Mermaid diagrams

Skip if no Mermaid blocks. Extract blocks into a JSON file, render with `scripts/render-mermaid.js`, replace blocks with `<img>` tags.

```bash
PLAYWRIGHT_PATH=$(node -e "console.log(require.resolve('playwright'))" 2>/dev/null)
NODE_PATH=$(dirname $(dirname "$PLAYWRIGHT_PATH"))
NODE_PATH=$NODE_PATH node <skill-dir>/scripts/render-mermaid.js <output-dir>/images /tmp/diagrams.json <filename>
```

The JSON format is `[{ "name": "diagram-1", "code": "graph TD\n  A-->B" }]`. The script detects clipping and exits with code 1 if any diagram hits viewport edges.

### Convert to PDF

Inline Node.js script using Playwright. Key options: `printBackground: true`, `preferCSSPageSize: true`, `format: 'A4'` (fallback). Multi-page docs: add `displayHeaderFooter`, `headerTemplate`/`footerTemplate`, and margins. Check `package.json` for `"type": "module"` — if present, use `import()` instead of `require()`.

### Audit

**Mandatory.** Max 3 iterations of: audit, fix HTML, regenerate.

1. **Content check:** Verify all sections from source are present in HTML.
2. **Page audit:** Run `<skill-dir>/scripts/audit-pdf.sh OUTPUT.pdf` — flags pages with < 200 text characters.
3. **Visual inspection:** Render suspect pages as PNG (`pdftoppm -png -f PAGE -l PAGE -r 150`), Read them. Pages with heading + diagram are OK. Fix orphan content, blank pages, split tables, undersized images.

### Report

```text
PDF generated:
- PDF: <path>.pdf (X KB, N pages)
- HTML: <path>.html
- Content: All [N] sections present
- Audit: [Clean / N issues fixed in M iterations]
```
