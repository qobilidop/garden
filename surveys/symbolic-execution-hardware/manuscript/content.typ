// Manuscript body, shared by the paged and HTML wrappers.

#include "sections/01-introduction.typ"
#include "sections/02-boundary.typ"
#include "sections/03-method.typ"
#include "sections/04-lineages.typ"
#include "sections/05-artifacts.typ"
#include "sections/06-execution-models.typ"
#include "sections/07-scaling.typ"
#include "sections/08-contracts.typ"
#include "sections/09-evidence.typ"
#include "sections/10-synthesis.typ"
#include "sections/11-conclusion.typ"

#context if target() == "html" {
  bibliography("references.bib", style: "apa", title: [References])
} else {
  set text(size: 9.7pt)
  set par(leading: 0.52em)
  bibliography("references.bib", style: "apa", title: [References])
}
