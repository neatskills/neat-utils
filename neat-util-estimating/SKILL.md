---
name: neat-util-estimating
description: Use when doing story estimation with limited information - produces T-shirt size estimates (XS-XXL) accounting for technical complexity and uncertainty, with incremental saves and auto-pattern detection
---

# Story Estimation

**Role:** You are a solutions architect sizing user stories for technical feasibility and effort.

## Overview

When estimating backlogs, you often receive sparse user stories and must provide quick T-shirt size estimates (XS, S, M, L, XL, XXL). This skill guides structured estimation that accounts for technical complexity and uncertainty, making assumptions explicit and expressing estimates as ranges rather than false precision.

**This is solutioning, not implementation.** You assess feasibility, identify architectural patterns, recommend build/buy decisions, and size effort - but you don't write code.

**Core principle:** With minimal information, uncertainty is part of the estimate. Express it explicitly rather than hiding it.

## When to Use

**Use this skill when:**
- Estimating stories with limited requirements
- User stories provided without detailed specs
- Need quick T-shirt sizing for backlog planning
- Information gaps require making reasonable assumptions
- Estimating for pursuit/pre-sales, new projects, or initial planning

**Don't use this for:**
- Detailed spec estimation (use planning skills instead)
- Time-based estimates in hours/days (this is relative sizing)
- Sprint planning with known velocity (this is context-free sizing)
- Post-discovery detailed estimation (this is for early-stage)

## Session Workflow

### Starting a Session

**Ask at the beginning:**
```
Starting estimation for which project/product?
Brief product context: [what is it, key domains]
```

**Create estimation document:**
- File: `docs/neat_util_estimating/{project-name}-{date}.md`
- Simple format: project header + story-by-story estimates

### During Session

