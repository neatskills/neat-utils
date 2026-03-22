---
name: neat-util-insights
description: Use when the user runs /neat-util-insights - reviews Claude Code insights report, tracks suggestions in a ledger, and assists with applying them
---

# Neat Insights

**Role:** You are a senior developer experience engineer who reviews Claude Code usage insights and helps developers act on recurring suggestions.

## Overview

Parses `/insights` reports, tracks suggestions in a persistent ledger, surfaces recurring friction. Auto-tags by project, detects applied items, presents prioritized review.

## When to Use

- User runs `/neat-util-insights`
- Review accumulated suggestions after significant usage
- Track addressed vs. dismissed insights
- Surface recurring friction

**Not for:** Generating insights (use `/insights`), code quality review (use code review skills).

## Prerequisites

- Auto-runs `/insights` if report missing or stale (>1 day)
- No manual setup

## Quick Reference

| Phase | Purpose | Auto-detect |
| --- | --- | --- |
| 1 | Ensure fresh report | Runs `/insights` if missing/stale |
| 2 | Parse report | Extracts metrics, friction, features, patterns |
| 3 | Filter by context | Tags by project, filters to current context |
| 4 | Diff against ledger | Tracks recurrence, first/last seen dates |
| 5 | Auto-detect applied | Checks CLAUDE.md, settings.json, skills dir |
| 6 | Present review | Prioritizes recurring > new > applied |
| 7 | Update ledger | Saves status changes and dismiss reasons |

Output: `docs/neat_util_insights/ledger.md` (at current working directory)

Use TodoWrite to track Phases 1-7.

## Phase 1: Ensure fresh report

Check `~/.claude/usage-data/report.html`:

- **Missing:** run `/insights`
- **>1 day old:** run `/insights`
- **Fresh:** proceed

## Phase 2: Parse report

Extract from `~/.claude/usage-data/report.html`:

- `metrics` — session/message counts
- `friction` — title, description, examples
- `claudeMdSuggestions` — rule text, rationale
- `features` — title, one-liner, rationale
- `patterns` — title, summary, detail
- `projectAreas` — directories with session counts

Generate slug per item (lowercase, hyphenated, max 60 chars).

## Phase 3: Filter by context

Scan `docs/neat_util_insights/*/` for known project names.

Tag items by searching values (joined, lowercased) for project names. If no match, tag `global`.

**Filter:**

- If `basename(cwd)` matches known project: keep items tagged with that project
- Otherwise: keep `global` items

**Normalize types:**

| Parser section        | Ledger type |
|-----------------------|-------------|
| `claudeMdSuggestions` | `claude-md` |
| `friction`            | `friction`  |
| `features`            | `feature`   |
| `patterns`            | `pattern`   |

## Phase 4: Diff against ledger

Ledger: `docs/neat_util_insights/ledger.md`

**First run:** create all items as `open`, recurrence `1`, first-seen and last-seen = today.

**Subsequent runs** (match by slug):

- **New:** add as `open`, recurrence `1`
- **Existing `open`:** increment recurrence, update last-seen = today
- **Existing `applied`/`dismissed`:** no change
- **Ledger-only:** keep (historical)

Ledger header:

```text
> Format: v1 | Last updated: YYYY-MM-DD | Runs: N
```

Fields: `slug`, `type`, `title`, `status` (open/applied/dismissed), `recurrence`, `first-seen`, `last-seen`, `projects`, `dismiss-reason`.

## Phase 5: Auto-detect applied

Read and concatenate:

1. Project CLAUDE.md
2. Global CLAUDE.md (`~/.claude/CLAUDE.md`)

**claude-md:** If rule text in either CLAUDE.md, mark `applied`.

**feature:**

| Feature       | Auto-detect signal                               |
|---------------|--------------------------------------------------|
| Custom Skills | `~/.claude/skills/` contains entries             |
| Hooks         | `~/.claude/settings.json` contains `"hooks"` key |
| Task Agents   | any CLAUDE.md mentions "agent" or "subagent"     |

**friction/pattern:** Skip (manual review required).

## Phase 6: Present review

Priority order:

**1. Recurring** (`open`, recurrence >= 2):

```text
RECURRING (seen N times since YYYY-MM-DD):
"<title>"
Suggested fix: <summary>
Action? [address / dismiss / skip]
```

**2. New** (`open`, recurrence 1):

```text
NEW: "<title>"
Type: <type>
Project: <project>
Action? [address / dismiss / skip]
```

**3. Applied:**

```text
APPLIED: "<title>"
Detected in CLAUDE.md since last run
```

**Actions:**

- **address** (type-specific):
  - `claude-md`: Show rule + target. Confirm/edit. Append to CLAUDE.md. Mark `applied`.
  - `friction`: Show description + examples. Ask action. Assist. Mark `applied`.
  - `feature`: Explain + offer config. Mark `applied`.
  - `pattern`: Show summary + detail. Mark `applied` after acknowledgment.
- **dismiss**: Ask reason. Record. Mark `dismissed`.
- **skip**: Leave `open`.

## Phase 7: Update ledger

Create output directory:

```bash
mkdir -p docs/neat_util_insights
```

Save to `docs/neat_util_insights/ledger.md`.

Print summary:

```text
N addressed, N dismissed, N skipped, N auto-detected
```

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Not running `/insights` when report is stale | Auto-run if older than 1 day |
| Tagging all items as global | Match project names from existing docs directories |
| Missing auto-detected applied items | Check both project and global CLAUDE.md |
| Presenting all items at once | Prioritize: recurring first, then new, then applied |
| Not recording dismiss reasons | Always ask and save — helps future reviews |
| Overwriting ledger history | Merge new items, keep historical entries |
| User skips all items in Phase 6 | Update ledger with new recurrence counts even if no actions taken |
| User cancels during review | Save partial ledger updates to preserve recurrence tracking |
