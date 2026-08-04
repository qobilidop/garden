# li2025llm — Large Language Model Powered Symbolic Execution

- **Status:** deep-read; finite path-set partition comparator
- **Primary source:** https://doi.org/10.1145/3763163
- **Version read:** author-hosted OOPSLA 2025 PDF, pp. 3148--3176
- **Bibliography key:** `li2025llm`

## Why it matters

The idealized method partitions program paths by finite coverage sets, derives
a property slice for each partition, and lets one truncated slice generalize a
possibly infinite family of loop paths. The number of coverage sets is finite,
so the decomposition terminates even for unbounded loops.

## Evidence locations

- Sections 2--3: path-set decomposition, coverage partition, and slice
  construction.
- Section 3.3: finite coverage-set argument and loop generalization.
- Sections 4--6: AutoBug design and empirical evaluation.
- Threats and discussion: the LLM is an approximate oracle and can return
  incorrect verification judgments.

## Relationship and evidence limit

The finite structural partition and property-directed slices are relevant
precedent for path-family omission. Because the practical oracle is explicitly
approximate, the method does not provide exact observer-fiber enumeration or a
sound exhaustive residual partition.
