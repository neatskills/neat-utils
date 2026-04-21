---
name: neat-util-lint
description: Use when linting a skill-based project for consistency - run after any skill changes
---

# Skill Lint

**Role:** You are a software architect who lints skill pipelines and standalone skills for structural integrity, logic flow, code quality, and documentation.

**Usage:**

- `/neat-util-lint` — lint all skills
- `/neat-util-lint <skill>` — lint only the specified skill

## Overview

Six-phase lint: logic flow, structure, code quality, documentation, project health.

**Modes:**

- **All skills**: All six phases
- **Single skill**: Skip Phase 1, limit Phase 2 checks, scope Phases 3-5 to skill dir, run Phase 6

Catches interdependency issues manual review misses.

## When to Use

- After creating, renaming, deleting, changing SKILL.md/scripts, or before committing
- After changing inputs/outputs/cross-skill references, suspecting drift, or before release
- Not for user code (use `simplify` or code review)

## Prerequisites

- `simplify` skill (Phase 4)
- `markdownlint-cli2` (optional, Phase 5)
- Git repo (optional, Phase 1 ripple check)

## Quick Reference

| Phase | What | Blocking? | Single Skill |
| --- | --- | --- | --- |
| 1. Logic Flow | Contracts, consistency, terminology | No | Skipped |
| 2. Structure | Frontmatter, completeness, README | FAIL blocks | Checks 1-2, 5-10 |
| 3. Tighten | Condense flagged files | No | Skill dir only |
| 4. Simplify | `/simplify` scripts | No | Skill dir only |
| 5. Markdown | markdownlint fix loop (max 3) | No | Skill dir only |
| 6. Project Health | Dependencies, security, lockfiles | No | Always runs |

## Phase 1: Logic Flow (agent-driven)

*Skip for single-skill mode.*

Ask user: "Check logic flow and cross-skill consistency? [y/n/stop]"

If user responds "stop", exit immediately without proceeding to remaining phases.

### Checks

1. **Input/output contracts:** Upstream output matches downstream input
2. **Shared step consistency:** Identical logic across skills
3. **Terminology alignment:** Consistent terms
4. **Edge case coverage:** Handling when optional inputs missing
5. **Ripple effects:** `git diff HEAD~5 --name-only` (skip if not git repo or < 5 commits)

Present findings with severity (ERROR, WARNING, INFO). User options:
1. **Fix all** → Fix everything, re-run Phase 1, repeat cycle
2. **Fix some, mark others as non-issues** → Fix selected, suppress non-issues (comment or ignore pattern), re-run Phase 1, repeat cycle
3. **Fix some, leave others** → Fix selected only, proceed to Phase 2
4. **Skip** → Proceed to Phase 2

Repeat cycle (fix → re-check → present) only for options 1-2. For option 2, ensure suppressed findings don't appear in subsequent iterations.

## Phase 2: Structure (automated + agent review)

Automated checks returning FAIL, WARN, or PASS. Glob `**/SKILL.md`.

**Single-skill mode:** Match `name:` field (FAIL if not found). Run checks 1-2, 5-10 (skip 3-4).

**Check 4 (README completeness):** Agent ensures single repo-level README exists and documents all skills. Skill-level READMEs are not required.

See [structural checks reference](references/structural-checks.md). FAIL blocks Phase 3. Present FAIL and WARN items. User options:
1. **Fix all** → Fix everything, re-run Phase 2, repeat cycle
2. **Fix some, mark others as non-issues** → Fix selected, document why others are acceptable, re-run Phase 2, repeat cycle
3. **Fix some, leave others** → Fix selected only, proceed to Phase 3 (blocks if FAIL remains)
4. **Skip** → Proceed to Phase 3 (blocks if FAIL remains)

Repeat cycle only for options 1-2. WARN non-blocking.

## Phase 3: Tighten (agent-driven)

Ask user: "Tighten flagged SKILL.md files and references? [y/n/stop]"

If user responds "stop", exit immediately without proceeding to remaining phases.

Target flagged skills (INFO/WARN). Skip if < 200 words or no clear reduction. Otherwise condense 30-50%, show word count, apply with approval.

**References:**

- **All skills:** Glob `references/**/*.md` + `<skill-dir>/references/**/*.md`
- **Single skill:** Glob `<skill-dir>/references/**/*.md`

**Principles:** Cut explanatory prose, keep operational instructions. Use tables/lists over paragraphs. Preserve Quick Reference, Common Mistakes, and critical decision points. Don't change section structure.

## Phase 4: Simplify (agent-driven)

Ask user: "Simplify script files? [y/n/stop]"

If user responds "stop", exit immediately without proceeding to remaining phases.

Glob `scripts/**/*`, `/simplify` each, apply with approval.

## Phase 5: Markdown (automated fix loop)

Run `npx markdownlint-cli2` on `"**/*.md"` or `"path/to/skill/**/*.md"`. Present warnings. User options:
1. **Fix all** → Fix everything, re-run Phase 5, repeat cycle
2. **Fix some, mark others as non-issues** → Fix selected, add to `.markdownlint-cli2.jsonc` ignore rules, re-run Phase 5, repeat cycle
3. **Fix some, leave others** → Fix selected only, proceed to Phase 6
4. **Skip** → Proceed to Phase 6

Repeat cycle only for options 1-2.

## Phase 6: Project Health (automated)

Ask user: "Check project dependencies? [y/n/stop]"

If user responds "stop", exit immediately.

Quick project infrastructure checks. Skip if user declines or no package.json.

### Health Checks

1. **Outdated packages:** `npm outdated`
2. **Security audit:** `npm audit --production`
3. **Lock file:** Check package-lock.json matches package.json
4. **Unused dependencies:** Compare package.json deps to imports (optional)

Present findings with status (PASS/WARN/INFO/FAIL). Non-blocking. Recommend `npm audit fix` if security FAIL.

## Process

See [process diagrams](references/lint-process-diagrams.md).

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Skipping Phase 6 | Quick checks (< 30s) |
| Ignoring security FAIL | Recommend fix, non-blocking |
| Updating deps without testing | User decides when |
| Running npm on non-Node.js | Check package.json first |
| Exiting when Phase 6 declined | Continue — optional |
| Changing section structure | Tighten words only |
| Tightening all skills | Only flagged (INFO/WARN) |
| Skipping Phase 1 | Checks logic flow |
| Fixing without reading | Read upstream/downstream |
| Auto-fixing markdown | Review first |
| Infinite markdownlint loop | Max 3 iterations |
| User declines all phases | Workflow exits |
| User cancels Phase 1 fixes | Stop, get confirmation |
| Proceeding after "stop" | Exit immediately |
