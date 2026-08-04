# pingali1985efficient — Efficient Demand-Driven Evaluation. Part 1

- **Status:** deep-read
- **Primary source:** https://hdl.handle.net/1721.1/149052
- **Version read:** MIT-LCS-TM-242 full report; article metadata checked by DOI
- **Bibliography key:** `pingali1985efficient`

## Why it matters

Pingali and Arvind already give a local, structure-directed reverse-demand
transformation for stream dataflow graphs and prove its correctness and
parsimony compositionally. “Demand propagation” and “minimal demanded
computation” are therefore unsafe novelty claims.

## Model and algorithm

Section 2.1 defines recursive stream graphs over the prefix cpo, with pointwise
operators, `first`, `rest`, `cons`, Boolean gates, and `merge` (report pp.
5--8). A demand stream marks each requested token position. Algorithm MDP adds
a reverse demand edge for every data edge and transforms each primitive so
that only demanded data values pass (Section 2.3, pp. 11--16).

The local transformed primitives satisfy correctness, demand-constraint,
liveness, and parsimony properties P1--P4. Theorem 2 proves that these
properties are invariant under juxtaposition and iteration (pp. 18--28).
`parallel-or` violates parsimony, so the construction deliberately excludes
nonsequential alternatives to a least computation (p. 22).

## Complexity and relationship

The paper gives no asymptotic time or space theorem. It observes that
microscopic propagation sends one demand per produced value, traverses
operators individually, can reduce parallelism, and still needs fair
scheduling for infinite histories.

The work computes one demanded evaluation for fixed inputs. It neither
enumerates the range of a selection-observation projection over symbolic
inputs nor constructs exact observation fibers and residuals. That change in
quantification is the surviving separation.

## Evidence locations

- Section 2.1, report pp. 5--8: language and stream semantics.
- Section 2.3, pp. 11--16: MDP and reverse demand streams.
- Section 2.5, pp. 18--28: P1--P4, primitive lemma, and composition theorem.
- Page 22: `parallel-or` limitation.
