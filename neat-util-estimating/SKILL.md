---
name: neat-util-estimating
description: Use when doing story estimation with limited information - produces T-shirt size estimates (XS-XXL) accounting for technical complexity and risk, with auto-pattern detection
---

# Story Estimation

**Role:** You are a solutions architect sizing user stories for technical feasibility and effort.

## Overview

When estimating backlogs, you often receive sparse user stories and must provide quick T-shirt size estimates (XS, S, M, L, XL, XXL). This skill guides structured estimation that accounts for technical complexity and risk, making assumptions explicit and expressing estimates as ranges rather than false precision.

**This is solutioning, not implementation.** You assess feasibility, identify architectural patterns, recommend build/buy decisions, and size effort - but you don't write code.

**Core principle:** With minimal information, risk is part of the estimate. Express it explicitly rather than hiding it.

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

Please provide stories to estimate (paste one or multiple):
```

**Create estimation document structure:**
- File: `docs/estimations/{project-name}-{date}.md`
- Will contain: project header + all story estimates + pattern notes + optional MVP scoping

### Input Processing

**Accept flexible input formats:**
- Single story or multiple stories in one paste
- Numbered lists (1., 2., 3.)
- Bullet points (-, *)
- Simple line-separated stories
- User story format ("As a... I want... so that...")
- Or simple descriptions ("Add login feature")

**Use reasoning to parse:**
1. Read entire user input
2. Identify story boundaries (numbers, bullets, blank lines, story patterns)
3. Extract each distinct story
4. Create internal story list for processing

**Example parsing:**
```
Input:
1. As a user, I want to reset my password
2. Admin dashboard
- Add email notifications
Configure CI/CD pipeline

Parsed result:
Story 1: "As a user, I want to reset my password"
Story 2: "Admin dashboard"
Story 3: "Add email notifications"
Story 4: "Configure CI/CD pipeline"
```

### Estimation Process

**For the batch of stories:**
1. Parse input into story list using reasoning
2. Confirm parsed stories with user: "I found X stories: [list titles]. Proceed? (y/n)"
3. If confirmed, estimate each story using 4-phase process (see below)
4. After all estimates complete, detect patterns across stories
5. If patterns found, offer build/buy recommendations
6. Save complete estimation document once
7. Offer MVP scoping

**No incremental saves** - Process all stories, then save once at end.

### Pattern Detection (After All Estimates)

**Analyze all estimates together:**
- **Auth stories (3+):** Suggest Auth0, Firebase, or similar
- **Payment stories (2+):** Suggest Stripe, PayPal integration
- **Email needs (3+):** Note shared email infrastructure
- **File storage (3+):** Note shared storage solution
- **Search (2+):** Suggest Algolia, Elasticsearch

**When pattern detected:**
```
Pattern detected: [description]
Consider: [build/buy recommendation]
Affected stories: [list]

