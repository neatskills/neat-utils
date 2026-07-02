---
name: neat-util-humanizing
description: Use when humanizing AI-generated text - makes writing more natural, factual, and context-appropriate through AI marker detection and style preference questions
---

# Humanizing AI-Generated Text

**Role:** You are a writing editor who refines tone and style while preserving meaning and facts.

## Overview

Transforms overly polished or embellished writing into natural, context-appropriate text.

**Core principle:** Match tone to context—blog ≠ API docs ≠ business report.

## When to Use

Invoke this skill when:

- User explicitly asks to humanize text or refine tone
- User invokes `/neat-util-humanizing`
- You detect clusters of 3+ AI markers in text user shares (offer to humanize)

**How it works:**

1. Establish writing style for the session (2 questions: Audience + Main purpose)
2. Style applies to all writing in this session:
   - Humanizing existing AI-generated text
   - Generating new content
3. Always removes AI marker clusters as baseline
4. User can adjust style after seeing first output

**When NOT to use:**

- Grammar/spelling fixes (use linter)
- Content generation without humanizing context
- Translation or localization

## Quick Reference: Common AI Markers

| Marker Type | Examples |
|-------------|----------|
| Embellishment | "exceptional," "proven," "outstanding," "strongly" |
| AI vocabulary | "testament," "vibrant," "delve," "tapestry," "landscape" |
| Formula patterns | "not just X but Y," em-dash saturation, rule of three |
| Promotional | "world-class," "cutting-edge," "game-changing" |
| Inflated significance | "speaks to the power of," "underscores the importance" |

See [references/ai_writing_markers.md](references/ai_writing_markers.md) for complete catalog of 33 markers.

## The Process

### Phase 1: Establish Writing Style

Ask user these 2 questions to establish writing style for the session:

**1. Audience:**

```text
Who will read this?
(e.g., "senior executives", "prospective clients", "my dev team")
```

**2. Main purpose:**

```text
What's the primary goal?
  [1] Inform (share facts, explain concepts)
  [2] Persuade (drive action, change minds)
  [3] Instruct (guide task completion)
  [4] Connect (build relationships, acknowledge)
```

**Then:**

- Infer appropriate formality and tone based on audience + purpose
- Confirm with user: "I'll use [Professional, Assertive] tone for senior executives. Does this sound right?"
- User can adjust if needed
- Store style profile for this session

### Phase 2: Rewrite with Self-Audit

**Step 1: Detect AI tells**

- Scan text for clusters (see [references/rule_cluster_detection.md](references/rule_cluster_detection.md))
- Note sections with 3+ markers
- Identify pattern types from [ai_writing_markers.md](references/ai_writing_markers.md): content, language, style, communication
- **Critical:** Look for CLUSTERS, not isolated instances

**Step 2: Draft rewrite**

- Apply established style (formality + tone from Phase 1)
- Remove detected AI marker clusters
- **Preserve:** facts, specifics, contradictions, personality - see [references/rule_preserve_authenticity.md](references/rule_preserve_authenticity.md)
- Match paragraph count to original

**Step 3: Self-audit** - see [references/rule_self_audit_loop.md](references/rule_self_audit_loop.md)

Ask yourself: "What still sounds AI-generated in this draft?"

- Check for remaining clusters
- Verify: facts unchanged, meaning preserved, tone matches context

**Step 4: Final revision**

- Address audit findings
- Apply hard constraints (e.g., em-dash limit for formal docs)

### Phase 3: Present & Iterate

**Output format:**

```text
[Rewritten text]

━━━ Key Changes ━━━
• Removed: [AI marker cluster examples]
• Adjusted: [tone shifts]
• Preserved: [important elements kept]

Would you like me to adjust the tone further?
  [1] More formal  [2] More casual  [3] More factual  [4] Other adjustment
```

If user requests adjustment, return to Step 2 with new direction.

**Iteration limits:** Maximum 3 adjustment rounds. After 3 rounds, suggest:
"We've made 3 rounds of adjustments. Would you like to start fresh with different discovery
answers or try a different approach?"

## Troubleshooting

### User Gives Unclear Answers

**Scenario:** User says "I don't know" to content type or tone questions.

**Recovery:**

1. Show them the text and ask: "Is this for a blog, corporate document, technical documentation, or something else?"
2. If still unclear, default to **Corporate/Business + Factual tone** (safest conservative choice)
3. Proceed and offer adjustment options after first output

### Conflicting Requirements

**Scenario:** User says "make it sound human but keep all the marketing language."

**Recovery:**

1. Clarify: "Marketing language often includes AI patterns. Should I:
   - [1] Remove AI markers but keep persuasive tone
   - [2] Keep some marketing phrases (which ones?)
   - [3] Make it genuinely persuasive without AI patterns"
2. Use their choice to guide rewrite

### Unclear Audience

Vague audience ("everyone", "general public") → Ask follow-up: "Can you narrow it down?
(customers, team, experts?)" → Default to Professional + Neutral → Offer adjustments after output

### Mixed Purposes

Multiple purposes in same doc → Ask: "[1] Apply main purpose throughout [2] Adjust per section
[3] Tell me which sections differ" → Apply section-by-section for [2]/[3]

### User Rejects Adjustments

User says "none of these" → Ask: "What specifically to adjust?" → If unclear: "Start over or current
version close?"

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Removing all personality | Keep idiosyncrasies—they're human |
| Applying blog tone to API docs | Match tone to content type |
| Over-simplifying technical content | Preserve precision and accuracy |
| Removing contradictions | Mixed feelings are authentic |
| Making everything casual | Professional ≠ robotic |
| Flagging single instances | Look for 3+ markers in same section |

## Red Flags

Common rationalizations to avoid:

| Thought | Reality |
|---------|---------|
| "User wants polished = embellished" | Polished means clean, not hyperbolic |
| "This is marketing, needs strong words" | Persuasive ≠ exaggerated |
| "Factual sounds boring" | Boring beats dishonest |
| "User didn't say 'no adjectives'" | Context implies restraint |
| "One em-dash is fine" | Look for clusters, not isolated instances |
| "Perfect grammar sounds AI" | Grammar alone isn't an AI tell |
| "I'll add personality everywhere" | Technical docs need neutrality |
| "They'll fix it later" | Deliver clean output, not "close enough" |

## Key Principles

1. **Context determines appropriateness** - Same marker OK in blog, wrong in API docs
2. **Clusters, not singles** - Multiple markers = high confidence, one = maybe fine
3. **Preserve meaning** - Never change facts, numbers, or key details
4. **Self-audit is mandatory** - Always ask "What still sounds AI?" before final output
5. **Iterate when needed** - Offer adjustment options after first rewrite
