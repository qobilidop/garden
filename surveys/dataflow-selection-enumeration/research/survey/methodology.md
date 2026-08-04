# Mapping-study methodology and validity record

The study is a systematic **map**, not a systematic literature review. Its
purpose is to classify semantic objects, algorithms, omission mechanisms, and
guarantees across several neighboring research communities; it does not pool
empirical effect sizes. The protocol follows Petersen et al.'s distinction
between mapping and review, Wohlin's separate backward/forward snowballing
procedure, and the SEGRESS emphasis on reporting enough of a secondary study
to audit its selection process.

## Measures implemented in the repository

- Research questions, search clusters, inclusion criteria, and stable
  exclusion codes were written before closure was claimed.
- Exploratory, non-replayable searches are separated from audited searches and
  explicitly marked `not-recorded`.
- Every audited database query and citation direction has an exact seed or
  query, hit count, screened count, and frozen title-level result set.
- Index citation neighborhoods are checked against the primary bibliography;
  unresolved or truncated backward results are supplemented by a complete
  primary-reference snapshot and cannot independently establish closure.
- The bounded closest-work set is read from primary papers rather than index
  abstracts. Technical claims carry page, section, definition, theorem, or
  algorithm anchors in source notes.
- Final no-add queries and the rule that reopens the map were predeclared.
- A reviewer who did not choose those queries must sample exclusions and audit
  the closure record before the map is called closed.

## Threats that remain

**Selection reliability.** Initial screening and extraction use one primary
screener. An independent audit can detect systematic omissions but is weaker
than duplicate human screening with inter-rater agreement. The manuscript must
state this limitation rather than imply a conventional two-reviewer study.

**Index coverage and metadata quality.** OpenAlex omits some bibliographies,
leaves referenced identifiers unresolved, conflates versions, and sometimes
assigns an incorrect DOI. Crossref searches broad bibliographic metadata and
can return very noisy rankings. Frozen snapshots expose these failures, but do
not repair missing records. The neural-decision-diagram forward audit also
produced different counts in Crossref, OpenAlex, OpenCitations, and Semantic
Scholar. The largest stable snapshot was screened, but index disagreement
precludes a complete-forward-neighborhood claim. Primary publisher or author
sources control the technical and bibliographic claims.

**Vocabulary drift.** The map crosses symbolic execution, term graphs,
hardware simulation, demand semantics, event structures, decision diagrams,
and model enumeration. No finite query vocabulary can guarantee recall across
all of them. Citation chasing from a deliberately heterogeneous critical set
and synonym-expansion rounds mitigate this threat.

**Temporal validity.** Mapping closure is relative to the recorded query date
and databases. A later work or a newly exposed cluster reopens the map.

**Synthesis bias.** The formal framework is an interpretive bridge among prior
objects. Every equivalence must distinguish a theorem proved in a cited work
from a derivation obtained after our instrumentation or change of observer.
