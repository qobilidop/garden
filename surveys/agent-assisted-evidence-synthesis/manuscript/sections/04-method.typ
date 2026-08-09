= How This Survey Was Made <sec-method>

The survey was compiled with LLM-agent assistance under human
direction: agent passes performed search, screening, classification,
and deep reading; the author set the protocol, approved the scheme,
and gated every stage. It has run in two waves — an initial campaign
closing 2026-08-08 and an update batch on 2026-08-09 — and the map is
their reconciled union.

== The initial campaign

Eleven logical queries ran against OpenAlex, Crossref, Semantic
Scholar, and arXiv (window 2020-01-01 to 2026-08-08, English); ten
succeeded and one Semantic Scholar query ended in a persistent 429.
Results were relevance-sorted with a cap of 50 records. Review-side
vocabulary such as "systematic review" and "evidence synthesis" was
paired with model-side vocabulary spanning LLMs, agents, automation,
AI, and ML.

The first 412 candidates received two agent screening passes with
adjudication. A single backward+forward snowball round @wohlin2014 then
used a title-vocabulary pre-filter; its 881 retained candidates received
one screening pass and a verification pass over included decisions. The
wave was not iterated to saturation. Facets were assigned once from
truncated abstracts. A post-campaign integrity pass resolved 24
version/duplicate rows and removed two retracted works, leaving 646
included works.

== The 2026-08-09 update

The update ran the standing query registry — 17 queries after adding
six covering mapping-study, scoping-review, and living-evidence
vocabulary, the genre terms the original review-centric query set
underweighted. Sixteen succeeded; one Semantic Scholar query failed
with HTTP 429 on six attempts across two spaced rounds and is counted
as no query. Each query fetched the inclusive interval since its own
last reconciliation (the survey window start, for the six new ones).

The update also declared a bounded critical set — twelve closest works
comprising the competing maps, the load-bearing evidence studies, and
the disclosure instruments — and chased each backward and forward.
Three backward chases returned bibliographies the citation index could
not supply (two empty, one with 23 unresolved references); each was
re-chased from the publisher-deposited reference list of the primary
version and is marked as such in the record. We do not generalize
from three cases to a claim about index reliability; the record marks
which chases needed it.

@tab-funnel gives both waves' funnels side by side, the campaign's as
retained aggregates and the update's at candidate level.

Screening followed the protocol's dual-pass design: an
eligibility-first pass and an exclusion-first pass on different model
tiers, disagreements adjudicated by a stronger model, the human gate
approving the batch. Of 579 dual-pass candidates, 360 were pass
agreements and 219 went to adjudication; six further rows from a late
chase were screened and verified separately, for 585 in all, of which
132 were included. On the 66 substantive disagreements — one pass
including where the other excluded — the adjudicator sided with the
eligibility-first pass 54 times and with the exclusion-first pass 8
times, choosing an exclusion code in 59. The smaller-tier
exclusion-first pass systematically over-included domain reviews, the
mirror image of the over-exclusion measured in the initial
campaign. Facets for the new includes were
assigned once from abstracts, as before.

Two screening passes had to be discarded and re-run: their outputs
were keyword heuristics rather than judgments — one written as an
explicit program, one detectable as 97 decisions sharing seven
template justifications. They were caught by an output check (distinct
justifications per decision) before adjudication. The failure was
silent and plausible in aggregate: it would not have been visible from
decision counts, and we cannot exclude subtler instances in the passes
that survived the check.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, right, right),
    table.header([Phase], [In], [Out]),
    [*Campaign (through 2026-08-08)*], [], [],
    [Search (11-query set; 10 succeeded)], [—], [419 unique],
    [Dedup (arXiv–DOI)], [419], [412],
    [Dual-pass screen + adjudication], [412], [139 includes],
    [Snowball round (pre-filtered)], [139 seeds], [1,204 new],
    [Vocabulary pre-screen], [1,204], [881],
    [Wave-2 screen + verification], [881], [533 includes],
    [Campaign close], [1,291 rows], [672 included rows],
    [Integrity correction], [672 included rows], [646 works],
    [*Update (2026-08-09)*], [], [],
    [Search (17-query set; 16 succeeded)], [—], [517 rows],
    [Critical-set chases (24 + 3 primary)], [12 seeds], [1,191 rows],
    [Vocabulary pre-screen (chase rows)], [1,191], [595 retained],
    [Dedup, enrichment, park], [1,112], [585 screened],
    [Dual-pass screen + adjudication], [585], [132 includes],
    [Date-rule coding (primary chases)], [41], [39 before-window],
    [Integrity (aliases, artifacts)], [26 rows], [13 E6, 13 dropped],
    [*Current ledger*], [1,975 rows], [*776 include-level*],
    [Facet classification], [776], [the map],
    [Deep reads], [776], [31 notes],
  ),
  caption: [Identification and selection funnel across both waves.
    Campaign phase quantities are retained historical aggregates:
    candidate-level provenance was pruned and cannot regenerate them.
    The campaign's 323 vocabulary rejects were not cataloged; two of
    881 screened rows merged on entry (412 + 879 = 1,291), and a later
    publication migration brought the ledger to 1,292 before the
    update. Update quantities are candidate-level and reproducible
    from the record's log. Of the 517 search rows and the 595 chase
    rows surviving the pre-screen, 585 reached screening; the
    remainder were already cataloged, merged into another row, or
    parked for lack of any registrar abstract. The update's 132
    include decisions yield 130 new include-level rows: one work had
    already entered the map in the campaign and was independently
    re-included, and one was later reclassified out of scope by a
    deep read.],
) <tab-funnel>

== What the record holds

Update coverage is bounded by the same 50-record relevance cap, and
this survey retains its logged queries rather than the unfiltered
result sets — a deliberate departure from the save-everything practice
of the SLR canon @kitchenham2007, justified by replayability of the
verbatim queries and disclosed here because it limits reanalysis.
Thirty-nine rows from the primary-complete chases were coded
before-window mechanically from verified publication years without a
screening pass. Seventy-six rows remain parked as undecidable on
available metadata and are re-screened on every update; 87 of the 585
screened candidates still carried no registrar abstract after
enrichment was attempted against two registrars, and were judged on
title, venue, and year.

Thirty-one works carry evidence notes, selected facet-guided as
candidate anchors. Citations resting on abstract-only evidence carry an
"abstract-only" marker. The survey record linked in the title note
holds the protocol, the append-only search and audit log with
per-row decided keys, the classified catalog, the syntheses, and the
per-work evidence notes. It is a minimal public record; process
history remains in git.
