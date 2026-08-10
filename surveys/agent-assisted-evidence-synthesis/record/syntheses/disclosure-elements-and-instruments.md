# Disclosure elements recur while instruments and roles diverge

## Current conclusion

Selected guidance repeatedly addresses tool identity and version, stage or
task, human role, configuration, verification, and accountability, but no one
item set is common to every instrument. The instrument coverage is unsettled,
and the guidance differs more substantively on whether AI may perform
first-pass work or should remain a secondary checker.

## Recurring disclosure elements

- `hamel2021` gives a graded oversight ladder for active-ML screening and treats
  fully autonomous thresholding as inappropriate; it separately risk-ranks
  options for records left after human-chosen truncation.
- `gartlehner2025` asks authors to specify tools, tasks, verification, model
  version, and prompts, and keeps humans accountable.
- `holst2025` requires tool configuration, prompts, oversight, evaluation, and
  AI-versus-human flow counts in a 14-item PRISMA-trAIce checklist.
- `degen2024` records tool name, version, and input parameters per stage in a
  machine-readable FRAISR table.
- `fernandes2026` pairs reporting fields with a conduct table assigning human
  and AI roles by stage.

These are recurring elements, not a common intersection: FRAISR has no
human-role field, and the item sets were not formally aligned. Overlap in
disclosure content does not imply agreement on acceptable conduct.

## Four instruments in two genres

Three instruments govern reporting:

1. PRISMA-trAIce — 14 section-mapped items plus a human/AI-split flow diagram;
2. FRAISR — a per-stage machine-readable table; and
3. HAICO-SLR — paired conduct and reporting tables.

`lombaers2024` supplies a fourth instrument in a different genre: a 15-item
reproducible-storage checklist for active-learning reviews. It asks software to
store random seeds, labeling order, and per-iteration model and training-set
state—artifacts the reporting checklists do not name.

None of the four source notes reports field validation or adoption. The storage
checklist's only application is a conformance example against a tool developed
by two of its three authors. This supports "unvalidated in the selected
evidence," not a claim that no external use exists.

## PRISMA-AI status is source-dependent

`holst2025` describes PRISMA-AI as announced in 2022 but unpublished;
`fernandes2026` says it was never actually developed. These histories conflict.
Both sources agree on the operative point: no usable PRISMA-AI instrument was
available to govern AI used as a review tool. PRISMA 2020 itself asks for
automation details at selection and extraction items but is not a comprehensive
AI-use instrument.

## The normative disagreement is the sanctioned role

The Cochrane-family line (`hamel2021`, `gartlehner2025`) favors AI as a
secondary quality-assurance reviewer: re-check human exclusions or extractions,
with risk-ranked exceptions and oversight. HAICO-SLR (`fernandes2026`) permits
AI first-pass filtering and drafting under human validation, while retaining
human-only responsibility for question formulation and final synthesis.

Hamel et al. are more specific than a flat "human decision on every record"
rule. They reject fully autonomous score-threshold screening, then separately
rank options for the unscreened remainder after a human-chosen truncation point;
AI-only exclusion is the highest-risk option in that narrower setting. The
manuscript preserves the distinction.

## Practice and consensus evidence

`oconnor2024` relays a domain-limited mapping result that only a very small
percentage of reviews disclosed advanced-AI tools. This is secondhand evidence,
not a field prevalence estimate. `mughal2026` is one positive exemplar: it
names the model, cites PRISMA 2020 item 8, publishes validation results, and
discusses residual risk; the authors also perform their own validation, whose
single observed miss has a wide interval.

`golob2025` reports a 29-expert, three-round Delphi on living evidence
synthesis. Nineteen of 23 statements reached the authors' consensus threshold,
but their account places the weakest agreement on actionable automation use.
The statement tables were not machine-readable and the work is a preprint, so
the finding rests on the authors' characterization rather than an independently
recomputed vote table.

## Scope and limitations

- The three reporting proposals arise from different development methods and
  are not interchangeable merely because their content overlaps.
- Two reporting proposals and the Delphi are preprints.
- Rare-disclosure evidence is secondhand and domain-limited.
- One detailed exemplar plus one prevalence relay does not measure adoption.
- Coexistence is not, by itself, evidence of a standards race.

## Consequence for presentation

State the recurring disclosure elements without implying a common intersection,
separate reporting from reproducible storage, stage the PRISMA-AI history
conflict, and present secondary-checker versus first-pass-worker as the live
conduct disagreement. Never promote missing validation in the selected notes
to a worldwide non-adoption claim.
