# Neat Insights

A Claude Code skill that parses `/insights` reports, tracks suggestions in a persistent ledger, and surfaces recurring unaddressed friction.

## Prerequisites

- No manual setup needed — the skill auto-runs `/insights` if the report is missing or stale (older than 1 day)

## Install / Uninstall

From the repo root:

```bash
./scripts/install.sh insights
./scripts/uninstall.sh insights
```

## Usage

Invoke `/neat-util-insights` from any project directory.

- **From a known project directory:** shows only suggestions tagged to that project
- **From anywhere else:** shows global suggestions (not tied to a specific project)

## How it works

1. Ensures a fresh `/insights` report (auto-runs if missing or stale)
2. Reads and parses the `/insights` HTML report directly
3. Tags each suggestion with a project (best-effort keyword matching) or `global`
4. Diffs against a persistent ledger at `docs/neat_util_insights/ledger.md`
5. Auto-detects applied items (checks both project and global CLAUDE.md, detects configured features)
6. Presents a prioritized review: recurring nags, new items, applied confirmations
7. Accepts actions per item: address / dismiss / skip

## Output

| File                                  | Purpose                                     |
|---------------------------------------|---------------------------------------------|
| `docs/neat_util_insights/ledger.md`   | Persistent suggestion tracker with statuses |
