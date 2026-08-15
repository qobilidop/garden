= How This Survey Was Made <sec-method>

Agent passes performed search, screening, classification, and deep
reading under an author-set protocol and human gates. The title-page note owns
the authorship, assistance, evidence-use, and public-record disclosure; this
section records only the procedure and its limits.

== Coverage and selection

The map covers English-language work from 2020 through 2026. Searches ran
against OpenAlex, Crossref, Semantic Scholar, and arXiv, relevance-sorted and
capped at 50 results per query. The initial eleven-query set had ten successful
queries; a later seventeen-query set added mapping-study, scoping-review, and
living-evidence vocabulary and had sixteen successful queries. The standing
searches center language models. Broader AI, ML, deep-learning, and automation
work entered through initial screening vocabulary and citation chasing, so the
retained map is LLM-centered rather than a comprehensive automation
denominator.

The initial 412 candidates received two screening passes with adjudication.
One backward and forward citation round @wohlin2014 then used a title-vocabulary
pre-filter; the 881 retained candidates received one screening pass plus a
verification pass over includes. The later batch screened 585 candidates with
an eligibility-first and an exclusion-first pass, adjudication, and a human
gate. Twelve designated critical works were chased in both directions. Three
defective backward-index results were replaced by publisher-deposited reference
lists. The searches and chases were not iterated to saturation.

== Coding and evidence

Every include received one primary-focus value on each taxonomy dimension from
a truncated abstract. The coding was single-pass and unvalidated. Thirty-one
works were selected purposively for evidence notes to cover the research
questions, taxonomy contrasts, closest prior maps, quantitative anchors,
disclosure instruments, and multi-model designs. Selection was iterative, with
no fixed score, random sample, or saturation rule. Twenty-five notes are
full-text, five abstract-only, and one secondary-only; the secondary-only note
supports no finding. The catalog's evidence facet records the comparison a work
claims or plans, not study quality and not confirmation that the comparison was
completed.

The record retains the exact standing queries, current dispositions, source
notes, syntheses, claim/evidence bindings, and an append-only event log. It does
not retain unfiltered result sets, departing from Kitchenham and Charters'
save-for-reanalysis guidance @kitchenham2007. Historical campaign phases survive
only as reconciled aggregates because candidate-level provenance was pruned;
later rows carry decided keys. Seventy-six catalog rows remain parked for
re-screening on a future update.

@tab-campaign and @tab-funnel separate retained historical aggregates from the
candidate-level later batch. Their quantities describe this record, not
retrieval completeness.

#figure(
  text(size: 8.5pt)[
    #table(
      columns: (auto, auto, auto),
      align: (left, right, right),
      table.header([Campaign phase], [In], [Out]),
      [Search (11-query set; 10 succeeded)], [—], [419 unique],
      [Dedup (arXiv–DOI)], [419], [412],
      [Dual-pass screen + adjudication], [412], [139 includes],
      [Snowball round (pre-filtered)], [139 seeds], [1,204 new],
      [Vocabulary pre-screen], [1,204], [881],
      [Wave-2 screen + verification], [881], [533 includes],
      [Campaign close], [1,291 rows], [672 included rows],
      [Integrity correction], [672 included rows], [646 works],
    )
  ],
  caption: [Historical campaign funnel through 2026-08-08. Quantities are
    reconciled aggregates because candidate-level provenance was pruned.],
) <tab-campaign>

#figure(
  text(size: 8.5pt)[
    #table(
      columns: (auto, auto, auto),
      align: (left, right, right),
      table.header(
        repeat: true,
        [Update and current ledger], [In], [Out],
      ),
      [Search (17-query set; 16 succeeded)], [—], [517 rows],
      [Critical-set chases (24 + 3 primary)], [12 seeds], [1,191 rows],
      [Vocabulary pre-screen (chase rows)], [1,191], [595 retained],
      [Dedup, enrichment, park], [1,112], [585 screened],
      [Dual-pass screen + adjudication], [585], [132 includes],
      [Date-rule coding (primary chases)], [41], [39 before-window],
      [Integrity (aliases, artifacts)], [26 rows], [13 E6, 13 dropped],
      [*Current catalog*], [1,975 rows],
        [*776 include-level; 1,123 excluded; 76 parked*],
      [Post-ledger outputs], [776], [facet map; 31 evidence notes],
    )
  ],
  caption: [Candidate-level update through 2026-08-09, recoverable from the
    event log. Its 132 include decisions produced 130 new include-level rows
    after one rediscovery and one deep-read reclassification.],
) <tab-funnel>
