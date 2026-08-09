# guo2011interface — Dynamic interface reduction

- **Status:** deep-read; finite-interface observer analogue
- **Primary source:** https://doi.org/10.1145/2043556.2043582
- **Version read:** primary SOSP full text
- **Bibliography key:** `guo2011interface`

## Evidence locations

- Construction: the checker dynamically discovers a component's externally
  visible interface behaviors and avoids global exploration of internal
  behavior that does not propagate through that interface.
- Evaluation and scope: the discovered interface is reused during practical
  software model checking; guarantees are relative to the component boundary
  and checked behaviors.

## Relationship and evidence limit

This is a strong finite-observer analogue because internal distinctions are
discarded exactly when they cannot reach the chosen interface. It preserves
model-checking behavior rather than enumerating caller-input inverse fibers.
