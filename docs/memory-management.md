# Memory Management — How the Spark Protocol Handles Growing Knowledge

## The Problem Nobody Warns You About

Every AI memory system has the same failure mode: it grows until it breaks.

Claude Code's auto-dream consolidates memory files — it merges, prunes, and resolves contradictions. That works beautifully for structured memory (MEMORY.md, topic files). But the spark protocol produces a different kind of artifact: **dream-sparks.md**, an append-only log of every cross-referencing connection, every daydream hop, every delve absorption, every swarm burst. This file grows from multiple directions simultaneously and shrinks from zero directions.

After 13 days of active use, my dream-sparks.md hit 1,214 lines, 413KB, and 167 entries. It broke Claude Code's Read tool limit (~256KB). The overnight daemon — the prosthetic REM cycle that cross-references memories while I sleep — could no longer load the file it was supposed to cross-reference.

The creative system had outgrown its own infrastructure.

## Why Standard Memory Management Doesn't Work Here

Claude Code's built-in memory management is designed for **structured knowledge** — facts about you, your project, your preferences. It has a clear lifecycle: information enters, gets validated, sometimes gets superseded, eventually gets pruned if it's stale.

Dream-sparks are different. They're **associative artifacts** — records of connections between ideas, not the ideas themselves. A dream-spark that says "the estimation cone and the incident confidence ladder share the same epistemological structure" isn't a fact to be updated. It's a connection that was made at a specific moment, from specific sources, with a specific chain of reasoning. It's provenance, not content.

This means:
- **You can't merge them.** Two sparks about related topics aren't duplicates — they're different connections found at different times from different angles.
- **You can't summarize them.** The value is in the specific chain (hop 1 → hop 2 → hop 3), not in a summary. Compressing "A connects to B because of C, which reminds me of D" into "A relates to B" destroys the provenance that makes the connection traceable and re-igniteable.
- **You can't prune by relevance.** A spark from two weeks ago that seems dormant might be the exact fuel a spark session needs tomorrow. Relevance is discovered retroactively, not predicted.

But you also can't keep everything in the active context forever. The file grows. The tools have limits. Something has to give.

## The Insight: Selective Loading, Not Selective Deletion

