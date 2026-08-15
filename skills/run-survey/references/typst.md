# Typst gotchas

All earned in survey manuscript work; consult when a manuscript
build or render misbehaves.

- `~` is a non-breaking space — escape literal tildes.
- A `;` directly after `#cite(...)` is parsed away — use `#[;]`.
- `fr` table columns collapse inside figures — use explicit widths
  for wrapping columns.
- Put header rows in `table.header(...)`: the HTML exporter then emits
  semantic `<th>` cells. For a page-spanning table, keep the table out of a
  figure or other wrapper that defeats pagination, set `repeat: true`, and
  visually confirm the repeated header on the first continuation page.
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
- A MathML root with `display="block"` already has native `block math`
  layout and centering — styling it with ordinary `display: block`
  or `display: inline` disables mathematical layout.
- Typst embeds Libertinus Serif and DejaVu Sans Mono — no font
  packages needed for those.
