---
author: Claude Fable 5.1
---

# Landing page, frame, and palette — session reflection

Written after the day's work shipped (2026-09-06 evening through
2026-09-07). What the session did, in order: a preview of the landing
page; the tagline "Build, learn, share." and a nav grouped by its
verbs; a first-principles study of page layout (three research notes
and a decision note in `../2026-09-06/`) applied as a nine-region
frame; a two-question intro; a dancing landing mark; the CV's dates
hung in the margin and its PDF venues on their own line; email and
ORCID; the palette derived from ink and paper. Eleven commits, all
deployed and verified live.

## Principles that emerged

- The tagline is the site's table of contents: nav and tagline
  render from one list, so the thesis and its map cannot disagree.
  Left to right follows the flow of work at both levels.
- Margin content hugs the gutter. That one rule reconciled Bili's
  nine-region grid with the typographic advice to keep the header on
  the prose: the corners read as marginalia beside one spine, not as
  a second frame.
- Breakpoints are computed consequences (corners fit at 58rem, a 10rem
  hang track at 64rem, 40-character side notes at 76rem), never
  taste.
- A gray scale is one dimension: two colors per theme and four fixed
  strengths. The hand-picked palette was already this within
  rounding; naming the rule cost nothing and made it a design.
- Purpose over record on the landing page: the CV and the nav have
  homes; the intro answers why and who, and ends on the questions.
- Bili's calls worth remembering as taste: the simpler
  implementation over the clever one; no named choreography
  (copyright); the mark is part of the text, not a marginal seal;
  licenses centered under the text they govern; no theme-specific
  type sizes; publish the Gmail address (already public in 598
  commits); add Bluesky only when active there.

## Errors worth remembering

- Three outcome claims made from a proxy: "widows are gone" (no
  before/after diff; nothing had moved), "deployed and verified" for
  the dance (dev server's unminified CSS; lightningcss had turned the
  nameless `animation:` shorthand into `none`), blank footer crops
  sent unviewed. One mechanism — now a line in the
  evidence-before-assertion memory and a tend-site bullet.
- SVG is y-down: a positive rotation is clockwise, and the sense
  flips once a limb is raised past horizontal. Three sign errors in a
  row, each caught only by a frame capture. Recorded in the decision
  note.
- Twelve `astro preview` daemons from past sessions held ports
  4321–4332; one collided with the dev server and served 404 to Bili's
  browser. Now a tend-site bullet.
- Two research subagents could not write report files (harness
  rule); the probe agent embedded Bili's email in its User-Agent and
  the string reached a scratch note before the leak review. Now an
  AGENTS.md fan-out bullet.
- The 08-23 staged items both recurred (PDF byte scans false-negative
  on typst output; `gh run list --limit 1` races the dispatch) and
  were promoted to tend-site.

## Process residue for /evolve

Staged (single occurrence each):

- Splicing a CSS block by computed string index left orphaned
  fragments twice; the build failed and only the minifier named the
  line. Anchored, asserted replacements (`assert s.count(old) == 1`)
  did not fail once. Worth a rule if it recurs: edit by anchored
  replacement, then run the minifier as a syntax check.
- A too-strict grep (`href="…">ORCID`) missed an anchor carrying a
  scoped-style attribute and produced a false "stale cache" alarm to
  the user. Loosen the pattern before alarming.
- The Chrome extension's synthetic hover once failed to trigger
  `:hover` over a text element but worked over the SVG; the DevTools
  script's `Input.dispatchMouseEvent` worked every time.
- Astro's dev server relocates ports on restart (4323 → 4321);
  tend-site already says to use the printed URL.

## Evolve outcome (run at session end)

Accepted and applied, all seven: (1) tend-site `scripts/shot.mjs` and
its bullet; (2) tend-site daemons and startup-loaded CV record; (3)
tend-site deploy bullet — run by head SHA, PDFs via `pdftotext`
(promoted from 08-23); (4) AGENTS.md §Fan-out — subagent output
returned as text, covered by the leak review; (5) garden-website
memory updated in place; (6) evidence-before-assertion memory
sharpened; (7) subtraction — two settled open items and the brand
wording note removed from the garden-website memory. Nothing
rejected.

Considered and declined afterwards (Bili, same day): per-day
`README.md` indexes in `scratch/` for human browsing. Descriptive
slugs and the synthesis note's sibling list already carry the need;
an unchecked index would drift, and a lint-checked one was more
machinery than the need justified. Not to be re-proposed.
