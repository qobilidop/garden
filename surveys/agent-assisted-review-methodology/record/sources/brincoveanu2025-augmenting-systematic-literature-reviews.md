---
citekey: brincoveanu2025-augmenting-systematic-literature-reviews
work:
  title: "Augmenting Systematic Literature Reviews: A Human-AI Collaborative Framework"
  author: "Constantin Brîncoveanu, K. Valerie Carl, Aaron Witzki, Oliver Hinz"
  venue: "KI 2025: Advances in Artificial Intelligence"
  date: 2025
  doi: 10.1007/978-3-032-02813-6_1
read: abstract-only
source: "verbatim abstract via the Springer chapter landing page; metadata cross-checked via Unpaywall, OpenAlex, Semantic Scholar, DBLP (conf/ki/BrincoveanuCWH25), Leibniz Institute SAFE, and Goethe University Frankfurt (WIIM chair) publication pages; OA search: no OA PDF: Unpaywall `is_oa:false`, OpenAlex `best_oa_location:null`, Semantic Scholar `openAccessPdf.url` empty and abstract elided by publisher, no arXiv preprint, no PDF on the SAFE Frankfurt working-paper page or either author's institutional page — see Evidence limits"
facets:
  stage: "end2end"
  contribution: "method"
  setting: "se"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "AI-augmented Grounded Theory SLR framework, human-AI role split"
---

# Augmenting Systematic Literature Reviews: A Human-AI Collaborative Framework

## Evidence

- Framework integrates AI into Wolfswinkel et al.'s established Grounded
  Theory Literature Review Method — an existing SE/IS synthesis method,
  not a bespoke pipeline.
- Three AI-augmented components named in the abstract: AI-driven
  relevance assessments, automated selection, automated thematic content
  analysis — screening through synthesis, i.e. end-to-end.
- Design principle: AI augmentation is "underpinned by rigorous human
  oversight to ensure reliability and interpretative validity" — human
  oversight legitimizes AI output, not a fallback for AI failure.
- Evaluation design: a comparative study that *replicates and extends a
  previously published human-conducted SLR*, using it as ground truth
  rather than a synthetic or crowd-labeled benchmark.
- Evaluation metrics: type I/II error rates (false-positive/negative
  selection) measured *across varying confidence thresholds* — the
  framework exposes a tunable AI-confidence threshold and reports the
  resulting accuracy/coverage trade-off, not a single accuracy figure.
- Reported findings (qualitative, no figures in the abstract):
  "substantial efficiency gains and effective accuracy in AI-assisted
  selection," emphasizing "the importance of carefully calibrated
  thresholds and continued human oversight."
- Stated contribution: "practical guidelines for effectively balancing AI
  automation with human scholarly judgment" as a replicable methodological
  approach — the contribution target is the human-AI division-of-labor
  design itself, not just a tool.

## Bearing on RQs

- **RQ4 (collaboration/independence design):** directly on-point — the
  abstract's framing is a human-AI role split (AI proposes
  relevance/selection/theme judgments at a calibrated confidence
  threshold; humans retain oversight for reliability and interpretive
  validity), grounded in a named prior human method rather than an ad hoc
  pipeline. The confidence-threshold mechanism is a concrete, nameable
  gate design (AI decides above threshold, defers below it) worth
  comparing against other RQ4 sources' gates once full text is available.
- **RQ1 (what stages are automated / how):** end-to-end scope (screening
  → selection → thematic analysis) is a candidate contrast against
  single-stage screening-only sources; the "replicate a prior human SLR"
  evaluation design is a useful pattern for RQ1's evidence-quality
  discussion.

## Evidence limits

- **Abstract-only.** Every claim above comes from the ~200-word published
  abstract plus title/keyword/venue metadata; the framework's
  stage-by-stage mechanics, actual confidence-threshold values, specific
  type I/II error numbers, the identity of the replicated SLR, and the
  exact human checkpoints are unknown.
- **No case-study numbers**: the abstract asserts "substantial efficiency
  gains and effective accuracy" but gives no percentages, error rates,
  thresholds, or sample sizes — this note cannot yet support a
  quantitative claim in the survey text.
- **OA search exhausted, not skipped**: checked Unpaywall, OpenAlex,
  Semantic Scholar (abstract elided, `openAccessPdf.url` empty), arXiv
  (0 results), DBLP (no PDF field), the SAFE Frankfurt working-paper
  listing, the Goethe WIIM chair's Hinz publications page, and the first
  author's personal site — none host a preprint or postprint. No
  pirate-mirror fallback attempted.
- No transcript in shadow/store; nothing ingested into the library. This
  note is scratch-survey-only under `sources/`.
