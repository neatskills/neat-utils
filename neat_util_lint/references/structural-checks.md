# Phase 1 Checks

## Check 1: Skill completeness

`SKILL.md` and `README.md` exist.

## Check 2: Frontmatter validity

`name:`, `description:`, `**Role:**` present.

## Check 3: Cross-skill references

*(Skip for single-skill mode)* Backtick-quoted skill names resolve.

## Check 4: README consistency

*(Skip for single-skill mode)* Top-level README lists discovered skills only.

## Check 5: README up-to-date

README matches SKILL.md. WARN if stale.

## Check 6: Name format

Letters, numbers, hyphens only.

## Check 7: Description trigger

Starts with "Use when".

## Check 8: Frontmatter size

Under 1024 chars.

## Check 9: Description length

Under 500 chars (WARN).

## Check 10: Recommended sections

Has Overview, When to Use, Quick Reference, Common Mistakes (WARN).

## Check 11: Complexity metrics

Count lines (exclude frontmatter), conditionals
(if/when/otherwise/skip if/depending on/only if), sections.

- **INFO**: > 200 lines OR > 20 conditionals OR > 15 sections
- **WARN**: > 250 lines OR > 30 conditionals OR > 20 sections

Surfaces tech debt. Actions: split, review, run Phase 3.
