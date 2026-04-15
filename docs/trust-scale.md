# Trust Scale

A generalizable framework for graduated confidence in AI-assisted knowledge systems. Five levels, explicit graduation and downgrade criteria, and a currency model where trust expires without recency.

---

## The Five Levels

```
SEED --> REVIEWED --> VERIFIED --> MAINTAINED --> SOT
  |         |            |            |           |
  v         v            v            v           v
 raw     convergent   artifact     actively    behavioral
 signal   evidence    produced     tended      authority
```

### SEED

**What it means:** Raw output from a single source, single session, one person. Uncorroborated.

**Handle with:** Curiosity, not commitment. SEED items are hypotheses to explore, not facts to act on.

**Examples:** A raw spark chain, a single daydream connection, a FOMO capture (the zero-friction idea capture skill -- see [/fomo](../skills/fomo.md)), an unreviewed idea.

**Graduation criteria:** Validated by 2+ independent organizational signals (convergent evidence from separate sources).

**Downgrade criteria:** N/A (this is the entry level). SEED items expire after 30 days without interaction.

### REVIEWED

**What it means:** Corroborated by convergent evidence. Two or more independent sources point in the same direction without being derived from each other.

**Handle with:** Interest and investigation. REVIEWED items deserve dedicated exploration time.

**Examples:** A spark idea that matches an active issue tracker thread AND a team chat discussion. A dream-spark with `[ext-signal]` from 2+ organizational sources.

**Graduation criteria:** Produced a concrete artifact (issue tracker ticket, pull request, design doc, process document). Survived contact with implementation -- the idea was not just interesting but actionable.

**Downgrade criteria:** If the corroborating signals expire or are resolved without the idea being acted on, downgrade to SEED. If 60 days pass without any artifact, downgrade to SEED.

### VERIFIED

**What it means:** Produced a concrete artifact that survived implementation contact. The idea moved from concept to something real.

**Handle with:** Confidence and follow-through. VERIFIED items are proven actionable.

**Examples:** A spark-derived issue tracker ticket with full provenance chain. A design document that emerged from a spark session and was reviewed by the team. A process change proposal backed by organizational signal evidence.

**Graduation criteria:** The artifact is actively maintained -- someone owns it, updates it, and it is referenced by others. It has not drifted from reality.

**Downgrade criteria:** If the artifact becomes stale (no updates in 90 days, no references), downgrade to REVIEWED. If the artifact is abandoned or the underlying assumption is invalidated, downgrade to SEED.

### MAINTAINED

**What it means:** Actively tended knowledge. Someone owns it, keeps it current, and others depend on it.

**Handle with:** Reliance, with periodic verification. MAINTAINED items are working knowledge.

**Examples:** A process standard that the team follows and updates. A living document that gets reviewed each sprint. An architectural decision record that is referenced in code reviews.

**Graduation criteria:** Changed team behavior. The knowledge is not just documented and maintained -- it is how the team actually works. Observable in workflow, not just in files.

**Downgrade criteria:** If the owner leaves and no successor is assigned, downgrade to VERIFIED. If the document drifts from actual practice (what the doc says vs. what people do diverges), downgrade to VERIFIED.

### SOT (Source of Truth)

**What it means:** Behavioral authority. This knowledge has changed how the team works. It is the reference point, not a reference document.

**Handle with:** Authority, with ongoing validation. SOT items define practice.

**Examples:** A development process standard that every PR is reviewed against. A trust scale that governs how ideas are routed. An incident investigation framework that the team follows during every outage.

**Graduation criteria:** N/A (this is the highest level). SOT status is maintained through continuous use and relevance.

**Downgrade criteria:** If the team stops following the process (behavioral drift), downgrade to MAINTAINED. If the knowledge becomes obsolete due to architectural or organizational change, downgrade to VERIFIED or lower depending on remaining relevance.

---

## Trust as Currency

Trust levels are not permanent classifications. They are **currency** -- they expire without recency.

### The Recency Requirement

| Trust Level | Recency Window | Consequence of Staleness |
|-------------|---------------|--------------------------|
| SEED | 30 days | Auto-expires. Mark `[expired]` in dream-spark cycle. |
| REVIEWED | 60 days | Downgrades to SEED. Corroborating signals may have resolved. |
| VERIFIED | 90 days | Downgrades to REVIEWED. Artifact may have drifted. |
| MAINTAINED | Per review cycle | Downgrades to VERIFIED if review is skipped. |
| SOT | Continuous | Downgrades to MAINTAINED if behavioral drift is detected. |

