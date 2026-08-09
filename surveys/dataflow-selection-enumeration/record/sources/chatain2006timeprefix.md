# chatain2006timeprefix — Symbolic complete prefixes for safe time nets

- **Status:** screened; timed symbolic complete-prefix boundary
- **Primary source:** https://doi.org/10.1007/11767589_8
- **Author-hosted full text:**
  https://lsv.ens-paris-saclay.fr/Publis/PAPERS/PDF/Chatain-Jard_ICATPN06.pdf
- **Version read:** full ICATPN 2006 paper, pp. 125--145
- **Bibliography key:** `chatain2006timeprefix`

## Evidence locations

- Section 2 fixes safe time Petri nets with rational earliest and latest firing
  delays and assumes time-divergent infinite executions. Processes retain the
  causality and concurrency hidden by a global interleaving state-class graph.
- Section 3 defines a concurrent local-firing semantics using partial states
  and read arcs. Theorem 1 proves the local firing condition correct, and
  Theorem 2 proves it complete with respect to ordinary timed processes.
  Definition 11 superimposes extended processes into the symbolic unfolding;
  Theorems 3--4 characterize its finite extended processes and possible event
  extensions.
- Section 4 quotients temporally complete states by marking and reduced token
  ages. Theorem 5 proves equivalent consistent states have matching future
  firings, and Theorem 7 proves that only finitely many reduced-age predicates
  arise for each maximal marking.
- Definition 16 constructs the finite prefix by cutting an extended process
  when its reduced-age predicate has already occurred at a shorter process.
  The finiteness argument bounds retained process length by the finite number
  of such predicates.
- Theorem 8 supplies the completeness statement: every temporally complete
  extended process decomposes by prefix substitution into processes represented
  in the finite prefix. The paper reports a prototype but leaves adequate-order
  refinements and broader verification development open.

## Relationship and evidence limit

This provides a finite exact partial-order representation of dense-time
behavior without enumerating arbitrary interleavings, under the paper's safe
time-net and timing assumptions. Its equivalence classes summarize net
markings and token ages, and its residual object is a continuation of timed
process behavior. It neither partitions caller inputs by a requested internal
selection event nor pairs every exact inverse fiber with a typed residual
function.
