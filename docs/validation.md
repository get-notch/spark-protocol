# Validation Framework

How to validate a cognitive pipeline. Creativity cannot be unit tested, but it can be calibrated through honest feedback loops and survival evidence.

---

## Validation Philosophy

The spark protocol makes strong claims: it produces cross-domain connections, background insights, and traceable chains from ideation to shipped artifacts. These claims require evidence.

But the evidence cannot be "100% of sparks were useful." That is not how divergent thinking works. The validation framework is designed to answer:

1. **Do sparks survive?** -- What percentage of generated ideas are ever referenced again?
2. **Do sparks convert?** -- What percentage of surviving ideas produce concrete artifacts?
3. **Does trust calibrate?** -- Do higher-trust sparks correlate with better outcomes?
4. **What would we have missed?** -- Can we identify counter-factual evidence?

---

## The Survival Log

The survival log is the empirical backbone of the validation framework. It tracks every significant spark from generation through outcome.

### Schema

| Column | Type | Description |
|--------|------|-------------|
| `id` | string | Unique identifier (format: `YYYY-MM-DD-NNN`) |
| `date` | date | Date the spark was generated |
| `anchor` | string | The spark session anchor or dream-spark source |
| `rating` | enum | Session rating: `nuclear`, `fire`, `warm`, `smoke`, `cold` |
| `trust_level` | enum | Trust level at generation: `SEED`, `SEED+`, `REVIEWED`, `VERIFIED` |
| `outcome` | string | What happened: artifact produced, referenced again, expired, or nothing |
| `outcome_date` | date | When the outcome occurred (null if pending) |
| `status` | enum | `alive` (still referenced), `shipped` (produced artifact), `expired` (not referenced), `pending` (too early to tell) |

### Example

```markdown
| ID | Date | Anchor | Rating | Trust | Outcome | Outcome Date | Status |
|----|------|--------|--------|-------|---------|-------------|--------|
| 001 | Day 1 | team-workflow-optimization | fire | SEED+ | Led to architecture proposal | Day 2 | shipped |
| 002 | Day 1 | api-design-patterns | fire | REVIEWED | Cross-domain pattern applied to organizational process | Day 3 | shipped |
| 003 | Day 3 | observability-gap | warm | SEED | Referenced in architecture discussion | Day 5 | alive |
| 004 | Day 3 | documentation-freshness | warm | SEED | Not referenced | -- | expired |
| 005 | Day 5 | deployment-pipeline | nuclear | VERIFIED | Captured as idea file, pending exploration | Day 5 | shipped |
```

### Maintaining the Log

- **After every spark session:** Add entries for significant sparks (not every hop -- just the sparks that received output routing)
- **Weekly review:** Update `outcome` and `status` for pending entries. Mark expired entries that have not been referenced in 30 days.
- **Monthly retrospective:** Calculate metrics (see Health Thresholds below)

---

## Survival Rate

The survival rate is the primary health metric: what percentage of generated sparks are ever referenced again in later work?

```
Survival Rate = (alive + shipped) / total * 100
```

### What Survival Means

A spark "survives" if it is referenced in any of these contexts after its initial session:
- Another spark session uses it as an anchor or fuel
- A dream-spark or daydream cross-references it
- It is cited in a decision, ticket, or document
- It produces a concrete artifact (PR, design doc, process change)

A spark "expires" if it goes 30 days without being referenced.

### Interpreting Survival Rate

| Rate | Interpretation |
|------|---------------|
| **Below 15%** | Protocol may be producing noise. Review anti-convergence mechanics and signal quality. |
| **15-30%** | Healthy range for divergent thinking. Most ideas should NOT survive -- that is the nature of exploration. |
| **30-50%** | Strong performance. Either the protocol is well-calibrated or the data lake is rich enough that connections are naturally abundant. |
| **Above 50%** | Suspiciously high. Either cherry-picking what enters the log, or the divergent thinking is not actually divergent (the anti-convergence ratchet may be failing). |

A healthy divergent thinking system has a LOW survival rate. If most ideas survive, you are not exploring widely enough. The value is in the survivors, not the survival rate.

### Evidence from First Implementation

Initial data from the first implementation (55+ sparks across multiple sessions):