The currency model prevents knowledge systems from accumulating stale authority. A VERIFIED document from 6 months ago with no updates is not VERIFIED -- it is REVIEWED at best, because you no longer know if the artifact matches reality.

### Recency Signals

What counts as "interaction" that resets the recency clock:

- **SEED:** Referenced in a spark session, daydream, or dream-spark cycle
- **REVIEWED:** Discussed in a meeting, referenced in an issue tracker comment, or deepened in a spark session
- **VERIFIED:** Artifact updated, referenced in a PR, or cited in a decision
- **MAINTAINED:** Review completed by owner, content updated based on current state
- **SOT:** Team observed following the practice, or practice updated based on feedback

---

## Idea Trust Mapping

The spark protocol assigns trust levels based on the combination of session quality (rating) and organizational signal grounding:

| Session Rating | Org Signal Validation | Trust Level |
|---------------|----------------------|-------------|
| cold / smoke | -- | **Discard** (noise, do not route) |
| warm | No org signal match | **SEED** (capture, might ignite later) |
| fire / nuclear | No org signal match | **SEED+** (strong but ungrounded) |
| warm / fire | 1 org signal match | **REVIEWED** (convergent evidence) |
| fire / nuclear | 2+ org signal matches | **VERIFIED** (multiply grounded) |

Trust level determines routing priority:
- **Discard** -- raw session log only
- **SEED** -- daylog entry, dream-spark fuel, might expire
- **SEED+** -- idea file, worth parking for dream-spark enrichment
- **REVIEWED** -- idea file + issue tracker ticket candidate with `spark-derived` label
- **VERIFIED** -- issue tracker ticket with full provenance, high-confidence action item

A spark that later produces a shipped outcome (PR, process change, team adoption) graduates to **SOT** -- update the survival log (see [validation.md](validation.md)).

---

## YAML Frontmatter Spec

Documents and ideas tracked under the trust scale should carry trust metadata in YAML frontmatter:

```yaml
---
trust_level: SEED | REVIEWED | VERIFIED | MAINTAINED | SOT
trust_date: YYYY-MM-DD          # Date trust level was last assigned or confirmed
trust_source: spark | dream-spark | daydream | manual
trust_signals:                   # What evidence supports this level
  - "spark session YYYY-MM-DD (fire)"
  - "issue tracker ISSUE-XXXX (convergent)"
  - "team chat thread (convergent)"
trust_expires: YYYY-MM-DD        # When this trust level auto-downgrades if not refreshed
provenance:                      # Chain from spark to current state
  - "spark anchor: <topic>"
  - "chain hop [N]: <connection>"
  - "routed to: <destination>"
---
```

### Required Fields

- `trust_level` -- current level (SEED, REVIEWED, VERIFIED, MAINTAINED, SOT)
- `trust_date` -- when the trust level was last assigned or confirmed
- `trust_source` -- which skill or process assigned the trust level

### Optional Fields

- `trust_signals` -- list of evidence supporting the current level
- `trust_expires` -- explicit expiration date (calculated from recency window)
- `provenance` -- the chain of connections from original spark to current state

### Example

```yaml
---
trust_level: REVIEWED
trust_date: 2026-03-31
trust_source: spark
trust_signals:
  - "spark session 2026-03-31 (fire)"
  - "issue tracker: ISSUE-1234 (blocked on same topic)"
  - "team chat: #architecture thread (12 replies)"
trust_expires: 2026-05-30
provenance:
  - "spark anchor: deployment pipeline bottleneck"
  - "chain hop [4]: connected to CI/CD feedback loop pattern"
  - "chain hop [7]: org signal -- issue tracker shows ISSUE-1234 blocked on same pattern"
  - "routed to: ideas/2026-03-31-deployment-pipeline.md"
---
```

---

## Five Domains of Application

The trust scale is not specific to ideas or sparks. It applies as a universal primitive across five domains:

### 1. Documentation

| Level | Meaning |
|-------|---------|
| SEED | AI-generated or first-draft doc, unreviewed |
| REVIEWED | Peer-reviewed by 1+ domain expert |
| VERIFIED | Tested against code reality, confirmed accurate |
| MAINTAINED | Has an owner, reviewed on schedule, actively updated |
| SOT | The authoritative reference -- team cites it in PRs, decisions, onboarding |

