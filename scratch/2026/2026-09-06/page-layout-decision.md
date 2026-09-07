---
author: Claude Fable 5.1
---

# Page layout: a nine-region frame on a 36rem measure

Written after the three sibling evidence notes settled:
`page-layout-principles.md` (typographic and empirical first
principles, font metrics), `page-layout-precedents.md` (the served CSS
of 13 sidenote/TOC sites), `page-layout-probe.md` (container survey of
34 notable personal sites). Trigger: Bili refining the landing page
under a new tagline ("Build, learn, share."), wanting a floating
outline and side notes in the margins of future posts, and proposing a
three-by-three region grid for header, body, and footer. Applied to
`site/src/styles/global.css` and `site/src/layouts/Base.astro`; the
`body` comment there carries the short form of this rationale (the
durable layer never links here).

## The decision

The page is one three-column grid, carried through header, main, and
footer — Bili's nine regions:

| | left margin | measure | right margin |
|---|---|---|---|
| header | mark (two rows tall), name over cv | build · learn · share, each over its pages (within a group, upstream to downstream: library, wiki, notebook; stream, blog) | search, theme toggle |
| main | outline, hanging labels (future: sticky TOC) | prose, and the landing profile block | future: side notes |
| footer | repository | © Bili Dong · code MIT · non-code CC BY 4.0 | GitHub, LinkedIn, X |

Tokens (`:root`): `--measure: 36rem`, `--margin-col: 16rem`,
`--gutter: 2.5rem`, `--frame: 73rem`, `--unit: 1.8rem`.

Alignment rule: content in a margin column hugs the gutter (the left
column justifies its blocks to the end, the right column to the
start). The prose's left edge stays the page's one spine; the corners
read as marginalia beside it, not as a second, wider rectangle.

Thresholds, each a computed consequence:

- below 58rem: single column at the measure; the header is two rows
  (brand and utilities, then the sections); the footer is one line.
- from 58rem: the grid opens. Margins are 7.25rem there, the width at
  which the corner blocks (brand ≈ 6rem, utilities ≈ 4.5rem) fit
  beside the measure.
- from 64rem: margins reach 10rem — the wiki's month-label hang (a
  9rem track, pre-existing at this breakpoint) and a future outline.
- from 76rem: margins reach the full 16rem — side notes.

## Each number, traced

- **Measure 36rem = 576px ≈ 73 characters, 2.5 lowercase alphabets**
  of 18px Charter (mean prose advance 0.4385em, alphabet 12.748em,
  measured from the font by the principles agent). Inside Bringhurst's
  45–75; under WCAG 1.4.8's 80; the midpoint of Butterick's 2–3
  alphabets; in the comprehension-and-preference band of the reading
  studies (Dyson & Haselgrove 55 beats 100; Bernard et al. prefer 76).
  Among the precedents, authored-prose sites cluster at 27–37em, and
  this is 36em, beside Tufte CSS (36.7) and Rendle (36).
- **The old measure was wrong about itself.** 44rem gave 664px of
  content = 84 characters, 2.9 alphabets, while its comment claimed
  75–80. Above Bringhurst's 75 and WCAG's 80. Counted on a rendered
  line to confirm: 79–83. The comment is replaced.
- **Why 73 and not Bringhurst's ideal 66** (32.5rem). The site's prose
  is dense with links and mono citekey handles that resist breaking; a
  slightly longer line keeps them from fragmenting lines. 73 sits
  inside every band except Nanavati & Bias's soft "about 70", whose
  primary text the agent could not open. A reasoned deviation, not a
  default: 66 remains the number every source tolerates.
- **Margin columns 16rem = 256px.** At the note size (0.8rem = 14.4px,
  the converged sidenote ratio: tufte-latex 0.80, tufte-css 0.786,
  gwern 0.85) that is 40.5 characters — Bringhurst's floor for a
  narrow column. 16rem is also 0.44 × measure, beside Tufte's
  0.46–0.50. 18rem would give 46 characters but a 79.5rem frame, too
  wide for a 1280px viewport with a scrollbar.
- **Gutter 2.5rem = 0.069 × measure** (tufte-latex 0.077, tufte-css
  0.10). Frame 73rem = 1168px, 1208px with body padding: fits 1280.
- **Vertical unit 1.8rem** = the line box, 18px × 1.6. Paragraph
  margins are half a unit (0.9rem): a paragraph break is then 43.2px
  against a 28.8px line, exactly WCAG 1.4.8's 1.5×. The old 0.5rem
  gave 1.28×, a failing ratio. Header and footer paddings are on the
  unit.
