---
description: "Delve — process FOMO captures into resonance, patterns, and connections. The absorption layer."
context: fork
allowed-tools: Bash, Read, Write, Edit, WebSearch, WebFetch, Grep, Glob
---

Process FOMO captures into resonance, patterns, and connections. The absorption layer between `/fomo` (capture) and `/dream-spark` (cross-reference).

Mirror of `/daydream`: daydream goes outward (whisper from your head to connections in memory). Delve goes inward (captured link from the world to patterns brought into your context).

### Structural Position in the Cognitive Pipeline

```
/fomo (capture) --> /delve (absorb) --> /dream-spark (cross-reference) --> /spark (ideate)
```

FOMO is capture. Delve is absorption. Dream-spark is cross-referencing. Without delve, the gap between capture and cross-referencing is where knowledge rots.

## Usage

- `/delve` — process the oldest unprocessed FOMO entry (foreground, interactive)
- `/delve <url>` — delve into any URL directly (doesn't need to be in FOMO)
- `/delve --batch` — process 3-5 oldest unprocessed entries (background sub-agent)
- `/delve --scan` — quick triage pass over all unprocessed entries (foreground, no fetching)

## Configuring Your Signal Sources

The default allowed-tools (Bash, Read, Write, Edit, WebSearch, WebFetch, Grep, Glob) support delve processing out of the box. To enable organizational signal cross-referencing in Step 4, add your MCP tool names to the `allowed-tools` line in the frontmatter above.

Examples:
- **Issue tracker** (Linear, Jira, GitHub Issues): enables "is the org already working on this?" queries during cross-referencing
- **Team chat** (Slack, Teams, Discord): enables "is the team already talking about this?" queries during cross-referencing

The skill degrades gracefully — without MCP tools, organizational signal queries are skipped, but the core delve protocol (fetch, extract, cross-reference memory, verdict) still works with memory + web search.

## Content Type Detection

Auto-detected by URL pattern. If detection is wrong, the skill still works — slightly less optimal read strategy.

| Type | Detection | Processing |
|------|-----------|-----------|
| **Article** | Default (any URL not matching below) | Fetch full page via WebFetch. Extract core insight/pattern. |
| **Repo** | `github.com`, `gitlab.com` (not gist) | Fetch README + scan structure. Extract: what it does, architecture pattern, comparison to what we have. |
| **Video** | `youtube.com`, `youtu.be`, `vimeo.com` | Do NOT WebFetch (returns JS garbage). WebSearch for transcript/summary instead. Extract the idea, not the content. |
| **Tweet** | `x.com`, `twitter.com`, `threads.net` | Fetch post + thread. Value is the implication, not the text. |
| **Thought** | No URL (pure text entry) | Skip fetching. Go straight to cross-referencing. The resonance IS the entry. |

## Processing Workflow

For each entry, run these steps in order:

### Step 1: Detect type

Parse the entry from `<KNOWLEDGE_DIR>/fomo/links.md`. URL pattern match determines type (see table above). Entries without a URL starting with `http://` or `https://` are type `thought`.

### Step 2: Fetch content

Type-appropriate read:
- **Article:** `WebFetch` the URL. Extract the main content, strip navigation/ads.
- **Repo:** `WebFetch` the README. If the repo has a notable structure, scan the directory listing.
- **Tweet:** `WebFetch` the post URL. If it's a thread, get the full thread.
- **Thought:** Skip this step entirely. The entry text is the content.

If fetching fails (404, paywall, timeout), note it and proceed with whatever metadata exists (title, tags, description from the FOMO entry).

### Step 3: Extract core pattern

Not "what is this about" but "what's the extractable insight or trade-off."

**Mechanical rules:**
- Extract the TRADE-OFF or TENSION, not the conclusion. Write "They chose X over Y because Z" not "They recommend X."
- IF the pattern can be stated in one generic sentence ("AI agents need guardrails") → go deeper. What SPECIFIC guardrail, for what SPECIFIC failure mode, with what SPECIFIC trade-off?
- The core pattern MUST be transplantable — someone in a different domain should be able to apply the same structural insight. If it only makes sense in the original context, you extracted a fact, not a pattern.

### Step 4: Cross-reference

Search for connections to your existing context:
1. Grep `<MEMORY_DIR>/` for keywords from the extracted pattern
2. Read `<MEMORY_DIR>/dream-sparks.md` — does this connect to existing sparks?
3. Grep `<KNOWLEDGE_DIR>/ideas/` for related idea files
4. Grep `<KNOWLEDGE_DIR>/sparks/` for related spark session logs
5. Check recent daylogs in `<KNOWLEDGE_DIR>/daylog/` for related activity

If organizational signal tools are configured (see "Configuring Your Signal Sources"):
6. Query your issue tracker for keywords — is the org already working on this?
7. Search your team chat for keywords — is the team already talking about this?

### Step 5: Write resonance

Why did YOUR salience filter flag this, given YOUR context? This is the POI model: the classifier said "above threshold" but the specific reason is unexamined. Examine it now.

**Anti-convergence enforcement (not optional):**
- IF you're about to write "this article discusses" or "this repo provides" → STOP. That's a summary. Write WHY IT PULLED YOU instead: "This challenges my assumption about X" or "This is the pattern I've been circling around in Y."
- The resonance MUST be a question or an assertion, never a description. "Does this mean our trust scale needs a sixth level?" or "This inverts our approach to Z." Not "This presents an approach to Z."
- IF nothing surprises you → say so honestly. That IS the verdict: release. Don't manufacture resonance.
- Lead with what surprised you, not what you expected. If the first sentence could appear in a Google snippet, rewrite it.

### Step 6: Verdict

One of three:
- **absorb** — enriches your context. Route to relevant idea file or propose memory update.
- **park** — interesting, not urgent. Mark processed, might ignite later.
- **release** — nothing you're missing. FOMO resolved. The pull was noise.

The verdict is a decision, not a label. Be honest: if the resonance step produced nothing real, release it. FOMO is the fear of missing something important. If you didn't miss anything important, the fear is resolved.

**Anti-pattern: "already thought about it" ≠ "already have it" (MANDATORY CHECK)**

Before issuing a `release` verdict because "this concept already exists in memory":
1. Check whether the GAP the concept addresses has been IMPLEMENTED, not just identified.
2. If the gap is still open (no code, no tooling, no process change shipped), the reference is still load-bearing.
3. A concept in memory with zero implementation is an OPEN GAP with a KNOWN SOLUTION — that's a `park` or `absorb`, not a release.
4. Ask: "If someone started tomorrow and needed to close this gap, would they need this reference?" If yes, it's not releasable.

Identifying a problem is not solving it. Naming a pattern is not implementing it.

### Step 7: Write outputs

Two writes, always:

1. **Append `[delve]` entry to dream-sparks.md:**

   Append to `<MEMORY_DIR>/dream-sparks.md`:

   ```markdown
   ### [delve] <title> (YYYY-MM-DD HH:MM)
   **Source:** <url or "thought">
   **Type:** <article|repo|tweet|thought>
   **Resonance:** <why your salience filter flagged this -- 1-2 sentences>
   **Core pattern:** <the extractable insight -- 2-3 sentences>
   **Connects to:** <memory files, ideas, projects>
   **Verdict:** <absorb|park|release> -- <one-line reason>
   ```

2. **Mark entry in links.md as processed:**

   In `<KNOWLEDGE_DIR>/fomo/links.md`, find the entry and add the `[delved]` marker:

   Before:
   ```
   - 2026-04-07 09:30 | https://example.com — "Title" #tag
   ```

   After:
   ```
   - 2026-04-07 09:30 | [delved 2026-04-07] https://example.com — "Title" #tag
   ```

   **Note:** For entries that already start with a bracketed tag (e.g., `[claude-code-src]`), insert the `[delved]` marker BEFORE the existing tag. The `[delved]` marker is always the first token after the pipe.

3. **If verdict is `absorb`:** Also route to the relevant idea file in `<KNOWLEDGE_DIR>/ideas/` (append or create) or propose a memory update to `<MEMORY_DIR>/MEMORY.md`.

4. **Daylog entry:** Append to `<KNOWLEDGE_DIR>/daylog/YYYY-MM-DD.md`:
   ```
   **HH:MM | delve** -- "<title>": <verdict>. <1-line summary>.
   ```

## Execution Modes

### Single mode (default, foreground)

Interactive — present the resonance and connections, let the user react. The voice is the friend who read the thing you couldn't and comes back buzzing. Excitement, not summary. Show the work: what you found, what connects, why it matters to THIS person in THIS context.

If no argument is given (`/delve`), pick the oldest unprocessed entry from `<KNOWLEDGE_DIR>/fomo/links.md` (no `[delved]` marker).

If a URL is given (`/delve <url>`), process that URL directly — it doesn't need to exist in links.md. Still write the `[delve]` entry to dream-sparks.md. Skip the links.md marker step.

### Batch mode (`--batch`, background)

Launch a background sub-agent that processes 3-5 oldest unprocessed entries autonomously. Each entry gets the full 7-step workflow. Results appended to dream-sparks.md, markers added to links.md. Summary notification when done.

Sub-agent prompt:

```
You are a delve processor -- the absorption layer for FOMO captures.

Process the 3-5 oldest unprocessed entries in <KNOWLEDGE_DIR>/fomo/links.md
(entries without a [delved] marker).

For each entry:
1. Detect type (article/repo/tweet/thought) by URL pattern
2. Fetch content (WebFetch for URLs, skip for thoughts)
3. Extract the core pattern or insight (not summary -- the structural takeaway)
4. Cross-reference against memory files in <MEMORY_DIR>/
5. Write resonance (why did the salience filter flag this?)
6. Verdict: absorb (route to idea/memory), park (processed, might ignite), release (FOMO resolved)
7. Append [delve] entry to <MEMORY_DIR>/dream-sparks.md
8. Mark entry [delved YYYY-MM-DD] in links.md
9. If absorb: route to relevant idea file in <KNOWLEDGE_DIR>/ideas/

After all entries: print summary (processed count, verdicts, remaining unprocessed, oldest unprocessed date).
Append daylog entry to <KNOWLEDGE_DIR>/daylog/YYYY-MM-DD.md.
```

### Scan mode (`--scan`, foreground)

Does NOT fetch content. Lightweight triage pass over ALL unprocessed entries in links.md:

1. Read each unprocessed entry's title, description, and tags
2. Grep `<MEMORY_DIR>/` for keywords from each entry
3. Score each entry by keyword overlap with active projects, recent sparks, current context
4. Output: ranked list of entries by resonance strength — which ones have the highest connection density to your current world

The scan tells you WHAT to delve, not what it contains. Use it to pick the highest-signal entries for deep processing.

Output format:
```
FOMO Scan — <N> unprocessed entries

Strong resonance (delve these first):
  1. <entry> -- connects to: <memory/project> (<N> keyword hits)
  2. ...

Moderate resonance:
  3. <entry> -- connects to: <memory/project> (<N> keyword hits)
  ...

Weak/no resonance:
  N. <entry> -- no strong connections found
  ...

Oldest unprocessed: <date> (<N> days ago)
Suggestion: /delve <top-ranked-url>
```

## Decay and Health

### Staleness rules

- Unprocessed >14 days: flag in morning review output — "X FOMO links aging"
- Unprocessed >30 days: suggest `/delve --scan` to triage
- `park` verdicts >30 days: suggest `release` (if it hasn't resurfaced in a spark or daydream, it's not pulling)

### Health metric

Tracked in the summary output at the end of any delve run:

```
Delve complete.
Processed: <N>
Verdicts: <N> absorb, <N> park, <N> release
Unprocessed remaining: <N>
Oldest unprocessed: <date> (<N> days ago)
```

**Verdict distribution signals:**
- 80%+ release = salience filter is capturing noise. Tighten what you `/fomo`.
- 80%+ absorb = filter is excellent, or absorb threshold is too low. Check if absorbed items are actually producing downstream value.
- Balanced mix = healthy pipeline.

**Processing rate:** If unprocessed count is trending up across runs, intake is outpacing absorption. Either batch more aggressively or be more selective with `/fomo`.

## Trust Model

| State | Meaning | Downstream |
|-------|---------|------------|
| Raw FOMO link | Unexamined POI | Nothing — just captured |
| Delved with `release` | Examined, no action needed | FOMO resolved, link marked |
| Delved with `park` | Examined, might ignite later | Low priority, 30-day expiry |
| Delved with `absorb` | Examined, enriches context | Routed to idea/memory |
| Absorbed insight that ships | Produces real outcome | Track in survival log (SOT) |

## What This Skill Does NOT Do

- Replace `/fomo` (capture is capture, delve is processing)
- Replace `/dream-spark` (delve processes individual items, dream-spark cross-references the whole pool)
- Run automatically (requires manual trigger or batch scheduling)
- Modify memory files other than dream-sparks.md, links.md, daylog, and idea files
- Produce action items (produces resonance analysis and verdicts — routing happens via verdict)
