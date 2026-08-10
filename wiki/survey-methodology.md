# Survey methodology

How secondary studies — surveys, in this repo's vocabulary — are made
trustworthy: the systematic-review tradition from evidence-based
medicine as adapted by software engineering. Shelf:
[[kitchenham2007-slr-guidelines]]
(the process standard),
[[petersen2008-systematic-mapping]]
(the mapping genre's founding statement),
[[wohlin2014-snowballing]]
(the citation-based search procedure),
[[page2021-prisma]] (the reporting standard),
[[madeyski2025-llm4screenlit]] (the measurement-reform statement for
LLM screening),
[[woelfle2024-human-ai-appraisal]] (the human-gate
placement benchmark),
[[fagerberg2025-dual-model-screening]]
(the cross-model ensemble evidence and its causal boundary).

## The genres trade depth for breadth, not quality for laziness

A systematic review evaluates few studies deeply to establish a state
of evidence; a mapping study classifies many studies shallowly to
structure a field.
[[petersen2008-systematic-mapping]]
grounds the distinction in an argument
[[kitchenham2007-slr-guidelines]]'s
review-first framing understates: quality-filtering *biases an
overview*, because methodological rigor is unevenly easy across
sub-topics — one review kept 5% of candidates, a sound basis for an
evidence verdict and a hopeless one for a map. The genres compose
rather than rank: map first to find the clusters and deserts, then
review a structured sub-area. Petersen's "adaptive reading depth"
makes the boundary a continuum — read each paper only as deep as its
classification requires — which is graded ingestion by another name.

## The protocol prevents bias; the report makes it checkable

The tradition splits review quality across three enforceable layers.
Conduct: a protocol — questions, search strategy, selection criteria,
extraction forms, synthesis plan — written and piloted *before* the
review, explicitly so that selection cannot be driven by expectation
([[kitchenham2007-slr-guidelines]]).
Reporting: [[page2021-prisma]]'s 27 items, whose
common thread is that everything is disclosed somewhere a reader can
check — full search strategies for every database, near-miss
exclusions cited with reasons, reviewer counts and independence,
automation tools, competing interests, data and code. Appraisal is a
third layer with its own instruments (AMSTAR 2, ROBIS), deliberately
outside PRISMA's scope. The separation is load-bearing: PRISMA's own
authors concede the causal evidence that reporting checklists improve
reviews is observational and thin — the checklist verifies presence
of disclosures, not their honesty, which is exactly why conduct needs
its own gate.

## Search is a coverage argument, not a query

Both search schools exist because completeness cannot be observed,
only argued.
[[kitchenham2007-slr-guidelines]]
argues it by redundancy — multiple engines (none suffices), manual
venue searches, gray literature, author contact against publication
bias — with the search documented as it happens and unfiltered
results saved for reanalysis.
[[wohlin2014-snowballing]]
argues it by connectivity: SE terminology drifts too much for search
strings, but authors cite each other across the drift, so traversing
citation edges from a diverse start set reaches what no query names —
with decay of per-iteration yield and blank cells in a citation
matrix as the completeness diagnostics. The two compose here too:
Wohlin's closing deduction is that for *extending* an existing study,
snowballing dominates database search, since new work almost
certainly cites the prior study or its included papers — the
principle behind registered citation refreshes in any living survey.

## Reliability is measured, not assumed

The canon treats reviewer judgment as a measurement instrument
needing calibration: two extractors with disagreements resolved by
arbitration and agreement reported as Cohen's kappa; a single
researcher substitutes test–retest on a random sample; sensitivity
analysis asks whether conclusions survive dropping the doubtful
studies
([[kitchenham2007-slr-guidelines]]).
[[petersen2008-systematic-mapping]]
names the cost of skipping it — shallow classification misfiles
papers whose terminology misleads — and
[[page2021-prisma]] moves the discipline into the
report: *how many* reviewers, *whether* independent, *which*
automation tools. Written for ML screening tools, those items land
directly on agent-run surveys, where independent extraction passes
play the second reviewer and an inter-rater statistic for agent
passes is an unsolved instrumentation gap. The first agent-era
measurements sharpen that gap rather than close it.
[[fagerberg2025-dual-model-screening]]'s
duplicate-run κ of 0.78–0.93 shows a model disagreeing with itself
far less than it errs — its mistakes are systematic, so test–retest
is the wrong instrument for an agent pass and redundancy must come
from outside the model.
[[woelfle2024-human-ai-appraisal]] turns the canon's
two-extractor design into a routing rule — score items where one
human and one LLM agree, defer disagreements to a second human —
that significantly beats solo raters on the instruments where humans
themselves are reliable (PRISMA, AMSTAR), and collapses into
near-total deferral on PRECIS-2, where the human raters' own κ is
0.29: the collaboration pattern carries the result, and human
inter-rater reliability still bounds it.

## The agent-era frontier

The canon predates agents, and the first sys0 survey
([[agent-assisted-evidence-synthesis]]) maps part of what has grown in the gap:
776 include-level works on AI-assisted evidence synthesis from 2020–2026, with
31 selected evidence notes. Its dated, relevance-capped catalog is not a
complete field census, but its bounded findings rhyme with the canon rather
than replacing it. Screening dominates the retained map while appraisal and
reporting remain thin. Measurement practice still falls short of
[[kitchenham2007-slr-guidelines]]-grade
discipline: [[madeyski2025-llm4screenlit]] finds complete confusion matrices in
only 7 of 29 selected evaluations and demonstrates that metric choice can
reverse a model ranking while changing how much relevant evidence is lost.
The selected guidance converges on disclosure content while four unvalidated
instruments divide that content between reporting and reproducible storage.

The survey also turns the canon's measured-reliability thesis toward reviewer
design. No selected deep read defines when two agent reviewers count as
independent, and the survey did not search that question exhaustively.
[[fagerberg2025-dual-model-screening]]
reports 99.7% sensitivity for a two-model OR ensemble on author-adjudicated
labels, but its design does not isolate model family, model identity, duplicate
runs, or the OR rule. [[woelfle2024-human-ai-appraisal]] instead
shows that agreement-gated human–LLM deferral can outperform its comparison
arms on two easier appraisal instruments. Together these results motivate a
measurement question, not a novelty claim: which operational independence
controls actually cause ensemble or deferral gains?

## Local instantiation and open questions

This canon is the methodological ground of the survey layer this
repo is designing (scratch/2026/2026-08-08/survey-layer-design.md):
protocol and audited search logs from Kitchenham, the systematic-map
genre and disposition-coded catalogs from Petersen, backward/forward
chases and refresh-by-citation from Wohlin, the deposition gate
answering PRISMA's items. The canon also argues the layer's
citability plan by example — Kitchenham & Charters is a versioned,
never-journal-published technical report cited five figures deep.
Open: Petersen's 2015 update (closed access) stays a queue item; the
canon predates agents, so agent-pass inter-rater measurement and the
boundary between automation disclosure (PRISMA items 8–9) and
authorship disclosure are for this repo to work out in practice.
