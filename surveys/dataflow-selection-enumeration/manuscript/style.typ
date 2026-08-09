// Theorem apparatus for the manuscript sections. Page style comes
// from the shared surveys/style.typ (which was ported from this
// manuscript's original style); only the formal-statement machinery
// is local.

#let named-statement(kind, title, body) = {
  let number = counter(kind)
  number.step()
  block(
    width: 100%,
    breakable: false,
    inset: (left: 0.8em, right: 0.8em, top: 0.55em, bottom: 0.55em),
    above: 0.85em,
    below: 0.85em,
    stroke: (left: 1.4pt + rgb("375a7f")),
    fill: rgb("f7f9fb"),
  )[
    *#kind #context number.display()#(if title != none { [ (#title)] }).*
    #body
  ]
}

#let definition(title, body) = named-statement("Definition", title, body)
#let theorem(title, body) = named-statement("Theorem", title, body)
#let lemma(title, body) = named-statement("Lemma", title, body)
#let proposition(title, body) = named-statement("Proposition", title, body)
#let corollary(title, body) = named-statement("Corollary", title, body)
#let proof(body) = block(above: 0.45em, below: 0.8em)[
  _Proof._ #body #h(1fr) $square$
]
