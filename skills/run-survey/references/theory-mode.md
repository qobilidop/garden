# Theory mode (for formal subjects)

Load this when the survey's subject is a formal problem and the
synthesis is a unified framework, not only a facet taxonomy. The
reference implementation is dataflow-selection-enumeration
(manuscript sections `sec-framework`, `sec-algorithms`, `sec-composition`,
`sec-complexity`, and `sec-synthesis`;
`record/syntheses/unified-framework/`; `record/claims.md`). Its moves:

- **Problem before solvers.** Open with a formal model of the object
  the literatures argue about, independent of any solver or data
  structure, deliberately narrowed until the task is well-defined
  (the reference isolates the finite, acyclic, deterministic, total
  case). Separate four things and keep them separate throughout: the
  observer (what is asked), its fibers (the semantic object), the
  discovery algorithm, and the output representation — mechanism and
  representation are orthogonal to the object.
- **Coordinates plus equivalence theorems.** Give each literature's
  native object a coordinate in the framework and prove the
  coordinates induce the same partition. The equivalence results are
  what license cross-literature comparison — without them "the same
  problem" is an analogy, not a theorem.
- **Relationship taxonomy.** Classify every compared work's relation
  to the target problem — direct presentation / restricted
  specialization / adjacent comparator — with any instrumentation or
  quotient stated explicitly. Never silently transfer a theorem
  across an observer change; framework-induced misclassification is
  a named validity threat, not just a risk.
- **Contract decomposition.** Split the target guarantee into
  independent obligations (the reference: coverage, guard–fiber
  equivalence, residual correctness, witness) and assess each work
  per-obligation. No approach inherits all obligations from its
  name; similar output syntax can hide different semantics.
- **Novelty as hypothesis.** Every synthesis claim lives in a claims
  ledger with status, explicit `Scope`, anchored evidence, and its
  closest established result (`Prior frontier`); a claim is never
  novel merely because no contradicting paper surfaced. A settled
  claim's terminal status records how novelty resolved —
  `survey synthesis; <qualifier>` (broad novelty defeated, formal
  derivation recorded, implementation claim rejected, organizing
  terminology). Run an adversarial reduction audit
  (reduce each tempting "new" statement to the nearest established
  construction) and keep a counterexamples file of small models that
  falsify overclaims. A rejected hypothesis stays in the ledger as a
  guardrail until its reduction is argued in the manuscript — then
  it retires to git history, the manuscript itself becoming the
  guardrail. Label every theorem prior work / direct derivation /
  local synthesis.
- **Record layer.** `record/syntheses/unified-framework/` is the formal
  workspace — model, semantics, derivations, complexity notes,
  counterexamples, reduction audit, open questions — beside the
  thematic syntheses and the adopted terminology
  (`syntheses/terminology.md`); the standard `claims.md` and
  `evidence.md` carry the assertions and their bindings. Changes
  propagate understanding layer → ledger → manuscript, never
  manuscript-first.
- **Manuscript additions.** The framework section uses the shared
  statement apparatus (`surveys/style.typ` definitions/theorems,
  target-aware for HTML); the terminology maps each literature's
  native vocabulary onto framework terms (a "known as" list per
  concept); complexity claims name their charge model — oracle-call
  accounting is not an output-sensitivity theorem.

Theory mode refines, not relaxes, the no-research rule: definitions
and connecting theorems are contributed as a unifying lens, and
anything that could read as a novel result must survive the
reduction audit first.
