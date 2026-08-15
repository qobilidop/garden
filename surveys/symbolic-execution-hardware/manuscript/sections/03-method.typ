= Method <sec-method>

#let mapped-corpus = csv("../../record/catalog.tsv", delimiter: "\t", row-type: dictionary).filter(
  row => row.at("status") == "deep-read" or row.at("status") == "included"
)
#let map-count(target, regime) = mapped-corpus.filter(
  row => row.at("artifact") == target and row.at("execution") == regime
).len()
#let target-count(target) = mapped-corpus.filter(row => row.at("artifact") == target).len()
#let regime-count(regime) = mapped-corpus.filter(row => row.at("execution") == regime).len()

We conducted a bounded systematic map followed by critical narrative
synthesis. The public record contains the protocol, standing queries, complete
catalog, append-only search log, source notes, evidence ledger, and validator.
The design follows systematic-mapping and backward/forward-snowballing guidance
@petersen2015mapping @wohlin2014snowballing. It does not claim that every
relevant publication has been found.

== Discovery and update

No domain-specific historical cutoff was imposed. APIs were queried from 1900,
before the relevant digital-hardware literature. 17 broad active
queries were reconciled through 10 August 2026; 4 added strict-boundary
queries were reconciled on 11 August; a fifth strict Semantic Scholar query
failed that day and remains unreconciled. Critical-work citation chases were
run on 12 August, with defective directions disclosed below. OpenAlex,
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
after source aliases were collapsed.

The stricter classification also promoted a new set of works to critical.
Both citation directions were attempted for each. Index and primary-paper
chases added 161 records after overlap reconciliation. An adversarial audit
found that their initial exclusion partition had been produced by title rules;
all 161 were subsequently re-screened as individual metadata judgments. A
delta review rejected 138 still-template-shaped rationales; three reviewers
then re-adjudicated those records in bounded item batches against retained
metadata, with close cases checked against available abstracts and primary
records. The catalog now records one work-specific rationale per chase record.
The public audit record preserves the exact 138-record repair subset and the
original and final disposition fields for all 161 records.
Printed
bibliographies for the two zero-index seeds added 44 further records. No
chase-only work changed the strict include set. Forward discovery for
AutoVeriFix+ and the HLS thesis remains incomplete: the index returned no
usable forward records, and no zero-result event is treated as evidence of
coverage. Two older provenance claims were also narrowed. Carter's backward
event resolves only part of its claimed record set, and the legacy Sylvia
event's screened total lacks a complete key partition; neither is now called
complete.
The failed Semantic Scholar query remains registered and unreconciled rather
than being treated as an empty result.
Finally, 2 methodology works cited to document mapping and snowballing were
added as excluded secondary context when their local survey notes were made
self-contained. Binding the Sylvia external decision home at key level also
added 1 previously absent boundary comparator from that delegated bibliography.
The baseline and all 5 addition batches therefore sum to the 1,917-record
catalog.

== Selection and coding

The broad baseline was screened in two blinded title/abstract passes with
item-specific reasons, followed by adjudication of every decision or code
disagreement. The strict revision then re-adjudicated every previous include,
every previous parked record, and every strict-query candidate; aliases were
reconciled to existing records. A positive
decision required primary full text supporting every part of the five-part
operational test. A clear primary abstract could support exclusion; an
otherwise plausible record without decisive full text was parked. Duplicate
or superseded versions remained in the catalog under E8 so the denominator
would not silently shrink. A later provenance audit appended the keys omitted
from the original strict-reclassification event rather than rewriting history.
For historical search and chase rows that compacted away overlaps,
corrective audit rows now record every raw screened position as a canonical key,
including repeated keys when two source records collapse to one work.

Each include has one value on four substantive facets. Together they identify
the design claim, primary execution regime, sought result, and evaluation form:

#block(breakable: false)[
#set text(size: 9pt)
#figure(
  table(
    columns: (24%, 76%),
    inset: 2.5pt,
    table.header([*Facet*], [*Values*]),
    [Design target], [RTL; other HDL; HLS; SystemC/TLM; gate netlist; mixed level; generic],
    [Primary regime], [classical; concolic; selective-hybrid],
    [Goal], [functional; test coverage; security; equivalence; general],
    [Evidence], [experiment; case study; formal only; none],
  ),
  caption: [Coding facets for the strict include-level corpus.],
) <tab-facets>
]

“Deep-read” denotes the 17 load-bearing works with a local, survey-specific
source note. The remaining includes were still checked against
primary full text for eligibility but retained at mapping depth; detailed
algorithm and performance claims do not rest on them.

== Bounded map result

The catalog contains 1,917 records. Of these, 31 are include-level publication records: 17
were deep-read and 14 were retained at mapping depth. A further 59 are parked,
while 1,827 are excluded with a declared reason. The 31 include preprints and
were agent-adjudicated without item-level human screening. They are publication
records, not independent tool implementations, a population estimate, or a
mapping-closure claim.

Under the classification rule, the execution map contains 14 classical, 15
concolic, and 2 selective-hybrid works. By design target, 20 claim about RTL, 4
about SystemC/TLM, and 4 about coupled mixed-level models. The remaining
targets comprise 1 other-HDL work, 1 HLS-source work, and 1 gate-netlist work. Operational
artifacts such as generated C/C++ and lifted IR are analyzed separately because
they do not disappear behind the target label.

The cross-tabulation makes the concentration inspectable:

#figure(
  table(
    columns: (28%, 18%, 18%, 18%, 18%),
    table.header(
      [*Design target*], [*Classical*], [*Concolic*], [*Selective*], [*Total*],
    ),
    [RTL], [#map-count("rtl", "classical")], [#map-count("rtl", "concolic")], [#map-count("rtl", "selective-hybrid")], [#target-count("rtl")],
    [SystemC/TLM], [#map-count("systemc-tlm", "classical")], [#map-count("systemc-tlm", "concolic")], [#map-count("systemc-tlm", "selective-hybrid")], [#target-count("systemc-tlm")],
    [Mixed level], [#map-count("mixed-level", "classical")], [#map-count("mixed-level", "concolic")], [#map-count("mixed-level", "selective-hybrid")], [#target-count("mixed-level")],
    [Other HDL], [#map-count("hdl-other", "classical")], [#map-count("hdl-other", "concolic")], [#map-count("hdl-other", "selective-hybrid")], [#target-count("hdl-other")],
    [HLS], [#map-count("hls", "classical")], [#map-count("hls", "concolic")], [#map-count("hls", "selective-hybrid")], [#target-count("hls")],
    [Gate netlist], [#map-count("gate-netlist", "classical")], [#map-count("gate-netlist", "concolic")], [#map-count("gate-netlist", "selective-hybrid")], [#target-count("gate-netlist")],
    [*Total*], [*#regime-count("classical")*], [*#regime-count("concolic")*], [*#regime-count("selective-hybrid")*], [*#mapped-corpus.len()*],
  ),
  caption: [Primary execution regime by design target. Values are
  machine-checked against the catalog.],
) <tab-map-matrix>

The catalog itself is the canonical work-by-facet map. @sec-corpus-map renders
all 31 rows with full title, target, regime, goal, evidence class, and scrutiny
depth.

== Validity of the agent-assisted procedure

The two initial screens used related AI systems, so their errors may
be correlated; the accountable human author directed the scope but did not
perform item-level screening. Stronger adjudication, retained canonical
decisions, full-text notes for the critical set, and machine-derived counts
improve auditability but are not independent replication. The initial
classifier-produced chase partition was discarded and every affected item was
re-adjudicated from its own record; this repair strengthens traceability but
does not turn related agent judgments into independent human review.
