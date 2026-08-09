// Paged (PDF) wrapper. HTML sibling: manuscript-html.typ.
#import "../../style.typ": paper, titleblock, abstract
#import "meta.typ": title, subtitle, byline, author-note, draft, landing, record, abstract-body

#show: paper.with(
  running-author: "Bili Dong",
  footer-note: [sys0 Surveys · Draft v1 · 2026-08-08],
)

#set document(
  title: title + ": " + subtitle,
  author: byline,
)

#titleblock(
  title: title,
  subtitle: subtitle,
  byline: [#upper(byline)#footnote[#author-note]],
  meta: [
    #draft ·
    #link(landing)[landing page] ·
    #link(record)[campaign record]
  ],
)

#abstract[#abstract-body]

#include "content.typ"
