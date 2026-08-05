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
  query, hit count, screened count, and frozen source-dependent metadata result
  set; abstracts are retained when the source exposes them.
- Index citation neighborhoods are checked against the primary bibliography;
  unresolved or truncated backward results are supplemented by a complete
  primary-reference snapshot and cannot independently establish closure.
- The bounded closest-work snowballing seed set is exactly the catalog entries
  marked `priority=critical` and is read from primary papers rather than index
  abstracts. The broader comparison table also contains comparison-only
  boundaries. Technical claims carry page, section, definition, theorem, or
  algorithm anchors in source notes.
- Final no-add queries and the rule that reopens the map were predeclared.
- Three separate agent passes duplicate-screened every logical record in each
  final closure round and audited the query, file, and anomaly counts before
  the map was called closed.

At the archived snapshot, the catalog has 897 entries, of which 201 are marked
deep-read. The audited log contains 318 database-query rows and 245 separately
recorded backward or forward citation chases. Excluding duplicate adjudication
passes, those rows account for 35,720 screened record occurrences; occurrence
counts are not unique-paper counts. Eighty-three claim-evidence rows connect
manuscript statements to primary-source notes.

## Threats that remain

**Selection reliability.** Initial extraction uses one primary agent. Later
closure rounds were duplicate-screened in full by three separate agent passes,
but all agents worked from the same project framing and were not independent
human review teams. No human inter-rater calibration or agreement statistic was
performed. The duplicated passes expose disagreements and mechanical omissions
but remain weaker than a conventional multi-reviewer study.

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
