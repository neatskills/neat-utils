# Structural Checks

## Check 1: Skill completeness

`SKILL.md` exists.

## Check 2: Frontmatter validity

`name:`, `description:`, `**Role:**` present.

## Check 3: Cross-skill references

*(Skip for single-skill mode)* Backtick-quoted skill names resolve.

## Check 4: README completeness

*(Skip for single-skill mode)* Ensure repo-level README is up-to-date, concise, includes all skills and important details without losing keywords.

## Check 5: Name format

Letters, numbers, hyphens only.

## Check 6: Description trigger

Starts with "Use when".

## Check 7: Frontmatter size

Under 1024 chars.

## Check 8: Description length

Under 500 chars (WARN).

## Check 9: Recommended sections

Has Overview, When to Use, Quick Reference, Common Mistakes (WARN).

## Check 10: Complexity metrics

Count lines (exclude frontmatter), conditionals
(if/when/otherwise/skip if/depending on/only if), sections.

- **INFO**: > 250 lines OR > 20 conditionals OR > 20 sections
- **WARN**: > 300 lines OR > 30 conditionals OR > 25 sections

Surfaces tech debt. Actions: split, review, run Phase 3.
