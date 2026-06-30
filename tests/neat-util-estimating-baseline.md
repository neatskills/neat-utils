# Baseline Testing: neat-util-estimating

## Purpose

Test scenarios to observe agent behavior WITHOUT the skill loaded, identifying:
- Natural estimation patterns
- Common failures and rationalizations
- Areas where guidance is needed

## Testing Protocol

Per `superpowers:writing-skills`:
1. Run each scenario 5 times with fresh subagents
2. Document verbatim behaviors and rationalizations
3. Identify patterns in failures
4. Use findings to write skill addressing specific issues

---

## Scenario 1: Over-Precision Trap

**Prompt:**
```
Estimate this user story using T-shirt sizes (XS, S, M, L, XL, XXL):

"As a user, I want to reset my password via email"

Product context: SaaS web application for project management.
```

**Pressure:**
- Fast answer expected
- Simple-seeming story
- No explicit request for uncertainty/assumptions

**Expected Failure:**
Agent provides point estimate ("This is a Medium") without:
- Expressing uncertainty range
- Documenting assumptions
- Explaining what info would change the estimate

**Observations:** (To be filled after testing)

### Run 1
- [ ] Agent response:
- [ ] Uncertainty expressed? Y/N
- [ ] Assumptions documented? Y/N
- [ ] Complexity breakdown? Y/N
- [ ] Rationalizations noted:

### Run 2
- [ ] Agent response:
- [ ] Uncertainty expressed? Y/N
- [ ] Assumptions documented? Y/N
- [ ] Complexity breakdown? Y/N
- [ ] Rationalizations noted:

### Run 3
- [ ] Agent response:
- [ ] Uncertainty expressed? Y/N
- [ ] Assumptions documented? Y/N
- [ ] Complexity breakdown? Y/N
- [ ] Rationalizations noted:

### Run 4
- [ ] Agent response:
- [ ] Uncertainty expressed? Y/N
- [ ] Assumptions documented? Y/N
- [ ] Complexity breakdown? Y/N
- [ ] Rationalizations noted:

### Run 5
- [ ] Agent response:
- [ ] Uncertainty expressed? Y/N
- [ ] Assumptions documented? Y/N
- [ ] Complexity breakdown? Y/N
- [ ] Rationalizations noted:

### Pattern Summary
(To be filled after all runs)

---

## Scenario 2: Missing Context Rationalization

**Prompt:**
```
Estimate this user story using T-shirt sizes (XS, S, M, L, XL, XXL):

"As an admin, I want to export all user data to CSV"

Product context: Enterprise CRM system.
```

**Pressure:**
- Critical missing information (data volume, format complexity, security requirements)
- User expects estimate despite gaps

**Expected Failure:**
Agent either:
- Guesses without stating assumptions, OR
- Refuses to estimate ("can't estimate without more info")

Neither is ideal—should make reasonable assumptions explicit.

**Observations:** (To be filled after testing)

### Run 1
- [ ] Agent response:
- [ ] Made assumptions explicit? Y/N
- [ ] Refused to estimate? Y/N
- [ ] Sized based on assumptions? Y/N
- [ ] Rationalizations noted:

### Run 2
- [ ] Agent response:
- [ ] Made assumptions explicit? Y/N
- [ ] Refused to estimate? Y/N
- [ ] Sized based on assumptions? Y/N
- [ ] Rationalizations noted:

### Run 3
- [ ] Agent response:
- [ ] Made assumptions explicit? Y/N
- [ ] Refused to estimate? Y/N
- [ ] Sized based on assumptions? Y/N
- [ ] Rationalizations noted:

### Run 4
- [ ] Agent response:
- [ ] Made assumptions explicit? Y/N
- [ ] Refused to estimate? Y/N
- [ ] Sized based on assumptions? Y/N
- [ ] Rationalizations noted:

### Run 5
- [ ] Agent response:
- [ ] Made assumptions explicit? Y/N
- [ ] Refused to estimate? Y/N
- [ ] Sized based on assumptions? Y/N
- [ ] Rationalizations noted:

### Pattern Summary
(To be filled after all runs)

---

## Scenario 3: Complexity vs Uncertainty Conflation

**Prompt:**
```
Estimate this user story using T-shirt sizes (XS, S, M, L, XL, XXL):

"As a developer, I want to integrate with Stripe for payment processing"

Product context: E-commerce checkout flow. Team has not used Stripe before.
```

**Pressure:**
- High uncertainty (new to team)
- Potentially low technical complexity (Stripe has good docs)
- Risk of conflating "unknown to us" with "technically hard"

**Expected Failure:**
Agent conflates technical complexity with team familiarity/uncertainty, leading to:
- Oversized estimate based on "it's new" without separating dimensions
- OR undersized estimate assuming "good docs = easy"

**Observations:** (To be filled after testing)

### Run 1
- [ ] Agent response:
- [ ] Separated complexity from uncertainty? Y/N
- [ ] Acknowledged team unfamiliarity as risk? Y/N
- [ ] Size rationale clear? Y/N
- [ ] Rationalizations noted:

### Run 2
- [ ] Agent response:
- [ ] Separated complexity from uncertainty? Y/N
- [ ] Acknowledged team unfamiliarity as risk? Y/N
- [ ] Size rationale clear? Y/N
- [ ] Rationalizations noted:

### Run 3
- [ ] Agent response:
- [ ] Separated complexity from uncertainty? Y/N
- [ ] Acknowledged team unfamiliarity as risk? Y/N
- [ ] Size rationale clear? Y/N
- [ ] Rationalizations noted:

### Run 4
- [ ] Agent response:
- [ ] Separated complexity from uncertainty? Y/N
- [ ] Acknowledged team unfamiliarity as risk? Y/N
- [ ] Size rationale clear? Y/N
- [ ] Rationalizations noted:

### Run 5
- [ ] Agent response:
- [ ] Separated complexity from uncertainty? Y/N
- [ ] Acknowledged team unfamiliarity as risk? Y/N
- [ ] Size rationale clear? Y/N
- [ ] Rationalizations noted:

### Pattern Summary
(To be filled after all runs)

---

## Scenario 4: Batch Estimation Fatigue

**Prompt:**
```
Estimate these 10 user stories using T-shirt sizes (XS, S, M, L, XL, XXL). Provide size and brief reasoning for each.

Product context: Mobile app for fitness tracking.

1. "As a user, I want to log my daily water intake"
2. "As a user, I want to see my weekly exercise summary"
3. "As a user, I want to sync data with Apple Health"
4. "As a user, I want to set fitness goals"
5. "As a user, I want push notifications for goal milestones"
6. "As a user, I want to share my progress on social media"
7. "As a coach, I want to view my clients' progress dashboards"
8. "As a user, I want to export my data as PDF reports"
9. "As an admin, I want to manage user subscriptions"
10. "As a user, I want dark mode support"
```

**Pressure:**
- Repetitive work (10 estimates)
- Time pressure (user wants all estimated)
- Fatigue may cause shortcuts

**Expected Failure:**
Quality degradation across batch:
- Later estimates get less rigorous
- Copy-paste reasoning without adaptation
- Skip assumption documentation
- Lose nuance in sizing

**Observations:** (To be filled after testing)

### Run 1
- [ ] Quality consistent across all 10? Y/N
- [ ] Last 3 estimates as thorough as first 3? Y/N
- [ ] Evidence of copy-paste reasoning? Y/N
- [ ] Rationalizations noted:

### Run 2
- [ ] Quality consistent across all 10? Y/N
- [ ] Last 3 estimates as thorough as first 3? Y/N
- [ ] Evidence of copy-paste reasoning? Y/N
- [ ] Rationalizations noted:

### Run 3
- [ ] Quality consistent across all 10? Y/N
- [ ] Last 3 estimates as thorough as first 3? Y/N
- [ ] Evidence of copy-paste reasoning? Y/N
- [ ] Rationalizations noted:

### Run 4
- [ ] Quality consistent across all 10? Y/N
- [ ] Last 3 estimates as thorough as first 3? Y/N
- [ ] Evidence of copy-paste reasoning? Y/N
- [ ] Rationalizations noted:

### Run 5
- [ ] Quality consistent across all 10? Y/N
- [ ] Last 3 estimates as thorough as first 3? Y/N
- [ ] Evidence of copy-paste reasoning? Y/N
- [ ] Rationalizations noted:

### Pattern Summary
(To be filled after all runs)

---

## Cross-Scenario Analysis

### Common Rationalizations Observed
1. **"This is an M"** (point estimate) rather than "M, could be S-L depending on..."
2. **Thorough analysis but buried uncertainty** - agents do good analysis but conclusion feels certain
3. **Time estimates mixed with size** - some agents said "1-2 days" which is time, not relative size
4. **Good assumption documentation** - this was actually done well in most cases

### Failure Patterns
1. **MINIMAL FAILURES** - Baseline behavior is surprisingly good
2. **Point estimates over ranges** - "M" instead of "M (could be S-L)"
3. **Uncertainty expressed in body but not summary** - good caveats buried in analysis
4. **Time/effort conflation** - occasionally mention days instead of pure relative sizing

### Gaps to Address in Skill
1. **Emphasize expressing estimate as range** - "M, could shift to L if..." as standard format
2. **Clarify size vs time** - T-shirt sizes are relative, not time estimates
3. **Structure for consistent output** - make uncertainty explicit in final answer
4. **When to ask vs when to assume** - balance between "need more info" paralysis and hidden assumptions
5. **Batch estimation rigor** - ensure quality doesn't degrade (need to test Scenario 4)

### Red Flags to Include
1. "This is definitely a [size]" → Should express uncertainty
2. Giving time estimates (hours/days) instead of relative sizing
3. Not documenting assumptions when information is sparse
4. Analysis mentions caveats but final estimate is absolute

---

## Next Steps

After completing baseline testing:
1. Analyze patterns across all scenarios
2. Document verbatim rationalizations
3. Identify specific guidance needed
4. Write SKILL.md (GREEN phase) addressing these failures
5. Re-run scenarios with skill loaded
6. Iterate until bulletproof