### 2. Ideas

| Level | Meaning |
|-------|---------|
| SEED | Raw spark, single session output |
| REVIEWED | Convergent evidence from 2+ sources |
| VERIFIED | Produced an artifact (ticket, doc, PR) |
| MAINTAINED | Actively being implemented, progress tracked |
| SOT | Changed team behavior or shipped as a feature |

### 3. Permissions

| Level | Meaning |
|-------|---------|
| SEED | New team member, default access |
| REVIEWED | Completed onboarding, demonstrated understanding |
| VERIFIED | Successfully contributed (merged PR, resolved incident) |
| MAINTAINED | Consistently reliable, expanded access |
| SOT | Trusted to grant/revoke access for others |

### 4. Incidents

| Level | Meaning |
|-------|---------|
| SEED | Initial report, unconfirmed |
| REVIEWED | Confirmed by 2+ sources (monitoring + user report) |
| VERIFIED | Root cause identified, fix implemented |
| MAINTAINED | Post-mortem completed, preventive measures in place |
| SOT | Incident pattern documented, team trained, detection automated |

### 5. Estimation

| Level | Meaning |
|-------|---------|
| SEED | Gut estimate, no data |
| REVIEWED | Informed by historical data from similar work |
| VERIFIED | Broken down into measurable subtasks with evidence |
| MAINTAINED | Tracked against actuals, refined across iterations |
| SOT | Estimation model calibrated with statistical confidence |

---

## The Medical AI Calibration Mapping

The trust scale design was informed by patterns from building trust between AI systems and domain experts in cancer diagnostics (FDA 510(k), CE-IVDR regulated). The pattern transfer:

### Graduated Trust

Medical AI does not deploy as "trust me." It follows a graduated progression:

1. **Shadow mode** -- AI runs but only researchers see output
2. **Audit mode** -- AI reviews after the expert, flags discrepancies
3. **Suggest mode** -- AI presents findings alongside expert review
4. **Draft mode** -- AI produces first assessment, expert validates
5. **Auto mode** -- AI handles routine cases, expert handles exceptions
6. **Authority mode** -- AI is the reference (not yet achieved in most domains)

The trust scale mirrors this: SEED (shadow) --> REVIEWED (audit) --> VERIFIED (suggest/draft) --> MAINTAINED (auto) --> SOT (authority).

### Points of Interest (Showing Uncertainty)

In medical AI, even when classifying a result as negative, the system always shows the top Points of Interest -- the highest-scoring locations that did not cross the threshold. This builds trust because:

- The expert can verify the negative without re-examining everything
- When a POI catches something the classification missed, trust INCREASES
- Transparency about uncertainty builds more confidence than hiding it

Applied to the trust scale: every knowledge item shows its trust level visibly. A SEED idea is not hidden or minimized -- it is presented as SEED. The consumer calibrates their own confidence accordingly.

### Asymmetric Failure Modes

In cancer diagnostics, a false negative (missed cancer) is far more dangerous than a false positive (unnecessary re-examination). The system is calibrated for this asymmetry.

Applied to the trust scale: **missing a real insight is more costly than shipping noise.** The trust scale is calibrated so that:

- Low-confidence sparks trigger deeper exploration, not discard (the undetermined zone triggers useful action)
- Over-routing (sending SEED ideas to issue tracker) creates noise but is recoverable
- Under-routing (burying VERIFIED ideas in daylogs) loses real value permanently

The asymmetry means the system errs toward exploration, not toward silence.

### Calibrated Thresholds

Medical AI uses different confidence thresholds for different classification types -- not one-size-fits-all. Similarly, the trust scale applies different recency windows and graduation criteria per domain. A documentation SOT has different maintenance requirements than an estimation SOT.

---

## What the Trust Scale Is NOT

- **Not a quality score.** SEED does not mean "bad." It means "uncorroborated." A nuclear-rated spark can be SEED.
- **Not permanent.** Trust is currency. It expires without recency.
- **Not hierarchical in value.** A SEED spark might be more important than a SOT standard -- but it requires more validation before action.
- **Not automated.** Trust levels are assigned by humans (through spark sessions) or by protocol rules (convergent signals), but never by AI confidence scores alone.