- **line-height 1.6 stays.** Butterick's band is 1.2–1.45 and this is
  above it; WCAG 1.4.8 requires at least 1.5 within paragraphs. The
  accessibility criterion wins; recorded so it is a decision, not a
  default.
- **Type step 18→17px moves from 600px to 25rem (400px).** Under the
  new measure a 600px viewport already gives 71 characters; only a
  phone width pushes the line under Bringhurst's 45 (390px: 44 at
  18px, 47 at 17px). The other 600px rules (profile scale, stacking)
  are about narrow layout and stay.

## Conflicts and how they were resolved

- **Header on the prose container vs. the nine-region grid.** Both
  agents recommended keeping the header inside the measure, and the
  probe found 19 of 34 sites do (5 wider, 3 full-bleed). Bili's grid
  puts the brand and utilities in the margins. Resolved by the hugging
  rule: the margins hold marginalia that sit against the text, so the
  spine the agents were protecting (the return-sweep anchor, the
  text-block-locked margins of the canons) is kept, and the header and
  footer align to the prose by construction — Distill's model, where
  one named grid carries header, article, and footer.
- **Left-to-right order of the sections.** Bili proposed share, learn,
  build (polished work first). Kept build, learn, share: polish does
  not sort the groups cleanly (stream is raw, portfolio is the most
  curated), while the tagline does, and the nav now renders from the
  same list as the tagline, so the two cannot disagree.
- **Landing mark in the margin.** Proposed as the seal hanging beside
  the signature; Bili's call: the mark is part of the text. It stays
  on the measure.
- **Licenses.** Proposed left with source; Bili's call: they govern
  the text, so they sit on the measure. Source alone on the left.
- **Surveys** left the nav (amended later the same day): the section
  is moving to its own home, so its pages stay built and citable via
  wikilinks and search, but are not advertised.
- **`ch` units.** Not used: Charter and Georgia agree on prose advance
  within 0.2% but differ 10% on the zero, so a `ch` measure would
  shift between fallbacks while a `rem` measure holds (principles
  note; Butterick: "Skip it").

## Amended later the same day

Decisions made after the frame landed, while refining the landing
page in the preview:

- Landing intro: two questions as h2 headings ("Why this site?",
  "Who is behind it?") replace the three verb paragraphs; the verbs
  live in the tagline and the nav. Purposes as a list with bold leads
  (to share, to connect, to provide a shared context). "What is
  interesting here?" and "What's new?" (the latter generated from the
  sections' recency, never hand-written) wait for content.
- Dark mode: a `--fg-strong` token, equal to `--fg` in light and a
  step brighter in dark, on headings and bold — the dimmed body text
  left Charter's bold only its weight to stand on.
- Footer: "repository" (not "source", which reads as page source),
  then "© Bili Dong · code MIT · non-code CC BY 4.0" centered on the
  measure (below the rule the spine argument no longer bites, and
  centered separates it from the left corner), profiles right. No
  year: copyright needs none, and a year drifts.
- Lists: 1.25rem indent, muted markers. `text-wrap: pretty` was tried
  and reverted — on two-line items it trades a long last word for a
  visibly short first line, and did nothing for the three-line item.
- Profile icons stay in the profile block as well as the footer
  (Bili's call).

## Verified and not

- Headless Chrome screenshots at 1280, 940 (frame), 700, 500 (single
  column), and the wiki index at 1280 (month labels in the margin);
  `npm run build` exit 0; `hooks/lint.sh` exit 0.
- Not verified: the light theme (headless ignored the scheme flag; no
  new colors were introduced), and anything below 500px (headless
  clamps the window). Both need a look in a real browser.

## Deferred

- Side notes: float with calc margins or CSS anchor positioning;
  in-flow after their paragraph below 76rem; hidden with
  `left: -99999px`, never `display: none` (Koos; screen readers).
- Sticky outline in the left column from 64rem; disclosure at the top
  of the article below it.
- Heading line-heights on the unit (h1 1.0, h2 1.28, h3 1.524) and h2,
  hr, blockquote margins as unit multiples — Bringhurst's "return on
  beat"; skipped here to keep this change to the frame.
- Astro 7's `dev`/`preview` run as detached daemons; twelve were found
  alive from past sessions on ports 4321–4332. The stop command is
  `astro dev stop`; tend-site should say so (batched for /evolve).
