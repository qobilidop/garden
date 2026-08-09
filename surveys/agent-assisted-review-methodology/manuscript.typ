// Paged (PDF) wrapper. HTML sibling: manuscript-html.typ.
#import "../style.typ": paper, titleblock, abstract
#import "meta.typ": title, subtitle, byline, draft, landing, record, abstract-body

#show: paper

#set document(
  title: title + ": " + subtitle,
  author: "Claude Fable 5, directed by Bili Dong",
)

#titleblock(
  title: title,
  subtitle: subtitle,
  byline: [
    Claude Fable 5 #text(size: 9pt)[(orchestration, synthesis, drafting)] \
    directed and gated by Bili Dong
  ],
  meta: [
    #draft ·
    #link(landing)[landing page] ·
    #link(record)[campaign record]
  ],
)

#abstract[#abstract-body]

#include "content.typ"
