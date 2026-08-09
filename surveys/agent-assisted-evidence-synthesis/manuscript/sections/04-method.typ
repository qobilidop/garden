= How This Survey Was Made <sec-method>

The survey was compiled with LLM-agent assistance under human
direction: agent passes performed search, screening, classification,
and deep reading; the author set the protocol, approved the scheme,
and gated every stage. Eleven logical queries ran against OpenAlex,
Crossref, Semantic Scholar, and arXiv (window 2020-01-01 to
2026-08-08, English); ten succeeded and one Semantic Scholar query
ended in a persistent 429. Results were relevance-sorted with a cap of
50 records. Review-side vocabulary such as "systematic review" and
"evidence synthesis" was paired with model-side vocabulary spanning
LLMs, agents, automation, AI, and ML.

The first 412 candidates received two agent screening passes with
adjudication. A single backward+forward snowball round @wohlin2014 then
used a title-vocabulary pre-filter; its 881 retained candidates received
one screening pass and a verification pass over included decisions. The
wave was not iterated to saturation. Facets were assigned once from
truncated abstracts. A post-campaign integrity pass resolved 24
version/duplicate rows and removed two retracted works, leaving 646
included works; this corrected classified catalog is the map.
@tab-funnel separates the historical campaign funnel from the current
record.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, right, right),
    table.header([Phase], [In], [Out]),
    [Search (11-query set; 10 succeeded)], [—], [419 unique],
    [Dedup (arXiv–DOI)], [419], [412],
    [Dual-pass screen + adjudication], [412], [139 includes],
    [Snowball round (pre-filtered)], [139 seeds], [1,204 new],
    [Vocabulary pre-screen], [1,204], [881],
    [Wave-2 screen + verification], [881], [533 includes],
    [Campaign close], [1,291 rows], [672 included rows],
    [Integrity correction], [672 included rows], [*646 works*],
    [Current unresolved park], [646 non-included rows], [12 U rows],
    [Facet classification], [646], [the map],
    [Deep reads], [646], [25 notes],
  ),
  caption: [Identification and selection funnel. Phase quantities are
    retained historical aggregates: candidate-level wave/source
    provenance was pruned and cannot regenerate them. The 323
    vocabulary rejects were not cataloged; two of 881 screened rows
    merged on entry (412 + 879 = 1,291). The integrity pass resolved 24
    version aliases and removed two retracted works. A later publication
    migration leaves the current identifier ledger at 1,292 rows.],
) <tab-funnel>

25 works were selected facet-guided for deep reads as candidate
anchors: 20 read in full text, 5 abstract-only (one with no
retrievable text at all, reconstructed secondhand). 23 of the 25
cleared the curation bar and anchor the reading list and the
citations below; citations resting on abstract-only evidence carry
an "abstract-only" marker. The survey record linked in the title note
holds the update contract, search-attempt log, corrected catalog, and
per-work evidence notes. It is a minimal public record; process history
remains in git.
