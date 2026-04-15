---
description: "Daydream — triggered background micro-spark. Runs 3-5 associative hops in a sub-agent while you stay in focus mode."
context: fork
allowed-tools: Bash, Read, Write, Edit, WebSearch, Grep, Glob
---

Triggered background micro-spark. When something pings a pattern mid-session but you don't want to break focus, whisper it to a daydream. A sub-agent runs 3-5 hops against the memory pool and drops the result into dream-sparks.md. You check it later.

This mirrors the concept of a waking subconscious — analogous to the DMN processing in parallel while the ECN does its job.

## Usage

`/daydream <whisper>`

The whisper is a fragment — a connection you noticed, a half-formed "this reminds me of," a URL that pinged something. Keep it short. The daydream does the rest.

Examples:
- `/daydream "this retry pattern looks like the stigmergy thing"`
- `/daydream "customer churn data + the scaling bottleneck — something connects"`
- `/daydream https://some-article.com "feels related to orchestration patterns"`

## Configuring Your Tools

The default allowed-tools (Bash, Read, Write, Edit, WebSearch, Grep, Glob) support local daydreaming out of the box. To enable organizational signal queries in the sub-agent, add your MCP tool names to the `allowed-tools` line in the frontmatter above.

Examples:
- **Issue tracker** (Linear, Jira, GitHub Issues): enables "is the org already working on this?" queries
- **Team chat** (Slack, Teams, Discord): enables "is the team already talking about this?" queries

The skill degrades gracefully — without MCP tools, organizational signal queries are unavailable, but the core daydream protocol still works with memory + web search.

## How It Works

### Step 1: Acknowledge and background

Respond with one line: `Daydreaming on: "<whisper>"` — then launch a background sub-agent. The user's current session continues undisturbed.

### Step 2: Background sub-agent — the micro-spark

The sub-agent runs autonomously:

1. **Context sweep** (lightweight — speed over depth):
   - Read MEMORY.md — scan for resonance with the whisper
   - Read `<KNOWLEDGE_DIR>/fomo/links.md` — any FOMO link that connects
   - Read `<MEMORY_DIR>/dream-sparks.md` if it exists
   - Grep memory files for keywords from the whisper

2. **Organizational context** (if available):
   - Read the latest signal snapshot from `<KNOWLEDGE_DIR>/signals/` (most recent `.md` file). If the snapshot is less than 24 hours old, scan it for resonance with the whisper. If stale or missing, skip — no extra queries.
   - Query your issue tracker for the whisper keywords — is the org already working on this?
   - Search your team chat for the whisper terms — is the team already talking about this?

3. **3-5 associative hops** (with anti-convergence enforcement):
   - Start from the whisper
   - Each hop pulls from context, web search, memory, **or organizational signals**
   - Follow the chain wherever it leads
   - Stop after 3-5 hops (don't over-extend — this is a micro-spark, not a full session)

   **Mechanical rules (not optional):**
   - IF a hop restates the whisper in different words → that hop doesn't count. Make a DIFFERENT connection.
   - IF two consecutive hops are in the same domain → the next hop MUST cross domains.
   - IF you're about to write "this relates to" or "this is similar to" → replace with a SPECIFIC structural claim: "X uses the same failure mode as Y" or "X inverts Y's assumption about Z."
   - Each hop MUST name a specific file, concept, or entity from context — no abstract references.

4. **Self-rate the chain:**
   - `resonant` — at least one hop produced a non-obvious connection worth surfacing
   - `faint` — some movement but nothing surprising
   - `noise` — hops didn't connect to anything real

5. **Write output to dream-sparks.md:**
   Append to `<MEMORY_DIR>/dream-sparks.md` (create if it doesn't exist):

   ```markdown
   ### [daydream] <short title> (YYYY-MM-DD HH:MM)
   **Whisper:** "<original whisper>"
   **Chain:** <hop 1> → <hop 2> → <hop 3> [→ <hop 4> → <hop 5>]
   **Signal:** <resonant|faint|noise>
   **Connection:** <1-2 sentence summary of what emerged, or "No clear connection">
   ```

   If any hop references external organizational data (signal snapshot, issue tracker query, team chat query), add `[ext-signal]` to the title: `### [daydream] [ext-signal] <title>`.

   If self-rated `noise`, still write it but prefix the title with `[noise]`. Noise today might resonate with something tomorrow.

6. **Daylog entry:**
   Append: `**HH:MM | daydream** — "<whisper>": <1-line result>. Signal: <rating>.`

### Step 3: Notify when done

When the sub-agent completes, the user sees a brief notification:
- If `resonant`: `Daydream landed: "<short title>" — check dream-sparks.md`
- If `faint`: `Daydream: faint signal on "<whisper>" — logged to dream-sparks.md`
- If `noise`: `Daydream: noise on "<whisper>" — logged anyway`

One line. Don't interrupt the user's flow.

## Sub-Agent Prompt

When launching the background agent, use this prompt scaffold:

```
You are a daydream — a background micro-spark running while the user works on something else.

Your whisper: "<whisper>"

Instructions:
1. Read MEMORY.md, fomo/links.md, and dream-sparks.md (if it exists) for context
2. Read the latest signal snapshot from <KNOWLEDGE_DIR>/signals/ (skip if stale >24h or missing)
3. Grep memory files for keywords from the whisper
4. Query your issue tracker and team chat for the whisper's key terms — is the org already working on or talking about this?
5. Starting from the whisper, make 3-5 associative hops. Each hop should pull from what you found in context, organizational signals, or from a web search. Follow the chain — don't converge, don't judge.
6. Self-rate: resonant (non-obvious connection found), faint (some movement), noise (nothing real)
7. Append your finding to dream-sparks.md in the daydream format. Tag [ext-signal] if any hop used organizational data.
8. Append a daylog entry

Be fast. Be loose. This is the waking subconscious, not a research report.
```

## Swarm Mode (experimental)

When a whisper has multiple possible directions, launch 3-5 sub-agents in parallel — each taking a different starting angle:

- Agent 1: greps memory for the whisper keywords
- Agent 2: web searches the whisper topic
- Agent 3: reads FOMO links for resonance
- Agent 4: queries your issue tracker for the whisper keywords (issues, comments, documentation)
- Agent 5: searches your team chat for the whisper keywords (threads, conversations)

Each runs independently, writes its own daydream entry. Most will be noise. The one that isn't is the connection your focused session would never have found.

Swarm mode is triggered by adding `--swarm` to the command:
`/daydream --swarm "this retry pattern looks like the stigmergy thing"`

## What This Skill Does NOT Do
- Interrupt the user's current session (background only)
- Run full spark sessions (3-5 hops max, not unlimited chain reactions)
- Replace /spark (daydreams are micro-sparks, not sessions)
- Converge or produce action items (just surfaces connections)
- Require user interaction (fully autonomous after the whisper)

## Design Note: Three-Tier Cognitive Architecture

With `/daydream`, the spark protocol now has three tiers matching the neuroscience:

| Tier | Brain | Protocol | When |
|------|-------|----------|------|
| **Focus** | ECN-dominant | ops/review/dev intents | Structured work, convergent |
| **Ideate** | Controlled DMN | `/spark` sessions | Dedicated divergent thinking |
| **Daydream** | Ambient DMN | `/daydream` micro-sparks | Background, triggered, autonomous |

Focus is the default. Ideate is deliberate. Daydream is ambient. All three feed the same data lake. Dream consolidates all of them overnight.
