# Campaign status

Phase: snowball round COMPLETE (2026-08-08). Catalog: 1291 works, 672 included (533 via snowball, verified by sonnet pass; overturn rate ~13%). Next: classification faceting, then G1.

- Searched: 11 logged queries, 4 sources (1 persistent 429 logged);
  419 raw candidates, 412 after arxiv-DOI dedup (7 merged; the
  key-normalization miss is a skill-v1 fix).
- Dual-pass screening: 24 subagent passes (12 haiku criteria-framed,
  12 sonnet RQ-framed), 417 dual-screened. Binary agreement 0.971,
  Cohen's kappa 0.937, 6-category exact 0.835. Same-vendor caveat
  applies (RQ4 relevance).
- Adjudication: 33 rows (12 disagreements, 19 uncertain, 2
  single-pass) ruled by Fable; rationales in catalog.tsv;
  decisions/0003 records the peer-review-record protocol gap.
- Dispositions: I=139, E1=54, E2=213, E3=4, E6=2.

## Next steps (resumable; work/ + logs/raw/ hold intermediates)

1. Snowball: one backward+forward round from the 139 includes via
   citation indexes (expect heavy overlap; log iteration yield).
2. Classification: facet the includes (stage / contribution /
   evidence / setting) by keywording; scheme changes logged.
3. G1 selection (cap 25): RQ2-RQ4 bearing works + RQ1 cluster
   anchors; fan out capture->transcribe->evidence-note pipelines.
4. Syntheses (problem-scoped), claims.md, wiki writebacks,
   baseline.md freeze with full disclosure block.
