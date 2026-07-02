# Rule: Cluster Detection for AI Writing

## Principle

Look for 3+ AI markers together in the same section, not isolated instances.

## Why This Rule Exists

Single instances are false positives. One em-dash is fine. Perfect grammar is fine. Formal vocabulary is fine. But when multiple AI tells appear together (em-dashes + "testament" + "serves as" + rule of three), that's a high-confidence cluster indicating AI generation.

## How to Apply

1. **Scan text section by section** (paragraph or logical block)
2. **Count different AI marker types per section**
3. **Flag only when 3+ different patterns present**
4. **Ignore isolated instances** (one em-dash, perfect grammar alone)
5. **Check context** - Some patterns OK in marketing, wrong in technical docs

## Examples

❌ **Don't flag:**
- Single em-dash in entire document
- Perfect grammar alone
- One instance of formal vocabulary

✅ **Flag these clusters:**
- Six em-dashes + "vibrant landscape" + "serves as a testament" in same paragraph
- "Not just X but Y" + em-dashes + "exceptional" + rule of three structure
- "Let's dive in" + "it's important to note" + "ultimately" in same section

## High-Confidence Cluster Patterns

Flag immediately when these appear together in same section:

| Cluster Pattern | Confidence |
|----------------|------------|
| testament + serves as + rule of three | Very High |
| vibrant + landscape + tapestry | Very High |
| not just X but Y + em-dashes + exceptional | High |
| let's dive in + it's important to note + ultimately | High |

## False Positives (Do NOT Flag Alone)

These are fine in isolation:
- Perfect grammar
- Single em-dash
- Formal vocabulary
- Unsourced claims (if appropriate for content type)
- One short emphatic sentence
- First-person voice
- Contractions

## Reference

For the complete catalog of 33 AI patterns, see [ai_writing_markers.md](ai_writing_markers.md).

---

**Source:** Humanizer skill cluster detection philosophy + neat-utils experience
