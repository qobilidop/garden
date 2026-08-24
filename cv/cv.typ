// Paged view of cv.yaml (the canonical record; edit facts there, not
// here). Compiled to site/public/cv.pdf by site/scripts/build-cv.py.
// Fonts: Libertinus Serif only (embedded in typst) — the dev image
// installs no font packages, so no CJK; the HTML view carries 董比立.

#let cv = yaml("cv.yaml")

#set document(title: cv.name + " - Curriculum Vitae", author: cv.name)
#set page(paper: "us-letter", margin: (x: 4.4em, y: 5em))
#set text(font: "Libertinus Serif", size: 10.5pt)
#set par(justify: false)

#show heading.where(level: 2): it => {
  v(1.1em)
  text(size: 1.05em, it.body)
  v(-0.7em)
  line(length: 100%, stroke: 0.5pt + luma(70%))
}

#let muted = text.with(fill: luma(35%), size: 0.92em)

// year = dated occurrence; start/end = tenure (as in the record).
#let dates(e) = {
  if "year" in e { str(e.year) } else [#str(e.start) -- #str(e.end)]
}

#let entry(date, body) = grid(
  columns: (5.6em, 1fr),
  column-gutter: 1em,
  row-gutter: 0.55em,
  muted(date),
  body,
)

#let with-note(e, body) = {
  body
  if "note" in e [ \ #muted(e.note)]
}

// The record's owner in bold within an author string.
#let authors(s) = {
  let parts = s.split(cv.name)
  parts.map(p => [#p]).join(strong(cv.name))
}

// Header
#text(size: 1.7em, strong(cv.name))
#v(-0.5em)
#muted[
  Curriculum vitae · current as of #cv.as_of
]
#v(-0.4em)
#muted[
  #cv.links.pairs().map(((k, url)) => link(url, url.replace("https://", ""))).join(" · ")
]

#if cv.employment.len() > 0 [
  == Employment
  #for e in cv.employment {
    entry(dates(e), with-note(e)[#e.role, #e.org])
  }
]

#if cv.education.len() > 0 [
  == Education
  #for e in cv.education {
    entry(dates(e), with-note(e)[#e.degree, #e.org])
  }
]

#if cv.service.len() > 0 [
  == Service
  #for s in cv.service {
    entry(dates(s), with-note(s)[
      #link(s.url)[#s.role, #if "event" in s { s.event } else { s.org }]
    ])
  }
]

#if cv.talks.len() > 0 [
  == Talks
  #for t in cv.talks {
    entry(dates(t), with-note(t)[#link(t.url, t.title). #t.event.])
  }
]

#if cv.publications.len() > 0 [
  == Publications
  #for p in cv.publications {
    entry(str(p.year), with-note(p)[
      #link(p.url, p.title). \
      #muted[#authors(p.authors). #p.venue.]
    ])
  }
]