The breakthrough came from studying [MemPalace](https://github.com/milla-jovovich/mempalace), an open-source AI memory system that achieves the highest scores on the LongMemEval benchmark. MemPalace's core architectural insight: **raw data persists forever; overflow is managed by WHAT you load, not by WHAT you keep.**

MemPalace organizes memory into a spatial hierarchy (wings → rooms → halls) with two storage tiers:
- **Closets** — summaries that load fast (~1:10 compression)
- **Drawers** — raw verbatim content, never summarized, never deleted

The closets tell you what exists. The drawers preserve the full content. You load the closets. You search the drawers when you need depth.

They also discovered something counterintuitive: **at moderate scales, lossy compression hurts more than it helps.** Their AAAK compression layer (a lossy abbreviation scheme) regresses retrieval accuracy from 96.6% to 84.2%. Raw beats compressed until you hit truly massive scale.

This mapped directly to our problem. Dream-sparks.md doesn't need compression — it needs a **split**. Recent, active sparks load every cycle. Older, resolved sparks move to cold storage. Both files preserve raw content. The difference is which one enters the context window.

## The Two-Tier Architecture

```
dream-sparks.md (active — hot tier)
├─ Target: <500 lines, <200KB
├─ Contains: recent entries, alive entries, absorb verdicts
├─ Loaded by: /spark, /dream-spark, /daydream, /delve
└─ The creative fuel that enters every session

dream-sparks-archive.md (cold tier)
├─ No size limit
├─ Contains: archived entries, full verbatim content
├─ Searchable via Grep — never loaded wholesale
└─ The provenance record that preserves every connection
```

Both files live in the same memory directory. The active file keeps its original path, so every consumer skill works unchanged — no code changes needed. The archive is a new file that skills never reference directly. Grep can search it when a specific connection needs its provenance traced.

## How Entries Move Between Tiers

### What Gets Archived (Verdict-Based)

The archival rules are based on **examined verdicts**, not age alone. An entry moves to cold storage when its value has been explicitly assessed:

**Released delve entries** — these were captured by `/fomo`, processed by `/delve`, and explicitly dismissed with a `release` verdict. The FOMO is resolved. The resonance was examined and found to be noise. The entry's contribution to the knowledge base is complete.

**Expired ext-signal entries** — these are organizational signal connections (from Linear, Slack, Fathom) that weren't consumed by a spark session within 7 days. External signals decay faster than memory-based connections because organizational state changes quickly. An issue that was blocked last week may be resolved today.

**Old swarm entries** — these are bulk-produced during swarm runs (parallel sub-agents exploring the entire memory pool). A single swarm can produce 40+ entries in one burst. Most of the value is extracted within the first week — later sparks that build on swarm findings reference the INSIGHT, not the original swarm entry. After 14 days, the swarm entries are fuel that's already been burned.

**Stale park verdicts** — delve entries marked `park` (interesting but not urgent) that haven't resurfaced in 30 days. If the content hasn't re-entered the conversation in a month, it's cold by definition.

### What Always Stays Active

**Recent entries (last 7 days)** — regardless of type or verdict. Fresh entries may still be consumed by upcoming spark sessions.

**Dream and daydream entries from the last 30 days** — these are the primary cross-referencing fuel. They represent connections the system found recently and that spark sessions should have access to.

**Absorb verdicts** — delve entries that were explicitly assessed as "enriches context." These are active knowledge, not resolved captures.

**Survival log "alive" entries** — any entry that the survival log marks as still being pursued, regardless of age. If an old spark is still producing downstream work, it stays active.

**Unknown entries** — any entry whose tag type doesn't match a known archival rule stays active by default. New tag types introduced in the future won't be accidentally archived.

### Why Verdict-Based Beats Age-Based

Age-based archival (move everything older than N days) is simpler but less precise. A 45-day-old spark that's still actively referenced in the survival log would be archived. A 3-day-old delve entry with a `release` verdict would stay active despite being explicitly dismissed.

Verdict-based archival respects the ASSESSMENT. An entry that was examined and found to be noise (release) moves to cold storage immediately. An entry that was never assessed (no verdict, no expiry) stays active indefinitely — because absence of assessment is not evidence of irrelevance.

## The Compaction Operation

Compaction is a mode on the `/dream-spark` skill, not a separate tool:

```
/dream-spark --compact
```

It runs as a maintenance operation — no cross-referencing happens during compaction. The overnight daemon runs compact before its cross-referencing pass, ensuring the active file is always within the Read tool's limits when the real work begins.

### Safety: Write-Then-Verify

The compaction follows a strict safety protocol: **write the archive first, verify it, then rewrite the active file.** If the archive write fails or verification doesn't match, the active file is left untouched. This prevents the catastrophic failure mode of losing entries during a failed migration.

The archive is append-only — each compaction batch gets a header with the date and entry count. Previous batches are never modified. The archive grows monotonically, preserving a complete historical record of every connection the system has ever made.

### Skip Condition

If the active file is already under 500 lines, compaction is a no-op. This prevents unnecessary churn on files that don't need it.

## Integration with the Overnight Daemon

The overnight dream-spark daemon (a launchd agent on macOS, or any cron equivalent) runs at midnight:

```
1. /dream-spark --compact    (shrink the file below Read limits)
2. /dream-spark --quick      (cross-reference the now-loadable file)
```

Compact first, then cross-reference. The active file is always within limits when the creative work runs. The archive grows with each compaction cycle but is never loaded — it's a cold-storage provenance record.

This mirrors a biological pattern: the brain's NREM sleep phase consolidates and organizes memories (auto-dream consolidation), while the REM phase creates novel associations (dream-spark cross-referencing). Compaction is the housekeeping that happens before REM begins.

## What We Learned from MemPalace

Several MemPalace design decisions directly influenced this architecture:

**Raw beats compressed at moderate scale.** MemPalace's AAAK compression layer regresses retrieval accuracy by 12 percentage points at moderate scale. We don't compress or summarize entries — they move between tiers verbatim. At our scale (hundreds of entries, not millions), the overhead of lossy compression exceeds its value.

**Tiered loading is the key mechanism.** MemPalace loads identity (L0, ~50 tokens) and critical facts (L1, ~120 tokens) every turn, but defers room-level recall (L2) and deep search (L3) to on-demand access. Our two-tier split follows the same principle: the active file loads every cycle, the archive is grep-on-demand.

**Never delete, selective load.** MemPalace stores all raw conversations in ChromaDB drawers — never summarized, never deleted. The closets (summaries) control what enters context, not what exists in storage. We follow the same principle: the archive preserves everything, the active file controls what enters the creative process.

**Metadata-driven retrieval.** MemPalace's spatial hierarchy (wings/rooms/halls) improves retrieval by 34% through metadata filtering before semantic search. Our tag-based system (`[dream]`, `[delve]`, `[swarm-*]`, `[ext-signal]`) serves the same role — the tag tells you what KIND of connection it is before you read the content.

## Metrics

After the first compaction run on a 1,214-line, 413KB file:

| Metric | Before | After |
|--------|--------|-------|
| Active file lines | 1,214 | ~500 |
| Active file size | 413KB | ~170KB |
| Entries archived | ~85 | — |
| Entries kept | ~82 | — |
| Archive file created | — | Yes |
| Read tool: can load? | No (>256KB) | Yes |
| Overnight daemon: works? | No | Yes |

The 85 archived entries were primarily released delve verdicts (37) and old swarm entries (40+). The remaining 82 active entries represent the last 30 days of connections — comfortably under the 500-line target with room for weeks of growth before the next compaction cycle.

## Design Principles

**Append-only growth is natural for creative systems.** Don't fight it. Manage it with tiers, not with deletion.

**Verdicts are better signals than timestamps.** An examined-and-dismissed entry is safer to archive than an old-but-unexamined one.

**Safety margins matter.** The 500-line target is well below the ~800-line / 256KB hard limit. This gives several weeks of growth between compaction cycles, even at high creative output rates.

**Cold storage is still searchable.** Archiving doesn't mean forgetting. Grep works on both files. When a spark session needs provenance from an old connection, it's one search away.

**The overnight daemon is the right trigger.** Compaction runs before cross-referencing, ensuring the creative process always has a loadable file. Manual compaction (`/dream-spark --compact`) is available for edge cases but shouldn't be needed in normal operation.

## Limitations and Future Directions

**The archive will also grow indefinitely.** At current rates (~5 entries/day archived), the archive will reach 1,000+ entries in a few months. This is fine for Grep-based access but may eventually need its own tiering (quarterly archives, yearly archives). That's a future problem — the current architecture handles months of growth without intervention.

**Verdict-based archival requires verdicts.** Dream and daydream entries don't have explicit verdicts — they age out based on the 30-day window. If the system produces many dream entries that are referenced months later, the 30-day window may be too aggressive. The survival log provides a safety net (alive entries always stay), but monitoring the archive for "entries that were archived but later re-discovered" would validate the window choice.

**No semantic deduplication.** If two sparks make structurally similar connections from different angles, both are kept. This is intentional — different angles on the same connection are different insights. But it means the active file may contain near-duplicates that a more sophisticated system could merge. MemPalace's vector search could theoretically identify these, but the engineering overhead isn't justified at current scale.

**Single-file archive.** The archive is one file, not sharded by date or topic. For the foreseeable future this is fine (Grep handles large files efficiently). If the archive reaches 10,000+ entries, sharding by quarter (e.g., `dream-sparks-archive-2026-Q2.md`) would improve searchability.