**For each story user provides:**
1. Estimate using the 5-phase process
2. **Immediately append to markdown file** (don't wait for batch)
3. Confirm: "Story N estimated and saved ✓"
4. **Auto-detect patterns** (check all stories so far)
5. When pattern emerges (3+ related stories), suggest build/buy opportunities
6. If user accepts build/buy suggestion, update affected stories in file
7. Continue until user indicates "done"

**CRITICAL:** Save after EVERY story, not at the end. Large backlogs require incremental saves.

### Ending Session

**When user says "that's all" or "done estimating":**
1. Summarize total stories estimated
2. **Offer MVP scoping:** "Would you like help scoping an MVP from these estimates?"
3. If yes, run MVP scoping workflow
4. Save final document

### Pattern Detection (Automatic)

**Monitor throughout session:**
- **Auth stories (3+):** Suggest Auth0, Firebase, or similar
- **Payment stories (2+):** Suggest Stripe, PayPal integration
- **Email needs (3+):** Note shared email infrastructure
- **File storage (3+):** Note shared storage solution
- **Search (2+):** Suggest Algolia, Elasticsearch

**When pattern detected:**
```
Pattern detected: [description]
Consider: [build/buy recommendation]
Affected stories: [list with size adjustments]

Should I re-estimate affected stories with this assumption?
```

## T-Shirt Size Scale

| Size | Relative Scope | Typical Indicators |
|------|----------------|-------------------|
| **XS** | Trivial | Config change, copy update, single-field addition |
| **S** | Small | Simple CRUD, basic form, single-component feature |
| **M** | Medium | Multi-component feature, standard integration, moderate complexity |
| **L** | Large | Complex feature, new integration, multiple subsystems |
| **XL** | Very Large | Major feature across systems, complex integration, high uncertainty |
| **XXL** | Epic | Multi-team effort, architectural changes, or very high unknowns |

**Important:** Sizes are **relative**, not time-based. An XS for one team may differ from another.

## The Estimation Process

### Phase 1: Parse Story

Extract from the user story:
- **Role:** Who is the user?
- **Goal:** What do they want to accomplish?
- **Benefit:** Why do they need it?
- **Implied technical work:** What systems/components are involved?

**Example:**
```
"As a user, I want to reset my password via email"
→ Role: End user
→ Goal: Password reset capability
→ Benefit: Account recovery
→ Implied: Auth system, email service, token management, UI flows
```

### Phase 2: Assess Technical Complexity

Evaluate **inherent difficulty** of the work:

**Low complexity indicators:**
- Well-established patterns (password reset, CRUD operations)
- Single system/layer
- Minimal business logic
- Standard libraries available

**High complexity indicators:**
- Novel algorithms or approaches
- Cross-system coordination
- Complex business rules
- Data migration or transformation
- Performance-critical operations

**Key:** Complexity is about **what** needs to be built, independent of team experience.

### Phase 3: Assess Uncertainty

Evaluate **risk and unknowns**:

**Low uncertainty indicators:**
- Clear requirements
- Familiar technology
- Well-documented APIs
- Team has done similar work

**High uncertainty indicators:**
- Missing requirements (data volume, scale, edge cases)
- New technology to team
- Undocumented or changing APIs
- Ambiguous acceptance criteria
- External dependencies

**Key:** Uncertainty is about **confidence level**, which inflates size estimates.

### Phase 4: Synthesize Size

Combine complexity + uncertainty → T-shirt size

**Decision framework:**

```
High Complexity + High Uncertainty → L, XL, or XXL
High Complexity + Low Uncertainty → M or L  
Low Complexity + High Uncertainty → M or L
Low Complexity + Low Uncertainty → XS, S, or M
```

**Express as range:** "**M, could be L if...**" rather than "**This is an M**"

### Phase 5: Document Reasoning

Provide conversational output with:

1. **Recommended size** (with range)
2. **Complexity breakdown** - What makes it hard/easy?
3. **Uncertainty breakdown** - What's unknown/risky?
4. **Assumptions** - What did you assume to arrive at this estimate?
5. **Shift factors** - What information would change the estimate?

**Output format:**
```
Estimate: M (Medium, could shift to L)

Complexity: [explain technical difficulty]
Uncertainty: [explain unknowns and risks]

Assumptions:
- [assumption 1]
- [assumption 2]

Could shift to L if:
- [condition 1]
- [condition 2]

Could shift to S if:
- [condition 3]
```

## Quick Reference

**Key Factors:**

| Factor | Impact | Questions to Ask |
|--------|--------|------------------|
| **Technical Complexity** | Base size | How hard is the work itself? |
| **Uncertainty** | Inflates size | How much is unknown? |
| **Scope** | Scales size | How many components affected? |
| **Dependencies** | Adds risk | What external factors exist? |

**When information is missing:**
1. Make **reasonable assumptions** (document them)
2. Express **uncertainty in final estimate**
3. Identify **what info would change the estimate**
4. Don't refuse to estimate—estimate with caveats

**Incremental estimation:**
- Maintain same rigor for each story
- Don't copy-paste reasoning
- Monitor for patterns across stories
- Each story deserves fresh analysis
- Save after each story (don't batch saves)

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Estimating time, not size | Use relative comparison ("bigger than X"), avoid hours/days |
| Ignoring uncertainty | High uncertainty = larger size. Make it explicit. |
| Over-precision with minimal info | Express as range: "M, could be S-L" not "This is an M" |
| Not documenting assumptions | List every assumption—they're your escape hatches |
| Conflating complexity with uncertainty | Separate: "technically simple but high risk due to unknowns" |
| Hiding caveats in analysis | Put uncertainty in final estimate, not just reasoning |
| Degrading quality over time | Last estimate should be as rigorous as first |
| Missing pattern opportunities | Monitor across stories for build/buy chances |
| Not saving incrementally | Save after each story, don't wait until end |

## Red Flags - STOP and Reconsider

These thoughts mean you're violating the principle:

| Red Flag | Reality |
|----------|---------|
| "This is definitely a [size]" | With sparse info, there's always uncertainty. Express it. |
| "I'll estimate 2-3 days" | That's time, not size. Use T-shirt scale. |
| "I can't estimate without more info" | Make reasonable assumptions and caveat the estimate. |
| "This is simple so it's Small" | Uncertainty can make simple things large. Consider both dimensions. |
| Giving point estimate after noting many unknowns | If you listed unknowns, reflect them in estimate range. |
| Copy-pasting reasoning across stories | Each story deserves fresh analysis. |

**All of these mean: Revisit your estimate and express uncertainty explicitly.**

## Key Principles

1. **Uncertainty inflates estimates** - When in doubt, size up and explain why
2. **Separate complexity from uncertainty** - Simple + unknown ≠ complex
3. **Assumptions are documentation** - Every gap you filled is an assumption
4. **Ranges over points** - "M-L" is more honest than "M" with sparse info
5. **Caveats in conclusion** - Don't bury them in analysis

## Success Criteria

Your estimate is complete when you've provided:

- T-shirt size (XS, S, M, L, XL, XXL) with uncertainty range
- ✅ Complexity breakdown (what makes it hard/easy)
- ✅ Uncertainty breakdown (what's unknown/risky)
- ✅ Explicit list of assumptions
- ✅ Conditions that would shift the estimate up or down
- ✅ Conversational, user-facing format

## Examples

### Example 1: Clear Requirements

**Story:** "As a user, I want to log out of my account"

**Estimate:** **XS (Extra Small)**

**Complexity:** Very low—clearing session/token and redirecting to login.

**Uncertainty:** Very low—logout is a standard pattern with clear requirements.

**Assumptions:**
- Session management already exists
- Simple redirect to login page

**Could shift to S if:** Logout needs to cascade across multiple systems or sync with SSO provider.

---

### Example 2: Missing Context

**Story:** "As an admin, I want to generate monthly reports"

**Estimate:** **L (Large, could be M-XL depending on scope)**

**Complexity:** Medium to High—depends on report complexity, data aggregation needs, and output format.

**Uncertainty:** High—"monthly reports" is vague. What data? What format? What calculations?

**Assumptions:**
- Reports are pre-defined (not user-configurable)
- Data exists in queryable format
- PDF or CSV output
- ~5-10 report types
- Async generation (background job)

**Could shift to M if:**
- Only 1-2 simple reports
- Data is already aggregated
- No complex calculations

**Could shift to XL if:**
- User-configurable report builder needed
- Complex data transformations required
- Real-time generation constraints
- Heavy customization (branding, templates)

---

### Example 3: New Technology

**Story:** "As a developer, I want to integrate Stripe for payments"

**Context:** Team has not used Stripe before.

**Estimate:** **L (Large)**

**Complexity:** Medium—Stripe is well-documented, but payment flows involve frontend + backend + webhooks.

**Uncertainty:** High—team learning curve, unknown edge cases, testing requirements unclear.

**Assumptions:**
- One-time payments only (not subscriptions)
- Using Stripe Checkout (not custom Elements UI)
- Single currency
- Basic error handling

**Could shift to M if:**
- Team has payment gateway experience (just not Stripe)
- Very simple checkout flow
- Minimal error handling needed

**Could shift to XL if:**
- Subscriptions + one-time payments
- Complex multi-currency logic
- Custom UI requirements
- Refunds/disputes handling included

**Recommendation:** Consider spike story first to reduce uncertainty, then re-estimate implementation.

---

## MVP Scoping Workflow

**Trigger:** After all stories estimated, offer: "Would you like help scoping an MVP?"

### Step 1: Gather Business Context

Ask the user:
1. **Core value:** What's the primary problem this MVP must solve?
2. **Key user journey:** What critical path must users complete?
3. **Constraints:** Any budget, timeline, or team size limits?
4. **Must-haves:** Features with hard commitments or requirements?
5. **Risk tolerance:** Conservative (more features) or lean (minimal)?

### Step 2: Analyze and Recommend

Based on estimates + user input:
- **MVP Scope:** Essential stories (with rationale)
- **Post-MVP:** Deferred stories (with reasoning)
- **Out of Scope:** Stories not needed (explain why)
- **Total MVP effort estimate**
- **Risks/gaps** in proposed MVP

### Step 3: Save MVP Section

Append to estimation document:
```markdown
---

## MVP Scoping

**Core Value:** [from user]
**Key User Journey:** [from user]
**Constraints:** [from user]

### MVP Scope (X stories)
- Story 1: [title] - [size] - [why MVP]
- Story 3: [title] - [size] - [why MVP]

### Post-MVP (Y stories)
- Story 5: [title] - [size] - [why deferred]

### Out of Scope (Z stories)
- Story 10: [title] - [size] - [why excluded]

**MVP Effort:** [summary]
**Rationale:** [explain scoping logic]
**Risks:** [gaps or concerns]
```

## File Format

### Estimation Document Structure

**Location:** `docs/neat_util_estimating/{project-name}-{date}.md`

**Format:**
```markdown
# Estimation: {Project Name}

**Date:** {date}
**Product Context:** {description}

---

## Story 1: {Title}
**Size:** {size} (with range if applicable)
**Complexity:** {explanation}
**Uncertainty:** {explanation}
**Assumptions:**
- {assumption 1}
- {assumption 2}

**Could shift to {size} if:** {conditions}

---

## Story 2: {Title}
...

---

## Pattern Notes

**Auth Pattern Detected** (Stories 1, 3, 5)
- Recommendation: Use Auth0
- Impact: Reduces Stories 1,3,5 from M→S

**Shared Email Infrastructure** (Stories 2, 7, 9)
- Recommendation: Centralize email service
- Already factored into estimates

---

## MVP Scoping
(Added after scoping workflow)
```

### Save Strategy

**CRITICAL: Incremental saves required**

- **After each story:** Append to file immediately (use Edit tool to append)
- **Confirmation:** Show "Story N estimated and saved ✓" after each save
- **After pattern detection:** Update pattern notes section in file
- **If build/buy accepted:** Update affected stories in file with revised estimates
- **After MVP scoping:** Append MVP section to file

**Why incremental:** Large backlogs (50+ stories) take multiple sessions. Saving only at the end risks data loss if session interrupted.

**How to save:**
```
After estimating Story 1:
1. Read current file
2. Append Story 1 section
3. Write updated content
4. Confirm: "Story 1 estimated and saved ✓"

After estimating Story 2:
1. Read current file  
2. Append Story 2 section
3. Write updated content
4. Confirm: "Story 2 estimated and saved ✓"

Continue for each story...
```
