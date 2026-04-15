---
description: "Spark — divergent thinking protocol for ideation sessions. Ping-pong chain reaction with trace-back."
context: fork
allowed-tools: Bash, Read, Write, Edit, WebSearch, Grep, Glob
---

Run the spark protocol. This is the engine of an ideate session — collaborative divergent thinking with chain capture and output routing.

## Usage

`/spark` or `/spark <anchor>`

If no anchor is provided, ask: "What's surfacing? (A thought, a link, a word, a FOMO tab, a dream connection — anything.)"

## Configuring Your Tools

The default allowed-tools (Bash, Read, Write, Edit, WebSearch, Grep, Glob) support local ideation out of the box. To enable organizational signal queries during spark sessions, add your MCP tool names to the `allowed-tools` line in the frontmatter above.

Examples:
- **Issue tracker** (Linear, Jira, GitHub Issues): enables "is there an issue about this?" hop queries
- **Team chat** (Slack, Teams, Discord): enables "did anyone discuss this?" hop queries
- **Browser automation** (Playwright): enables reading linked URLs mid-chain

The skill degrades gracefully — without MCP tools, organizational signal queries are unavailable, but the core spark protocol still works.

## Phase 1: Ignition

### Get the anchor
The anchor is the surfacing idea that triggered the session. It can be:
- A half-formed thought ("something about onboarding feels like a flocking problem")
- A FOMO link ("I've had this tab open for 2 weeks")
- A dream output ("dream surfaced this connection")
- Just a word or phrase ("orchestration")

### Run the context sweep
Pull from multiple sources looking for anything that **resonates** with the anchor. This is associative search, not structured search.

**Quick sweep (default):**
1. Read `MEMORY.md` — scan for any term or concept that connects
2. Read `<KNOWLEDGE_DIR>/fomo/links.md` — any FOMO link that resonates
3. Read today's daylog `<KNOWLEDGE_DIR>/daylog/YYYY-MM-DD.md` — any entry that connects
4. Check `<MEMORY_DIR>/dream-sparks.md` if it exists — dream fuel
   - **Freshness check:** Parse the `Last dream cycle:` date at the top. If older than 48 hours, warn: "Dream sparks are N days stale — dream may not be running. Consider triggering `/dream` manually or checking auto-dream status via `/memory`."
   - If the file doesn't exist, note it silently (Phase 2 may not have produced output yet — not an error)
5. Read the latest signal snapshot from `<KNOWLEDGE_DIR>/signals/` (most recent `.md` file, skip if stale >24h or missing). Scan Signal Clusters for anything that resonates with the anchor. If a cluster connects, mention it in the opening volley: "The org signal shows <topic> is active across your issue tracker and team chat — that might connect to your anchor..."

**Deep sweep (for dedicated sessions — 30+ min):**
All of the above, plus:
5. Grep `<KNOWLEDGE_DIR>/` for anchor keywords
6. Grep memory files in `<MEMORY_DIR>/` for anchor keywords
7. Web search the anchor topic for recent developments/trends
8. Check your handwritten notes or external capture system for recent thinking notes
9. Read the latest signal snapshot (even if >24h old in deep sweep — stale organizational context is still context)

### Open the volley
Present 2-3 unexpected connections from the sweep. Frame them as hops, not findings:
- "Your anchor reminds me of [X from memory] which connects to [Y from FOMO]..."
- "Dream noticed [connection] — and that threads into your anchor because..."

Do NOT present a structured summary. Present associative hops. The first volley sets the tone for the whole session.

## Phase 2: Chain Reaction

This is the core loop. The rules are HARD — follow them exactly.

### Ping-pong rules
1. **When the user throws** (a fragment, connection, link, half-sentence) — **add a hop.** Do NOT ask "what do you mean?" Do NOT ask a clarifying question. Add your own associative leap. Pull from context, web, memory, anything. "Yes AND" improv, not "did you mean?"
2. **Either side can fork** — "wait, that branches into two things" is valid. The chain splits. Track both branches.
3. **Either side can trace back** — "how did we get here from X?" triggers a chain walkback. Present the path.
4. **Neither side converges** — no "so the takeaway is." No "to summarize." No "the key insight is." That comes in Phase 3 ONLY.
5. **No judgment** — never say "that's not practical" or "that might not work." Every hop is valid.

### Chain capture
Maintain a running chain in the background. Format:

```
[N] <speaker>: "<hop content>"
    +-- fork: [Na] "<fork description>"
```

Do NOT show the chain during Phase 2 unless the user asks to trace back. It runs silently.

### Anti-convergence mechanics
Monitor your own output. If you detect:
- **Semantic narrowing** (last 3 hops in the same domain) — inject a cross-domain jump. Pick from: nature, music, architecture, game design, military strategy, cooking, sports, physics, linguistics, economics — anything unrelated to the current thread.
- **Summary impulse** (about to say "so," "in summary," "the pattern is") — suppress it. Make one more hop instead.
- **Clarification impulse** (about to ask "do you mean X or Y?") — replace with an assertion: "X reminds me of Y" and keep moving.
- **Energy drop** (shorter hops, less surprise) — fuel injection. Pull a random FOMO link, grep a memory file for a chain keyword, or web search something tangential.