- **Total sparks logged:** 55
- **Survival rate:** ~29%
- **Sparks that reached SOT:** 2 (the spark protocol itself, and a development process standard that emerged from a spark session)
- **Sparks that produced artifacts:** 16 (tickets, documents, process changes, skills)

The 29% survival rate is within the healthy range. The two SOT outcomes from 55 sparks suggest the pipeline can produce team-level behavioral change, not just documents.

**Honest caveat:** This is data from a single implementation over approximately one month. The sample is small. The survival rate may shift as the data lake matures and more sessions accumulate. It is reported as initial evidence, not as a validated benchmark.

---

## Signal-to-Action Conversion

Beyond survival, track how sparks convert into concrete organizational actions:

### Conversion Funnel

```
Total sparks generated
  |
  +--> Survived (referenced again)           ~29%
         |
         +--> Formed idea (idea file created)  ~18%
                |
                +--> Artifact (ticket/PR/doc)   ~11%
                       |
                       +--> Shipped (merged/adopted) ~7%
                              |
                              +--> SOT (changed behavior) ~4%
```

These percentages are illustrative based on initial data. Your conversion funnel will differ based on team size, data lake richness, and organizational receptivity to spark-derived work.

### What to Track

For each stage of the funnel:
- **Count** -- how many sparks reached this stage
- **Time to convert** -- how long from spark to this stage
- **Trust level correlation** -- do higher-trust sparks convert faster/more often?

---

## Trust Calibration Testing

The trust scale (see [trust-scale.md](trust-scale.md)) assigns graduated confidence to sparks. Validation requires testing whether the trust levels actually correlate with outcomes.

### The Test

For each trust level, measure:

| Trust Level | Expected Survival | Expected Conversion | Observed Survival | Observed Conversion |
|------------|-------------------|---------------------|-------------------|---------------------|
| SEED | Low (~10-20%) | Low (~5%) | [measure] | [measure] |
| SEED+ | Medium (~25-40%) | Low-Medium (~10%) | [measure] | [measure] |
| REVIEWED | Medium-High (~40-60%) | Medium (~20-30%) | [measure] | [measure] |
| VERIFIED | High (~60-80%) | High (~40-60%) | [measure] | [measure] |

If trust levels do NOT correlate with outcomes (e.g., SEED sparks convert at the same rate as VERIFIED sparks), the trust calibration is broken. Either:
- The signal sources are not actually providing useful convergent evidence
- The graduation criteria are too loose (too easy to reach REVIEWED/VERIFIED)
- The organizational signals are noise, not signal

### Calibration Adjustments

Based on observed data:
- If SEED survival is too high (>40%), the bar for SEED may be too high -- ideas are being pre-filtered before entering the system
- If VERIFIED survival is too low (<50%), the graduation criteria are too loose
- If there is no difference between trust levels, the entire trust mechanism needs re-evaluation

---

## Counter-Factual Evidence

The strongest validation is evidence of sparks that would have been missed without the protocol. Counter-factual evidence answers: "What did the organizational subconscious surface that no individual was tracking?"

### What Qualifies as Counter-Factual

A spark is counter-factual if:
1. It connected information from 2+ domains that no individual holds simultaneously
2. The connection was not obvious (the "of course" test -- if someone says "of course those are related," it is not counter-factual)
3. It produced a concrete outcome that would not have occurred through normal work

### Examples from Initial Data

**Example 1:** A spark session about code architecture produced a connection to an unrelated organizational process. The session anchor was a question about skill composition. A chain hop connected medical AI annotation patterns to AI agent skill decomposition -- a cross-domain leap requiring both topics to be simultaneously in context. Result: a cross-domain concept was extracted from the spark chain and applied to a different organizational process. The connection required multiple knowledge domains to be simultaneously in context -- something that would not have occurred in a topic-specific brainstorming session.

**Example 2:** A background daydream about a lightweight browser tool produced a neuroscience connection: the browser as "prosthetic thalamus" for concurrent scanning. This crossed browser infrastructure, neuroscience, and agent architecture. No individual was thinking about all three simultaneously. Result: architecture insight that informed agent design decisions.

