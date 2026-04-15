# The Organizational Subconscious

A pattern for wiring external organizational signals into the dream cycle, transforming personal knowledge cross-referencing into organizational intelligence.

---

## The Core Concept

A dream cycle that only reads local files (memory, notes, captured links) is a **personal subconscious** -- it cross-references what one person knows and has written down.

Wire in live organizational signals -- issue tracker deltas, team chat threads, meeting summaries, project board movements -- and it becomes an **organizational subconscious**. It surfaces connections that no individual is watching, across sources that no individual reads in full.

### Snapshot vs. Delta

Most organizational tools show you the **current state** (what is true now). The organizational subconscious cares about **deltas** (what changed, moved, escalated, or went quiet). The distinction matters:

| Approach | Question | Output |
|----------|----------|--------|
| Snapshot (current state) | "What does the org need today?" | Priorities, blockers, status |
| Delta (backward-looking) | "What changed that nobody connected?" | Hidden patterns, convergent signals, drift |

Forward-looking tools (daily standup, sprint review, status dashboards) cover the snapshot. The organizational subconscious covers the delta -- what moved between the snapshots that nobody is explicitly tracking.

### The Hybrid Architecture

The organizational subconscious uses a two-tier architecture that balances signal depth with resource cost:

**Heavyweight tier (dream-spark):** Runs a full signal sweep across all configured sources. Writes a reusable **organizational signal snapshot** file. This is the expensive operation -- multiple tool queries, full cross-referencing, signal cluster detection.

**Lightweight tier (daydream, spark):** Reads the snapshot if fresh (less than 24 hours old). Optionally runs inline queries when a chain hop touches an organizational topic. No full sweep -- just reads what dream-spark already gathered, plus targeted lookups.

```
Dream-spark (nightly/periodic):
  Step 0: Signal sweep --> write <KNOWLEDGE_DIR>/signals/YYYY-MM-DD.md
  Steps 1-5: Cross-reference memory x signals, produce dream-sparks

Daydream (background, frequent):
  Step 1.5: Read latest signal snapshot (if fresh)
  Step 2.5: Inline query issue tracker + team chat for whisper keywords

Spark (interactive session):
  Step 2.5: Load latest signal snapshot (if fresh)
  Mid-chain: Hop-triggered inline queries when chain touches org topics
```

---

## The Signal Snapshot

The signal snapshot is a point-in-time capture of organizational deltas. It lives at `<KNOWLEDGE_DIR>/signals/YYYY-MM-DD.md` and is written by dream-spark as its first step (Step 0).

### What It Captures

For each configured source, the snapshot captures what **changed** in a rolling window (default: 48 hours since last snapshot):

| Source Category | Delta Query | Output |
|-----------------|------------|--------|
| Issue tracker | Status transitions, new comments, newly blocked items, cycle progress | Status changes, blockers, comment themes |
| Team chat | Hot threads (high reply count), messages matching signal keywords (blocker, urgent, incident, stuck, escalat*), new channels | Escalation signals, conversation clusters |
| Meeting notes | Recent meetings -- summaries, action items, customer/topic mentions | Meeting themes, unresolved actions, recurring topics |
| Project management | Board items that changed status, new items, overdue items | State changes, customer-facing movement |
| Calendar | Recent + upcoming meetings (for temporal context) | Who met with whom, recurring patterns |
| Design tools | Recent file activity (if design-relevant sparks exist) | Design iteration signals |

### Snapshot Format

