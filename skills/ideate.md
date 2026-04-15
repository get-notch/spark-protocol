---
description: "Ideate — activate divergent thinking mode for the session. Loads fuel, sets guardrails, runs session primer, then maintains anti-convergence for all subsequent work."
context: fork
allowed-tools: Bash, Read, Write, Edit, WebSearch, Grep, Glob, AskUserQuestion
---

Activate divergent thinking mode. This reconfigures the current session for exploration — same data lake as focused work, opposite lens. Follow threads, make remote associations, embrace the chain reaction.

Unlike `/spark` (which runs a single ideation protocol), `/ideate` sets the MODE for an entire session. You might invoke `/spark`, `/daydream`, `/fomo`, or `/dream-spark` within an ideate session — all under the divergent guardrails.

## Usage

`/ideate` — activate divergent mode with automatic fuel loading
`/ideate <anchor>` — activate and immediately begin a spark session with the given anchor

## How It Works

### Step 1: Load fuel

Read everything that might spark a connection. Speed over completeness.

1. Read `<MEMORY_DIR>/dream-sparks.md` — overnight and recent cross-references
   - **Freshness check:** If `Last dream cycle:` is older than 48 hours, warn: "Dream sparks are stale — consider running `/dream-spark` first."
   - **Size check:** If the file exceeds ~1500 lines, read only the last 500 lines (most recent entries). The Grep in Step 1.5 reads the full file regardless of Read limits.
2. Read `<KNOWLEDGE_DIR>/fomo/links.md` — the FOMO backlog (unprocessed tabs, captured URLs)
3. Read today's daylog `<KNOWLEDGE_DIR>/daylog/YYYY-MM-DD.md` — what's already happened today
4. Scan `MEMORY.md` — any memory file that resonates with recent activity
5. Check `<KNOWLEDGE_DIR>/sparks/` for the most recent spark session log — cross-session snowball

If any of these don't exist, skip silently. The skill degrades gracefully.

### Step 1.5: Surface what's hot

After loading fuel, score each idea file by recent signal accumulation to find which ideas are ripe for a spark session.

**Signal tiers (weighted):**

| Tier | Signal | Weight |
|------|--------|--------|
| Highest | Handwritten note references idea's key terms (if configured) | 3x (physically written = highest cognitive commitment) |
| High | Dream-spark from last 7 days references idea | 2x (unconscious accumulation from overnight daemon) |
| Medium | Idea file modified in last 7 days (delve absorb) | 1x (deliberate enrichment) |

**Procedure:**

1. Glob all idea files in `<KNOWLEDGE_DIR>/ideas/*.md`
2. For each idea file: extract the title (first `# ` line) and 3-5 key terms from the title
3. Grep `<MEMORY_DIR>/dream-sparks.md` for those key terms — count matches from the last 7 days only (parse dates from `### [tag]` headers). **Two date formats exist:** `(YYYY-MM-DD HH:MM)` for dream/daydream entries and `(YYYY-MM-DD)` for delve/swarm entries. Some entries have trailing text after the date. Extract the date portion only. Accept both formats.
4. If you have a handwritten notes directory (e.g., a pen-to-digital pipeline), grep it recursively for key terms. Any match is a 3x signal — physically written = highest cognitive commitment. Skip if not configured.
5. Check if the idea file was modified in the last 7 days (via `stat` or file metadata)
6. Score each idea: `(handwritten_matches x 3) + (dream_spark_matches x 2) + (recent_modification x 1)`
7. Sort by score descending
8. Top 3 with score > 0 → generate provocative questions (see below)
9. Score 0 + no modification in 14+ days → classify as dormant

**Provocative question generation (for top 3 hot ideas):**

For each hot idea:
1. Read the idea file (first 30 lines)
2. Read the matching dream-spark entries
3. Generate ONE question that connects the idea to its fresh fuel

**Anti-convergence enforcement:**
- IF the question starts with "How does" or "What is" → rewrite as "What breaks if..." or "What happens when..."
- The question must be specific to the NEW connection, not the idea in general
- The question must work as a `/spark` anchor

### Step 2: Session primer

Output the fuel summary:

```
## Session: Ideate

Divergent mode active. Anti-convergence guardrails ON.

**Fuel loaded:**
- Dream sparks: <N connections, last cycle YYYY-MM-DD> or "stale/missing"
- FOMO: <N unprocessed links> or "empty"
- Daylog: <N entries today> or "clean slate"
- Last spark: <date + anchor> or "none recent"
```

Then present hot ideas via `AskUserQuestion`:

If any ideas scored > 0 in Step 1.5, present:

```
AskUserQuestion:
  question: "What's pulling you?"
  header: "What's Hot"
  options:
    1. label: "<provocative question 1>", description: "<signal summary: N dream-sparks + handwritten note>"
    2. label: "<provocative question 2>", description: "<signal summary>"
    3. label: "<provocative question 3>", description: "<signal summary>"
    4. label: "Something else", description: "Throw your own anchor"
    5. label: "Just explore", description: "No anchor — see what connects"
  multiSelect: false
```

If fewer than 3 ideas scored > 0, present only the hot ideas that exist (1 or 2) followed by options 4 and 5. Do not pad with additional ideas. If no ideas scored > 0, present options 4 and 5 only.

After the AskUserQuestion, list dormant ideas if any:
```
Dormant (no signals in 14+ days): <idea name>, <idea name>, ...
```

**On selection:**
- Options 1-3: immediately invoke `/spark` with the selected question as the anchor
- Option 4: ask for free text anchor, then invoke `/spark`
- Option 5: stay in open ideate mode, print "Ready. What's surfacing?"

If `/ideate <anchor>` was called with an argument: show the heat section as context but go straight into `/spark` with the given anchor after the primer.

### Step 3: Maintain guardrails for the session

For the remainder of the session, enforce these rules. They are HARD — override default assistant behavior.

**Anti-convergence rules:**
- **Don't converge early.** No summarizing, no "so to summarize," no "the key takeaway is," no action items until explicitly asked. If you catch yourself converging, make one more hop instead.
- **Follow tangents.** If something reminds you of something — say it. Don't filter for relevance. Relevance is discovered retroactively, not predicted.
- **Ping-pong is the protocol.** User throws a fragment, you add a hop. You throw a connection, user steers. Neither side leads — both riff.
- **Trace the chain.** Maintain a running association chain in the background so the path can be walked back at any time.
- **Exploration IS the highest-leverage thing.** No "is this the most important use of time?" checks. No productivity guilt. That's for focused mode.
- **Output routing at the end, not during.** Don't stop to categorize mid-flow. Don't ask "should I save this?" during active sparking. Capture everything, sort at session close.
- **No code.** If a spark leads to "we should build this," capture it as an idea. Don't context-switch to implementation. That's a separate session.

**Chain sustaining mechanics (apply automatically):**
- **Fuel injection:** When hops get semantically closer together (chain spiraling inward), inject new raw material — pull a random FOMO link, grep a memory file for a keyword from the chain, web search a tangential concept from 3 hops ago.
- **Anti-convergence ratchet:** If about to summarize → make one more hop first. If last 3 hops are in the same domain → force a cross-domain jump. If asking a clarifying question → replace with an assertion.
- **Cross-session snowball:** Reference dream-sparks.md and prior spark session logs throughout. Each session enriches the next.

**Session close triggers:**
When the user says "let's land this," "cool down," "wrap up," or "done" — or when energy drops for 5+ exchanges:

1. Trace back the chain if one was active
2. Collect a session rating (fire/warm/smoke/cold) if a spark ran
3. Route outputs: daylog entries, idea files, memory updates — propose, don't auto-save
4. Save session log to `<KNOWLEDGE_DIR>/sparks/YYYY-MM-DD-<slug>.md`
5. Append daylog entry with spark category

### Step 4: Skill interactions

Within an ideate session, other spark-protocol skills behave as normal but under the ideate umbrella:

| Skill | Behavior in ideate mode |
|-------|------------------------|
| `/spark <anchor>` | Full spark session with anti-convergence mechanics |
| `/daydream <whisper>` | Background micro-spark, runs as sub-agent |
| `/dream-spark` | Full cross-referencing pass across knowledge base |
| `/fomo <content>` | Quick capture to FOMO intake |

All outputs accumulate. Routing happens at session close.

## Configuring Your Environment

The skill works out of the box with local files. To enhance it:

- **Add MCP tools** to `allowed-tools` in frontmatter for organizational signal queries (issue tracker, team chat, meeting notes)
- **Set up a FOMO file** at `<KNOWLEDGE_DIR>/fomo/links.md` for URL/thought capture
- **Set up a daylog** at `<KNOWLEDGE_DIR>/daylog/YYYY-MM-DD.md` for cross-session context
- **Run `/dream-spark`** before an ideate session to pre-load fresh cross-references

The skill degrades gracefully — without any of these, the core divergent protocol still works with just web search and conversation.

## What This Skill Does NOT Do
- Replace `/spark` (ideate sets the MODE; spark runs the PROTOCOL)
- Write code or switch to implementation
- Converge prematurely or produce action items mid-session
- Auto-save anything without user consent
- Judge ideas for practicality (that's for focused mode)

## Design Note: Intent vs. Skill

Traditional skills DO something and return. `/ideate` CONFIGURES the session and persists. It's the closest thing to an "intent" or "mode" in a skill-based system. Once activated, it shapes how all subsequent interactions behave until the session ends or the user explicitly switches modes.
