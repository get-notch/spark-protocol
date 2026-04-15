# Lessons from Claude Code Internals — What We Learned and What We Changed

*Practical architecture decisions for anyone building skills, agents, or cognitive workflows on Claude Code.*

When Anthropic's Claude Code source was exposed via an npm source map on March 31, 2026, we didn't just read it — we applied it. This document captures every decision we made based on what the internals revealed, why each matters, and how you can apply the same patterns.

Our goal: make your skills and workflows smarter, faster, and more resilient to the invisible maintenance systems running underneath them.

---

## 1. Use `context: fork` for Heavy Skills

**What we found:** When a skill has `context: fork` in its YAML frontmatter, Claude Code runs it as a fully isolated sub-agent with its own token budget, cloned file state, and independent permission context. Without it, the skill runs inline and shares the parent session's context window.

**Source:** `skills/loadSkillsDir.ts` (line 260), `forkedAgent.ts` (lines 191-399)

**Why it matters:** Skills that load large amounts of context — like a cross-referencing pass that reads 20+ files, or a customer health check that queries multiple APIs — eat into the parent session's token budget when they run inline. In a long session, this accelerates compaction (see below). Forking gives the skill its own budget and prevents it from degrading the parent conversation.

**What we changed:** Added `context: fork` to four heavy skills: `/spark` (divergent thinking sessions), `/dream-spark` (cross-referencing passes), `/daydream` (background micro-sparks), and `/customer-pulse` (multi-source health checks). One line per file. Immediate benefit.

**How to apply:**
```yaml
---
description: "Your heavy skill"
context: fork
allowed-tools: Bash, Read, Write, Edit, WebSearch, Grep, Glob
---
```

Add `context: fork` to any skill that:
- Reads more than 5 files during execution
- Runs web searches or MCP queries
- Takes more than 2-3 minutes to complete
- You want to run without degrading the parent session

**Trade-off:** Forked skills can't directly modify parent session state. If your skill needs to update the parent's working context, keep it inline. For read-heavy or analysis-heavy skills, forking is strictly better.

---

## 2. MEMORY.md Has a Hard Ceiling: 200 Lines and 25KB

**What we found:** Claude Code truncates MEMORY.md at two thresholds: 200 lines (line-first), then 25KB bytes (at the last newline before the byte cap). A warning marker is injected when truncation fires. Lines beyond 200 are invisible to the model.

**Source:** `memdir/memdir.ts` (truncation logic)

**Why it matters:** MEMORY.md is the "hot tier" — it's loaded into every single conversation. Everything in it shapes how Claude interprets your requests. But it's not unlimited. If your index exceeds 200 lines or 25KB, the bottom silently disappears.

**What we changed:** Compressed our MEMORY.md from 187 lines / 25,492 bytes (13 lines from the line cap, 108 bytes from the byte cap) to 142 lines / 17,619 bytes. Moved verbose behavioral rules and active checks to topic files. MEMORY.md is now an index of one-line pointers, not a knowledge store.

**How to apply:**
- Check your MEMORY.md: `wc -l` and `wc -c`
- If approaching limits, move detailed content to topic files
- Keep each MEMORY.md entry under ~150 characters
- Use MEMORY.md as a routing table: `- [Topic](file.md) — one-line hook`
- Put the most important entries at the TOP (bottom gets truncated first)

---

## 3. MicroCompact Silently Evicts Your File Reads

**What we found:** Claude Code has a three-tier context compression pipeline that runs automatically:

| Tier | Trigger | What it does |
|------|---------|-------------|
| **MicroCompact (cached)** | Tool result count exceeds threshold | Silently deletes oldest tool results from the server cache via API-side `cache_edits`. Your local messages look unchanged — the model just can't see them. |
| **MicroCompact (time-based)** | 60+ minutes idle | Replaces ALL but the last 5 tool results with `[Old tool result content cleared]`. The session's working context is gutted. |
| **Full Compact** | ~180K input tokens | Forked agent generates summaries. 50K token budget post-compact. Restores 5 most recent files (5K each) + recently invoked skills (25K total). |

**Which tools get compacted?** FileRead, Bash, Grep, Glob, WebSearch, WebFetch, FileEdit, FileWrite — exactly the tools that context-heavy skills use most.

**Source:** `services/compact/microCompact.ts`, `services/compact/apiMicrocompact.ts`, `services/compact/timeBasedMCConfig.ts`

**Why it matters:** In long sessions, the files you read at the START are the first to be evicted. A spark session that loads 15 memory files in Phase 1 (ignition) may find that context gone by Phase 2 (chain reaction). A dream-spark cycle that loads 30+ files will lose early reads as later reads accumulate. The model is working from a shrinking context window, and you won't see a warning.