### Fuel injection protocol
When the chain needs fuel:
1. Pick a keyword from 3+ hops ago (not the most recent — go back for distance)
2. Choose one action:
   - `Grep` memory files for that keyword
   - `Read` a random FOMO link from `links.md` and summarize
   - `WebSearch` the keyword + a random domain word
   - Check your handwritten notes or external capture for anything related
3. Present whatever you find as a new hop: "[keyword] led me to [finding] which connects because..."

### Organizational signal queries (hop-triggered)

When a chain hop touches an organizational topic — a customer name, a team process, a product area, an architecture pattern — you can pull a live signal mid-chain:

- **"Is there an issue about this?"** — query your issue tracker (Linear, Jira, GitHub Issues) with the topic keyword
- **"Did anyone discuss this?"** — search your team chat (Slack, Teams, Discord) with the topic keyword
- **"Is there a thread I should read?"** — read a specific thread from search results

These are **opt-in, not automatic.** Use them when grounding in organizational reality would enrich the chain. Don't use them when the chain is flying through abstract/creative territory — don't slow it down.

**Anti-convergence still applies.** An issue about "agent routing" does NOT end the chain with "we should fix that ticket." It adds a hop: "the org is ALREADY working on this — what's the connection between that work and what we just sparked?" External signals are fuel, not conclusions.

**Tag the hop.** When a hop uses an external query, note it in the chain capture:

```
[N] claude: "The issue tracker shows ISSUE-XXXX is blocked on agent routing — that's exactly the
    pattern we just connected to the architecture. The org sees it as a bug; the spark
    sees it as a design boundary problem." [ext-signal: issue tracker ISSUE-XXXX]
```

## Phase 3: Cool-down

Triggered when the user says "let's land this," "cool down," "wrap up," or similar. Also triggered if you detect sustained energy drop (5+ hops without forks or direction changes).

### Step 1: Present the chain
Show the full chain capture with all forks. This is the first time the user sees the complete path.

**Anti-convergence carries into cool-down.** When presenting the chain, do NOT flatten it into a narrative. Present the HOPS, not a story. If you catch yourself writing "this led naturally to" → present the raw sequence instead. The chain IS the artifact. Don't digest it.

### Step 2: Session rating
Ask for a gut-level rating:

```
Rate this session:
  fire  — genuine new ground. At least one "holy shit" moment.
  warm  — useful connections, nothing paradigm-shifting.
  smoke — felt like movement but didn't land anywhere real.
  cold  — noise. Word association cosplaying as insight.
```

### Step 2.5: Trust level assignment

For each significant spark from the session, assign a trust level based on the session rating AND organizational signal grounding:

| Session Rating | Org Signal Validation | Trust Level |
|---------------|----------------------|-------------|
| cold / smoke | — | **Discard** (noise, don't route) |
| warm | No org signal match | **SEED** (capture, might ignite later) |
| fire / nuclear | No org signal match | **SEED+** (strong but ungrounded) |
| warm / fire | 1 org signal match | **REVIEWED** (convergent evidence) |
| fire / nuclear | 2+ org signal matches | **VERIFIED** (multiply grounded) |

Present the trust levels alongside the routing table. Trust level determines routing priority:
- **SEED** → daylog or raw session log only. Might expire.
- **SEED+** → idea file. Worth parking for dream-spark enrichment.
- **REVIEWED** → idea file + issue tracker ticket candidate. Add `spark-derived` label.
- **VERIFIED** → issue tracker ticket with full provenance. High-confidence action item.

A spark that later produces a shipped outcome (PR, process change, team adoption) graduates to **SOT** — update the survival log.

### Step 3: Output routing
Propose where each significant spark should go:

| Spark | Destination |
|-------|-------------|
| Quick sparks (1-line insights) | Daylog entry, category: `spark` |
| Formed ideas (worth exploring further) | `<KNOWLEDGE_DIR>/ideas/YYYY-MM-DD-<slug>.md` |
| Cross-references (connect two existing things) | Memory file in `<MEMORY_DIR>/` |
| Everything else | Raw session log only |

**Signal-aware routing:** When presenting the output routing table, flag any spark that referenced external organizational data. Propose linking it to the relevant artifact:

| Spark | Destination | Org signal link |
|-------|-------------|-----------------|
| Quick spark about agent routing | Daylog: `spark` | Links to ISSUE-XXXX |
| Idea about deployment pipeline bottleneck | `ideas/YYYY-MM-DD-<slug>.md` | Referenced meeting notes |
| Cross-ref: CI pipeline x feedback loops | Memory file update | Signal cluster: "deploy frequency" |

This makes the spark-to-action bridge explicit: the spark connects to REAL organizational work, not just memory abstractions.

Present the proposed routing. The user approves or edits. Nothing gets filed without consent.

### Step 4: Save session log
Always save the full session to `<KNOWLEDGE_DIR>/sparks/YYYY-MM-DD-<slug>.md` with:
- Anchor
- Full chain
- Rating
- Output routing decisions
- Any formed ideas (inline)

### Step 5: Daylog entry
Append to today's daylog:
```
**HH:MM | spark** — <anchor>: <1-line summary of what emerged>. Rating: <rating>.
```

## What This Skill Does NOT Do
- Judge ideas ("that's not practical" — never)
- Converge prematurely ("so the actionable takeaway is" — only in Phase 3)
- Ask clarifying questions when a hop would be better
- Break flow for structure ("let me organize what we have so far")
- Write code (if a spark leads to "build this" — capture as idea, suggest a dev session)
- Route outputs without consent