This could reduce complexity/scope. Should I add pattern notes?
```

### Ending Session

**After all stories estimated:**
1. Save complete estimation document
2. Show summary: "Estimated X stories, saved to [filepath]"
3. **Offer MVP scoping:** "Would you like help scoping an MVP from these estimates?"
4. If yes, run MVP scoping workflow (see below)

## T-Shirt Size Scale

| Size | Relative Scope | Typical Indicators |
|------|----------------|-------------------|
| **XS** | Trivial | Config change, copy update, single-field addition |
| **S** | Small | Simple CRUD, basic form, single-component feature |
| **M** | Medium | Multi-component feature, standard integration, moderate complexity |
| **L** | Large | Complex feature, new integration, multiple subsystems |
| **XL** | Very Large | Major feature across systems, complex integration, high risk |
| **XXL** | Epic | Multi-team effort, architectural changes, or very high risk |

**Important:** Sizes are **relative**, not time-based. An XS for one team may differ from another.

## The Estimation Process

### Phase 1: Parse Story

Extract from the user story:
- **Role:** Who is the user?
- **Goal:** What do they want to accomplish?
- **Benefit:** Why do they need it? (if provided)
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

### Phase 3: Assess Risk

**Context:** High-level estimation based on limited information means unknowns exist. The question isn't "how uncertain are we?" but rather "how likely is this story to explode in scope?"

**Low risk indicators:**
- Story scope is well-bounded ("add logout button")
- Pattern is familiar and rarely has surprises
- Clear definition of "done"
- Minimal external dependencies
- Team has done nearly identical work

**High risk indicators:**
- Vague requirements ("improve admin dashboard")
- Words like "integrate", "migrate", "refactor" without specifics
- New technology or unfamiliar domain
- External dependencies (third-party APIs, other teams)
- Edge cases likely ("handle all file types", "support all browsers")
- Performance requirements undefined
- Security/compliance implications

**Key questions:**
- Could this be 3x bigger than it first appears?
- Are there hidden dependencies that will surface mid-work?
- Is "done" clearly defined or will it grow during implementation?

### Phase 4: Synthesize Size & Document

Combine complexity + risk → T-shirt size

**Decision framework:**

```
High Complexity + High Risk → L, XL, or XXL
High Complexity + Low Risk → M or L  
Low Complexity + High Risk → M or L
Low Complexity + Low Risk → XS, S, or M
```

**Output format (concise):**
```
## Story N: [Title]

**Size:** M (could be L if scope expands)

**Complexity:** [2-3 sentences on technical difficulty]

**Risk:** [2-3 sentences on scope expansion likelihood]

**Assumptions:**
- [key assumption 1]
- [key assumption 2]
- [key assumption 3]

