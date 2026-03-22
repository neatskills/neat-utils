#!/usr/bin/env node
//
// Renders Mermaid diagrams to PNG images using Playwright + Mermaid CDN.
//
// Usage:
//   node render-mermaid.js <output-dir> <diagrams.json> [<prefix>]
//
// diagrams.json format:
//   [{ "name": "my-diagram", "code": "graph TD\n  A-->B" }, ...]
//
// Output: one PNG per diagram in <output-dir>/<prefix>-<name>.png (or <name>.png if no prefix)
// Exit code 1 if any diagram is clipped by the viewport.

const { chromium } = require('playwright');
const fs = require('fs');
const path = require('path');

const outputDir = process.argv[2];
const diagramsFile = process.argv[3];
const prefix = process.argv[4] || '';

if (!outputDir || !diagramsFile) {
  console.error('Usage: render-mermaid.js <output-dir> <diagrams.json> [<prefix>]');
  process.exit(2);
}

const diagrams = JSON.parse(fs.readFileSync(diagramsFile, 'utf-8'));

if (!Array.isArray(diagrams) || diagrams.length === 0) {
  console.error('No diagrams found in', diagramsFile);
  process.exit(2);
}

const VIEWPORT = { width: 3000, height: 3000 };
const PADDING = 20;

(async () => {
  const browser = await chromium.launch();

  for (const diagram of diagrams) {
    const page = await browser.newPage();
    await page.setViewportSize(VIEWPORT);

    const html = `<!DOCTYPE html>
<html><head>
<script src="https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js"></script>
<style>body { margin: 0; padding: 20px; background: #1a1a2e; }</style>
</head><body>
<div id="diagram" class="mermaid">${diagram.code}</div>
<script>
  mermaid.initialize({
    startOnLoad: true, theme: 'base',
    themeVariables: {
      background: '#1a1a2e',
      primaryColor: '#0f3460', primaryBorderColor: '#53a8b6',
      primaryTextColor: '#e0e0e0', lineColor: '#53a8b6',
      secondaryColor: '#16213e', tertiaryColor: '#2a2a4a',
      mainBkg: '#0f3460', nodeBorder: '#53a8b6',
      clusterBkg: '#16213e', clusterBorder: '#2a2a4a',
      titleColor: '#ffffff', edgeLabelBackground: '#1a1a2e',
      actorBkg: '#0f3460', actorBorder: '#53a8b6',
      actorTextColor: '#e0e0e0', signalColor: '#53a8b6',
      signalTextColor: '#e0e0e0', fontSize: '14px',
      noteBkgColor: '#16213e', noteTextColor: '#e0e0e0',
      noteBorderColor: '#2a2a4a'
    },
    flowchart: { curve: 'basis', padding: 15, useMaxWidth: false },
    sequence: { useMaxWidth: false, mirrorActors: false }
  });
</script></body></html>`;

    await page.setContent(html, { waitUntil: 'networkidle' });
    await page.waitForSelector('svg', { timeout: 10000 });
    await page.waitForTimeout(500);

    const svgEl = await page.$('#diagram svg');
    if (svgEl) {
      const box = await svgEl.boundingBox();
      const vp = page.viewportSize();

      // Clipping detection
      if (box.x + box.width >= vp.width - 5 || box.y + box.height >= vp.height - 5) {
        console.error(`CLIPPED: ${diagram.name} (${Math.round(box.width)}x${Math.round(box.height)}) hits viewport ${vp.width}x${vp.height}`);
        process.exitCode = 1;
      }

      await page.screenshot({
        path: path.join(outputDir, `${prefix ? prefix + '-' : ''}${diagram.name}.png`),
        clip: {
          x: Math.max(0, box.x - PADDING),
          y: Math.max(0, box.y - PADDING),
          width: box.width + PADDING * 2,
          height: box.height + PADDING * 2
        }
      });
      console.log(`OK: ${diagram.name} (${Math.round(box.width)}x${Math.round(box.height)})`);
    } else {
      console.error(`FAIL: ${diagram.name} - SVG not found`);
      process.exitCode = 1;
    }

    await page.close();
  }

  await browser.close();
  if (process.exitCode) {
    console.error('Some diagrams failed or were clipped');
  }
})().catch(err => { console.error(err.message); process.exit(1); });
