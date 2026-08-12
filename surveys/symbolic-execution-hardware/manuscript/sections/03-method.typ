= Method <sec-method>

We conducted a bounded systematic map followed by critical narrative
synthesis. The public record contains the protocol, standing queries, complete
catalog, append-only search log, source notes, evidence ledger, and validator.
The design follows systematic-mapping and backward/forward-snowballing guidance
@petersen2015mapping @wohlin2014snowballing. It does not claim that every
relevant publication has been found.

== Discovery and update

No domain-specific historical cutoff was imposed. APIs were queried from 1900,
before the relevant digital-hardware literature. Standing searches closed on
11 August 2026 and critical-work citation chases on 12 August 2026. OpenAlex,
Crossref, arXiv, and Semantic Scholar searches
combined *symbolic execution*, *dynamic symbolic execution*, *concolic*,
*path condition*, and *path constraint* with RTL, Verilog, SystemC, HLS,
processor, hardware security, and hardware verification terms. Backward and
forward citation searches supplemented database discovery. When an index
omitted a plausible bibliography, the primary paper's reference list was
screened.

The initial broad campaign reconciled 1,262 deduplicated database-search records,
273
chase-only records, 41 Carter-lineage records, 48 Forbench bibliography
records, and 2 directly inspected primary additions, yielding a baseline of
1,626. After the scope was narrowed, the revision attempted 5 boundary-focused queries:
4 returned result sets, and 1 failed with HTTP 429. The four successful
exports and two primary-version additions contributed 83 new catalog records
after five source aliases were collapsed.

The stricter classification also promoted nine works into the critical set.
Both citation directions were run for each. After overlap reconciliation,
those chases added 161 records: 159 were excluded and 2 remained parked because
complete primary text was unavailable. No chase-only work changed the strict
include set.
The failed Semantic Scholar query remains registered and unreconciled rather
than being treated as an empty result.

== Selection and coding

The broad baseline was screened in two blinded title/abstract passes with
item-specific reasons, followed by adjudication of every decision or code
disagreement. The strict revision then re-adjudicated all 87 previous includes,
all 38 previous parked records, and 86 strict-query candidates, five of which
were aliases of existing records. A positive
decision required primary full text supporting every part of the five-part
operational test. A clear primary abstract could support exclusion; an
otherwise plausible record without decisive full text was parked. Duplicate
or superseded versions remained in the catalog under E8 so the denominator
would not silently shrink.

Each include has one value on four substantive facets:

#figure(
  table(
    columns: (19%, 37%, 44%),
    [*Facet*], [*Values*], [*Interpretive question*],
    [Artifact], [RTL; other HDL; HLS; SystemC/TLM; gate netlist; mixed level; generic], [What design representation actually executes?],
    [Execution], [classical; concolic; selective-hybrid], [How are path predicates related to execution?],
    [Goal], [functional; test coverage; security; equivalence; general], [What result is sought?],
    [Evidence], [experiment; case study; formal only; none], [How is the contribution evaluated?],
  ),
  caption: [Coding facets for the strict include-level corpus.],
) <tab-facets>

“Deep-read” denotes the 17 load-bearing works with a local or declared
external evidence note. The remaining includes were still checked against
primary full text for eligibility but retained at mapping depth; detailed
algorithm and performance claims do not rest on them.

== Bounded map result

The catalog contains 1,870 records. Of these, 31 are include-level records: 17
were deep-read and 14 were retained at mapping depth. A further 59 are parked,
while 1,780 are excluded with a declared reason. These are publication records,
not independent tool implementations and not a population estimate.

The execution map contains 14 classical, 11 concolic, and 6 selective-hybrid
works. By artifact, 20 execute RTL, 4 execute SystemC/TLM, and 4 execute coupled mixed-level models.
The remaining 3 are one each for another HDL, an HLS source, and a gate
netlist. This concentration supports an RTL-centered title while exposing the
semantic edges of the scope.

== Threats to validity

Terminology is the main discovery threat: relevant papers may say test
generation or formal simulation, while unrelated papers may adopt symbolic-
execution language. Multi-index searches, citations, and mechanism review
reduce but cannot remove this risk. One strict Semantic Scholar query failed;
the overlapping concepts were searched elsewhere, but unique records may
remain missing.

Full-text inclusion reduces false positives at the cost of false negatives
when old or inaccessible texts cannot be obtained. Fifty-nine such or
otherwise unresolved records are parked. The operational boundary is also a
researcher judgment. To make it falsifiable, every include has an item-specific
rationale and every close negative has a named failed condition.

Finally, the two initial screens used related AI systems, so their errors may
be correlated; the accountable human author directed the scope but did not
perform item-level screening. Stronger adjudication, complete decision logs,
full-text notes for the critical set, and machine-derived counts improve
auditability but are not independent replication.
