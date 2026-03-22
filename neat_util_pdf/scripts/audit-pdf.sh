#!/usr/bin/env bash
#
# Audits a PDF for layout issues by extracting text per page.
# Flags pages with fewer than a threshold of text characters as suspect.
#
# Usage:
#   audit-pdf.sh <pdf-file> [threshold] [skip-page]
#
# Arguments:
#   pdf-file    Path to the PDF to audit
#   threshold   Min text chars per page (default: 200)
#   skip-page   Page number to skip, e.g., cover page (default: 1)
#
# Output:
#   One line per suspect page: "SUSPECT page N (X chars): preview..."
#   Exit code 0 if no suspect pages, 1 if any found.
#
# Requires: poppler-utils (pdftotext, pdfinfo)

set -euo pipefail

PDF="${1:?Usage: audit-pdf.sh <pdf-file> [threshold] [skip-page]}"
THRESHOLD="${2:-200}"
SKIP_PAGE="${3:-1}"

if ! command -v pdftotext &>/dev/null; then
  echo "ERROR: pdftotext not found. Install poppler: brew install poppler (macOS) or apt install poppler-utils (Linux)" >&2
  exit 2
fi

if [ ! -f "$PDF" ]; then
  echo "ERROR: File not found: $PDF" >&2
  exit 2
fi

PAGES=$(pdfinfo "$PDF" 2>/dev/null | grep Pages | awk '{print $2}')
SUSPECTS=0

for i in $(seq 1 "$PAGES"); do
  # Skip designated page (e.g., cover)
  if [ "$i" -eq "$SKIP_PAGE" ]; then
    continue
  fi

  text=$(pdftotext -f "$i" -l "$i" "$PDF" - 2>/dev/null)
  chars=$(echo -n "$text" | wc -c | tr -d ' ')

  if [ "$chars" -lt "$THRESHOLD" ]; then
    preview=$(echo "$text" | head -2 | tr '\n' ' ' | cut -c1-100)
    echo "SUSPECT page $i ($chars chars): $preview"
    SUSPECTS=$((SUSPECTS + 1))
  fi
done

if [ "$SUSPECTS" -gt 0 ]; then
  echo "---"
  echo "$SUSPECTS suspect page(s) found (threshold: $THRESHOLD chars)"
  exit 1
else
  echo "All pages OK ($PAGES pages, threshold: $THRESHOLD chars)"
  exit 0
fi
