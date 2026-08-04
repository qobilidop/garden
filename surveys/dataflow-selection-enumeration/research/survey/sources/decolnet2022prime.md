# decolnet2022prime — On the Complexity of Enumerating Prime Implicants from Decision-DNNF Circuits

- **Status:** deep-read
- **Primary source:** https://www.ijcai.org/proceedings/2022/0358.pdf
- **Version read:** official IJCAI 2022 proceedings paper
- **Bibliography key:** `decolnet2022prime`

## Why it matters

The paper provides rigorous OutputP and IncP comparison points and prevents
informal solver-call counting from being mislabeled output-sensitive runtime.

## Enumerated object

The input is an already compiled decision-DNNF. The outputs are all prime
implicants of its Boolean function: subset-minimal cubes entailing the
function. Prime implicants need not be disjoint, need not form a partition, and
can outnumber satisfying assignments.

## Complexity definitions and results

Page 2585 defines EnumP, OutputP, IncP, and the `AnotherSol` problem. For an
EnumP relation, incremental polynomial time is equivalent to solving
`AnotherSol` in polynomial time (Proposition 1).

Proposition 7 places prime-implicant enumeration from decision-DNNF in OutputP.
Propositions 10–11 find another prime implicant or prove completeness in time
polynomial in the circuit and prior output set; Proposition 12 yields IncP
(pp. 2586–2587). This is not a polynomial-delay theorem.

The compiled decision-DNNF is the input. The result does not charge potentially
exponential compilation from CNF or program syntax.

## Relationship to our hypothesis

Observation records are not immediately an EnumP relation: feasibility of an
observation is generally NP-hard, and checking exact fiber guards and residual
equivalence may be stronger. Adding arbitrary witnesses creates many records
per observation unless a canonical witness is defined. Any complexity
classification is therefore likely oracle-relative and requires a formal
output-verification model; ordinary IncP does not follow from the current
enumerator.

## Evidence locations

- Page 2585: enumeration classes and `AnotherSol`.
- Propositions 7 and 10–12, pp. 2586–2587: OutputP and IncP results.
- Proposition 16, p. 2589: a restricted case linked to hypergraph transversals.