**What we changed:** Added a "context anchor" pattern to our spark and dream-spark skills. After the initial context sweep, BEFORE entering the main work phase, the skill writes a TEXT SUMMARY of the key findings. Text messages (user/assistant) are NOT compactable — only tool results are. The summary survives all three compression tiers.

**How to apply:**

After your skill loads files, add a step that summarizes the key context:

```markdown
### Context anchor (compaction survival)

After loading all context, write a brief text summary of key themes,
entities, and patterns found. This text message survives compaction.
Keep it under 500-800 tokens. Include:
- Key themes across loaded files
- Important entities/names/identifiers
- Active threads or patterns
- Anything the main work phase will need to reference
```

This is especially important for:
- Skills that load many files upfront
- Sessions expected to run 30+ minutes
- Multi-phase workflows where Phase 2+ references Phase 1 discoveries

**The 60-minute cliff:** If you pause a session for an hour, expect to lose all but the 5 most recent tool results when you return. Consider ending the session and starting a new one instead of resuming.

---

## 4. Compaction Truncates Skills to 5,000 Tokens

**What we found:** When Full Compact fires (the emergency tier), it restores recently invoked skills — but truncates each to 5,000 tokens, with a total budget of 25,000 tokens across all restored skills.

**Source:** `services/compact/compact.ts` (lines 122-130: `POST_COMPACT_MAX_TOKENS_PER_SKILL = 5_000`, `POST_COMPACT_SKILLS_TOKEN_BUDGET = 25_000`)

**Why it matters:** If your skill file is 20KB (like some of ours were), only the first ~5,000 tokens survive compaction. Whatever is at the top of your skill file is what the model will see after a long session. Whatever is at the bottom is gone.

**What we changed:** Restructured four oversized skills to front-load critical instructions. Moved reference material, examples, and detailed guidance to sub-files. Results:

| Skill | Before | After | Reduction |
|-------|--------|-------|-----------|
| frontend-development | 736 lines | 294 lines | 60% |
| policy-components | 879 lines | 217 lines | 75% |
| planning-standards | 312 lines | 228 lines | 27% |
| review-standards | 268 lines | 172 lines | 36% |

**How to apply:**
- Check your skill file sizes: `wc -l ~/.claude/commands/*.md`
- Any skill over ~300 lines (roughly 5K tokens) should be reorganized
- Put the MOST CRITICAL instructions in the first 100 lines
- Move reference material, examples, and edge cases to separate files that the skill can `Read` when needed
- The model can always re-read a sub-file; it can't recover truncated inline content

---

## 5. Auto-Dream Consolidates But Does Not Cross-Reference

**What we found:** The auto-dream consolidation prompt runs four phases: Orient (scan memory directory), Gather (find new signal in logs/transcripts), Consolidate (merge, update dates, resolve contradictions), Prune (keep MEMORY.md under limits). Phase 2 explicitly says: "Don't exhaustively read transcripts. Look only for things you already suspect matter."

**Source:** `services/autoDream/consolidationPrompt.ts` (lines 10-65)

**Why it matters:** Auto-dream is a maintenance system, not a creative one. It merges, deduplicates, and prunes. It does NOT look for connections between unrelated memories. It does NOT test memory pairs for structural links. It does NOT inject novelty or external signal. If you're relying on auto-dream to surface insights, it won't.

**What we built:** A separate `/dream-spark` skill that does the cross-referencing auto-dream skips. It runs a multi-pass loop: Pass 1 finds pair-wise connections between memory files, Pass 2 deepens into three-way connections, Pass 3 injects external signal (web search, organizational data). This complements auto-dream — consolidation keeps memories clean, cross-referencing finds the connections between them.

**How to apply:** If you want cross-session insight generation, you need to build it yourself. Auto-dream won't do it. Options:
- Build a skill that reads your memory files and tests pairs for non-obvious connections
- Schedule it via `/loop` or remote triggers for regular execution
- Store results in a separate file (not MEMORY.md — that's auto-dream's territory)

---

## 6. The Memory Relevance Selector Picks 5 Files Per Turn

**What we found:** Claude Code doesn't load ALL memory files every turn. A Sonnet-powered side query scans up to 200 memory file frontmatter headers and returns the 5 most relevant files for the current turn. Only MEMORY.md (the index) is always loaded.

**Source:** `memdir/findRelevantMemories.ts`, referenced in multiple architecture analyses

**Why it matters:** Your memory file's frontmatter `name` and `description` fields are the ONLY thing the relevance selector sees. If your description is vague ("misc notes") or missing, the file may never be selected. If it's specific ("Review criteria for PR reviews in our monorepo"), it gets selected when the conversation touches code review.

**What we changed:** Ensured every memory file has a specific, descriptive frontmatter that tells the relevance selector WHEN to load it:

```yaml
---
name: Ibex Medical Trust Principles
description: First-hand trust-building principles from AI pathology — expert annotation, calibrated thresholds, POIs, asymmetric failure modes. Foundation for trust scale design.
type: user
---
```

