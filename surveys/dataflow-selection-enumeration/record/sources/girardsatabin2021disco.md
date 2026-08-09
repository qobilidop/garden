# girardsatabin2021disco — DISCO Verification

- **Status:** deep-read
- **Primary source:** https://arxiv.org/abs/2105.07776
- **Bibliography key:** `girardsatabin2021disco`

## Result and limitation

The paper collects relevant facets and their linear functions to represent all
possible network behaviors (PDF p. 6). Algorithm 1 returns a set of linear
problems describing all feasible facets (p. 7). The graph representation
supports matrix multiplication, convolution, and pooling.

DISCO is close exact dense activation enumeration following Serra, but gives no
new formal completeness theorem or output bound. Every ReLU remains assigned;
there is no demanded-site omission.
