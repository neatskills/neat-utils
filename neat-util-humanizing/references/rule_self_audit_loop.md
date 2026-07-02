# Rule: Self-Audit Loop Before Final Output

## Principle

Always use draft → self-audit question → final revision before delivering output.

## Why This Rule Exists

First drafts often miss subtle AI markers or tone mismatches. Models are better at critiquing their own output than generating perfect output on first attempt. The self-questioning step catches remaining issues that the generation step missed.

## How to Apply

### Step 1: Draft
Generate rewrite applying tone/style requirements from user context.

### Step 2: Self-Audit
Ask yourself: **"What still sounds AI-generated in this draft?"**

Check for:
- Are there remaining marker clusters?
- Does tone match context (blog vs. API docs)?
- Are facts unchanged?
- Is meaning preserved?
- Any embellishment crept in?

### Step 3: Final Revision
Address specific findings from audit, apply any hard constraints.

## Examples

**Scenario 1: Corporate Document**

Draft output:
> "Evan Derby has demonstrated exceptional capabilities through outstanding stakeholder management."

Self-audit catches:
> "exceptional" and "outstanding" are embellishment for factual doc

Final revision:
> "Evan Derby has demonstrated capabilities through stakeholder management."

---

**Scenario 2: Blog Post**

Draft output:
> "The hiking experience was exceptional, offering breathtaking views and unforgettable moments."

Self-audit catches:
> Still too polished, generic positivity, lacks personality

Final revision:
> "The hike had incredible views, but the six-story staircase with no elevator? I'm still not sure if I loved it."

---

**Scenario 3: API Documentation**

Draft output:
> "This innovative function seamlessly integrates with your workflow, enabling robust error handling."

Self-audit catches:
> "innovative", "seamlessly", "robust" are AI markers; tone too marketing

Final revision:
> "This function integrates with your workflow and provides error handling."

## Common Self-Audit Questions

Use these to check your draft:

| Question | What It Catches |
|----------|-----------------|
| What still sounds AI-generated? | Overall marker clusters |
| Are there 3+ AI tells in any section? | Cluster detection |
| Does this match the target tone? | Context appropriateness |
| Did I change any facts or numbers? | Accuracy preservation |
| Did I remove personality that should stay? | Authenticity preservation |
| Are there generic phrases? | "unforgettable", "exceptional", "journey" |
| Is this too smooth/polished? | Over-refinement |

## When to Skip This Rule

Never. Always apply self-audit before final output, even for quick rewrites.

The audit takes 10 seconds and catches issues that waste user time.

---

**Source:** Humanizer skill 3-step rewriting loop