**How to apply:**
- Review every file in your memory directory
- Ensure `description` is specific enough to match relevant conversations
- Think of it as an SEO title: when should this file be loaded?
- Test by starting conversations on different topics and checking which memories surface

---

## 7. 25+ Hook Events Exist Beyond PreToolUse

**What we found:** The hook system supports far more events than the commonly documented PreToolUse and PostToolUse:

| Event | Fires when | Potential use |
|-------|-----------|--------------|
| `FileChanged` | A watched file is modified | Auto-refresh context when config changes |
| `PreCompact` / `PostCompact` | Before/after context compression | Save/restore critical state |
| `SubagentStart` / `SubagentStop` | Sub-agent lifecycle | Track background task health |
| `TaskCreated` / `TaskCompleted` | Task lifecycle | Auto-log completed work |
| `UserPromptSubmit` | Before processing user message | Intent detection, context injection |
| `WorktreeCreate` / `WorktreeRemove` | Git worktree lifecycle | Track isolated development branches |
| `ConfigChange` | Settings modified | React to configuration updates |

**Source:** `types/hooks.ts`, `utils/hooks/hookEvents.ts`

**Exit code protocol:** 0 = continue (output shown to model), 2 = BLOCK (stderr sent to model as context). This means hooks can inject information into the model's reasoning by writing to stderr with exit code 2.

**What we're exploring:** FileChanged hooks to auto-reload context when memory files are updated by auto-dream. SubagentStart/Stop hooks to track dream-spark execution health.

**How to apply:** Check the hook events available in your version. The most immediately useful for most users:
- `FileChanged` on your CLAUDE.md or project config — auto-detect when configuration drifts
- `PostToolUse` with tool matcher on `git commit` — auto-log commits to a changelog
- `UserPromptSubmit` — inject session-specific context before every turn

---

## 8. Forked Sub-Agents Share Prompt Cache

**What we found:** When a skill or agent runs with `context: fork`, the forked sub-agent shares the parent's prompt cache. The fork creates a byte-identical API prefix (same system prompt, same tool definitions), so the cached prefix from the parent gets reused. Only the fork-specific directive at the end is new.

**Source:** `tools/AgentTool/AgentTool.tsx` (fork path, lines 321-335), prompt cache sharing via `useExactTools: true`

**Why it matters:** Forking doesn't double your API costs. The shared cache means the forked agent's first turn is nearly free (cache hit on the common prefix). This makes `context: fork` even more attractive for heavy skills — you get isolation WITHOUT paying for a full new prompt.

**How to apply:** Use `context: fork` without worrying about cost. The cache sharing makes forking cheap. The isolation makes it safe. The independent token budget makes it necessary for heavy skills.

---

## 9. Read-Only Agents Can Skip CLAUDE.md

**What we found:** Explore and Plan agents use `omitClaudeMd` to skip loading CLAUDE.md files. For Anthropic internally, this saves 5-15 GTok/week.

**Source:** Architecture analyses referencing coordinator mode configuration

**Why it matters:** If you're building read-only skills (analysis, search, exploration), your sub-agents don't need the full CLAUDE.md context. Skipping it reduces token usage and speeds up the sub-agent's startup.

**What we're exploring:** Whether dream-spark's context sweep sub-agents could benefit from this pattern. Currently investigating.

---

## The Meta-Pattern: Understand the Machine Underneath

Every decision above follows one principle: **the infrastructure you build on has invisible maintenance systems that affect your work.** MicroCompact evicts your file reads. Auto-dream reorganizes your memories. Compaction truncates your skills. The relevance selector filters your memory files.

You can fight these systems (and lose), or you can design with them:
- Write context anchors that survive compaction
- Front-load skill instructions for truncation resilience
- Write descriptive frontmatter for relevance selection
- Fork heavy skills for budget isolation
- Build cross-referencing yourself (auto-dream won't)

The source revealed these systems. The decisions above are how we adapted. Your setup is different — but the patterns apply everywhere.

---

*These findings are from the Claude Code source exposed via npm source map on March 31, 2026, as reported by [VentureBeat](https://venturebeat.com/technology/claude-codes-source-code-appears-to-have-leaked-heres-what-we-know), [Fortune](https://fortune.com/2026/03/31/anthropic-source-code-claude-code-data-leak-second-security-lapse-days-after-accidentally-revealing-mythos/), [Alex Kim](https://alex000kim.com/posts/2026-03-31-claude-code-source-leak/), [Sathwick](https://sathwick.xyz/blog/claude-code.html), [Redreamality](https://redreamality.com/blog/claude-code-source-leak-architecture-analysis/), and [others](https://github.com/nblintao/awesome-claude-code-postleak-insights). All references are to publicly documented findings.*
