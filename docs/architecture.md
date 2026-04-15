# Spark Protocol — Architecture

## Dual Intelligence Model

The spark protocol is built on a core insight: a knowledge system needs two modes of intelligence operating on the same data.

**Focus** (convergent) — structured, noise-reducing, task-directed. "What's important right now?"

**Blur** (divergent) — associative, signal-amplifying, exploration-directed. "What's connecting that nobody's watching?"

The same data sources (memory files, notes, captured links, project signals) feed both modes. Focus mode filters for relevance. Blur mode filters for resonance.

Most productivity tools only build Focus. The spark protocol builds Blur.

## The Three-Network Mapping

The protocol's architecture is *inspired by* the neuroscience of creativity — not a literal replication. The brain is vastly more complex than any software analogy. The mapping is useful as a design framework, not as a neuroscience claim.

### Default Mode Network (DMN) → Chain Reaction

The DMN is the brain's "wandering" network — active when not focused on a task. It generates spontaneous associations, simulates scenarios, and connects remote concepts.

In the spark protocol, `/spark` Phase 2 (chain reaction) is the DMN: free association, ping-pong, no convergence, no judgment. The chain runs until the energy shifts.

### Executive Control Network (ECN) → Cool-down

The ECN is the brain's "focus" network — evaluates, selects, refines. It catches the useful spark and applies it to the problem.

In the spark protocol, `/spark` Phase 3 (cool-down) is the ECN: trace back the chain, evaluate what emerged, route outputs to the right places.

### Salience Network (SN) → Transition Trigger

The SN decides when to switch between DMN and ECN. It detects when a wandering thought crosses the threshold from noise to signal.

In the spark protocol, the transition from Phase 2 to Phase 3 is the SN: "let's land this," or the natural energy drop that signals the chain has run its course.

### Sleep Consolidation → `/dream-spark`

The brain cross-references the day's experiences with long-term memory during sleep. Insights surface upon waking.

I originally tried to piggyback on Claude Code's auto-dream for this, but the mechanism only consolidates (tidy, prune, merge) — it doesn't cross-reference. Confirmed by canary test and later by reading the actual source code. `/dream-spark` fills the gap as an explicit cross-referencing pass, schedulable overnight via daemon.

## Chain Sustaining Mechanics (Nuclear Fission Model)

The core engineering challenge: LLMs have no dopamine. No internal reward for novelty. The chain dies without external fuel.

The model is nuclear fission:

| Fission | Spark Protocol |
|---------|---------------|
| Fissile material | The data lake (memory, FOMO, notes, signals) |
| Neutrons | Each connection/hop in the chain |
| Critical mass | Enough accumulated material that each hop produces MORE connections than it consumes |
| Moderator | The protocol rules — prevent the reaction from going supercritical (incoherent noise) |
| Chain reaction | Self-sustaining sparking |

### Three sustaining mechanisms

**1. Fuel Injection (in-session)**
When the chain spirals inward (hops getting semantically closer), inject new raw material: random FOMO link, memory grep, tangential web search, note from the scratch pile.

**2. Anti-Convergence Ratchet (in-session)**
Hard rules that fire when convergence patterns are detected:
- About to summarize → make one more hop
- Last 3 hops in same domain → force cross-domain jump
- Asking clarifying question → replace with assertion
- Semantic distance shrinking → widen the next jump

**3. Cross-Session Accumulation (the snowball)**
Each session enriches the data lake. Dream processes the enrichment. The next session has richer fuel. Critical mass is reached across sessions, not within one.

## Validation Framework (V&V)

### Verification (did it produce output?)
- Files exist, chain was captured, outputs were routed
- Dream-sparks.md has a recent timestamp (freshness check)

### Validation (is the output actually creative and useful?)

A valid spark is:
- **Non-obvious** — you didn't already know the connection
- **Structurally real** — holds up under scrutiny, not surface-level word overlap
- **Generative** — opens a door, triggers "wait... that means..."
- **Recognizable** — your brain goes "yes, that's the leap I would have made"

Noise is:
- Superficial pattern matching ("both are about processes")
- AI "everything connects to everything" flattening
- Interesting-sounding but leads nowhere

### Validation layers

1. **Session ratings** (fire/warm/smoke/cold) — gut reaction after each session
2. **Spark survival rate** — do ideas get referenced again in later work?
3. **Dream quality gate** — thumbs up/down on each dream-generated connection
4. **Monthly retrospective** — which sparks became real? (ideas → projects → shipped work)

Creativity can't be unit tested. But it can be calibrated through honest feedback loops.

## The Dopamine Gap

Human chains self-sustain via dopamine — each novel connection is its own reward. LLM chains die without external fuel.

The spark protocol addresses this through:
- **Fuel injection** (prosthetic novelty)
- **Anti-convergence ratchet** (fight the convergence instinct)
- **Cross-session accumulation** (make fuel abundant enough that connections are everywhere)
- **Session ratings** (prosthetic dopamine — calibrates the AI to what "creative" means to this specific human)

This is a prosthetic, not the real thing. But accumulation may make it real — when the data lake is rich enough, the connections aren't forced. They're naturally abundant.

The industry appears to be moving toward models with richer associative capabilities. If future models are natively wired for connective thinking, the spark protocol becomes amplification rather than simulation. If they aren't, it remains a working prosthetic.

## Neuroscience Caveats

We derived this architecture from creativity neuroscience research. Here's where we're on solid ground and where we're simplifying:

**Solid ground:**
- The DMN/ECN/SN three-network model is well-established and causally validated (DMN disruption reduces creative output — [Darda et al., Brain, 2024](https://academic.oup.com/brain/article/147/10/3409/7695856))
- Creativity correlates with DMN-ECN switching frequency, not dominance of either network
- ADHD is associated with reduced DMN-ECN anti-correlation ("leaky gate")

**Simplifications and caveats:**
- The DMN is not a monolith — [recent critical work](https://www.sciencedirect.com/science/article/abs/pii/S2352154625001032) flags "vast variability in scoring methodology" and "blanket interpretations despite heterogeneous findings." We use it as a design metaphor, not a neuroscience claim.
- "ADHD = creative" is an oversimplification. The divergent thinking advantage appears at *subclinical* ADHD trait levels but plateaus or diminishes at clinical diagnosis levels. ([Boot et al., 2020](https://journals.sagepub.com/doi/full/10.1177/1087054717727352))
- ADHD participants generate more *novel* ideas but fewer *high-quality* ideas. The quantity-quality tradeoff is real. ([2026 design creativity study](https://www.tandfonline.com/doi/full/10.1080/21650349.2026.2622928))
- Our mapping from brain networks to protocol phases is a useful analogy, not a literal correspondence. The brain is vastly more complex.

**Our position:** The specific cognitive mechanism we're replicating — reduced filtering between associative and evaluative processing — is real and documented. The protocol doesn't claim to replicate the brain. It claims to be *inspired by* a well-documented cognitive pattern and designed to produce a similar behavioral outcome (divergent chain reactions followed by convergent evaluation).
