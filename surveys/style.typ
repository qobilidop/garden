// Shared manuscript style for survey papers (surveys/*/manuscript.typ).
// Approximates ACM's acmsmall journal format (the CSUR look): Libertinus
// text with Libertinus Sans display (Libertine/Biolinum successors —
// ACM's own faces), left-aligned sans title block, caps authors, plain
// small abstract, caps sans section headings, first-line paragraph
// indents, running header and journal-line footer. Deliberately close,
// not identical; grounded against a published CSUR first page
// (arXiv:2307.11124v2, CSUR 57(7)).

#let sans = "Libertinus Sans"

#let paper(running-author: none, footer-note: none, body) = {
  set page(
    paper: "us-letter",
    margin: (x: 1.05in, top: 0.95in, bottom: 0.95in),
    header: context {
      let p = counter(page).get().first()
      if p > 1 {
        set text(font: sans, size: 8.5pt)
        [#p #h(1fr) #running-author]
      }
    },
    footer: {
      set text(size: 8pt)
      footer-note
      h(1fr)
      context counter(page).display()
    },
  )
  set text(font: "Libertinus Serif", size: 10pt, lang: "en")
  set par(
    justify: true,
    leading: 0.55em,
    spacing: 0.55em,
    first-line-indent: 1em,
  )
  set heading(numbering: "1.1")
  show heading: set text(font: sans, weight: "bold")
  show heading.where(level: 1): it => block(above: 1.5em, below: 0.8em)[
    #set text(size: 10.5pt)
    #if it.numbering != none [
      #counter(heading).display(it.numbering)
      #h(0.6em)
    ]
    #upper(it.body)
  ]
  show heading.where(level: 2): set text(size: 10pt)
  set list(indent: 1.15em, body-indent: 0.55em)
  set enum(indent: 1.15em, body-indent: 0.55em)
  show link: set text(fill: rgb("245b8a"))
  show raw: set text(font: "DejaVu Sans Mono", size: 8.7pt)
  // Long tables break across pages instead of leaving page-sized
  // gaps. Tables with wrapping text columns must use explicit column
  // widths — fr collapses inside the figure's shrink-wrapped body.
  show figure: set block(breakable: true)
  set table(stroke: 0.4pt + luma(150), inset: 4.5pt)
  show figure.caption: set text(size: 9pt)
  body
}

#let titleblock(title: none, subtitle: none, byline: none, meta: none) = {
  block(above: 1.2em, below: 0.4em)[
    #set text(font: sans, weight: "bold", size: 15.5pt)
    #set par(leading: 0.4em, first-line-indent: 0em, justify: false)
    #title#if subtitle != none [: #subtitle]
  ]
  block(below: 0.5em)[
    #set text(font: sans, size: 10.5pt)
    #set par(first-line-indent: 0em, justify: false)
    #byline
  ]
  if meta != none {
    block(below: 1.2em)[
      #set text(size: 8.5pt, style: "italic")
      #set par(first-line-indent: 0em, justify: false)
      #meta
    ]
  }
}

#let abstract(body) = {
  block(above: 0.8em, below: 1.1em)[
    #set text(size: 9pt)
    #set par(first-line-indent: 0em)
    #body
  ]
}
