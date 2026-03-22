---
name: neat-util-lint
description: Use when linting a skill-based project for consistency - run after any skill changes
---

# Skill Lint

**Role:** You are a senior software architect who lints skill pipelines and
standalone skills for structural integrity, logic flow consistency, code
quality, and documentation standards.

**Usage:**

- `/neat-util-lint` — lint all skills
- `/neat-util-lint <skill>` — lint only the specified skill

## Overview

Five-phase lint: structure, logic flow, code quality, documentation.

**Modes:**

- **All skills**: All five phases
- **Single skill**: Skip Phase 2, limit Phase 1 checks, scope Phases
  3-5 to skill dir

Catches interdependency issues manual review misses. User confirmation per phase.

## When to Use

**Any skill:** After creating, renaming, deleting, changing SKILL.md/scripts,
or before committing

**Skill pipelines:** After changing inputs/outputs/cross-skill references,
when suspecting drift, or before release

**Not for:** User code (use `simplify` or code review)

## Prerequisites

- `simplify` skill (Phase 4)
- `markdownlint-cli2` (optional, Phase 5)
- Git repo (optional, Phase 2 ripple check)

## Quick Reference

| Phase | What | Blocking? | Single Skill |
| --- | --- | --- | --- |
| 1. Structure | Frontmatter, completeness | FAIL blocks | Checks 1-2, 5-11 |
| 2. Logic Flow | Contracts, consistency, terminology | No | Skipped |
| 3. Tighten | Condense flagged files | No | Skill dir only |
| 4. Simplify | `/simplify` scripts | No | Skill dir only |
| 5. Markdown | markdownlint fix loop (max 3) | No | Skill dir only |

## Phase 1: Structure (automated)

Automated checks returning FAIL, WARN, or PASS.

Glob `**/SKILL.md` from project root.

**Single-skill mode:** Match `name:` field (FAIL if not found). Run checks
1-2, 5-11 (skip 3-4), skip Phase 2, scope Phases 3-5 to skill dir.

**Checks:** See [structural checks reference](references/structural-checks.md).

**Output example:**

| # | Check | Status | Detail |
| --- | --- | --- | --- |
| 1 | Skill completeness | PASS | 8/8 |
| 2 | Frontmatter validity | FAIL | `my-skill` missing Role |
| 11 | Complexity metrics | INFO | `big-skill` 220 lines, 12 conditionals |

FAIL blocks Phase 2. WARN non-blocking.

## Phase 2: Logic Flow (agent-driven)

*Skip for single-skill mode.*

Ask user: "Check logic flow and cross-skill consistency? [y/n]"

Read all SKILL.md files, trace data flow, check consistency.

### Checks

1. **Input/output contracts:** Upstream output matches downstream input
2. **Shared step consistency:** Identical logic across skills
3. **Terminology alignment:** Consistent terms
4. **Edge case coverage:** Handling when optional inputs missing
5. **Ripple effects:** `git diff HEAD~5 --name-only` (skip if not git repo
   or < 5 commits)

### Output

Present findings with severity (ERROR, WARNING, INFO), recommend SKILL.md to
fix. If issues: fix, re-run, repeat until clean or max 3 iterations.

## Phase 3: Tighten (agent-driven)

Ask user: "Tighten flagged SKILL.md files and references? [y/n]"

Target flagged skills (INFO/WARN) only.

**Per skill:** If concise (< 200 words or no clear reduction), skip.
Otherwise condense 30-50%, show before/after word count, apply with approval.

**References:**

- **All skills:** Glob `references/**/*.md` from project root +
  `<skill-dir>/references/**/*.md`
- **Single skill:** Glob `<skill-dir>/references/**/*.md` only

**Per reference:** Same as skill tightening.

See [tightening guidelines](references/skill-tightening-guidelines.md).

## Phase 4: Simplify (agent-driven)

Ask user: "Simplify script files? [y/n]"

Glob `scripts/**/*`, `/simplify` each, apply with approval.

## Phase 5: Markdown (automated fix loop)

Run `npx markdownlint-cli2` on `"**/*.md"` (all skills) or
`"path/to/skill/**/*.md"` (single skill). Fix, re-run until clean
(max 3 iterations).

## Process

See [process diagrams](references/lint-process-diagrams.md).

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Changing section structure in Phase 3 | Tighten words, not structure |
| Tightening all skills | Only tighten flagged (INFO/WARN) |
| Skipping Phase 2 | Phase 2 checks logic, not structure |
| Fixing without reading both skills | Read upstream and downstream first |
| Auto-fixing markdown blindly | Review — fixes can change meaning |
| Infinite markdownlint loop | Max 3 iterations, then stop |
| User declines all phases | Workflow exits — no changes |
| User cancels during Phase 2 fixes | Stop iteration, get confirmation |
