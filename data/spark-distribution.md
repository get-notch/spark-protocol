# Spark Distribution Data

Anonymized quantitative summary from 5 days of active use (March 27 - April 1, 2026).
Single user (Yuval Raz). Early-stage data. See [EVIDENCE.md](../EVIDENCE.md) for caveats.

---

## Dream-Sparks (cross-referencing output)

**Total entries:** 92

| Source Type | Count | Resonant | Faint | Noise |
|-------------|-------|----------|-------|-------|
| [dream] (nightly cross-referencing) | 25 | 22 | 3 | 0 |
| [daydream] (triggered micro-sparks) | 15 | 13 | 2 | 0 |
| [swarm-fomo] (parallel FOMO link scan) | 17 | 12 | 5 | 0 |
| [swarm-meta] (meta-pattern detection) | 13 | 11 | 2 | 0 |
| [swarm-docs] (cross-document analysis) | 11 | 10 | 1 | 0 |
| [swarm-org] (organizational patterns) | 6 | 5 | 1 | 0 |
| [research] (web-enriched connections) | 5 | 5 | 0 | 0 |
| **Total** | **92** | **78 (85%)** | **14 (15%)** | **0** |

**[ext-signal] entries** (sourced from organizational tools): 9 entries with [ext-signal] in title

**Caveat:** Resonant/faint classification is self-assessed by the AI during the cross-referencing pass — there is no independent quality check. The 0% noise rate is suspicious and may indicate the threshold is too permissive.

---

## Survival Log (tracked sparks with outcomes)

**Total tracked:** 55 significant sparks across all sources

### By outcome status

| Status | Count | % |
|--------|-------|---|
| Shipped (produced concrete outcome) | 16 | 29% |
| Alive (actively being pursued) | 27 | 49% |
| Dormant (captured, not moving) | 12 | 22% |
| Dead (explicitly killed) | 0 | 0% |

### By source

| Source | Total | Shipped | Alive | Dormant | Conversion |
|--------|-------|---------|-------|---------|------------|
| Spark sessions | 17 | 8 (47%) | 7 | 2 | 47% |
| Daydreams | 5 | 3 (60%) | 1 | 1 | 60% |
| Dream-sparks | 33 | 5 (15%) | 19 | 9 | 15% |

### By trust level

| Trust Level | Count | % | Description |
|-------------|-------|---|-------------|
| SEED | 1 | 2% | Raw, ungrounded |
| SEED+ | 10 | 18% | Strong but no external validation |
| REVIEWED | 26 | 47% | Validated by 2+ signals |
| VERIFIED | 16 | 29% | Produced a concrete artifact |
| SOT | 2 | 4% | Changed behavior, adopted by team |

### By time to outcome (shipped sparks only)

| Days to Ship | Count | Pattern |
|-------------|-------|---------|
| 0 (same day) | 8 | All implementation-light (skills, docs, design specs) |
| 1 day | 4 | Initiatives, coverage audits |
| 2 days | 2 | Multi-step initiatives requiring design |
| 3+ days | 2 | Cross-domain work requiring coordination |

---

## Spark Sessions

| # | Date | Rating | Duration | Sparks Tracked | Shipped | Extended |
|---|------|--------|----------|---------------|---------|----------|
| 1 | Mar 27 | fire | ~10 min | 6 | 5 | Yes — produced /daydream skill |
| 2 | Mar 27 | fire | ~30 min | 2 | 1 | No |
| 3 | Mar 28 | fire | ~20 min | 5 | 1 | Yes — produced 5 organizational initiatives |
| 4 | Mar 31 | nuclear | ~45 min | 5 | 1 | Yes — produced cognitive pipeline architecture |
| 5 | Mar 31 | fire | varied | — | — | Embedded in longer ideate session |

**Session ratings:** 4 fire, 1 nuclear. 0 warm, 0 smoke, 0 cold.

**Sessions that produced extended work:** 3 of 5 sessions led to multi-day follow-up work (skills, initiatives, architecture). The 2 that didn't produce extensions were shorter and more contained.

---

## Shipped Outcomes (16 total)

Anonymized by category — content removed, only the type and timing preserved.

| # | Source | Category | Days to Ship |
|---|--------|----------|-------------|
| 1 | spark | Tool/skill | 0 |
| 2 | spark | Tool/skill | 0 |
| 3 | spark | Tool/skill | 0 |
| 4 | spark | Design spec | 0 |
| 5 | spark | Design spec | 0 |
| 6 | spark | Architecture doc | 0 |
| 7 | spark | Tool/skill (from failed experiment pivot) | 2 |
| 8 | spark | Architecture doc | 0 |
| 9 | daydream | Strategic initiative | 2 |
| 10 | daydream | Measurement framework | 2 |
| 11 | daydream | Architecture (most significant single shipping) | 1 |
| 12 | dream-spark | Design principle (reached SOT — changed team behavior) | 0 |
| 13 | dream-spark | Behavioral guardrail (reached SOT — self-identified pattern) | 0 |
| 14 | dream-spark | Framework design (informed trust scale) | 1 |
| 15 | dream-spark | Signal detection pattern | 4 |
| 16 | dream-spark | Knowledge architecture decision | 1 |

**Pattern:** Spark sessions ship tools and docs same-day (implementation-light). Daydreams ship initiatives over 1-2 days. Dream-sparks ship design principles and frameworks that inform other work — their value is often indirect.

---

## Observations

1. **Zero dead sparks.** No spark was explicitly marked as wrong or irrelevant. This likely means the system lacks a disposal mechanism, not that every idea was viable. A mature system needs a "kill" threshold.

2. **85% resonant rate on dream-sparks is suspiciously high.** Either the AI's self-assessment threshold is too permissive, or the memory pool is dense enough that most cross-references find something. Needs independent evaluation.

3. **Daydreams have the highest conversion rate (60%).** Hypothesis: whispers are pre-filtered by human attention (you only daydream about what's already nagging you), so the input quality is higher.

4. **Dream-sparks serve as enrichment, not action.** Only 15% ship directly, but they feed spark sessions with richer fuel. Their value may be indirect and harder to measure.

5. **Same-day shipping favors tooling over people-work.** 8 of 16 shipped outcomes were same-day, all implementation-light. Sparks that require human coordination (hiring, process changes) take longer and may never ship. The protocol may be better at producing artifacts than producing organizational change.

6. **All data is from one user (Yuval Raz) over 5 days.** None of these patterns may hold for a second user or a longer timeframe. Treat as directional signal, not validated findings.
