# hughes2008interface — Interface grammars for modular checking

- **Status:** screened; grammar-compiled component environment
- **Primary source:** https://doi.org/10.1109/TSE.2008.72
- **Version read:** author-hosted journal full text and primary metadata
- **Bibliography key:** `hughes2008interface`

## Evidence locations

- Language and compiler: a context-free interface grammar specifies allowed
  nested method-call sequences, semantic predicates, and actions, and is
  compiled to a parser-like component stub.
- Use: the generated environment constrains exhaustive Java PathFinder model
  checking of clients without materializing the unavailable component.

## Relationship and evidence limit

The environment exposes only declared component-interface behavior, making it
a strong finite-observer analogue. Its grammar is supplied by the analyst and
does not enumerate inverse caller-input fibers or residual graph values.
