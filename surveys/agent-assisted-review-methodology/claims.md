# Claims ledger

Each claim names its evidence (sources/ notes and map.tsv); claims
resting on abstract-only notes are marked (A). Search-authority claims
are bounded by the baseline's documented coverage (see baseline.md
limitations — one snowball round, title pre-filter, single-pass wave 2).

1. **The LLM-era stage distribution reproduces the pre-LLM skew** —
   screening dominates (225/672), appraisal and reporting thinnest —
   against the 2006–2020 baseline where all 41 automation studies sat in
   conducting-the-review. Evidence: map.tsv; vandinter2021.
2. **SE remains an order of magnitude behind medicine in evidence
   volume** (17 vs 412 setting-classified includes), continuing the
   pre-LLM adoption gap. Evidence: map.tsv; napoleao2021.
3. **No evaluated single model meets the field's own screening
   deployment bar** (recall≥0.95 with precision≈0.50). Evidence:
   huotala2025 (9 LLMs × 24 SE reviews); consistent with oami2025,
   gargari2023.
4. **Cross-review (task) variance exceeds cross-model variance in
   screening performance.** Evidence: huotala2025 regression;
   syriani2023 cross-corpus spread.
5. **Model-generation upgrades bought specificity (workload), not
   sensitivity (evidence retention)**, in the one controlled same-prompt
   comparison. Evidence: oami2025.
6. **A cross-vendor OR-ensemble reached near-perfect screening
   sensitivity** (99.7%/99.1%, specificity 49.3%) with a documented
   family-specific blind spot caught by the other family — the
   strongest designed evidence for model-family diversity. Evidence:
   fagerberg2025 (preprint; adjudication-circularity caveat in note).
7. **Agreement-gated human-AI deferral beats both humans-alone and
   LLM consistency-ensembles on appraisal** (95–96% accuracy sparing
   ~65–70% second-reviewer workload), and all individual LLMs score
   below all individual humans there. Evidence: woelfle2024.
8. **Evaluation practice is systematically inadequate under class
   imbalance**: 24% of LLM-screening evaluations report confusion
   matrices, 10% report MCC; accuracy-ranked model choice can lose 10×
   more relevant evidence than cost-weighted ranking. Evidence:
   madeyski2025 (29-paper review + reanalyses).
9. **Disclosure norms converge on content (tool/version/prompt/role/
   verification/human accountability) while instruments fragment** —
   four unvalidated competing instruments as of early 2026, none with
   adoption evidence, while disclosure in published SRs stays rare.
   Evidence: holst2025, degen2024, fernandes2026, gartlehner2025,
   oconnor2024, luo2024; map guideline facet (36).
10. **The best-documented end-to-end system derives reliability from
    task decomposition, deterministic components, and human gates — not
    agent redundancy** (63.6% end-to-end conclusion accuracy; ablation:
    two-stage extraction −14.9pp). Evidence: huang2026 (preprint,
    author-built benchmark).
11. **No published work defines or measures reviewer independence for
    agents** (vendor/prompt/tier diversity, correlated errors from
    shared training data) — the survey's clearest gap, and the one this
    campaign's own v2 can address with a cross-vendor pass. Evidence:
    absence across the 25 G1 notes; nearest neighbors fagerberg2025,
    safarpour2026 (A), hamel2021 (human-only independence).
12. **Living/update automation is nearly nonexistent** — 1 of 34 tools
    in the living-evidence inventory serves the update phase. Evidence:
    song2026.