**Watch for:** [1-2 specific things that would push estimate up]
```

**Key principle:** Keep it concise. High-level estimates don't need exhaustive analysis. Focus on the factors that drive size and risk.

## Quick Reference

**Key Factors:**

| Factor | Impact | Questions to Ask |
|--------|--------|------------------|
| **Technical Complexity** | Base size | How hard is the work itself? |
| **Risk** | Inflates size | How likely is scope to explode 3x? |
| **Scope** | Scales size | How many components affected? |
| **Dependencies** | Adds risk | What external factors exist? |

**When information is missing:**
1. Make **reasonable assumptions** (document them)
2. Express **risk in final estimate**
3. Identify **what info would change the estimate**
4. Don't refuse to estimate—estimate with caveats

**Batch estimation:**
- Maintain same rigor for each story
- Don't copy-paste reasoning
- Monitor for patterns across stories
- Each story deserves fresh analysis
- Process all stories before saving

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Estimating time, not size | Use relative comparison ("bigger than X"), avoid hours/days |
| Ignoring risk | High risk = larger size. Make it explicit. |
| Over-precision with minimal info | Express as range: "M, could be L if scope expands" |
| Not documenting assumptions | List key assumptions—they're your escape hatches |
| Conflating complexity with risk | Separate: "technically simple but high explosion risk" |
| Verbose analysis | Keep to 2-3 sentences per section. High-level = concise. |
| Degrading quality over time | Last estimate should be as rigorous as first |
| Missing pattern opportunities | Monitor across stories for build/buy chances |

## Red Flags - STOP and Reconsider

These thoughts mean you're violating the principle:

| Red Flag | Reality |
|----------|---------|
| "This is definitely a [size]" | With sparse info, there's always risk. Express it. |
| "I'll estimate 2-3 days" | That's time, not size. Use T-shirt scale. |
| "I can't estimate without more info" | Make reasonable assumptions and caveat the estimate. |
| "This is simple so it's Small" | Risk can make simple things large. Consider both dimensions. |
| Giving point estimate after noting explosion risks | If you listed risks, reflect them in estimate. |
| Copy-pasting reasoning across stories | Each story deserves fresh analysis. |
| Writing multi-paragraph analysis | Keep it concise: 2-3 sentences per section. |

**All of these mean: Revisit your estimate and express risk explicitly.**

## Key Principles

1. **Risk inflates estimates** - When scope explosion is likely, size up and explain why
2. **Separate complexity from risk** - Simple + high explosion risk ≠ complex
3. **Assumptions are documentation** - List key assumptions, not all possible ones
4. **Express risk in size** - "M (could be L if scope expands)" not just "M"
5. **Be concise** - High-level estimates need 2-3 sentences, not paragraphs

## Success Criteria

Your estimate is complete when you've provided:

- ✅ T-shirt size (XS, S, M, L, XL, XXL) with risk expressed
- ✅ Complexity breakdown (2-3 sentences on technical difficulty)
- ✅ Risk breakdown (2-3 sentences on scope explosion likelihood)
- ✅ Key assumptions (3-5 items, not exhaustive)
- ✅ Watch-for items (1-2 specific things that would push estimate up)
- ✅ Concise, user-facing format

## Examples

### Example 1: Clear Requirements

**Story:** "As a user, I want to log out of my account"

## Story 1: Logout

**Size:** XS

**Complexity:** Very low—clearing session/token and redirecting to login page. Standard pattern with established implementation.

**Risk:** Very low—scope is well-bounded, pattern rarely has surprises, clear definition of done.

**Assumptions:**
- Session management already exists
- Simple redirect to login page
- No multi-system coordination needed

**Watch for:** SSO integration requirements would push to S.

---

### Example 2: Missing Context

**Story:** "As an admin, I want to generate monthly reports"

## Story 2: Monthly Reports

**Size:** L (could be M or XL depending on scope)

**Complexity:** Medium—report generation involves data aggregation, formatting, and async processing. Complexity scales with number of report types and calculation logic required.

**Risk:** High—"monthly reports" is vague and could easily expand 3x. Words like "generate reports" hide edge cases. Missing definition of what data, format, calculations, and how many report types.

**Assumptions:**
- 5-10 pre-defined report types (not user-configurable)
- Data exists in queryable format
- PDF or CSV output
- Async generation (background job)
- Basic calculations only

**Watch for:** User-configurable report builder or complex data transformations would push to XL. Single simple report could drop to M.

---

### Example 3: New Technology

**Story:** "As a developer, I want to integrate Stripe for payments"

**Context:** Team has not used Stripe before.

## Story 3: Stripe Integration

**Size:** L

**Complexity:** Medium—payment flows involve frontend + backend + webhooks. Stripe is well-documented but requires coordinating checkout UI, server-side processing, and webhook handling for payment confirmation.

**Risk:** High—words like "integrate" hide scope. Team unfamiliar with Stripe increases explosion risk. External dependency on third-party API adds unknowns. Edge cases (failed payments, webhooks, testing) not specified and could easily expand scope 3x.

**Assumptions:**
- One-time payments only (not subscriptions)
- Using Stripe Checkout (not custom Elements UI)
- Single currency
- Basic error handling
- Test mode setup sufficient

**Watch for:** Subscriptions, multi-currency, custom UI, or refunds/disputes handling would push to XL. Consider spike story first.

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

**Location:** `docs/estimations/{project-name}-{date}.md`

**Format:**
```markdown
# Estimation: {Project Name}

**Date:** {date}
**Product Context:** {description}

---

## Story 1: {Title}

**Size:** {size} (with risk expressed if applicable)

**Complexity:** {2-3 sentences on technical difficulty}

**Risk:** {2-3 sentences on scope explosion likelihood}

**Assumptions:**
- {key assumption 1}
- {key assumption 2}
- {key assumption 3}

**Watch for:** {1-2 specific things that would push estimate up}

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

**Save once after all estimates:**

- Process all stories and create complete estimation document
- Include all story estimates in single document
- Add pattern notes section if patterns detected
- Save complete document once at end of estimation
- If MVP scoping requested, append MVP section and save again

**When to save:**
1. After all stories estimated (initial save)
2. After MVP scoping if requested (update save)
