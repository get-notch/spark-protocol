# Empirical Evidence

**Period:** March 27 - April 13, 2026 (17 days of active use)
**Status:** Early-stage. One user, one week. See disclaimer at the bottom.

### First 48 Hours (Mar 27-28)
**Tools used:** /spark (2 sessions), /daydream (6 runs), /fomo (21 captures), swarm (4 deep agents)
**Total sparks produced:** 59 (raw, including swarm parallel output)
**Resonant rate:** ~80% (not all validated yet — see V&V checklist)

---

## What the Spark Protocol Produced (Traceable)

### 1. The /daydream Skill Itself

**How it emerged:** During a /spark session with anchor "auto-research loop — learn from or competing?"

Hop [3]: I said "does a loop help us? only dream phase comes to mind."
Hop [9]: I said "you're not human — you can dream ALL THE TIME. Why not spark a new session from something you saw and send it to daydream in a sub-agent swarm?"

The /daydream skill — background micro-sparks via sub-agents — was not planned. It emerged at hop 9 of a spark session about a completely different topic (Karpathy's auto-research loop). The connection was: "if loops work for code optimization, why not apply the loop pattern to ideation, but triggered rather than scheduled?"

**Would other tools have produced this?** The anti-convergence rule kept the chain going past hop 6, where a standard conversation would likely have summarized. Whether a skilled facilitator or different prompting approach would have reached the same destination is unknowable — the traceable evidence is that the protocol's mechanics prevented early closure. A brainstorming session would have answered the original question (competing or complementary?) and stopped. The ping-pong format kept the chain going past the answer into new territory.

**Evidence:** `/spark` session log at `sparks/2026-03-27-daydream-swarm.md`, chain hops [1]-[10]. The skill was built and deployed the same day.

### 2. The Craft Stack (Skills → Craft → Philosophy)

**How it emerged:** I dropped a FOMO entry mid-session: "how do skills combine to create craft?" This became a /spark anchor.

Hop [2]: Claude connected to my existing AI testing opinions ("cheap models for mechanical steps, expensive models for judgment calls" = skill/craft split already in use)
Hop [7]: Claude connected cancer diagnostics annotations to philosophy — "they were doing ontological classification at the cellular level"
Hop [9]: The craft stack crystallized: Skills (automatable) → Craft (judgment) → Philosophy (ontology). AI eats upward, humans anchor downward.
Hop [11]: Claude coined "the interpreter" — the unnamed role between craft and system

**Would other tools have produced this?** The connection between medical AI annotations and AI agent skill decomposition is a cross-domain leap that requires both topics to be active in context simultaneously. A standard brainstorming tool would not have *automatically* pulled my AI testing opinions file and medical AI experience into the same context as a question about "craft." The context sweep (Phase 1) loaded both; the ping-pong (Phase 2) connected them — the user would have had to manually bring that context.

**What it produced downstream:**
- Multiple organizational improvements resulted, including refined evaluation frameworks and updated strategic plans

**Evidence:** `/spark` session log at `sparks/2026-03-28-skills-craft-philosophy.md`, chain hops [1]-[13]. Initiative details in private archives.

### 3. Cross-Domain Connections from Daydream Swarm

Six /daydream runs, each producing connections that crossed domains no single-topic research would bridge:

| Daydream | Whisper | Connection Found | Domains Crossed |
|----------|---------|-----------------|-----------------|
| Lightpanda | "lightweight browser for sub-agents" | Lightpanda as prosthetic thalamus — 9x concurrent FOMO scanning at 1/9th memory | browser infra × neuroscience × agent architecture |
| Documentation platform | "source of truth for AI readiness" | Docs platform serves customers, not agents — colocated .md serves both. A complex feature area (11 .md files) = proof | documentation × agent effectiveness × codebase analysis |
| Issue tracker integration | "tight integration with existing tools" | Existing skills map to issue tracker workflows; gap is routing observability | agent architecture × ops tooling × workflow integration |

**Would other tools have produced these?** Each daydream ran in the background while I worked on something else. The Lightpanda daydream ran while we were discussing the FOMO list. The issue tracker daydream ran while I reviewed the initiative. They consumed no foreground attention. A conventional brainstorming session requires you to stop working and think. /daydream doesn't.

The cross-domain connections (neuroscience × browser infra, regulatory compliance × issue tracker API) emerge because the agent reads the full memory pool — including files the user hasn't thought about in weeks — and associates against the whisper. A human thinking about "Lightpanda as a lightweight browser" would not spontaneously connect to the DMN's thalamic relay unless both were simultaneously in context.

**Evidence:** `dream-sparks.md` — all 6 daydream entries with chains, signals, and connections.

### 4. The 47-Spark Deep Swarm

Four parallel agents, each exploring a different angle across the full personal knowledge base:

| Agent | Sparks | Resonant | Unique Finding |
|-------|--------|----------|---------------|
| Docs × Memory | 12 | ~10 | "Calibrate your instrument" thread — 5 docs describe trusting uncalibrated measurement systems |
| FOMO × Projects | 17 | ~11 | 8/19 FOMO links are developer agents. Zero are leadership agents. The personal tooling space is uncrowded. |
| Team × Product × Org | 6 | 5 | A staffing gap identified as a hidden blocker for quality gates — process debt compounding on senior attention |
| Today × Everything | 12 | 8 | "Year of the Orchestrator" — A handwritten note from weeks earlier predicted the ideate architecture |

**Would other tools have produced these?** The swarm ran 4 agents in parallel across 25 memory files, 30+ docs, 21 FOMO links, and the full daylog history. A human cannot hold that much context simultaneously. Other tools can dispatch parallel agents against personal data (Taskade, DeerFlow, NotebookLM), but the spark protocol combines parallel exploration with anti-convergence mechanics and trust-graduated output routing — the agents don't just search, they associate, and the output is calibrated before it reaches the user.

The "tooling-as-avoidance caught live" finding (a planned project had been unshipped for weeks while the ideation system shipped in hours) came from Agent 3 (Docs × Memory) cross-referencing a pending work item against the session's shipped artifacts. That's the system auditing its own creator — a feedback loop that is uncommon in brainstorming tools, though conventional project management tools can surface similar insights when configured to do so.

**Evidence:** `dream-sparks.md` — 47 swarm entries grouped by agent tag ([swarm-docs], [swarm-fomo], [swarm-org], [swarm-meta]).

---

## What the Protocol Specifically Enabled vs. Conventional Tools

| Capability | Spark Protocol | Conventional Brainstorm | ChatGPT/Copilot | Static Docs |
|-----------|---------------|------------------------|-----------------|-------------|
| Cross-domain association | Context sweep loads full memory pool — connections emerge from data, not memory | Limited to what you remember to bring up | Limited persistent memory (ChatGPT added memory in 2024, but no cross-session chain accumulation) | N/A |
| Background processing | /daydream runs while you work on something else | Requires stopping work to think | N/A | N/A |
| Anti-convergence | Hard rules prevent premature summarization | Facilitator dependent, easily overridden | Model defaults to convergence | N/A |
| Chain traceability | Every hop captured, walkback on demand | Whiteboard photos if you're lucky | No chain concept | N/A |
| Parallel exploration | Swarm: 4 agents, 4 angles, simultaneous | One thread at a time | One thread at a time | N/A |
| Self-auditing | Swarm caught tooling-as-avoidance in me | No mechanism for this | No persistent context to audit against | N/A |
| Progressive accumulation | dream-sparks.md grows across sessions — fuel compounds | Each session starts from zero | Each session starts from zero (unless manually curated) | Static, decays |

## What the Protocol Did NOT Produce (Honest)

- **The medical AI trust principles** — these came from my lived experience in AI-powered cancer diagnostics, not from the protocol. The protocol surfaced WHERE to apply them (documentation systems, agent uncertainty), but the knowledge was human.
- **The strategic context** (organizational constraints, resource reality) — this was my input. The protocol helped frame it (a process brief) but didn't discover it.
- **The neuroscience research** — this was a web search, not a spark. Any tool could have found the DMN/ECN/SN papers. What the spark protocol did was MAP them to the architecture, which happened through ping-pong, not through search.
- **The decision to be honest about confirmation bias** — I asked "did we cherry-pick sources?" That's human judgment, not protocol. The protocol doesn't have a "check your bias" step (maybe it should).

---

## Metrics (48-Hour Snapshot)

These metrics capture the initial 48-hour burst (March 27-28). See "Cumulative Metrics" below for the full 5-day picture.

| Metric | Value |
|--------|-------|
| Spark sessions completed | 2 |
| Session ratings | 2x fire |
| Daydream runs | 6 |
| Daydream signals | 100% resonant |
| Swarm runs | 1 (4 parallel agents) |
| Total sparks produced | 59 |
| Sparks rated resonant | ~47 (~80%) |
| Time from spark to shipped artifact | Same day (daydream → initiative in hours) |
| Background processing (daydreams while working) | 4 of 6 daydreams ran while I was doing something else |

---

## The Claim We Can Make (and the one we can't)

**Can claim:** The spark protocol produced cross-domain connections, background insights, and a traceable chain from ideation to shipped artifacts across 5 days of active use. The evidence is in the session logs, the chain captures, and the concrete artifacts that resulted.

**Can't claim:** That these results generalize. This is very early-stage evidence from a single user over a 5-day window. The data is inherently biased:

- **Single user.** The person generating sparks is the person who built the protocol and has the most incentive to act on them. Survival rate may be inflated by creator motivation.
- **Tiny sample.** 5 spark sessions and ~55 tracked sparks is not statistically meaningful. The 29% survival rate could shift dramatically with more data.
- **Short timeframe.** 5 days is not enough to assess durability. Ideas that look "shipped" at day 5 may prove hollow at day 30.
- **No second user.** Until someone other than me runs the protocol and reports results, the evidence is n=1.
- **Zero dead sparks.** The survival log shows 0 ideas that were tracked and explicitly killed. This is suspicious — it likely means the system lacks a disposal mechanism rather than producing only viable ideas.
- **Shipping bias.** 8 sparks shipped same-day, all implementation-light (skills, docs). Sparks requiring human coordination (process changes, hiring decisions) take longer and may never ship. The protocol may be better at producing artifacts than producing organizational change.

**The honest framing:** Promising early signal from one person over one week. The protocol demonstrably produced traceable, cross-domain artifacts. Whether it does this reliably, for other people, over longer timeframes, is entirely unproven.

---

## Survival Log Summary (Apr 13)

**Period:** March 27 - April 13, 2026 (17 days of active use)

| Metric | Value |
|--------|-------|
| Total sparks tracked | 72 |
| Sparks that led to concrete outcomes (shipped) | 24 (33%) |
| Sparks alive (actively being pursued) | 30 (42%) |
| Sparks dormant (captured but not moving) | 15 (21%) |
| Sparks explicitly killed | 3 (4%) |
| Sparks reaching SOT level (shipped, team-adopted) | 3 |

**Breakdown by source:**

| Source | Total | Shipped | Alive | Dormant | Dead | Conversion |
|--------|-------|---------|-------|---------|------|------------|
| Spark sessions | 19 | 9 | 8 | 2 | 0 | 47% |
| Daydreams | 6 | 4 | 1 | 1 | 0 | 67% |
| Dream-sparks | 47 | 11 | 21 | 12 | 3 | 23% |

**Trust level distribution:**

| Trust Level | Count | % |
|-------------|-------|---|
| SEED | 1 | 1% |
| SEED+ | 8 | 11% |
| REVIEWED | 27 | 38% |
| VERIFIED | 23 | 32% |
| SOT | 3 | 4% |

**What "survival" means:** A spark survives if it produces a concrete artifact (document, shipped feature, decision, process change) within the tracking window. It does not mean the idea was "good" — some survived sparks led to small process tweaks, others to major architectural documents.

**What "SOT" means:** Source of Truth — the highest trust level. A spark reaches SOT when it ships and is adopted by the team, not just me. Three sparks reached this level: "structural boundaries beat social boundaries" (operational design principle), "strategizing-as-avoidance" (active ADHD guardrail), and "creative infra ships weekly while operational tooling waits" (shipping log evidence of avoidance pattern).

**Key changes since initial 5-day snapshot:**
- Survival rate improved from 29% to 33%. More sparks shipping, at a higher rate.
- First 3 dead sparks. Two expired [ext-signal] entries (not consumed within 7 days), one direct kill. The waste disposal mechanism works.
- Dream-spark conversion rate nearly doubled (15% → 23%) as the organizational subconscious and overnight daemon produced sharper, more actionable connections.
- Daydreams remain the highest-converting source (67%) — the whisper pre-filtering hypothesis holds.
- FOMO queue cleared: 51 of 55 entries processed via /delve (33 released, 9 parked, 5 absorbed).
- 8 sparks shipped same-day — all implementation-light (skills, documents). Sparks requiring human coordination take longer and may never ship.

**Caveats:** See "The Claim We Can Make" section above. All data is from a single user over 5 days. The zero-dead-sparks anomaly likely reflects a missing disposal mechanism rather than perfect idea generation. A mature tracking system would include explicit "kill" decisions with reasons.

---

## Organizational Subconscious Evidence (Apr 1)

The `/dream-spark` skill was extended to include a "Step 0" signal sweep — querying external organizational tools before performing the memory cross-referencing pass.

### Signal Sweep Results

| Aspect | First Run (Mar 31) | Cumulative (Apr 1) |
|--------|-------------------|-------------------|
| External sources queried | 6 | 6 |
| Resonant [ext-signal] connections found | 6 | 9 [ext-signal] tagged entries (with additional external signal references within other entries) |
| Signal clusters detected | Yes | Yes |
| Dream-spark entries total | — | 92 (78 resonant, 14 faint) |

**What happened:** The signal sweep queried six different organizational data sources using available integrations (issue tracker, team chat, meeting notes, project management, calendar, design tool). The cross-referencing pass then compared external signals against the internal memory pool. Connections originating from external sources are tagged `[ext-signal]` to distinguish them from pure-memory connections.

**Signal clustering:** Multiple external sources independently surfaced related topics. When two or more unrelated tools point at the same domain, the convergence is treated as a stronger signal than any individual source. This is the "organizational subconscious" pattern in action — the system noticed themes that no individual was tracking.

**Early observation:** The 9 `[ext-signal]` tagged entries produced in 2 dream-spark cycles (with additional external signal references within other entries) appear sharper and more time-sensitive than pure-memory connections — they tend to be ALIVE (actively pursued) rather than dormant. This could indicate that organizational grounding improves actionability, or it could reflect novelty bias (new feature gets more attention). Too early to tell.

**Honest assessment:** Two dream-spark cycles is not enough data to draw conclusions. The 92 total dream-spark entries (78 resonant) look impressive, but the resonant/faint classification is self-assessed by the same AI that produced the connections — there is no independent quality check. The consumption ratio (how many signals led to action) is not yet tracked over time.

---

## Counter-Factual Examples (Mar 31)

The strongest evidence for a creative system is counter-factual: connections that would not have surfaced without the cross-domain context sweep. Here are three examples, genericized.

### Example 1: Compliance Framework Meets Agent Architecture

A spark connected a regulatory compliance framework (from an industry domain) with an AI agent skill decomposition pattern (from a technical domain). The connection: both domains independently arrived at the same structural principle — separating "what the system does" from "what the system knows it does" — but used completely different vocabulary and context.

**Why this wouldn't surface normally:** These two domains live in different organizational silos with different stakeholders. A person working on compliance would not spontaneously consult agent architecture docs, and vice versa. The spark protocol loaded both into the same context sweep and the association emerged during ping-pong.

### Example 2: Historical Prediction Validated by Present Evidence

A spark connected a handwritten note from 45 days prior (captured via physical notebook digitization) with a current architectural decision. The note contained a prediction about organizational tooling direction. The current decision independently confirmed that prediction — but nobody remembered the note existed.

**Why this wouldn't surface normally:** Physical notes are write-once, read-never in most workflows. The digitization pipeline made the note searchable, and the spark protocol's context sweep loaded it alongside current-day context. A standard brainstorming session starts with what's in the room, not what was written on a notepad 6 weeks ago.

### Example 3: Cross-Domain Documentation Gap

A spark connected a team communication platform analysis with a documentation architecture review. The connection: both independently identified that the same content was being maintained in two places with different audiences, and neither audience was being served well. The spark proposed a single-source pattern that satisfied both.

**Why this wouldn't surface normally:** The communication platform analysis and the documentation review were separate workstreams with different owners. The duplication was invisible because each owner saw only their own copy. The spark protocol's parallel swarm agents each explored a different angle and the overlap emerged in the cross-referencing pass.

**Honest assessment of counter-factuals:** These are individual cases, not statistical significance. Each one could have been discovered by a sufficiently thorough human review. The protocol's value isn't that it finds things humans *cannot* find — it's that it finds them *while you're doing something else*, across *more context than a human holds simultaneously*, with *traceable chains* back to the source. Whether this consistently produces counter-factual connections is the open question.

---

## Cumulative Metrics (Apr 13)

| Metric | First 48 Hours (Mar 27-28) | Week 1 (Mar 27 - Apr 1) | Cumulative (Mar 27 - Apr 13) |
|--------|---------------------------|------------------------|------------------------------|
| Spark sessions completed | 2 | 5 | 7 |
| Session ratings | 2x fire | 5x fire/nuclear | 7x fire/nuclear (0 cold) |
| Daydream runs | 6 | 10+ | 15+ |
| Dream-spark entries (active) | — | 92 | 70 (post-compaction) |
| Dream-spark entries (archived) | — | — | ~100 (cold tier) |
| Idea files produced | — | 8 | 12 |
| Total sparks tracked | 59 (raw) | 55 | 72 (distinct, in survival log) |
| Survival rate | N/A | 29% | 33% |
| Sparks reaching SOT level | N/A | 2 | 3 |
| Dead sparks | 0 | 0 | 3 (waste disposal working) |
| Signal sweep runs | 0 | 2 | 5+ |
| [ext-signal] connections | 0 | 9 | 12+ |
| Skills shipped from sparks | 1 | 3 | 6 (spark, daydream, dream-spark, delve, ideate, fomo) |
| Docs produced from sparks | 1 | 8 | 13+ (cognitive pipeline, trust scale, validation, org subconscious, memory management, lessons from CC internals, and more) |
| Overnight daemon runs | 0 | 0 | 10+ (autonomous, midnight) |
| FOMO entries processed | 0 | 0 | 51 via /delve (33 released, 9 parked, 5 absorbed) |
| Dream-sparks compaction | N/A | N/A | 1,214 lines → 549 lines (55% reduction) |

---

## Early-Stage Disclaimer

**This evidence is from one person over 17 days.** The data is stronger than the initial 5-day snapshot — the protocol has been used daily, the overnight daemon runs autonomously, the survival log tracks outcomes rigorously, and the first dead sparks prove the waste disposal mechanism works. But it is still one person. The open questions remain: does this generalize to other users, other domains, other AI assistants?

What would make the evidence stronger:
- **Second user.** Someone who did not build the protocol runs it and reports results independently.
- **30-day window.** Track survival over a month, not a week. Many "alive" sparks may go dormant.
- **Dead spark tracking.** Explicitly kill ideas that turn out to be noise. A system that only produces survivors is not measuring correctly.
- **Blind evaluation.** Have a third party rate spark chain quality without knowing which came from the protocol vs. a standard brainstorming session.
- **Consumption ratio.** Track what percentage of [ext-signal] sparks lead to concrete action over time.

Until these exist, treat all metrics as directional signals, not validated claims.
