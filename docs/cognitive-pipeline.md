# The Cognitive Pipeline

A unified architecture for organizational intelligence through AI-assisted divergent thinking, trust-calibrated at every stage.

**Origin:** Spark session (nuclear-rated). Source analysis + reverse-harness insight.
**Status:** Tested across 5 spark sessions producing 55+ tracked sparks.

---

## The Architecture

One pipeline, five stages, trust-calibrated at every level:

```
DIVERGE          ENRICH              CALIBRATE           INTERPRET           DEPLOY
spark -->        dream-spark -->     trust level -->     interpreter -->     graduated routing
raw signal       org signal cross-   SEED/REVIEWED/      context-aware       daylog --> idea -->
                 referencing         VERIFIED/SOT        agent tests         ticket --> feature
                                                         against reality
```

### Stage 1: Diverge (Spark)

Ping-pong chain reaction. Human throws fragment, AI adds hop. Anti-convergence mechanics prevent premature closure. Output: raw associative chains.

The spark protocol uses three sustaining mechanisms:
- **Fuel injection** -- when the chain spirals inward, inject new raw material from memory, captured links, or web search
- **Anti-convergence ratchet** -- hard rules fire when convergence patterns are detected (about to summarize, same domain for 3+ hops, clarification impulse)
- **Cross-session accumulation** -- each session enriches the data lake, dream processes the enrichment, next session has richer fuel

See [skills/spark.md](../skills/spark.md) for the full protocol.

### Stage 2: Enrich (Organizational Subconscious)

Signal sweep across organizational tools (issue tracker, team chat, meeting notes, project management, calendar, design tools). Cross-reference organizational deltas against the memory pool. Pass 1b: memory x signal clusters. Output: grounded connections tagged `[ext-signal]`.

The enrichment stage transforms the dream cycle from a personal subconscious (files only) into an organizational subconscious (files + live signal changes). See [organizational-subconscious.md](organizational-subconscious.md) for the full pattern.

See [skills/dream-spark.md](../skills/dream-spark.md) for the implementation.

### Stage 3: Calibrate (Trust Scale)

Apply graduated confidence to every output:

- **SEED:** Raw spark, single session, one person. Handle with curiosity, not commitment.
- **REVIEWED:** Validated by 2+ organizational signals (convergent evidence from independent sources).
- **VERIFIED:** Produced a concrete artifact (ticket, PR, design doc). Survived contact with implementation.
- **SOT:** Changed behavior. The idea became how the team works. Proven in production.

See [trust-scale.md](trust-scale.md) for the full specification.

### Stage 4: Interpret (The Bridge)

Context-aware agent holds idea model + organizational model simultaneously. Says "these match HERE" or "these contradict HERE." The interpreter tests ideas against reality -- not by judging them, but by finding where they connect to (or conflict with) live organizational state.

The interpreter function is what separates divergent thinking from brainstorming. Brainstorming generates ideas and stops. The interpreter grounds ideas in organizational reality without collapsing them into action items prematurely.

### Stage 5: Deploy (Graduated Routing)

Route by confidence level:

| Trust Level | Routing |
|------------|---------|
| **SEED** | Daylog entry, dream-spark fuel. Might expire. |
| **SEED+** | Idea file. Worth parking for dream-spark enrichment. |
| **REVIEWED** | Idea file + issue tracker ticket candidate. Add `spark-derived` label. |
| **VERIFIED** | Issue tracker ticket with full provenance. High-confidence action item. |
| **SOT** | Process change, standard update, team-wide adoption. |

The routing prevents both noise-shipping (SEED ideas becoming tickets) and insight-burial (VERIFIED ideas staying in daylogs).

---

## Why This Matters: The Divergent Tooling Gap

**Convergent AI tooling** = crowded category. Code assistants, AI pair programmers, autonomous coding agents, issue tracker agents -- all optimize for getting from A to B.