```markdown
# Organizational Signal Snapshot -- YYYY-MM-DD HH:MM

## Deltas (since last snapshot: YYYY-MM-DD)

### Issue Tracker
- ISSUE-XXXX: In Progress --> Blocked (owner: X) -- "waiting on API response"
- ISSUE-YYYY: 3 new comments, last: "this is the same issue as..."

### Team Chat
- #channel-name: 12-reply thread on "agent routing failures" (hot)
- #team-growth: 5 messages about candidate pipeline

### Meeting Notes
- Meeting "Weekly Sync" (date): action items [3], theme: onboarding delays

### Project Management
- Board item: "API Migration" moved to Stuck

### Calendar
- 3 meetings with customer stakeholders this week (pattern: escalation?)

## Signal Clusters
<!-- Auto-generated: same topic appearing in 2+ sources -->
- "onboarding delays" -- Meeting notes (weekly sync) + Issue tracker (ISSUE-YYYY blocked) + PM board (API Migration stuck)
```

### Signal Clusters

A **signal cluster** is the same topic appearing in 2+ independent sources. These are the highest-value dream-spark fuel because they represent convergent evidence -- multiple parts of the organization are signaling about the same thing, often without knowing it.

Signal clusters enter dream-spark's Pass 1b with priority: "This topic is showing up across your issue tracker, team chat, AND meeting notes -- does any memory file have a structural connection?"

### Delta Window

Default: 48 hours. If the previous snapshot is older than 48h (weekend gap, vacation), extend the window to cover since-last-snapshot. The snapshot header records both the current timestamp and the previous snapshot date so the window is always explicit and auditable.

---

## How Each Skill Uses Signals

### Source-to-Tier Matrix

| Source | Dream-Spark | Daydream | Spark |
|--------|:-----------:|:--------:|:-----:|
| Signal snapshot (file read) | writes it | reads if fresh | reads if fresh |
| Issue tracker (tool query) | via snapshot | inline query | hop-triggered |
| Team chat (tool query) | via snapshot | inline query | hop-triggered |
| Meeting notes (tool query) | via snapshot | -- | hop-triggered |
| Project management (tool query) | via snapshot | -- | hop-triggered |
| Calendar (tool query) | via snapshot | -- | hop-triggered |
| Design tools (tool query) | via snapshot | -- | hop-triggered |

**Design principle: match the weight to the tier.**

- Dream-spark gets everything through the full sweep. It is the heavyweight that produces the snapshot for others.
- Daydream stays lightweight: reads the snapshot + at most two inline queries (issue tracker + team chat for whisper keywords).
- Spark has full access on demand but only queries when a chain hop touches an organizational topic. Queries are opt-in, never automatic.

### Dream-Spark Changes

Dream-spark gains three new capabilities:

1. **Step 0: Signal Sweep** -- queries all configured sources and writes the snapshot file before cross-referencing begins
2. **Pass 1b: Memory x Signal Clusters** -- every signal cluster from the snapshot is tested against every memory file. "Topic X is active across issue tracker and team chat -- does any memory file have a structural connection?"
3. **`[ext-signal]` tagging** -- any dream-spark originating from or referencing external data gets tagged `[ext-signal]` in its title for visual distinction and filtering

### Daydream Changes

Daydream gains two new capabilities:

1. **Step 1.5: Read latest snapshot** -- free context if dream-spark ran recently. If stale (>24h), skip.
2. **Step 2.5: Inline queries** -- two lightweight tool calls: issue tracker search + team chat search for whisper keywords. The "is the org already talking about this?" check.

Optional swarm agents:
- Agent 4: Queries issue tracker for whisper keywords
- Agent 5: Queries team chat for whisper keywords

These run in parallel with existing swarm agents (memory grep, web search, captured links).

### Spark Changes

Spark gains signal awareness:

1. **Step 2.5: Load signal snapshot** -- ambient context during ignition, available if a chain hop connects to organizational topics
2. **Hop-triggered inline queries** -- when a chain touches an org topic, pull a live signal mid-chain: "Is there an issue about this?" / "Did anyone discuss this in team chat this week?"
3. **Phase 3 signal awareness** -- hops that referenced external data get flagged during traceback. Output routing can include: "this spark connects to ISSUE-XXXX -- link it when creating the ticket."

