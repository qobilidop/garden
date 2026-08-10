// HTML wrapper. Paged sibling: manuscript.typ.
#import "metadata.typ": title, subtitle, byline, author-note, draft, landing, record, abstract-body

#set heading(numbering: "1.")

#html.elem("header", attrs: (class: "titleblock"))[
  #html.elem("h1")[#title: #subtitle]
  #html.elem("p", attrs: (class: "byline"))[#byline#html.elem("sup")[\*]]
  #html.elem("p", attrs: (class: "meta"))[
    #draft · #link(landing)[landing page] · #link(record)[survey record]
  ]
  #html.elem("p", attrs: (class: "authornote"))[\* #author-note]
]

#html.elem("section", attrs: (class: "abstract"))[
  #html.elem("p")[*Abstract.* #abstract-body]
]

#include "content.typ"
