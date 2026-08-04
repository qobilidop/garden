#let paper(body) = {
  set page(
    paper: "us-letter",
    margin: (x: 0.9in, y: 0.78in),
    numbering: "1",
    number-align: center,
  )
  set text(
    font: ("Libertinus Serif", "DejaVu Serif"),
    size: 10.5pt,
    lang: "en",
  )
  set par(justify: true, leading: 0.58em)
  set heading(numbering: "1.")
  set list(indent: 1.15em, body-indent: 0.55em)
  show link: set text(fill: rgb("245b8a"))
  show raw.where(block: true): set text(
    font: "DejaVu Sans Mono",
    size: 8.7pt,
  )
  body
}

#let named-statement(kind, title, body) = block(
  width: 100%,
  inset: (left: 0.8em, right: 0.8em, top: 0.55em, bottom: 0.55em),
  above: 0.85em,
  below: 0.85em,
  stroke: (left: 1.4pt + rgb("375a7f")),
  fill: rgb("f7f9fb"),
)[
  *#kind#(if title != none { [ (#title)] }).* #body
]

#let definition(title, body) = named-statement("Definition", title, body)
#let theorem(title, body) = named-statement("Theorem", title, body)
#let lemma(title, body) = named-statement("Lemma", title, body)
#let proposition(title, body) = named-statement("Proposition", title, body)
#let corollary(title, body) = named-statement("Corollary", title, body)
#let proof(body) = block(above: 0.45em, below: 0.8em)[
  _Proof._ #body #h(1fr) $square$
]
