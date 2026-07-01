---
name: neat-util-estimating
description: Use when doing story estimation with limited information - produces T-shirt size estimates (XS-XXL) accounting for technical complexity and risk, with auto-pattern detection
---

# Story Estimation

**Role:** Solutions architect sizing user stories for technical feasibility
and effort.

## Overview

Provide T-shirt size estimates (XS-XXL) for sparse user stories,
accounting for technical complexity and risk. Make assumptions explicit,
express estimates as ranges.

**This is solutioning, not implementation.** Assess feasibility, identify
patterns, recommend build/buy, size effort.

**Core principle:** Express risk explicitly rather than hiding it.

## When to Use

**Use when:**

- Stories have limited requirements or minimal specs
- Quick T-shirt sizing needed for backlog planning
- Information gaps require reasonable assumptions
- Pursuit/pre-sales, new projects, initial planning

**Don't use for:**

- Detailed spec estimation (use planning skills)
- Time-based estimates (this is relative sizing)
- Sprint planning with known velocity
- Post-discovery detailed estimation

## Session Workflow

### Starting a Session

Ask:

```text
Starting estimation for which project/product?
Brief product context: [what is it, key domains]

Please provide stories to estimate (paste one or multiple):
```

**Output:** `docs/estimations/{project-name}-{date}.md`

### Input Processing

Accept: numbered lists, bullets, line-separated, user story format, simple descriptions.

**Parse with reasoning:**

1. Read entire input
2. Identify story boundaries
3. Extract distinct stories
4. Confirm with user: "I found X stories: [list]. Proceed? (y/n)"

### Estimation Process

1. Parse and confirm stories
2. Estimate each using 4-phase process
3. Detect patterns across stories
4. Offer build/buy recommendations
5. Save complete document once
6. Offer MVP scoping

### Pattern Detection

**Patterns to detect:**

- Auth (3+): Auth0, Firebase
- Payment (2+): Stripe, PayPal
- Email (3+): Shared infrastructure
- File storage (3+): Shared solution
- Search (2+): Algolia, Elasticsearch

Offer pattern notes when detected.

## T-Shirt Size Scale

| Size | Scope | Indicators |
| ---- | ----- | ---------- |
| XS | Trivial | Config, copy, single field |
| S | Small | Simple CRUD, basic form |
| M | Medium | Multi-component, standard integration |
| L | Large | Complex feature, multiple subsystems |
| XL | Very Large | Major cross-system, high risk |
| XXL | Epic | Multi-team, architectural changes |

Sizes are relative, not time-based.

## The Estimation Process

### Phase 1: Parse Story

Extract: Role, Goal, Benefit (if provided), Implied technical work.

### Phase 2: Assess Technical Complexity

**Low:** Established patterns, single system, minimal logic, standard
libraries

**High:** Novel algorithms, cross-system coordination, complex rules,
migrations, performance-critical

Complexity = what needs to be built, independent of team experience.

### Phase 3: Assess Risk

How likely is this story to explode in scope (3x)?

**Low risk:** Well-bounded scope, familiar pattern, clear "done", minimal
dependencies

**High risk:** Vague requirements, words like
"integrate/migrate/refactor" without specifics, new tech, external
dependencies, undefined edge cases/performance/security

**Key questions:**

- Could this be 3x bigger?
- Hidden dependencies?
- "Done" clearly defined?

### Phase 4: Synthesize Size & Document

**Decision framework:**

```text
High Complexity + High Risk → L, XL, or XXL
High Complexity + Low Risk → M or L  
Low Complexity + High Risk → M or L
Low Complexity + Low Risk → XS, S, or M
```

**Output format:**

```markdown
## Story N: [Title]

**Size:** M (could be L if scope expands)

**Complexity:** [2-3 sentences]

**Risk:** [2-3 sentences on scope explosion]

**Assumptions:**
- [key assumption 1]
- [key assumption 2]
- [key assumption 3]

**Watch for:** [1-2 specific escalation conditions]
```

## Quick Reference

| Factor | Impact | Question |
| ------ | ------ | -------- |
| Complexity | Base size | How hard is the work? |
| Risk | Inflates size | How likely is 3x scope expansion? |
| Scope | Scales size | How many components? |
| Dependencies | Adds risk | External factors? |

