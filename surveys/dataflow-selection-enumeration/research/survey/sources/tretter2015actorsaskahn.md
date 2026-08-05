# tretter2015actorsaskahn — Translating dataflow actors to Kahn processes

- **Status:** screened; actor-to-process translation boundary
- **Primary source:** https://doi.org/10.1109/EMSOFT.2015.7318265
- **Open author copy:** https://tik-old.ee.ethz.ch/file/00ce38fc2507d3aeab209f02f06ac7cb/07318265.pdf
- **Version read:** complete author copy
- **Bibliography key:** `tretter2015actorsaskahn`

## Evidence locations

- Section 3.1, Theorem 1: firing the same action sequence for every input
  history suffices for functional equivalence of the actor and Kahn process.
- Section 3.1, Theorems 2--4: guard prediction and safe token prefetching yield
  a correct translation when the next action is always determined.
- Sections 3.2--3.3: a finite peek-sequence-tree analysis classifies actors and
  drives automatic KPN construction; Section 4 evaluates the implementation.

## Relationship and evidence limit

This reverses the already represented Kahn-to-firing translation and adds a
guard-sensitive functional-equivalence guarantee. It translates a whole actor;
it does not enumerate requested site outcomes and their caller-input fibers or
attach general typed residuals.
