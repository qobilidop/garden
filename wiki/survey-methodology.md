# Survey methodology

How secondary studies — surveys, in this repo's vocabulary — are made
trustworthy: the systematic-review tradition from evidence-based
medicine as adapted by software engineering. Shelf:
[[kitchenham2007-guidelines-for-performing-systematic-literature-reviews-in-software-engineering]]
(the process standard),
[[petersen2008-systematic-mapping-studies-in-software-engineering]]
(the mapping genre's founding statement),
[[wohlin2014-guidelines-for-snowballing-in-systematic-literature-studies-and-a-replication-in-software-engineering]]
(the citation-based search procedure),
[[page2021-the-prisma-2020-statement]] (the reporting standard).

## The genres trade depth for breadth, not quality for laziness

A systematic review evaluates few studies deeply to establish a state
of evidence; a mapping study classifies many studies shallowly to
structure a field.
[[petersen2008-systematic-mapping-studies-in-software-engineering]]
grounds the distinction in an argument
[[kitchenham2007-guidelines-for-performing-systematic-literature-reviews-in-software-engineering]]'s
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
([[kitchenham2007-guidelines-for-performing-systematic-literature-reviews-in-software-engineering]]).
Reporting: [[page2021-the-prisma-2020-statement]]'s 27 items, whose
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
[[kitchenham2007-guidelines-for-performing-systematic-literature-reviews-in-software-engineering]]
argues it by redundancy — multiple engines (none suffices), manual
venue searches, gray literature, author contact against publication
bias — with the search documented as it happens and unfiltered
results saved for reanalysis.
[[wohlin2014-guidelines-for-snowballing-in-systematic-literature-studies-and-a-replication-in-software-engineering]]
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
([[kitchenham2007-guidelines-for-performing-systematic-literature-reviews-in-software-engineering]]).
[[petersen2008-systematic-mapping-studies-in-software-engineering]]
names the cost of skipping it — shallow classification misfiles
papers whose terminology misleads — and
[[page2021-the-prisma-2020-statement]] moves the discipline into the
report: *how many* reviewers, *whether* independent, *which*
automation tools. Written for ML screening tools, those items land
directly on agent-run surveys, where independent extraction passes
play the second reviewer and an inter-rater statistic for agent
passes is an unsolved instrumentation gap.

## The agent-era frontier

The canon predates agents, and the first sys0 survey
([[agent-assisted-review-methodology]]) mapped what has grown in the
gap: 672 works on AI-assisted evidence
synthesis, 2020–2026. Read against this page's theses, the
campaign's findings rhyme with the canon rather than replacing it —
the LLM-era stage skew reproduces the pre-LLM one (screening dominant,
appraisal and reporting thin); evaluation practice still fails
[[kitchenham2007-guidelines-for-performing-systematic-literature-reviews-in-software-engineering]]-grade
measurement discipline (a 29-paper review co-authored by Kitchenham
herself finds only a quarter report confusion matrices, and
accuracy-ranked model choice can silently discard relevant evidence);
disclosure norms converge on content while instruments fragment,
extending [[page2021-the-prisma-2020-statement]]'s items 8–9 in four
competing unvalidated directions; and reviewer-independence — the
canon's measured-reliability thesis applied to agents — is entirely
undefined in the literature. A designed next experiment falls out of
that gap: a cross-vendor dual-screening pass (the mirrored Codex
configuration exists for exactly this), with disagreements analyzed
by error type — among the first deliberate cross-family independence
measurements the mapped literature lacks. The survey's manuscript
carries the detail; its load-bearing works are evidence-note sources
in the survey record awaiting promotion before this page can cite
them directly.

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
