# Typst gotchas

All earned in survey manuscript work; consult when a manuscript
build or render misbehaves.

- `~` is a non-breaking space — escape literal tildes.
- A `;` directly after `#cite(...)` is parsed away — use `#[;]`.
- `fr` table columns collapse inside figures — use explicit widths
  for wrapping columns.
- `#cite(form: "prose")` under numeric CSL styles expands full
  author lists — hand-write "Author et al. @key" there, and grep for
  that residue when switching styles back.
- Unbraced name particles (`van X`) drop in author-year rendering —
  brace them in the bib.
- Typst's BibTeX parser rejects `month=July` — normalize to
  three-letter forms.
- The HTML export silently drops `align`/`block` title content —
  build HTML title blocks from `html.elem`.
- The HTML math export drops decorations like `overline` (MathML
  warnings) — a known cosmetic limit.
- Typst embeds Libertinus Serif and DejaVu Sans Mono — no font
  packages needed for those.