**Example 3:** A dream-spark signal sweep detected the same "onboarding delays" topic appearing across issue tracker (blocked item), meeting notes (action items), and project management (stuck status). No individual was reading all three sources simultaneously. Result: the convergent signal was surfaced as a `[ext-signal]` dream-spark, connecting a structural memory insight about process bottlenecks to the live organizational signals.

### Collecting Counter-Factual Evidence

After each spark session rated `fire` or `nuclear`:
1. Ask: "Would any other tool or process have produced this specific connection?"
2. If the answer is "no" or "unlikely," document why
3. Record: what domains were crossed, what the outcome was, and why the connection required the protocol

---

## Health Thresholds

Monitor these metrics to detect when the pipeline needs adjustment:

### Primary Metrics

| Metric | Healthy Range | Action if Outside |
|--------|--------------|-------------------|
| **Survival rate** | 15-50% | Below: review signal quality and anti-convergence. Above: check for cherry-picking or convergence failure. |
| **Consumption ratio** (ext-signal sparks consumed / total ext-signal sparks) | >40% | Below 30%: external signals outpacing processing. Run a spark session or use quick mode. |
| **Trust level correlation** | Higher trust = higher survival | No correlation: recalibrate trust criteria. |
| **Time to conversion** (spark to artifact) | <14 days for REVIEWED+ | Longer: routing may be too slow, or trust levels are assigned but not acted on. |

### Secondary Metrics

| Metric | What It Indicates |
|--------|-------------------|
| **Session rating distribution** | If >50% cold/smoke, the data lake may be too thin. If >80% fire/nuclear, ratings may not be calibrated honestly. |
| **Ext-signal ratio** | What percentage of dream-sparks come from organizational signals vs. memory-only. Target: 30-60%. Below: signal sources may not be configured. Above: memory cross-referencing may be underweighted. |
| **Freshness** | How old is the latest signal snapshot? If consistently stale, dream-spark is not running often enough. |
| **Counter-factual count** | How many counter-factual examples per month? At least 1-2 is healthy. Zero suggests the protocol is not crossing domains effectively. |

---

## How to Start Your Own Validation

### Week 1: Establish Baseline

1. Run 2-3 spark sessions with different anchors
2. Start the survival log with all significant sparks
3. Rate each session honestly (fire/warm/smoke/cold)
4. Do NOT optimize for fire ratings -- honest calibration is the goal

### Week 2-4: Build Evidence

1. Run spark sessions regularly (2-3 per week minimum)
2. Run dream-spark at least twice per week (or nightly if automated)
3. Update the survival log weekly: which sparks survived, which expired?
4. Calculate your first survival rate

### Month 2+: Calibrate

1. Calculate trust level correlation: do REVIEWED sparks survive more than SEED?
2. Identify counter-factual evidence: what did the protocol catch that you would have missed?
3. Adjust thresholds based on observed data
4. Begin tracking the conversion funnel

### Ongoing

1. Monthly retrospective: review survival log, update metrics
2. Quarterly review: compare trust level predictions against outcomes
3. Annual assessment: has the protocol produced SOT-level outcomes?

---

## What Is Validated and What Is Not

**Honest accounting of current evidence status:**

### Validated (VERIFIED confidence)

- The spark protocol produces cross-domain connections that require simultaneous multi-domain context
- Background processing (daydream) generates connections without foreground attention cost
- Anti-convergence mechanics prevent premature closure and extend chain depth
- Session ratings correlate with downstream utility (fire sessions produce more artifacts than warm sessions)
- The protocol can produce SOT-level outcomes (behavioral change, not just documents)

### Partially Validated (REVIEWED confidence)

- Survival rate of ~29% is within the healthy range for divergent thinking
- Trust levels correlate directionally with outcomes (REVIEWED/VERIFIED sparks survive more)
- The organizational subconscious surfaces convergent signals across independent sources
- Counter-factual evidence exists for 3+ specific connections

### Not Yet Validated (SEED confidence)

- Long-term sustainability (does the protocol maintain value over months/years?)
- Multi-user effectiveness (only tested with one primary user)
- Optimal session frequency (how often is too often? how infrequent is too infrequent?)
- Trust scale calibration across all five domains (primarily tested on ideas and documentation)
- Whether survival rate changes as the data lake matures

The framework reports what is known, flags what is not, and lets the survival log accumulate evidence over time.
