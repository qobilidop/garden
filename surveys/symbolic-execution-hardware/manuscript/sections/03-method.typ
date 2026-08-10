= Method <sec-method>

We conducted a systematic mapping campaign followed by a critical narrative
synthesis. The protocol was frozen before screening, following established
guidance on systematic maps and separate backward/forward snowballing
@petersen2015mapping @wohlin2014snowballing. The complete protocol, standing
queries, catalog, decision log, evidence notes, and validator are published in
the linked survey record. This manuscript reports a dated bounded map, not an
unqualified claim that every relevant publication has been found.

== Discovery

The search used no domain-specific historical cutoff and closed on 10 August 2026.
The APIs were explicitly queried from 1900, decades before the earliest
relevant digital-hardware work located by the campaign. We attempted 22
standing queries across OpenAlex, Crossref, arXiv, and Semantic Scholar; 21
returned result sets and 1 failed.
Queries combined the core terms *symbolic execution* and *concolic* with
hardware, RTL, Verilog, SystemC, processors, security, and HLS. Separate
lineage queries used *symbolic simulation* and *symbolic trajectory
evaluation*. Results were normalized to DOI, arXiv, or title keys and
deduplicated before screening. One Semantic Scholar lineage query repeatedly
returned HTTP 429 and is recorded as failed rather than silently counted; its
topic was also targeted by the other three indexes and citation chasing.

Every critical work was chased backward and forward. Citation-index snapshots
were supplemented with a primary bibliography when an index was empty,
truncated, or failed to resolve a plausible reference list. Citation-derived
records underwent the same two-pass screening as database results. Search
depths and every reconciliation date are preserved in the machine-readable
record.

== Selection and adjudication

Two blinded agent screens judged every title/abstract record in separate
contexts using different prompts and model tiers. One pass was exclusion-first;
the other favored recall. Each decision carried an item-specific reason.
Agreement did not
automatically make a symbolic-simulation paper part of the lineage: final
inclusion still applied the protocol's selective-lineage rule and consolidated
duplicate versions. A third, stronger adjudication pass resolved every
decision or exclusion-code disagreement from the record itself. Ambiguous but
plausible records remained parked rather than forced into a binary decision.

At the initial checkpoint, the reconciled flow was 1,262 deduplicated
database-search records, 273
chase-only records, 41 Carter-lineage records, 48 Forbench bibliography
records, and 2 directly inspected primary additions: 1,626 baseline catalog
records. Suspected aliases and superseded versions remain cataloged under E8,
rather than disappearing from the denominator. Every search and chase row in
the retained log names its decided keys; staged result files are discarded
after reconciliation and can be regenerated only by rerunning the dated query.

The inclusion unit is a primary technical contribution. A work enters when a
digital hardware design is operationally executed over symbolic values,
states, traces, or path conditions, or when it is a selected lineage or direct
comparator necessary to interpret that core. The nine exclusion codes separate
software-only execution, formal hardware without execution, nonselected
symbolic simulation, analog or post-silicon work, hardware acceleration of
software analysis, wrong artifacts, secondary/insubstantial records,
duplicates, and retractions.

== Coding and evidence

Included works were coded on five facets:

#figure(
  table(
    columns: (18%, 32%, 50%),
    [*Facet*], [*Values*], [*Question answered*],
    [Relation], [core; lineage; comparator], [Why is the work in this survey?],
    [Artifact], [RTL; other HDL; HLS; SystemC/TLM; netlist; mixed; generic], [What representation is executed?],
    [Execution], [path; concolic; fragments; symbolic simulation; STE; hybrid], [Where do alternatives live?],
    [Goal], [functional; coverage; security; equivalence; general], [What verification objective is served?],
    [Evidence], [experiment; case study; formal only; none], [How is the method supported?],
  ),
  caption: [Survey coding facets.],
) <tab-facets>

Critical works were read in full where available, summarized on a common
evidence template, and tied to claims through page- or section-level anchors.
Abstract-only notes support chronology and scope, not algorithmic or
performance claims. Existing canonical notes elsewhere in the same public
library were reused by explicit exemption rather than copied. Counts are
derived only from the catalog; interpretive claims are registered separately
from evidence records so that prose cannot silently become a new source of
fact.

== Map result

The catalog contains 1,626 records. Of these, 87 are include-level records: 11
were deep-read as the critical set and 76 were retained at mapping depth. A
further 38 are parked for a future update, while 1,501 are excluded with a
declared reason. The include-level set consists of 65 core works, 11 selective
lineage works, and 11 direct comparators.

RTL is the center rather than the whole boundary: 55 included records execute
RTL, compared with 12 SystemC/TLM and 7 mixed-level records. The remaining 13
span other HDLs, HLS, netlists, and representation-generic methods. The
execution coding also resists a single-algorithm account: 26 works are
path-oriented, 20 concolic, 19 hybrid, and 17 symbolic-simulation systems; the
small remainder use explicit fragments or STE. These are publication counts,
not independent tool counts, and they describe the bounded map rather than a
population estimate.

== Threats to validity

Terminology is the largest discovery threat. Older work may say symbolic
simulation, formal simulation, test generation, or trajectory evaluation
without saying symbolic execution; newer work may use the fashionable term
for what is primarily BMC or fuzzing. Multi-index searching and citation
chasing reduce but cannot eliminate this risk. The selective lineage rule is
also a judgment: it intentionally sacrifices coverage of STE and symbolic
simulation to keep the core survey usable.

Metadata quality creates duplicate and missing-abstract risk, especially for
early proceedings. Blinding the two agent passes prevents direct decision
leakage, but both used related OpenAI systems and their errors may be
correlated; adjudication was another model pass, not an independent human
review. The accountable human approved the title, RTL-centered scope, HDL/HLS
admission, lack of a domain-specific historical cutoff, and autonomous release
workflow, but did not inspect item-level decisions. The catalog retains reasons
and superseded versions. Full texts were unavailable for some recent or old
works; those records cannot support fine-grained claims. Finally, the closing
date reaches into a fast-moving 2026 preprint landscape. Mutable relevance
rankings, discarded staging sets, and the failed query mean that this is a
traceable, rerunnable bounded snapshot, not a bit-for-bit reproducible export or
permanent census.
