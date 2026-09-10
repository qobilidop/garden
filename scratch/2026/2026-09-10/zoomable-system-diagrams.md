---
author: Claude Fable 5.1
---

# Zoomable system diagrams: prior art and Bili's stance

Bili's idea, raised 2026-09-10: a "recursive" or "hierarchical"
system-diagram tool. Complicated systems are described at several
abstraction levels; he wants one diagram that opens on the high-level
overview and zooms in to reveal finer structure. Scope is deliberately
unsettled, so this stays in scratch; a notebook note follows once the
thought is clearer.

## Bili's stance (2026-09-10)

- Ilograph is the closest existing product and looks right. He wants
  an open-source equivalent and will probably build one for his own
  use cases only.
- Intended use includes his own note-taking, so the notebook is a
  likely first consumer.
- Until then, Mermaid (already in the site pipeline) is the mature
  stand-in.

## Prior art

Single-agent web pass with direct fetches of the pages cited; not
panel-verified. Closest first.

- **Ilograph** — one resource hierarchy defined as code, "dynamic
  zoom" from big picture to fine-grain detail, multiple perspectives
  over the same model, sequence-flow perspectives, resource finder.
  Proprietary, web-hosted, also on-prem and Confluence.
  [features](https://www.ilograph.com/features.html),
  [why contexts](https://www.ilograph.com/blog/posts/why-ilograph-added-contexts).
- **C4 model** — the idea as a method: context, container, component,
  code; "different levels of zoom tell different stories to different
  audiences". Structurizr renders it from a DSL; IcePanel adds visual
  drill-down between the top three levels and links out instead of a
  code level. Fixed at four levels, software-architecture vocabulary.
  [c4model.info](https://c4model.info/),
  [IcePanel on C4](https://icepanel.io/c4-model),
  [IcePanel vs Structurizr](https://icepanel.medium.com/comparison-icepanel-vs-structurizr-7036c8762147).
- **Hardware schematics** — hierarchical sheets are decades old:
  KiCad's root sheet and sub-sheets with "enter sheet" / "leave
  sheet", including complex hierarchies where one sheet is
  instantiated many times; Simulink subsystems open on double-click.
  Navigation is page replacement, not continuous zoom.
  [KiCad schematic editor](https://docs.kicad.org/9.0/en/eeschema/eeschema.html).
- **Zoomable user interfaces, semantic zoom** — the academic root.
  Perlin and Fox's Pad, then Bederson and Hollan's Pad++: the
  representation changes with scale rather than merely shrinking.
  Later applied to hierarchical diagrams on large displays.
  [Pad++ (Bederson)](https://www.cs.umd.edu/~bederson/images/pubs_pdfs/p23-bederson.pdf),
  [ZUI for hierarchical diagrams](https://link.springer.com/chapter/10.1007/978-3-642-02577-8_87).
- **Top-down drawings of compound graphs** — Kasperowski and von
  Hanxleden (arXiv 2023, revised 2024): lay out the overview to fit
  the viewport and use scale to hide lower levels until zoomed, as
  against bottom-up compound layout. Same group as the ELK layout
  engine, which is the natural layout substrate for a build.
  [arXiv 2312.07319](https://arxiv.org/abs/2312.07319).
- **D2** — composition into layers, scenarios, and steps, but the
  docs describe sequential boards and animated exports, not drilling
  into a node. Graphviz clusters and Mermaid subgraphs nest but
  render flat.
  [D2 composition](https://d2lang.com/tour/composition/).

## What looks unclaimed (unverified)

The combination: open source, text-defined, unbounded nesting, one
continuous semantically-zooming canvas, static-hostable, with edges
that re-aggregate as the view zooms out. Each item above has two or
three of these. Needs a close read of Ilograph's and the compound-
graph paper's limits before it is stated as a gap.

## Design cautions for later

- "Single diagram" hides the hard problem: edge aggregation. When a
  child's connections collapse into its parent, the parent edge needs
  a defined meaning (union, count, typed bundle).
- Ilograph exists, so the contribution of a build is openness, a
  hardware-shaped vocabulary, and fit with the notebook, not the zoom
  itself.

## Candidate ingestions

Bederson & Hollan, Pad++ (1994); Kasperowski & von Hanxleden,
Top-Down Drawings of Compound Graphs (2023/2024); Simon Brown's C4
model page if a canonical dated text exists.
