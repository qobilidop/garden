---
citekey: petersen2008-mapping
work:
  title: Systematic Mapping Studies in Software Engineering
  author: Kai Petersen, Robert Feldt, Shahid Mujtaba, Michael Mattsson
  venue: EASE 2008 (BCS eWiC)
  date: 2008-06
  doi: 10.14236/ewic/EASE2008.8
sources:
  pdf: https://www.scienceopen.com/document_file/5c16e1ce-c17c-4035-b7db-080757194d49/ScienceOpen/001_Petersen.pdf  # → store
    # host blocks non-browser clients; the stored blob came from a verified existing Wayback capture
retrieved: 2026-08-08
notes-by: Claude Fable 5
notes-date: 2026-08-08
synthesis: "The founding SE mapping-study paper: classification over evaluation buys breadth (structure a whole field, quality-unassessed) and the map is a first step toward a review, not a lesser one — with keywording-built schemes that evolve during extraction."
---

# Systematic Mapping Studies in Software Engineering

The founding paper of the systematic-mapping branch of SE secondary
studies (10 pages, EASE 2008; Blekinge Institute of Technology and
Ericsson). Where a systematic review evaluates primary studies in
depth to establish a state of evidence, a mapping study classifies
them to structure a field — frequencies of publication across a
classification scheme, gaps visible as empty cells. At writing the
authors knew of exactly one SE example (Bailey et al. 2007); the
paper defines the process by walking their own product-line
variability map against it, then argues from a characterization of
ten existing SE systematic reviews that maps deserve a broader role
than the "areas lacking good primary studies" niche
[[kitchenham2007-slr]]
had assigned them.

## The process

Five steps, each with a named outcome: research questions (scope) →
search (all papers) → screening (relevant papers) → **keywording of
abstracts** (classification scheme) → extraction and mapping (the
map). Keywording is the distinctive move: reviewers pull keywords and
concepts from abstracts, cluster them into categories, and let the
scheme **evolve during extraction** — categories added, merged, and
split as papers are sorted, with a short rationale recorded per
classification. Three facets: topic (from the keywords), contribution
type (process/method/tool/model/metric), and research type, for which
they adopt Wieringa et al.'s classification (validation, evaluation,
solution proposal, philosophical, opinion, experience) — chosen
because it is assessable without evaluating each paper in detail.
Results render as a bubble plot: two x-y category scatters sharing an
axis, bubble size = paper count, gaps legible at a glance.

## Map versus review

The comparison, grounded in the ten characterized SLRs (most aiming
at best-practices from empirical evidence, most including only a
sliver of the potentially relevant studies): maps differ in goals
(classification and gaps, never state-of-evidence), process (no
quality assessment; thematic counting rather than in-depth
extraction), and breadth (restricting to methodologically rigorous
studies — one review kept 5% — biases any *overview* of an area,
since rigor is unevenly easy across sub-topics). The traded cost is
classification reliability: without deep reading, papers whose terms
mislead ("experiment" that isn't) get misfiled. Their guidelines:
use the methods complementarily — map first, then focus a review on
a structured sub-area, though a map has standalone value; adaptive
reading depth (abstracts are often too poor to classify from — read
introduction/conclusions when needed, accepting the map-review
continuum); classify on evidence and novelty; visualize.

## Assessment

- **Durable:** the map/review distinction as a scope-and-depth trade
  rather than a quality ranking; keywording as scheme construction;
  schemes that evolve during extraction; adaptive reading depth; the
  bias argument for classifying without quality-filtering.
- **Era-bound:** the tool suggestions (Excel extraction tables,
  GapMinder bubble charts); the 2008 snapshot of SE's SLR corpus.
- **Caveats:** the process rests on essentially two mapping studies
  (Bailey's and the authors' own), and the authors' 2015 update
  (Petersen, Vakkalanka & Kuzniarz, IST 64 — closed access, left as
  a queue item) audited seven years of practice and revised these
  guidelines; this paper is the founding statement, not the last
  word.
- **In this library:** the genre definition for the survey layer's
  declared kind — the dataflow survey self-describes as a systematic
  map, and its catalog TSVs, disposition codes, and
  evidence-cluster/desert framing are this paper's machinery at
  agent scale. The evolving classification scheme is the closest
  methodological ancestor of the wiki layer's pages-reshaped-as-
  material-accumulates rule, and adaptive reading depth is the
  graded-ingestion idea (G0/G1/G2) stated twenty years early.
