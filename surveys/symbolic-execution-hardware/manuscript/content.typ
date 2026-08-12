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
#include "sections/11-limitations.typ"
#include "sections/12-corpus-map.typ"
#include "sections/13-conclusion.typ"

// Typst 0.15.1 applies citation-name disambiguation to the same-name entries
// in the reference list as well as in text. Preserve the correct expanded
// in-text citations, but restore APA initials and complete author lists here.
#show "Ahmed, Farahmandi, & Mishra.": [Ahmed, A., Farahmandi, F., & Mishra, P.]
#show "Ahmed, Farahmandi, Iskander, et al.": [Ahmed, A., Farahmandi, F., Iskander, Y., & Mishra, P.]

#context if target() == "html" {
  bibliography(
    "references.bib",
    style: "apa",
    title: [References],
  )
} else {
  set text(size: 9.1pt)
  set par(leading: 0.45em)
  bibliography(
    "references.bib",
    style: "apa",
    title: [References],
  )
}
