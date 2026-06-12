---
description: "Dream Spark — unfocused cross-referencing pass across the full memory pool. The organizational subconscious."
effort: max
context: fork
allowed-tools: Bash, Read, Write, Edit, WebSearch, Grep, Glob
---

Run an unfocused cross-referencing pass across the full knowledge base. No anchor, no whisper — just "what connects that nobody's watching?"

Auto-dream consolidates memory but does NOT cross-reference — it tidies, it doesn't create. I tested this with a canary and confirmed it from the source code. This skill fills that gap.

## Usage

`/dream-spark` — run a full cross-referencing pass now
`/dream-spark --quick` — lightweight pass (memory files only, 1 iteration)
`/dream-spark --deep` — deep pass (memory + knowledge base + FOMO + web, 3-5 iterations)
`/dream-spark --compact` — run compaction only (no cross-referencing)

Default is `--deep`.

## Compact Mode (`--compact`)

Compaction archives old entries from `dream-sparks.md` to `dream-sparks-archive.md`, keeping the active file under the Read tool's size limit. No cross-referencing runs during compact — it's a maintenance operation only.

**When to run:** Automatically before `--quick` in the overnight daemon. Can also be run manually when the file grows too large.

**Skip condition:** If `dream-sparks.md` is already under 500 lines, skip archival entirely and report "already compact."

### Compact Procedure

1. **Read** `<MEMORY_DIR>/dream-sparks.md` in chunks (use offset/limit to handle files over the Read tool limit — read 200 lines at a time).

2. **Read** the survival log at `<KNOWLEDGE_DIR>/sparks/survival-log.md` to check which entries are marked "alive." If no survival log exists, skip this check — no entries are protected by survival status.

3. **Parse** each `### [tag]` entry. Extract:
   - Tag type: `[dream]`, `[daydream]`, `[delve]`, `[swarm-*]`, `[expired]`, `[ext-signal]`, `[research]`, or any other tag
   - Date: from `(YYYY-MM-DD HH:MM)` or `(YYYY-MM-DD)` in the title. Both formats are valid. If no date can be extracted, treat the entry as 0 days old (keep by default — never archive an entry whose age is unknown).
   - Verdict: from `**Verdict:**` line if present (for `[delve]` entries)
   - Title: for survival log cross-reference (use substring/contains matching, case-insensitive — survival log titles are often abbreviated versions of dream-sparks.md titles)

4. **Calculate age** in full calendar days between the entry date and today (UTC). "Older than 14 days" means strictly more than 14 calendar days (day 15+). For date-only entries, use start of the entry's date (00:00 UTC) for age calculation.

5. **Classify** each entry as KEEP or ARCHIVE:

   **ARCHIVE (move to cold tier):**
   - `[delve]` entries with `Verdict: release` — examined, dismissed, FOMO resolved
   - Entries tagged `[expired]` — ext-signal sparks not consumed within 7 days
   - `[swarm-*]` entries older than 14 days (strictly: day 15+) — bulk-produced, most dormant
   - `[delve]` entries with `Verdict: park` older than 30 days (strictly: day 31+) — hasn't resurfaced

   **KEEP (stays in active file, always):**
   - Frontmatter + header (first ~10 lines, including `Last dream cycle:` timestamp)
   - All `[dream]` entries from the last 30 days
   - All `[daydream]` entries from the last 30 days
   - All `[delve]` entries with `Verdict: absorb`
   - All entries explicitly marked "alive" in the survival log, regardless of age (matched by substring, case-insensitive). If ambiguous, prefer KEEP.
   - Any entry from the last 7 days, regardless of type or verdict

   **DEFAULT RULE:** Any entry whose tag type does not match an ARCHIVE rule and does not match an explicit KEEP rule: **KEEP by default.** Never archive an unrecognized tag type (e.g., `[research]`, future tags).

6. **Write ARCHIVE entries** to `<MEMORY_DIR>/dream-sparks-archive.md`:
   - If the archive file doesn't exist, create it with header: `# Dream Sparks Archive`
   - Prepend batch header: `## Archived YYYY-MM-DD — <N> entries (date range: YYYY-MM-DD to YYYY-MM-DD)`
   - Append entries verbatim below the batch header. No summarization.
   - New batches append below previous batches. Archive is append-only.
   - **VERIFY:** After writing, read back the archive file and confirm the batch header and entry count match the expected ARCHIVE list. If verification fails, ABORT compaction — do NOT proceed to Step 7. Log the failure to daylog.

