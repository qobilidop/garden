# Survey log grammar

Open this reference before writing, repairing, or validating `record/log.tsv`.
The TSV uses RFC 4180 quoting with a tab delimiter; parse it with a CSV-aware
reader, never `awk`, `cut`, or a line loop that treats quoted tabs as columns.

Semicolons delimit `notes` markers and commas delimit keys inside a marker.
The shared engine owns these markers:

- `seed-key:<key>` binds a snowball event to its critical work;
  `primary-complete` records fallback to the printed bibliography, while
  `discovery-only` excludes a defective or surrogate direction from critical
  chase completion.
- `parked-keys:<keys>` and `overlap-keys:<keys>` complete the screened-position
  partition without treating unresolved or duplicate positions as new works.
- `promoted-key:<key>`, `superseded-key:<key>`, and
  `reclassified-key:<key>` are audit-only disposition transitions.
- `repairs-marker-grammar:<event-id>` lets an appended audit replace
  machine-inert marker-shaped prose in one uniquely named earlier event. The
  target must actually contain a malformed boundary, and the corrective row
  must reproduce its exact disposition-marker keys with correct delimiters;
  the historical row is not rewritten.
- `catalog-additions:<N>` records the exact net rows added by an audit batch;
  baseline funnel plus all such additions must equal the live catalog.
- `decision-partition` marks a batched audit whose ordinary decision columns
  enumerate its checkpoint dispositions. `rationale_unique` is an opt-in
  forensic validator for a known template-corrupted batch, never a general
  screening-quality rule: distinct works can legitimately share a rationale.
- `partition-for:<event>` plus `screened-keys:<keys>` repairs a historical raw
  position partition. Repeated keys are retained when multiple positions
  collapse to one work; `coverage-incomplete` declares an unrecoverable
  remainder. A later repair names the prior audit with
  `supersedes-partition:<audit-id>`; both rows remain history, and the later one
  controls validation.
- `external-decision-home:<repo-path>#<event>` delegates the partition to a
  public log event. The validator checks the file, selected event, denominator,
  and local key set. An incomplete external partition also requires
  `coverage-incomplete`.

An event selector is `date|kind|id|direction`, optionally followed by the exact
`query_or_seed` field when a batch id still collides. A bare id is accepted only
for legacy logs where it resolves to exactly one row. Standing query and batch
ids may recur, so every new cross-event binding uses the shortest composite
form that resolves exactly once.

An `exploratory` event includes the literal `not-recorded` token to make clear
that it did not enter the catalog. A backward event whose notes say
`unresolved`, `index omits`, `exposes no references`, `wrong-version`,
`primary list is longer`, `incomplete bibliography`, or `truncated
bibliography` is treated as a defective index seed: it needs `seed-key` and a
corresponding `primary-complete` fallback. These phrases are engine-owned
because they trigger validation, not merely narrative conventions.

A search or snowball row keeps the decision made at its checkpoint. Later
evidence appends a key-bearing audit and updates the catalog; it never rewrites
the old row. Audit contracts likewise describe their checkpoint and permit a
later `reclassified-key` to supersede their final fields.
