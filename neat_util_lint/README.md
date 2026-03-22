# neat-util-lint

Five-phase lint for skill-based projects that checks structural integrity,
logic flow consistency, code quality, and documentation standards.

## Usage

- `/neat-util-lint` — lint all skills
- `/neat-util-lint <skill>` — lint only the specified skill

## When to Use

**Any skill:**

- After creating, renaming, or deleting
- After changing SKILL.md or scripts
- Before committing

**Skill pipelines:**

- After changing inputs, outputs, or cross-skill references
- When suspecting drift between skills
- Before release

**Not for:** User code (use `simplify` or code review).

## Prerequisites

- `simplify` skill (Phase 4)
- `markdownlint-cli2` (optional, Phase 5) — install:
  `npm install -g markdownlint-cli2`
- Git repo (optional, Phase 2 ripple check)

## Quick Reference

| Phase | What | Blocking? | Single Skill |
| --- | --- | --- | --- |
| 1. Structure | Frontmatter, completeness | FAIL blocks | Checks 1-2, 5-11 |
| 2. Logic Flow | Contracts, consistency, terminology | No | Skipped |
| 3. Tighten | Condense flagged SKILL.md and references | No | Skill dir only |
| 4. Simplify | `/simplify` scripts | No | Skill dir only |
| 5. Markdown | markdownlint fix loop (max 3) | No | Skill dir only |

## Phases

1. **Structure** — skill folders, frontmatter, README consistency, cross-skill references
2. **Logic flow** — input/output contracts, shared step consistency,
   terminology, edge cases
3. **Tighten** — condense flagged SKILL.md files and references
4. **Simplify** — invoke `/simplify` on all scripts
5. **Markdown** — runs markdownlint, fixes until zero warnings

Phase 1 FAIL items must be fixed before proceeding. Phases run in order —
each builds on the previous.

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Changing section structure in Phase 3 | Tighten words, not structure |
| Tightening all skills | Only tighten flagged skills (INFO/WARN) |
| Skipping Phase 2 | Phase 2 checks logic, not structure |
| Fixing without reading both skills | Read upstream and downstream first |
| Auto-fixing markdown blindly | Review — fixes can change meaning |
| Infinite markdownlint loop | Max 3 iterations, then stop |
| User declines all phases | Workflow exits — no changes made |
| User cancels during Phase 2 fixes | Stop iteration, get confirmation |
