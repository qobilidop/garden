---
citekey: page2021-prisma
work:
  title: "The PRISMA 2020 statement: an updated guideline for reporting systematic reviews"
  author: Matthew J. Page et al. (26 authors)
  venue: BMJ 372:n71 (co-published in PLoS Medicine, J Clin Epidemiology, Int J Surgery, Syst Rev)
  date: 2021-03-29
  doi: 10.1136/bmj.n71
sources:
  pdf:  # → store
    url: https://journals.plos.org/plosmedicine/article/file?id=10.1371/journal.pmed.1003583&type=printable
    # BMJ (version of record) bot-blocks downloads; captured the same-day PLoS Medicine co-publication (CC BY, doi 10.1371/journal.pmed.1003583)
    # archived: none yet — SPN triggered twice 2026-08-08, no record indexed; retry on next touch (sha256 a09df7b2 in shadow manifest anchors the artifact meanwhile)
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
synthesis: "Reporting as the enforceable surface of review quality: 27 items whose common thread is that everything — search, near-miss exclusions, automation, competing interests, data and code — is disclosed somewhere a reader can check."
---

# The PRISMA 2020 statement: an updated guideline for reporting systematic reviews

The reporting standard for systematic reviews: a 27-item checklist,
an abstract checklist, and revised flow diagrams, replacing PRISMA
2009 — which by August 2020 had over 60,000 citations, endorsement
from ~200 journals, and observational evidence associating its use
with more complete reporting. The scope line is drawn precisely:
PRISMA governs *reporting*, not conduct (Cochrane Handbook et al.),
not quality appraisal (AMSTAR 2, ROBIS), not protocols (PRISMA-P) —
it is the layer at which a review becomes checkable by outsiders. It
applies with or without meta-analysis, to updated and living
reviews, and anchors a family of extensions (network meta-analysis,
scoping reviews, search reporting via PRISMA-S).

Development is itself protocol-shaped, following EQUATOR guidance:
studies of where 2009 items were reported incompletely, a 60-document
item bank of existing guidance, a survey of 110 methodologists and
editors, a 21-member consensus meeting (Edinburgh 2018), five
circulated revisions, and a layout-feedback round. The 26-author list
publishes its competing-interest entanglements — editors-in-chief of
the very journals endorsing the guideline — in a competing-interests
statement the checklist itself now mandates of reviews (item 26).

## What changed, and what it signals

The noteworthy changes are a transparency ratchet: full search
strategies for **all** databases (2009 asked for at least one);
near-miss exclusions cited *with reasons* (item 16b — studies that
appear to meet criteria but were excluded); how many reviewers
screened and extracted, whether independently, and **details of any
automation tools used** (items 8–9); certainty-of-evidence assessment
(15, 22); data, code, and materials availability (27); protocol
registration or an explicit statement of its absence (24). The
glossary is load-bearing: report vs record vs study
disambiguates the units a flow diagram counts.

The discussion is candid about the enforcement gap: of 31 proposed
interventions to increase guideline adherence, only 11 have been
evaluated, mostly in confounded observational studies — the standard
is consensus-strong but its causal effect on reporting quality is
thinner than its citation count suggests.

## Assessment

- **Durable:** reporting as the enforceable quality surface; the
  reporting/conduct/appraisal separation; item 16b's
  excluded-with-reasons discipline; the automation-disclosure items,
  written for ML screening tools but exactly fitted to agent-run
  reviews; registration-or-say-so.
- **Era-bound:** the specific item wording (a PRISMA 2030 is the
  pattern's own prediction); the medicine-centered scope language.
- **Caveats:** effectiveness evidence is observational and mixed, by
  the authors' own accounting; checklist compliance can be performed
  without substance — the items verify presence of disclosures, not
  their honesty.
- **In this library:** the reporting phase of
  [[kitchenham2007-slr]]
  matured into an enforced, versioned artifact — and the map for the
  survey layer's deposition gate: a sys0 survey's frozen record
  should be able to answer PRISMA's items (search strategies in the
  audited logs, 16b in the disposition-coded catalog, items 8–9 as
  agent-pass disclosure, item 27 trivially by construction). The
  co-publication mechanics matter here too: the capture is the PLoS
  co-publication because the BMJ version of record blocks
  non-browser clients — multiple simultaneous DOIs for one work,
  handled as one identity with the BMJ DOI primary.