**When info missing:** Make assumptions (document them), express risk,
identify what would change estimate.

**Quality:** Maintain rigor for each story, don't copy-paste, monitor
patterns, be concise (2-3 sentences).

## Common Mistakes & Red Flags

| Don't | Do |
| ----- | --- |
| Estimate time | Use relative sizing |
| Ignore risk | Make it explicit, size up |
| Over-precision | Express as range |
| Skip assumptions | List 3-5 key items |
| Conflate complexity/risk | Separate them |
| Write paragraphs | 2-3 sentences per section |
| Copy-paste reasoning | Fresh analysis each story |
| "This is definitely [size]" | Express risk |
| "Can't estimate without info" | Make assumptions + caveats |

## Key Principles

1. Risk inflates estimates
2. Separate complexity from risk
3. Assumptions = documentation
4. Express risk in size
5. Be concise (2-3 sentences)

## Examples

### Example 1: Clear, Bounded Story

**Story:** "As a user, I want to log out of my account"

**Size:** XS

**Complexity:** Clearing session/token, redirect to login. Standard pattern.

**Risk:** Well-bounded scope, pattern rarely surprises, clear "done".

**Assumptions:** Session management exists, simple redirect, no multi-system coordination.

**Watch for:** SSO integration → S.

---

### Example 2: Vague, High Risk

**Story:** "As an admin, I want to generate monthly reports"

**Size:** L (could be M-XL)

**Complexity:** Data aggregation, formatting, async processing. Scales
with report types and calculations.

**Risk:** Vague—could 3x. "Generate reports" hides edge cases. Missing:
data, format, calculations, how many types.

**Assumptions:** 5-10 pre-defined types, queryable data, PDF/CSV, async,
basic calculations.

**Watch for:** User-configurable builder or complex transforms → XL.
Single simple report → M.

---

### Example 3: New Tech, External Dependency

**Story:** "As a developer, I want to integrate Stripe for payments"

**Size:** L

**Complexity:** Frontend + backend + webhooks. Well-documented but
requires checkout UI, server processing, webhook handling.

**Risk:** "Integrate" hides scope. Team unfamiliar with Stripe. External
API adds unknowns. Edge cases (failed payments, webhooks, testing) could
3x.

**Assumptions:** One-time payments, Stripe Checkout, single currency,
basic errors, test mode.

**Watch for:** Subscriptions, multi-currency, custom UI,
refunds/disputes → XL. Consider spike story.

---

## MVP Scoping Workflow

**Trigger:** After all estimates, offer: "Would you like help scoping an MVP?"

### Step 1: Gather Context

Ask: Core value, key user journey, constraints, must-haves, risk
tolerance.

### Step 2: Analyze & Recommend

Provide: MVP scope (with rationale), post-MVP deferred, out of scope,
effort estimate, risks/gaps.

### Step 3: Save MVP Section

Append to estimation document:

```markdown
---

## MVP Scoping

**Core Value:** [from user]
**Key User Journey:** [from user]
**Constraints:** [from user]

### MVP Scope (X stories)
- Story 1: [title] - [size] - [rationale]

### Post-MVP (Y stories)
- Story 5: [title] - [size] - [rationale]

### Out of Scope (Z stories)
- Story 10: [title] - [size] - [rationale]

**MVP Effort:** [summary]
**Rationale:** [scoping logic]
**Risks:** [gaps/concerns]
```

## File Format

**Location:** `docs/estimations/{project-name}-{date}.md`

**Structure:**

```markdown
# Estimation: {Project Name}

**Date:** {date}
**Product Context:** {description}

---

## Story 1: {Title}

**Size:** {size with risk}

**Complexity:** {2-3 sentences}

**Risk:** {2-3 sentences on scope explosion}

**Assumptions:**
- {key assumption 1}
- {key assumption 2}

**Watch for:** {1-2 escalation conditions}

---

## Pattern Notes

**Auth Pattern** (Stories 1, 3, 5)
- Recommendation: Use Auth0
- Impact: Reduces M→S

---

## MVP Scoping
(If requested)
```

**Save strategy:** Process all stories, save once with pattern notes. If
MVP scoping requested, append and save again.
