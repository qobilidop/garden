// Shared manuscript style for survey papers (surveys/*/manuscript.typ).
// Ported from the dataflow-selection-enumeration manuscript style; the
// theorem apparatus is dropped (surveys are prose, not proofs).

#let paper(body) = {
  set page(
    paper: "us-letter",
    margin: (x: 0.9in, y: 0.78in),
    numbering: "1",
    number-align: center,
  )
  set text(
    font: "Libertinus Serif",
    size: 10.5pt,
    lang: "en",
  )
  set par(justify: true, leading: 0.58em)
  set heading(numbering: "1.")
  set list(indent: 1.15em, body-indent: 0.55em)
  show link: set text(fill: rgb("245b8a"))
  show raw: set text(font: "DejaVu Sans Mono", size: 9pt)
  // Long tables (map distribution, findings summary) break across
  // pages instead of leaving a page-sized gap before them; full
  // width so fractional table columns resolve against the text
  // measure instead of collapsing in a shrink-wrapped figure.
  show figure: set block(breakable: true, width: 100%)
  body
}

#let titleblock(title: none, subtitle: none, byline: none, meta: none) = {
  align(center)[
    #text(size: 19pt, weight: "bold")[#title]
    #if subtitle != none [
      #v(0.1em)
      #text(size: 13.5pt)[#subtitle]
    ]
    #v(0.65em)
    #text(size: 10.5pt)[#byline]
    #if meta != none [
      #v(0.3em)
      #text(size: 9pt, style: "italic")[#meta]
    ]
  ]
  v(0.6em)
}

#let abstract(body) = {
  pad(x: 6%)[
    #block(
      width: 100%,
      inset: (x: 1em, y: 0.65em),
      fill: rgb("f7f9fb"),
      radius: 2pt,
    )[
      #align(center)[*Abstract*]
      #v(0.25em)
      #body
    ]
  ]
  v(0.8em)
}