**Anti-convergence still applies.** External signals are fuel, not conclusions. An issue tracker result does not end the chain with "we should fix that ticket." It adds a hop: "the org is ALREADY working on this -- what is the connection to what we just sparked?"

---

## Configuring Your Signal Sources

The organizational subconscious queries your organizational tools via MCP adapters, CLI tools, or API clients. The **pattern** is portable across any tool combination. Replace the tool references below with your own:

### Supported Source Categories

| Category | Example Tools | What to Query |
|----------|--------------|---------------|
| Issue tracker | Linear, Jira, GitHub Issues, Shortcut | Status transitions, new comments, blocked items |
| Team chat | Slack, Teams, Discord | Hot threads, signal keywords, new channels |
| Meeting notes | Fathom, Otter, Fireflies, manual notes | Summaries, action items, topic mentions |
| Project management | Monday, Asana, Notion, Basecamp | Board state changes, overdue items |
| Calendar | Google Calendar, Outlook | Recent + upcoming meetings |
| Design tools | Figma, Sketch, Adobe XD | Recent file activity |

### Configuration

In your skill files' `allowed-tools` frontmatter, add the MCP tool names for your specific integrations. The skills reference tool categories generically -- you map them to your actual tools.

**Minimum viable setup:** Issue tracker + team chat. These two sources cover the most common signal clusters.

**Full setup:** All six categories. Each additional source increases the probability of detecting convergent signals across independent sources.

**No tools configured:** The skills degrade gracefully. Without MCP tools, you get memory-only cross-referencing (the personal subconscious). The organizational layer is additive, not required.

---

## Guardrails

### 1. `[ext-signal]` Tagging

Every dream-spark originating from or referencing external data gets tagged `[ext-signal]` in its title. This makes external-sourced sparks visually distinct and filterable. You always know whether a connection came from the memory pool or from live organizational signals.

### 2. 7-Day Auto-Expire

External-signal sparks not consumed by a spark session within 7 days get marked `[expired]` during the next dream-spark cycle. Not deleted -- deprioritized. Organizational signals lose relevance faster than structural memory connections.

### 3. Output-to-Consumption Ratio

Health metric tracked in the dream-spark summary:

```
Dream cycle complete.
Connections found: 8 (resonant: 5, faint: 2, noise: 1)
External-signal: 4 of 8
Unconsumed [ext-signal] sparks from prior cycles: 6
Health: consumption ratio 40% <-- flag if below 30%
```

Below 30% triggers a warning: "External signals outpacing consumption. Consider a spark session to process, or use quick mode for next cycle."

This guardrail prevents telescope readings from accumulating without someone looking through the eyepiece.

### 4. Snapshot, Not Surveillance

The signal sweep captures a point-in-time delta on demand. No daemon, no continuous monitoring. You decide when to sweep.

### 5. Team-Level Signals Only

The signal sweep captures team-level signals: channel threads, issue status changes, meeting themes, board movements. It does NOT extract individual performance data, private messages, or one-on-one meeting content. Personnel observations require human judgment through direct conversation.

### 6. Spark Sessions Ground-Truth External Sparks

An external-signal spark is a hypothesis. It becomes an insight only when a human spark session validates it. The tools are the telescope, not the ground truth. External signals tell you where to look -- the human decides what they see.

---

## Design Principles

- **Deltas, not snapshots.** The signal sweep captures what CHANGED, not the full state. The dream cycle cares about movement, not inventory.
- **Convergence detection.** Same topic in 2+ sources = signal cluster = priority fuel for cross-referencing.
- **Graduated depth.** Dream-spark gets everything. Daydream gets lightweight. Spark gets on-demand. Match the weight to the tier.
- **Expire what is unconsumed.** External signals decay. The guardrail prevents signal accumulation without processing.
- **Infrastructure exists.** This is a wiring pattern, not a capability project. If you have MCP adapters, CLI tools, or API clients for your organizational tools, you can wire them into the dream cycle using this architecture.