7. **Rewrite** `dream-sparks.md` with KEEP entries only — **ONLY after Step 6 is verified:**
   - Preserve frontmatter + header at the top
   - Maintain chronological order of kept entries
   - Do NOT modify entry content — verbatim preservation
   - If Step 6 failed or was not verified, leave dream-sparks.md unchanged.

8. **Log** to daylog:
   ```
   **HH:MM | compact** — dream-sparks compacted: <N> archived, <N> kept. File: <lines> lines, <KB>KB.
   ```

### Death Evaluation (during compact)

After archival, evaluate remaining entries older than 30 days:

1. **Consumed?** Has this spark been referenced in a plan, decision, daylog entry, or shipped feature? If yes: keep with `[consumed: YYYY-MM-DD]` annotation.
2. **Signal strength?** `resonant` entries get more patience (45 days). `faint` entries die at 30 days unless consumed.
3. **Still relevant?** Would a fresh reader find this actionable? If the context has changed (person left, project cancelled, decision already made), mark as dead.
4. **Death format:** Move to archive with `[DEAD: reason]` annotation. Example: `[DEAD: project cancelled]`, `[DEAD: decision already made]`.

**Never delete sparks.** Dead sparks go to the archive, not to /dev/null. The archive is the graveyard, not the trash.

### What Compact Does NOT Do

