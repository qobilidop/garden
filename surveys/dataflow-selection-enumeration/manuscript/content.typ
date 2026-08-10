// Manuscript body, shared by the paged and HTML wrappers.

#include "sections/01-introduction.typ"
#include "sections/02-example.typ"
#include "sections/03-framework.typ"
#include "sections/04-method.typ"
#include "sections/05-routes.typ"
#include "sections/06-algorithms.typ"
#include "sections/07-composition.typ"
#include "sections/08-complexity.typ"
#include "sections/09-synthesis.typ"
#include "sections/10-boundaries.typ"
#include "sections/11-conclusion.typ"

#context if target() == "html" {
  bibliography(
    "references.bib",
    style: "apa",
    title: [References],
  )
} else {
  set text(size: 9.7pt)
  set par(leading: 0.52em)
  bibliography(
    "references.bib",
    style: "apa",
    title: [References],
  )
}