**Divergent AI tooling** = active research, but fragmented. Academic work addresses individual components -- anti-convergence via multi-agent debate ([Liang et al., EMNLP 2024](https://arxiv.org/abs/2305.19118)), divergent/convergent persona scaffolding ([arXiv:2510.26490](https://arxiv.org/abs/2510.26490)), recursive divergence for story ideation ([Reverger, arXiv:2507.03307](https://arxiv.org/abs/2507.03307)), and the AD-Loop's DMN/ECN-mapped Wander-Combine-Check-Report cycle ([TechRxiv, 2025](https://www.techrxiv.org/doi/pdf/10.36227/techrxiv.176283739.98056311/v1)). Commercial tools (Miro AI, Ideamap.ai) offer brainstorming features but are structurally shallow -- they generate ideas then immediately organize them. A 2025 EMNLP survey of creativity in multi-agent systems ([arXiv:2505.21116](https://arxiv.org/abs/2505.21116)) explicitly notes "inconsistent evaluation standards" and "the lack of unified benchmarks" across the field.

**The gap is integration, not absence.** To our knowledge, no existing product or open-source project combines all five — though the field is active and new work may exist that we have not surveyed:

1. A working divergent thinking engine with anti-convergence mechanics (spark protocol, tested across 5 sessions producing 55+ tracked sparks)
2. Organizational signal grounding (signal snapshot, tool-powered enrichment)
3. Graduated confidence calibration at every stage (trust scale, derived from medical AI trust patterns)
4. Interpretation that tests ideas against live organizational state
5. Trust-graduated routing with cross-session persistence and validation infrastructure (survival rates, counter-factual evidence)

The AD-Loop shares neuroscience inspiration and provenance tracking but lacks validation infrastructure and cross-session accumulation. Reverger implements recursive divergence but is domain-specific (story ideation) with no organizational grounding. The spark protocol may be among the first systems to integrate all five components into a working tool, though we have not conducted a systematic survey of the field. Validation is early-stage: one user, five days.

---

## The Medical AI Mapping

The trust architecture in this pipeline was informed by patterns from AI-powered cancer diagnostics (FDA 510(k), CE-IVDR regulated). The pattern transfer:

| Cancer Diagnostics | Cognitive Pipeline |
|-------------------|-------------------|
| Raw AI slide classification | Raw spark chain |
| Calibrated thresholds per cancer type | Trust levels per idea stage |
| Points of Interest (uncertainty flags) | `[ext-signal]` dream-sparks |
| Second-read deployment (AI assists pathologist) | Dream-spark + spark session (AI assists leader) |
| Graduated trust (shadow --> audit --> suggest --> draft --> auto --> authority) | SEED --> REVIEWED --> VERIFIED --> SOT |
| False negative (missed cancer) more dangerous than false positive | Missing a real insight more costly than shipping noise (asymmetric) |
| Undetermined zone triggers useful action (order IHC stain) | Low-confidence sparks trigger deeper exploration, not discard |

The critical insight from medical AI: **showing uncertainty builds more trust than hiding it.** Even when classifying a tissue sample as benign, the system always shows the top Points of Interest for cancer -- the highest-scoring suspicious locations. When a POI catches something the classification missed, trust INCREASES because the system was transparent about where its uncertainty lived.

Applied to the cognitive pipeline: every spark carries its trust level visibly. A SEED spark is not hidden -- it is presented as SEED. The consumer knows exactly how much confidence to place in it.

---

## The Reverse-Harness Advantage

Claude Code's infrastructure was built for convergent work:
- `context: fork` -- isolated execution environments
- Hook events -- lifecycle middleware
- Coordinator mode -- async worker orchestration
- MCP tools -- external system integration
- Deferred loading -- on-demand context
- Compaction -- long session maintenance

All of these work BETTER for divergent work because divergent thinking is more resource-hungry (wide context sweeps, parallel agents, cross-referencing). The approach runs convergent hardware with divergent software. The infrastructure supports divergent thinking perfectly -- it just was not designed for it.

**Temporal advantage:** When native divergent models ship (models with richer associative capabilities), the protocol layer provides one of the few tested harnesses for structured divergent thinking — and one of the first to integrate all five pipeline stages. The protocol becomes amplification instead of simulation.

---

## How to Implement This with Claude Code

The cognitive pipeline is implemented through three skills in this repository:

### Stage 1 (Diverge): `/spark`

The core ideation engine. Ping-pong chain reaction with anti-convergence mechanics.

```
/spark <anchor>
```

See [skills/spark.md](../skills/spark.md) for the full protocol. Produces raw chains, session ratings, and trust-level assignments.

### Stage 2 (Enrich): `/dream-spark`

The organizational subconscious. Runs a signal sweep, cross-references organizational deltas against the memory pool, and produces grounded connections.

```
/dream-spark
```

See [skills/dream-spark.md](../skills/dream-spark.md) for the full protocol. Produces `dream-sparks.md` with `[ext-signal]` tagged connections.

### Stage 3-5 (Calibrate, Interpret, Deploy): Built into `/spark`

Trust-level assignment happens in spark Phase 3 (cool-down), Step 2.5. The interpreter function operates during Phase 2 (chain reaction) when organizational signals are present. Graduated routing happens in Phase 3, Step 3.

### Background Processing: `/daydream`

Triggered micro-sparks that run in the background via sub-agents while you work on other things.

```
/daydream <whisper>
```

See [skills/daydream.md](../skills/daydream.md). Produces background connections that feed into the next spark session.

### Setup

1. Install the skills from `skills/` to your Claude Code commands directory
2. Create a knowledge directory with `fomo/`, `sparks/`, `ideas/`, `signals/`, and `daylog/` subdirectories
3. Optionally configure MCP tools for organizational signal queries (issue tracker, team chat, meeting notes)
4. Run `/spark` with any anchor to start

The pipeline degrades gracefully. Without MCP tools, you get personal-subconscious-only sparking. With MCP tools, you get the full organizational subconscious.