- Summarize or compress entries (verbatim only)
- Delete anything (archive preserves everything)
- Archive entries without parseable dates (these stay in the active file)
- Archive entries with unrecognized tag types (these stay in the active file)
- Run cross-referencing passes (that's `--quick` / `--deep`)
- Touch any file other than dream-sparks.md and dream-sparks-archive.md (plus daylog)

---

## Configuring Your Signal Sources

Step 0 queries your organizational tools to build a signal snapshot. Replace the tool names in the allowed-tools frontmatter and the query descriptions below with your own MCP tools or CLI commands. The pattern works with any combination of:

- **Issue tracker:** Linear, Jira, GitHub Issues
- **Team chat:** Slack, Teams, Discord
- **Meeting notes:** Fathom, Otter, Fireflies (or any CLI/API that returns recent meeting summaries)
- **Project management:** Monday, Asana, Notion
- **Calendar:** Google Calendar, Outlook
- **Design tool:** Figma, Sketch

You don't need all of these. The signal sweep degrades gracefully — fewer sources means fewer signal clusters, but the cross-referencing passes (Steps 1-5) work purely on memory files and don't require any external tools.

## How It Works

### Step 0: Signal Sweep (deep mode only)

**Skip this step in `--quick` mode.**

Query all external sources for deltas — what changed, moved, escalated, or went quiet. Write the result to `<KNOWLEDGE_DIR>/signals/YYYY-MM-DD.md`.

**Delta window:** 48 hours by default. If the previous snapshot exists and is older than 48h (e.g., weekend gap), extend the window to cover since-last-snapshot. The snapshot header records both the current timestamp and the previous snapshot date so the window is always explicit.

**Query each source:**

1. **Issue tracker** — List issues that changed status recently. Look for: newly blocked items, status transitions, new comments on active issues, cycle progress changes.
   - Extract: issue ID, status transition, owner, last comment summary

2. **Team chat** — Search for signal keywords across channels.
   - Query for: "blocker OR urgent OR incident OR stuck OR escalat"
   - Look for high-activity threads (5+ replies)
   - Extract: channel, thread summary, reply count, participants

3. **Meeting notes** — Get recent meeting summaries and action items.
   - Use your meeting notes CLI or API to fetch recent meetings (last 2 days)
   - Extract: meeting title, date, key themes, unresolved action items, customer mentions

4. **Project management** — Check board items that changed status.
   - Extract: item name, status change, owner, board name

5. **Calendar** — List events from last 48h and next 48h.
   - Extract: event titles, attendees, recurring patterns, customer-related meetings

6. **Design tool** — Check recent design activity (optional — skip if no design-relevant sparks in recent memory).
   - Extract: file name, last modified, editor count

**Write the snapshot** to `<KNOWLEDGE_DIR>/signals/YYYY-MM-DD.md`:

```
# Organizational Signal Snapshot — YYYY-MM-DD HH:MM

## Deltas (since last snapshot: YYYY-MM-DD)

### Issue Tracker
- <issue>: <old status> → <new status> (owner: <name>) — "<last comment summary>"
...

### Team Chat
- #<channel>: <N>-reply thread on "<topic>" (hot)
...

### Meeting Notes
- Meeting "<title>" (<date>): action items [<N>], customer theme: <theme>
...

### Project Management
- <board>: "<item>" moved to <status>
...

### Calendar
- <N> meetings with <pattern> this week
...

## Signal Clusters
<!-- Same topic appearing in 2+ sources = convergent signal -->
- "<topic>" — <source1> + <source2> [+ <source3>]
...
```

**Signal Clusters** are auto-detected: scan all extracted deltas for overlapping topics, entities, or keywords. Same topic in 2+ sources = a cluster. These are priority fuel for Pass 1b.

### Step 1: Load the full context

Read everything. This is the expensive step — the unfocused scan.

**Always read:**
1. All memory files in `<MEMORY_DIR>/` (Glob + Read each)
2. `<KNOWLEDGE_DIR>/fomo/links.md` — the FOMO backlog
3. `<MEMORY_DIR>/dream-sparks.md` — prior sparks (don't repeat them)
4. Today's daylog `<KNOWLEDGE_DIR>/daylog/YYYY-MM-DD.md`

**Deep mode adds:**
5. Recent daylogs (past 3 days)
6. Recent spark session logs in `<KNOWLEDGE_DIR>/sparks/`
7. Recent idea files in `<KNOWLEDGE_DIR>/ideas/`
8. Your handwritten notes or external capture (if any exist)
9. Web search on 1-2 keywords extracted from the most recent FOMO links
10. Today's signal snapshot `<KNOWLEDGE_DIR>/signals/YYYY-MM-DD.md` (written by Step 0)

### Step 1.5: Context anchor (compaction survival)

**Critical for deep mode sessions.** MicroCompact silently evicts the oldest tool results (file reads) as token count grows. The memory files loaded in Step 1 are the first to be cleared — by mid-session, the cross-referencing passes may have lost access to the source material.

After loading, write a **context anchor** — a text summary of the key themes, entities, and patterns found across the loaded context. This is a regular text message (not a tool result) so it survives all compaction tiers:

```
Dream context anchor:
- Memory themes: <5-7 key themes across memory files>
- Active signal clusters: <list from signal snapshot, or "none">
- Prior spark titles to avoid repeating: <list top 10 recent dream-spark titles>
- FOMO patterns: <dominant category in recent FOMO captures>
- Daylog highlights: <key events from last 3 days>
```

Keep it under 800 tokens. This anchor ensures the cross-referencing passes can still reference the source material even after MicroCompact evicts the raw file reads.

### Step 2: Cross-referencing passes (the Karpathy loop)

Run iterative passes. Each pass feeds the next.

**Pass 1 — Broad scan:**
For every pair of memory files, ask: "is there a non-obvious structural connection between these?" Skip connections that are already explicit (same project, same topic). Only surface connections where the link is structural or thematic, not just co-occurrence.

**Pass 1b — Memory x Signal Clusters (deep mode only):**
Take each Signal Cluster from the snapshot (Step 0 output). For each cluster, test it against every memory file: "is there a non-obvious structural connection between this organizational signal and this memory?" A cluster about "onboarding delays" appearing in meeting notes + issue tracker + project management might connect to architecture memories, customer health tracking, or process improvement documentation. Signal clusters enter Pass 1b with priority because they are already convergent — the cross-referencing starts from a stronger base.

**Pass 2 — Deepen pass 1 findings:**
Take the connections from pass 1. For each one, ask: "what ELSE connects to both of these?" Pull in FOMO links, daylog entries, knowledge base docs. The second pass finds the three-way connections that pass 1 missed.

**Pass 3 — Cross-domain injection:**
Take the strongest connections from passes 1-2. Web search a keyword from each in a completely unrelated domain. Does the external result resonate with any existing memory? This is the artificial novelty injection — the fuel injection for the dream.

**Quick mode:** Only pass 1, memory files only.
**Deep mode:** All 3 passes (or up to 5 if pass 3 produces strong signal — keep iterating until diminishing returns).

**Anti-convergence enforcement (all passes):**
- IF a connection says "both mention X" → that's co-occurrence, NOT a structural connection. Discard it. Find HOW they relate structurally.
- IF a connection could be found by keyword search alone → it's not cross-referencing, it's search. Discard it. The connection must require BOTH sources to be in context simultaneously.
- IF you're about to write a connection that starts with "similarly" or "this also" → replace with a SPECIFIC structural claim: "X's failure mode is Y applied to a different domain" or "X inverts Y's assumption about Z."
- Every connection MUST name the specific structural pattern that links the sources — not just that they share a topic.

### Step 3: Self-rate each connection

For every connection found:
- `resonant` — non-obvious, structurally real, opens a door
- `faint` — some movement, might ignite later
- `noise` — surface-level or already known

**[ext-signal] tagging:** If a connection originates from or references data from the signal snapshot (Pass 1b) or any external MCP/CLI query, add `[ext-signal]` to its title tag. Example: `### [dream] [ext-signal] <title>`. This makes external-signal sparks visually distinct and filterable.

**Auto-expire rule:** During each dream-spark cycle, scan prior `[ext-signal]` entries in dream-sparks.md. Any that are older than 7 days AND have not been referenced by a spark session get marked `[expired]` — change the tag to `### [dream] [expired] [ext-signal] <title>`. Not deleted, just deprioritized. Organizational signals lose relevance faster than structural memory connections.

### Step 4: Write to dream-sparks.md

Append each connection to `<MEMORY_DIR>/dream-sparks.md`:

```markdown
### [dream] <short title> (YYYY-MM-DD HH:MM)
**Pass:** <1|2|3|...>
**Sources:** <memory/file1> x <memory/file2> [x <external>]
**Chain:** <how the connection was found — which pass, what led to what>
**Signal:** <resonant|faint|noise>
**Connection:** <1-2 sentence summary>
```

For connections involving external signals, use the `[ext-signal]` tag:

```markdown
### [dream] [ext-signal] <short title> (YYYY-MM-DD HH:MM)
**Pass:** 1b
**Sources:** signals/YYYY-MM-DD.md (cluster: "<topic>") x <memory/file>
**Chain:** <how the connection was found — which pass, what led to what>
**Signal:** <resonant|faint|noise>
**Connection:** <1-2 sentence summary>
```

Update the header timestamp:
```markdown
Last dream cycle: YYYY-MM-DD HH:MM
```

The `/spark` skill checks this timestamp for freshness (>48h = stale warning).

### Step 5: Summary + daylog

After all passes:

1. **Print summary to user:**
```
Dream cycle complete.
Passes: <N>
Connections found: <N> (resonant: <N>, faint: <N>, noise: <N>)
External-signal: <N> of <N>
Unconsumed [ext-signal] sparks from prior cycles: <N>
Health: consumption ratio <N>%
Top 3:
  - <title 1> (<signal>)
  - <title 2> (<signal>)
  - <title 3> (<signal>)
```

**Health metric:** consumption ratio = (ext-signal sparks consumed by spark sessions) / (total ext-signal sparks produced). If below 30%, append warning: "External signals outpacing consumption. Consider running a /spark session to process, or use --quick (memory-only) for the next cycle."

2. **Append daylog entry:**
```
**HH:MM | dream** — Cross-referencing pass: <N> connections (<N> resonant). Top: "<title>". Passes: <N>.
```

## Quality Guidelines

- **Non-obvious only.** If the connection is already explicit, skip it.
- **Structural, not superficial.** "Both mention pipeline" = noise. "Both describe multi-phase processes where handoffs fail" = resonant.
- **Don't repeat prior sparks.** Read dream-sparks.md first. If a connection already exists, skip it unless you have a meaningfully different angle.
- **2-5 connections per pass is ideal.** Don't force it. Zero is fine.
- **Preserve old connections.** Append only, never delete prior entries.

## Scheduling

This skill can be run:
- **Manually:** `/dream-spark` whenever you want fresh fuel for an ideate session
- **Via /loop:** `/loop 24h /dream-spark --quick` for daily lightweight passes
- **Before /spark:** Run `/dream-spark --quick` before an ideate session to pre-load fresh connections
- **Weekend deep dives:** `/dream-spark --deep` on a Friday afternoon, review Monday morning

Recommended cadence: one `--quick` pass daily, one `--deep` pass weekly.

## What This Skill Does NOT Do
- Replace auto-dream's consolidation (pruning, organizing, resolving contradictions)
- Modify any memory files other than dream-sparks.md, dream-sparks-archive.md (compact mode), and daylog
- Produce action items (just surfaces connections — routing happens in /spark or manually)
- Run automatically (requires manual trigger, /loop scheduling, or overnight daemon)

## Design Note: Why This Exists

Auto-dream consolidates memory but does NOT cross-reference. Testing has shown that embedded instructions in memory files are ignored by auto-dream. This skill fills the gap: manual/schedulable cross-referencing that produces the fuel /spark consumes.

The iterative pass design (Karpathy loop pattern) means each run can go deeper than a single scan. Pass 1 finds pairs. Pass 1b adds organizational signals. Pass 2 finds triads. Pass 3 adds external novelty. The result is richer than any single-pass scan could produce.
