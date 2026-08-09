# 0002 — Screened pool exceeds the compact target (419 vs 100-300)

- Status: accepted (agent judgment, 2026-08-08)

Eleven logged queries deduped to 419 candidates; two Semantic Scholar
queries were rate-limited (one recovered on retry, s23 persistently
429 — logged as FAILED). Trimming by relevance rank would trade
recall for a round number; screening capacity absorbs the overshoot.
The compact bound applies to G1 depth (cap 25), which is unchanged.
