// Shared manuscript style for survey papers (surveys/*/manuscript.typ).
// Ported from the dataflow-selection-enumeration manuscript style; the
// formal-statement apparatus below serves proof-bearing surveys and is
// target-aware — paged output styles blocks directly, HTML output
// emits classed divs styled by site/src/styles/paper.css.

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
      fill: luma(247),
      radius: 2pt,
    )[
      #align(center)[*Abstract*]
      #v(0.25em)
      #body
    ]
  ]
  v(0.8em)
}

#let named-statement(kind, title, body) = {
  let number = counter(kind)
  number.step()
  let head = [*#kind #context number.display()#(if title != none { [ (#title)] }).*]
  context if target() == "html" {
    html.elem("div", attrs: (class: "statement"))[#head #body]
  } else {
    block(
      width: 100%,
      breakable: false,
      inset: (left: 0.8em, right: 0.8em, top: 0.55em, bottom: 0.55em),
      above: 0.85em,
      below: 0.85em,
      stroke: (left: 1.4pt + luma(51)),
      fill: luma(247),
    )[#head #body]
  }
}

#let definition(title, body) = named-statement("Definition", title, body)
#let theorem(title, body) = named-statement("Theorem", title, body)
#let lemma(title, body) = named-statement("Lemma", title, body)
#let proposition(title, body) = named-statement("Proposition", title, body)
#let corollary(title, body) = named-statement("Corollary", title, body)
#let proof(body) = context if target() == "html" {
  html.elem("div", attrs: (class: "proof"))[_Proof._ #body #sym.square]
} else {
  block(above: 0.45em, below: 0.8em)[
    _Proof._ #body #h(1fr) $square$
  ]
}
