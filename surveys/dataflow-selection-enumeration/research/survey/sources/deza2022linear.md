# deza2022linear — rational zonotope-vertex traversal

- **Status:** deep-read; high-priority bit-model qualification, not a new
  central-arrangement frontier
- **Primary source:** https://doi.org/10.1016/j.comgeo.2021.101809
- **Open copy:** https://arxiv.org/abs/1912.02439
- **Version read:** final journal framing, with the arXiv text used for stable
  theorem and page pinpoints
- **Bibliography key:** `deza2022linear`

## Version-sensitive contribution

The 2022 journal article treats generator-to-vertex enumeration as known and
includes it for self-containment. Its stated new contributions are the inverse
problem of recognizing and reconstructing a zonotope from vertices and the
greatest-zonotopal-summand computation. The 2019 arXiv-v1 introduction instead
lists the forward traversal as a contribution; the final journal framing is
authoritative.

## Exact object and traversal

The input is a canonical set (G=\{g_1,\ldots,g_Q\}\subset\mathbb Q^D) of
nonzero, pairwise noncollinear generators of a full-dimensional zonotope. The
output is its set of (K) vertices. Each vertex retains the unique generator
subset whose sum is that vertex; through zonotope/central-arrangement duality,
this subset implicitly gives one dense strict chamber sign vector.

Starting at zero, the algorithm considers adding each unused generator. It
admits an addition exactly when that generator spans a ray of the pointed
signed cone associated with the current subset, and it uses an exact visited
set to suppress rediscovery. The monotone-path proposition proves that every
vertex has a predecessor obtained by deleting one selected generator, hence
the traversal reaches every vertex.

## Complexity and qualifications

Section 2 implements the advertised linear-optimization oracle by explicit
rational feasibility systems. If (L) is total input encoding length and
(q(Q,D,L)) is the resulting polynomial ray-test cost, the proof gives

\[
  O\!\left(KQ\,[q(Q,D,L)+\log K]\right)
    = O\!\left(Kp(Q,D,L)\right),
\]

for an unspecified polynomial (p). This confirms OutputP behavior in a
rational bit model, but it gives neither an explicit bit exponent nor a
polynomial-delay theorem. The visited and treated sets retain all vertices,
and one (Q)-bit subset is retained per vertex, so the method does not have
the compact working-space guarantee of reverse search.

Zero and collinear generators require canonicalization. General position is
not required, but exact rational feasibility and exact vertex equality are.
The object contains full-dimensional strict chambers only; lower-dimensional
faces and boundary points are not emitted.

## Relationship to the established frontier

Ferrez, Fukuda, and Liebling already give the sharper
(O(KQ\,LP(Q,D))) LP-relative time and (O(QD)) working-space bound for
central-arrangement chambers. Rada and Černý give a later incremental
sign-prefix traversal. Deza and Pournin therefore supply a useful bit-model and
output-retention qualification, not a replacement complexity frontier and not
a sparse requested-root observer.

## Evidence locations

- Journal introduction: final contribution framing and self-contained status
  of forward enumeration.
- ArXiv Section 2, Theorems 2.3 and 2.5: exact rational feasibility and cone-ray
  enumeration.
- ArXiv Section 4, Theorem 4.1, Lemma 4.2, Proposition 4.3, Algorithm 1, and
  Theorem 4.4: vertex characterization, adjacency, completeness, and time.
- Published bibliography: 18 references, all screened.
- Forward audit: three OpenCitations records, four Semantic Scholar records,
  and five unique works after reconciliation; only `deza2026whitewhale`
  strengthens the traversal mechanism.
