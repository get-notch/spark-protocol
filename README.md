# Spark Protocol

**Your AI converges by default. This makes it diverge.**

---

## What it feels like

You throw a fragment. The AI adds a hop. Neither summarizes. The chain goes somewhere neither of you planned:

```
[1]  you:    "something about customer onboarding feels like a flocking problem"
[2]  claude: "flocking = local rules, global behavior. Each bird only sees
             its neighbors. Your onboarding steps only see their own context."
[3]  you:    "right — step 3 doesn't know what the customer said in step 1.
             each step is blind to the others."
[4]  claude: "blind agents with local context is also how ant colonies work.
             stigmergy — they don't communicate directly, they leave traces
             in the environment that other agents read."
[5]  you:    "we don't even have the traces. there's no shared surface."
[6]  claude: "medical AI had the same problem. The pathologist annotates a
             slide, but the model never sees the patient's history. The fix
             was cross-referencing — feed the full case context alongside
             the classification. Not more agents. More context per agent."
[7]  you:    "that's the opposite of what we're building. we keep adding
             specialized steps instead of enriching the context each step
             sees."
[8]  claude: "the ant colony doesn't need smarter ants. it needs richer
             pheromone trails. what if each onboarding step wrote its
             findings to a shared context layer, and every subsequent step
             read the full trail?"
[9]  you:    "that's not an onboarding optimization. that's a completely
             different architecture — one shared context, orchestrated
             steps reading from it."
[10] you:    "ok, let's land this before we lose it"
```

**The cool-down captures the spark before it fades:**

```
[cool-down]
  Rating: fire
  The idea: single orchestrator with full customer context, not a pipeline
  of isolated steps. Reframes the entire onboarding architecture.

  → Idea file created: "orchestrator-onboarding-architecture.md"
  → Trust level: REVIEWED (connects to 2 prior dream-sparks)
  → Next: Linear ticket when validated with the team
```

Five hops. A fragment became an architectural insight. The chain captured every step so you can trace HOW you got there. And the cool-down landed it into something actionable — not just a conversation, but an idea with provenance, a trust level, and a path to implementation.

Most AI tools help you execute faster. This one helps you think wider — and land what you find.

---

## Why I built this

I have ADHD. My brain fires chain reactions across unrelated domains — a customer complaint reminds me of a medical diagnostics pattern, which connects to a hiring gap, which reveals an architecture decision nobody noticed. The ideas are real. They fade in seconds.

So I studied the neuroscience. Creativity runs on three brain networks: the Default Mode Network (wandering), Executive Control (focus), and the Salience Network (the switch between them). The key finding: creativity correlates with the *frequency of switches* between wandering and focus — not dominance of either. In ADHD brains, the gate between these networks is leakier. More noise. But also more connections that focused thinkers never reach.

I took the useful part — the chain reaction pattern — and built a protocol that sustains it in AI. The anti-convergence mechanics fight the model's instinct to summarize. The trust calibration manages the noise. The survival tracking keeps me honest about what ships vs what just felt like progress.

The protocol works for anyone. My ADHD inspired the design — it's not a prerequisite.

---

## It dreams overnight

The system doesn't stop when you close the laptop. An overnight daemon cross-references your full context — memory files, captured links, issue tracker, team chat, meeting notes — and finds connections nobody is watching for.

One night, it connected a product initiative to a pattern from my previous role in medical AI. Nine hours later, a senior leader asked about building a framework in that exact domain. The context was pre-loaded. One spark session turned 8 weeks of accumulated insights into a proposal, delivered the same day.

The overnight system found the answer before the question was asked.

---

## Who is this for?

**Creators, PMs, and dreamers.** If you've ever had a shower thought that connected two things nobody else saw — this is that, on demand. You throw fragments, the AI riffs. The chain captures every hop so the insight doesn't fade.

**Thought leaders and strategists.** The organizational subconscious reads your issue tracker, team chat, and meeting notes overnight. It finds what's connecting across your teams that nobody is watching. The heat surfacing tells you which ideas are ripe right now.

**Builders.** Six Claude Code skills, anti-convergence mechanics, chain capture, trust calibration, two-tier memory management. Built on neuroscience. Open source.

---

## Six skills

| Skill | What it does |
|-------|-------------|
| `/ideate` | Activate divergent mode. Scores your ideas for heat, presents the ripest as one-tap spark launchers. The entry point. |
| `/spark` | Ping-pong divergent thinking with anti-convergence mechanics. The core engine. |
| `/dream-spark` | Overnight cross-referencing across your full context + org signals. The blind spot detector. |
| `/daydream` | Background micro-spark. Whisper a hunch; a sub-agent chases it without interrupting you. |
| `/delve` | Process captured links into resonance, patterns, and connections. The absorption layer. |
| `/fomo` | Zero-friction capture. URL, thought, half-idea — one command, done. |

---

