---
name: neat-util-insights
description: Use when the user runs /neat-util-insights - reviews Claude Code insights report, tracks suggestions in a ledger, and assists with applying them
---

# Neat Insights

**Role:** You are a developer experience engineer who reviews Claude Code usage insights and helps developers act on recurring suggestions.

## Overview

Parses `/insights` reports, tracks suggestions in ledger, surfaces recurring friction. Auto-tags by project, detects applied items.

## When to Use

- User runs `/neat-util-insights`
- Review/track accumulated suggestions

**Not for:** Generating insights, code quality review.

Auto-runs `/insights` if missing or stale. No setup required.

## Quick Reference

| Phase | Purpose |
| --- | --- |
| 1 | Ensure fresh report (runs `/insights` if missing/stale) |
| 2 | Parse report (metrics, friction, features, patterns) |
| 3 | Filter by context (tags by project) |
| 4 | Diff against ledger (tracks recurrence, dates) |
| 5 | Auto-detect applied (checks CLAUDE.md, settings, skills) |
| 6 | Present review (recurring > new > applied) |
| 7 | Update ledger (saves status, reasons) |

Output: `docs/neat_util_insights/ledger.md`

## Phase 1: Ensure fresh report

Check `~/.claude/usage-data/report.html`. Run `/insights` if missing or >1 day old.

## Phase 2: Parse report

Extract: `metrics`, `friction`, `claudeMdSuggestions`, `features`, `patterns`, `projectAreas`.

Generate slug (lowercase, hyphenated, max 60 chars).

## Phase 3: Filter by context

Scan `docs/neat_util_insights/*/` for project names. Tag items by searching values (lowercased) for matches. No match = `global`.

Filter: If `basename(cwd)` matches project, keep those items. Otherwise keep `global`.

**Type normalization:** `claudeMdSuggestions` → `claude-md`, `friction` → `friction`, `features` → `feature`, `patterns` → `pattern`

## Phase 4: Diff against ledger

Ledger: `docs/neat_util_insights/ledger.md`

**First run:** Create items as `open`, recurrence `1`, dates = today.

**Subsequent runs** (match by slug):

- New: add as `open`, recurrence `1`
- Existing `open`: increment recurrence, update last-seen
- Existing `applied`/`dismissed`: no change
- Ledger-only: keep

Header: `> Format: v1 | Last updated: YYYY-MM-DD | Runs: N`

Fields: `slug`, `type`, `title`, `status`, `recurrence`, `first-seen`, `last-seen`, `projects`, `dismiss-reason`.

## Phase 5: Auto-detect applied

Read project and global CLAUDE.md.

**claude-md:** Rule text in either → mark `applied`.

**feature:** Custom Skills (check `~/.claude/skills/`), Hooks (check `settings.json`), Task Agents (check for "agent"/"subagent" in CLAUDE.md).

**friction/pattern:** Manual review only.

## Phase 6: Present review

Priority: Recurring (recurrence >= 2) > New (recurrence 1) > Applied.

Format:

- Recurring: `RECURRING (seen N times since DATE): "<title>" | Suggested fix: <summary> | Action?`
- New: `NEW: "<title>" | Type: <type> | Project: <project> | Action?`
- Applied: `APPLIED: "<title>" | Detected in CLAUDE.md`

**Actions** (address/dismiss/skip):

- **address**: Type-specific. `claude-md`: show rule, confirm, append. `friction`: show details, assist. `feature`: explain, offer config. `pattern`: show summary. Mark `applied`.
- **dismiss**: Ask reason, record, mark `dismissed`.
- **skip**: Leave `open`.

## Phase 7: Update ledger

Save to `docs/neat_util_insights/ledger.md`. Print: `N addressed, N dismissed, N skipped, N auto-detected`

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Stale report | Auto-run `/insights` if >1 day |
| All items tagged global | Match from docs directories |
| Missing auto-detected | Check both CLAUDE.md files |
| No prioritization | Recurring > new > applied |
| No dismiss reasons | Always ask and save |
| Lost history | Merge, don't overwrite |
| Skipped ledger update | Update even if no actions |
| Lost partial updates | Save on cancel |
