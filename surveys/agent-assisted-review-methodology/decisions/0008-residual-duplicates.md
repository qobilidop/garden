# 0008 — Residual duplicates in the frozen include set (erratum)

- Status: recorded post-freeze (Bili-gated /evolve, 2026-08-08)

A post-freeze duplicate audit found ~22 duplicate-title groups (~26
excess rows, ~3.9%) among the 672 includes: preprint↔published pairs,
SSRN↔journal pairs, and F1000Research `.N` versions. Root cause: the
key normalization fix written into `snowball.py` was never backported
to `search.py`, which minted fake `doi:` keys from arXiv identifiers —
e.g. `doi:10.17526v2` and `arxiv:2310.17526` are the same work and
both survive in catalog-included.tsv. E6 fired only 16 times
campaign-wide because screeners see one row at a time and cannot
detect duplicates structurally.

Baseline counts are as-frozen, not recomputed; baseline.md carries a
dated erratum line pointing here.

Skill implication: v1 fix (applied — skills/run-survey/ §2 shared
`keyof()` ladder, §3 catalog-wide duplicate audit before
classification).
