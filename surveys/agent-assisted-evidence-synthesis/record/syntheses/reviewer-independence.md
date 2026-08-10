# Reviewer independence in the selected evidence

## Current conclusion

No selected evidence record identifies a definition of when two agent
reviewers count as independent in the sense used for dual human review. One
paper measures a proxy, inter-agent score correlation, but no selected design
isolates model-family diversity or correlated error with matched controls. The
result is a bounded selected-set observation, not a literature-wide absence
claim.

## What the selected studies establish

### Cross-vendor voting with a measured proxy

`akinseloyin2026` combines three agents from different vendors and reports
Spearman score correlations of 0.48–0.56. Soft voting beats every constituent
on the benchmark. Allowing the agents to debate raises their correlation and
reduces performance relative to independent voting. This is the selected set's
only within-study evidence that interaction can consume useful diversity.

The design changes vendor, parameter scale, training corpus, and model family
together. Correlation is therefore a measured mechanism proxy, not a definition
of independence or a causal family-diversity result.

### Cross-vendor OR aggregation

`fagerberg2025` runs GPT-5 Thinking and Gemini 2.5 Pro twice each and includes
the union of their positive decisions. The preprint reports 99.7% sensitivity
on author-adjudicated labels and 94.0–94.5% against original Cochrane labels.
Every in-team relabel moves measured sensitivity upward. No matched same-family
arm separates vendor diversity from model identity, repeated runs, or the OR
rule.

### Same-family aggregation

`knafou2023` combines five BERT-family classifiers and reports F1 89.16% against
the best member's 88.53%. The paper reports no correlation, agreement, or error
overlap among members. It establishes a configuration-level gain, not the
source of that gain.

### Human–model deferral

`woelfle2024` accepts human–LLM agreements and sends disagreements to a second
human. On two easier appraisal instruments, selected pairings reach 95–96%
accuracy while sparing roughly 65–70% of second-reviewer item count. Performance
is weaker on PRECIS-2. The design supports deferral for those retrospective
instruments, not a general independence law.

### Threshold-gated human–AI configuration

`brincoveanu2025` is an abstract-only framework spanning screening through
thematic analysis. It routes decisions by an AI-confidence threshold under
human oversight but reports no extractable threshold, error, workload, or
human-checkpoint values. It establishes a configuration, not its effectiveness
or an independence mechanism.

### Indirect boundaries

- `syriani2023` reports high run-to-run consistency on two corpora despite
  mediocre validity elsewhere: self-consistency is not independence.
- `rose2025` operationalizes independence as two human operators separately
  running one model. That is operator separation, not architectural or
  statistical independence, and the work is a protocol with no results.
- `huang2026` uses task decomposition and human review with no redundant agents;
  its strong result shows that redundancy is not a prerequisite for one
  end-to-end architecture.
- `safarpour2026` reports only an abstract-level directional contrast between
  open-weight and proprietary models, with no extractable performance numbers.

## What a definition would need

A useful construct must separate at least:

1. model and training-family overlap;
2. prompt, context, retrieval, and tool overlap;
3. sampling and run-level randomness;
4. shared reference-label and benchmark contamination;
5. interaction before aggregation; and
6. the error correlation that remains at the deployed operating point.

An evaluation would need matched same-family and cross-family arms, a fixed
corpus and aggregation rule, repeated runs, per-item error vectors, and explicit
cost/coverage accounting. Vendor labels alone are not a measurement.

## Scope and limitations

- The standing searches contain no independence query and the taxonomy has no
  independence facet.
- The deep reads are facet-guided rather than an exhaustive ensemble sample.
- The strongest positive cross-vendor result is a preprint with in-team label
  adjudication.
- Cross-study margins cannot be compared because corpus, task, metric, model
  era, and label source all differ.

## Consequence for presentation

Use "no selected evidence record identifies" rather than "the literature does
not define." Report each ensemble or deferral result with its own comparator
and caveat, and treat independence as an open measurement problem rather than
the name of a demonstrated causal mechanism.
