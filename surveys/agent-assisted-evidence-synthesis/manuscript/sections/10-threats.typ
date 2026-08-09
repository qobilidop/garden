= Limitations <sec-threats>

Search coverage is bounded by relevance-sorted top-50 caps, English-only
retrieval, and one failed query in each wave's set. The snowball rounds
apply a title-vocabulary pre-filter, which reintroduces the terminology
dependence snowballing exists to escape @wohlin2014 — and does so
asymmetrically, since the filter reads titles only. Chasing the update's
newest critical work surfaced a directly relevant abstract whose title
carried no genre term and had therefore been dropped before its
abstract was read; that work proved out of scope on its merits, but the
mechanism is a recall bound on every chase in both waves, and we cannot
say how many in-scope works it cost. The initial wave's model-vocabulary
list and candidate-level provenance were not retained, and the update
retains logged queries rather than unfiltered result sets.

Registrar defects shaped the update materially. Three of twelve
backward chases returned bibliographies the citation index could not
supply, requiring publisher-deposited reference lists; 137 screened
candidates carried no registrar abstract and were judged on title,
venue, and year; 39 rows were coded before-window mechanically from
publication years without a screening pass. Seventy-six records remain
parked as undecidable.

Screening and classification read truncated abstracts (600–900
characters); every facet in both waves was single-pass, with no
retained model or prompt-level audit trail. Two update screening passes
returned keyword-heuristic output rather than judgments and were
discarded and re-run (@sec-method); they were caught by an output
check, but we cannot exclude subtler instances of the same failure in
passes that survived it, in either wave. The dual-pass design's two
passes are repeated automated checks, not independent human reviewers,
and the survey's own RQ4 finding — that nobody has defined what makes
two agent reviewers independent — applies to this survey's method as
much as to its corpus.

The integrity review resolved known version aliases across both waves
but cannot prove that no semantically renamed duplicate remains. The
facet labels are not quality assessments. Full-text notes disagree with
abstract-level facets for a minority of deep reads, including one work
whose coded evidence label describes a comparison its protocol has not
yet performed; the map remains as coded and the notes are authoritative
for those works. Deep-read extraction had no second pass, and 31
facet-guided selections do not support literature-wide absence claims —
RQ4 in particular had no targeted query or coding facet in either wave.
Medicine accounts for 463 of 776 include-level rows against 23 for
software engineering, so thresholds and examples are
medicine-calibrated, and terminology claims about software engineering
rest on a small deep-read stratum rather than on the map.
