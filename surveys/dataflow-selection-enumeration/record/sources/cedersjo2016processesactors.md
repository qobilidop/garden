# cedersjo2016processesactors — Translating Kahn processes to firing actors

- **Status:** screened; cross-style dataflow translation
- **Primary source:** https://doi.org/10.1109/SAMOS.2016.7818327
- **Open author copy:** https://www.sjalander.com/research/mcc2016/MCC2016_paper_7.pdf
- **Version read:** complete author copy
- **Bibliography key:** `cedersjo2016processesactors`

## Evidence locations

- Program-model comparison: Kahn processes and firing-based dataflow actors
  expose different execution structure.
- Semantic construction: firing is introduced into the process account so the
  two styles can be related.
- Translation result: the paper gives meaning-preserving transformations from
  Kahn processes to dataflow with firing.

## Relationship and evidence limit

The work sharpens the process-versus-actor program-model boundary. Its goal is
whole-program semantic preservation, not enumerating requested firing outcomes
and exact inverse regions over caller inputs.