## Quick start

```bash
git clone https://github.com/get-notch/spark-protocol.git
cd spark-protocol
./install.sh   # 30 seconds — asks for paths, sets up directories
```

Then:
```
/ideate
```

This loads your fuel, scores your ideas by signal accumulation, and presents a "What's Hot" picker:

```
What's pulling you?

🔥 "What breaks if the trust scale has no temporal dimension?"
   ↳ 2 dream-sparks this week + handwritten note

🔥 "The observability gap now has quantitative evidence — what changes?"
   ↳ delve absorbed yesterday

🌡️ "Three sources describe the same architecture independently — coincidence?"
   ↳ 1 dream-spark, overnight

> Something else
> Just explore
```

Pick a hot idea, throw your own anchor, or just explore. The heat scoring: handwritten notes (3x — you physically wrote it), overnight connections (2x — the system found it), recent absorptions (1x — you examined and enriched it).

**First time?** No ideas yet = no heat. You'll see "Something else" and "Just explore." The heat builds as you spark, capture, and dream.

---

## How it works

### The session

Start with `/ideate`. It loads your context, surfaces what's hot, and activates divergent guardrails — no premature summarizing, no productivity guilt, follow every tangent.

Within a session, use the skills freely:
- `/spark <anchor>` — full divergent thinking with chain capture
- `/daydream <whisper>` — background micro-spark while you keep talking
- `/dream-spark` — cross-referencing across your full knowledge base
- `/delve` — process a FOMO capture into resonance and connections
- `/fomo <url or thought>` — capture without breaking flow

### The capture → absorb pipeline

`/fomo` captures. `/delve` completes the thought — reads the content, extracts the pattern, cross-references against your memory, and verdicts: **absorb** (enrich context), **park** (interesting, not urgent), or **release** (FOMO resolved). The gap between capture and absorption is where knowledge rots.

```
/fomo <url>    → captured (1 second)
    ↓
/delve         → processed (reads, extracts, verdicts)
    ↓
dream-sparks   → fuel for next session
```

### Inside a spark session

**Ignition** — provide an anchor. The AI sweeps your context for anything that resonates.

**Chain Reaction** — ping-pong. You throw a fragment, the AI adds a hop. Neither converges. Anti-convergence mechanics prevent premature summarization.

**Cool-down** — trace the chain. Rate the session. Assign trust levels. Route outputs.

### Anti-convergence

LLMs want to summarize. This fights it:
- Semantic narrowing → force cross-domain jump
- Summary impulse → suppress, make one more hop
- Clarifying question → replace with assertion
- Energy drop → inject random context

### The organizational subconscious

`/dream-spark` queries your org tools (issue tracker, chat, meeting notes, calendar) and cross-references against your memory pool. Same topic in two unrelated places = connection worth investigating. Runs on schedule or on demand. [Details →](docs/organizational-subconscious.md)

### Trust calibration

Every output gets a trust level: **SEED** (raw idea) → **REVIEWED** (validated by org signals) → **VERIFIED** (produced an artifact) → **SOT** (changed how the team works). Trust determines routing — prevents both shipping noise and burying insight. [Details →](docs/trust-scale.md)

### Memory management

Creative systems grow until they break. The fix: a two-tier architecture inspired by [MemPalace](https://github.com/milla-jovovich/mempalace). Active sparks stay hot. Archived sparks move to cold storage — still searchable, never loaded. [Details →](docs/memory-management.md)

### Cross-session snowball

```
Session 1 → sparks saved → overnight cross-referencing
Session 2 → richer fuel → better sparks → saved
Session N → connections self-sustain
```

---

## Does it work? (honest numbers)

17 days of tracked use: **72 ideas captured, 24 shipped (33%), 3 changed how the team works.** 15 are dormant. 3 have died. The system also caught me using creative tooling to avoid harder work — which is itself a useful insight.

The [survival log](docs/validation.md) tracks every spark — its trust level, provenance, and whether it shipped, stalled, or died. [Evidence →](EVIDENCE.md) · [Original chain →](PROOF.md) · [V&V checklist →](V&V-CHECKLIST.md)

**Caveats:** One person, 17 days. The ADHD-creativity link is more nuanced than headlines suggest. These numbers are directional, not definitive.

---

## The deeper architecture

[Architecture & neuroscience →](docs/architecture.md) · [Cognitive pipeline →](docs/cognitive-pipeline.md) · [Claude Code internals →](docs/lessons-from-claude-code-internals.md)

## References

- [Brain network switching predicts creative ability](https://www.nature.com/articles/s42003-025-07470-9) (Nature, 2025)
- [Disrupting DMN reduces creative output](https://academic.oup.com/brain/article/147/10/3409/7695856) (Brain, 2024)
- [Creativity and ADHD](https://pubmed.ncbi.nlm.nih.gov/33035524/) (2020)

## License

MIT
