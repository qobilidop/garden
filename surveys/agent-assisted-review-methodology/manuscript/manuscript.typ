// Paged (PDF) wrapper. HTML sibling: manuscript-html.typ.
#import "../../style.typ": paper, titleblock, abstract
#import "meta.typ": title, subtitle, byline, author-note, draft, landing, record, abstract-body

#show: paper

#set document(
  title: title + ": " + subtitle,
  author: byline,
  keywords: (
    "systematic review automation",
    "large language models",
    "agents",
    "evidence synthesis",
    "systematic map",
  ),
)

#titleblock(
  title: title,
  subtitle: subtitle,
  byline: [#byline#footnote[#author-note]],
  meta: [
    #draft ·
    #link(landing)[landing page] ·
    #link(record)[campaign record]
  ],
)

#abstract[#abstract-body]

#include "content.typ"
