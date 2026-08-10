---
author: Codex GPT-5.6 Sol
---

# Manuscript HTML refinement — /evolve outcomes

Lessons mined from the dataflow-selection-enumeration manuscript refinement
and site-rendering fixes on 2026-08-09. Bili approved the full proposal set;
the implementation commits that supplied the evidence are `a33f814` and
`e0dde05`.

## Applied

1. **Survey HTML navigation convention** (`run-survey` plus manuscript-build
   guard). The standalone HTML title row links to the landing page and survey
   record; the landing page owns HTML/PDF cross-format navigation. This
   codifies Bili's correction after both reference wrappers linked directly
   to their PDFs.
2. **Native MathML display invariant** (`run-survey` Typst reference plus
   manuscript-build guard). A MathML root's `display="block"` attribute
   already supplies `block math`; ordinary CSS `display: block` or
   `display: inline` disables mathematical layout. The guard accepts native
   `block math` and rejects the exact regression that broke the live paper.
3. **Cross-format manuscript visual review** (`tend-site`). Presentation
   changes compare representative HTML renders with corresponding
   equation- or layout-heavy PDF pages. A static renderer is a typographic
   smoke test, not evidence for responsive, interactive, or browser-engine
   behavior.
4. **Preview endpoint subtraction** (`tend-site`). The hard-coded port was
   removed; the preview command's printed URL controls because both previews
   in this session selected port 4322 rather than the documented 4321.

## Filtered or staged

- No new shell/work-directory rule. The failed attempts to run the manuscript
  builder from `site/` and to pass a host-absolute path through the dev image
  violated existing shell discipline; this was noncompliance, not a missing
  rule.
- No automated multi-browser screenshot harness yet. One engine-sensitive
  MathML regression establishes the semantic guard and manual comparison
  procedure, but not yet the maintenance cost of a browser matrix. Revisit on
  recurrence or explicit demand.

## Rejected

None.
