---
author: Claude Opus 5
---

# Framing text-centred pages: measured values from 13 sites

Research subagent report, orchestrated by Claude Fable 5.1 in the
landing-page layout session; the agent read each site's served CSS
with curl. Values are read verbatim or marked derived. Siblings:
`page-layout-principles.md`, `page-layout-probe.md`,
`page-layout-decision.md`.

(Report from the precedents research agent, 2026-09-06. CPL inferred as 2 × measure-in-em, ±10%.)

## (a) The numbers

| Site | Measure (px @ body size) | ≈ em / CPL | Outer frame | Margin column | Note size ratio | TOC | Header vs prose | Breakpoints |
|---|---|---|---|---|---|---|---|---|
| Tufte CSS | 770 @ 21px (55% of body) | 36.7em / ~73 | body 87.5%, max 1400px, padding-left 12.5% | sidenote width 50%, margin-right -60% → 385px, 77px gutter (derived) | 1.1/1.4rem = 0.786 | none | same block | 760px: notes display:none until checkbox, then inline width 95% |
| gwern.net | 895 @ 20px | 44.8em / ~90 | main 935px, padding 20px | calc(50vw − (935/2 + 96px)), max 550px, offset left calc(100% + 64px) | 0.85em | float:left, max-width 285px, inside the measure | header inside main — same container | 1761px (JS) sidenotes on; 1497px margin notes; 901px TOC floats; 650px type 20→18px |
| Distill | 592 @ ~17px | 34.8em / ~70 | page = 896px (derived) | gutter = 136px, 16px gap (derived) | figcaption 13/17 = 0.76 | none | same named grid | 768 / 1000 / 1180px — grid re-templated at each |
| Matuschak notes | 561 @ 17px/24px (625 − 2×32 pad) | 33.0em / ~66 | pane 625px (W8 = 625 in JS), sticky, flex-shrink 0 | n/a (panes) | n/a | none | per-pane | 800px: only the last note renders, full width; padding 32→16px |
| Butterick | 652 @ 20.4–24px (reader-selectable face) | 27.2–32.0em / ~55–64 | body max-width 1000px; html font-size 2.4vw | aside LEFT margin: left 2.5rem; width calc(2.5rem*3) = 180px | ≈ 0.83–0.98 | left column | title-block in the left margin | 1200px: aside → left 0; width 10rem; 1000px: root locks 24px; 520px: root 18px, aside boxed inline |
| Koos Looijesteijn (live) | ~430 @ 14–18px | ~27em / ~54 | 8rem column grid | calc(8rem*2 + gap) ≈ 270–292px | — | none | — | 820px float in/out (article still says 1080px) |
| Starlight | 720 @ 16px/1.75 | 45.0em / ~90 | --sl-content-width 45rem | left --sl-sidebar-width 18.75rem (300px) | — | right rail, TOC text capped 268px | full-bleed but header is a grid whose first column is computed to the prose start | 50rem (800px) sidebar + header grid; 72rem (1152px) right TOC appears |
| Docusaurus v3 | ~823 @ 16px/1.65 | 51.4em / ~103 | --ifm-container-width 1140px (1320px ≥1440) | left 300px (30px collapsed) | — | right col--3, sticky | full-bleed, no container | 997px 3-col on; 996px TOC display:none; 1440px container→1320 |
| mdBook / Rust Book | 750 @ 16px/1.45 | 46.9em / ~94 | none — viewport-filling | min(300px, 80vw), resizable | — | none | full-bleed over content pane | 620px push vs overlay; 1080px (JS) sidebar default-open |
| Ciechanowski | 704 @ 16px (44rem, content-box + 3rem pad) | 44.0em / ~88 | 44rem + 2×3rem = 800px (derived) | none | — | none | #banner_wrapper same 44rem, inside a 100%-width colour band | 450px: padding 3rem→1.2rem |
| Craig Mod | 746 @ 18px (eightcol) | 41.4em / ~83 | .row max 1140px, 12 tracks, 3.8% gap | 2 empty tracks each side = 197px (derived) | — | none | header spans all 12 tracks (1140px) — wider | 768px: body font-size 55%, columns stack |
| Robin Rendle | 576 @ 16px/1.3 | 36.0em / ~72 | --size-content-width 36rem | left --size-navigator 20rem | — | left navigator | — | 768px navigator; 1000px --reading-margin auto → 5vw |
| garden (this site) | 664 @ 18px/1.6 (44rem border-box − 40px) | 36.9em / ~74 | body is the frame | none yet (wiki month labels hang left at ≥64rem) | — | none | header inside body — same container | 600px (type 18→17px) |

## (b) Per-site notes

**Tufte CSS.** No box-sizing reset, so width 87.5% + padding-left 12.5% makes the block left-biased. The measure is 55% of that block; sidenotes are 50% of the paragraph pulled -60% right. Everything is a percentage of one number, which is why it scales and why nothing else can be added to the frame.

**gwern.net.** Two symmetric absolute columns, left/right: calc(100% + 64px) off main. The formula calc(50vw − (935/2 + 96px)) means the columns are whatever the viewport has left over: 317px at the 1761px threshold, reaching the 550px cap at 2227px viewport (derived). Rationale (gwern, /design): "sidenotes using both margins, fallback to floating footnotes". Verified discrepancy: shipped config is useLeftColumn: () => false, useRightColumn: () => true — gwern.net currently renders right-only. The TOC is float:left; max-width 285px inside the 895px measure, so the top of every page has a shortened line; below 901px it becomes a centred inline block.

**Distill.** One grid-template-columns with named lines (screen / page / middle / text / gutter) applied to distill-header, d-title, d-byline, d-article, d-appendix and distill-footer simultaneously. Elements opt into a span (.l-body, .l-page, .l-gutter, .l-screen). At ≥1180px tracks are 60px with a 16px gap: text spans 8 (592px) and sits symmetrically inside page (896px), gutter occupies the right two tracks (136px), and two tracks stay empty as counterweight. Rationale (Distill guide): the gutter "does not interrupt the normal flow of .l-body sized text except on mobile screen sizes". Below 768px every named line collapses onto one 8×1fr band.

**Andy Matuschak.** Inline style; .NoteContainer width 625px, sticky, flex-shrink 0, under min-width 801px, with .Note padding 32px giving a 561px measure at 17px/24px. The 625 is a bare constant (W8 = 625) in main.js. No margins: the margin is the next pane. At narrow widths only the last note in the stack renders, full width (render is stack.slice(-1) below 800px). No design write-up exists anywhere in the corpus (full-corpus search of 1,960 notes); no credit to a predecessor.

**Butterick.** html font-size 2.4vw, clamped to 24px above 1000px and 18px below 520px, every dimension in rem (body max-width 1000px; #content margin-left 12rem; margin-right 2.5rem). Between 520 and 1000px the measure in characters is constant; only the type size changes. His stated technique: "scaling the point size and element width at the same rate" with vw.
Prescriptions: line length "45–90 characters, including spaces", "two and three alphabets on a line"; point size "On the web, the optimal size is 15–25 pixels"; line spacing "between 120% and 145%"; margins "web pages need big margins too"; on ch: "Skip it".
Reader-selectable face changes body size 0.85–1.0rem, so his measure is 27.2–32.0em (derived). Sidenotes: aside position absolute; left 2.5rem; width calc(2.5rem*3); text-align right — LEFT margin, right-aligned toward the text, unnumbered.

**Koos Looijesteijn.** Article and shipped CSS disagree (1080px vs 820px). In 2025 he moved from position:absolute to float with calc() margins so subsequent sidenotes don't overlap. Hides collapsed notes with position:absolute; left:-99999px, not display:none, for screen readers. Names CSS anchor positioning as what he'd try today.

**Starlight.** Right rail width max(300px, calc(300px + (100% − 45rem − 18.75rem)/2)) splits leftover width evenly between the TOC column and the main pane, so the 720px prose reaches full measure only at ~1440px and is squeezed to 504px at 1152px (derived). Header at ≥50rem is display:grid whose first column is computed so the header's centre group starts exactly where the prose starts, even though the header is full-bleed.

**Ciechanowski.** One rule: .article > *, #archive, .padding_wrapper { max-width 44rem; margin-inline auto; padding 0 3rem } and the same for #banner_wrapper. No box-sizing reset, so 44rem is the content box and the outer block is 800px. #banner is width 100% — a full-bleed colour band with contents pinned to the 44rem spine. No layout media query above 450px.

**Craig Mod.** CSS-grid reimplementation of the 2011 1140 grid ("Twenty years of content uses these class names, so they are a permanent API"). Essays: twocol spacer + eightcol — prose centred at 746px inside a 1140px row. Header spans all 12 tracks: header 1140px against 746px prose — same grid, wider container.

**Robin Rendle.** --size-content-width 36rem with --reading-margin auto, overridden at ≥1000px to 5vw — prose stops being centred on wide screens and hangs off a viewport-proportional left margin beside the 20rem navigator.

## (c) Patterns, and the agent's reasoned view

1. Two-population split on measure: authored prose clusters at 27–37em (Butterick 27–32, Matuschak 33, Distill 34.8, Rendle 36, Tufte 36.7); docs and note-dense sites run 41–51em. Nobody writing about typography chose above 37em.
2. Sidenote font-size ratio converged at 0.76–0.87, clustered around 0.85 (Tufte 0.786, Distill 0.76, Butterick ~0.85, gwern 0.85, Nystrom 0.875).
3. Collapse is universal: fold in-flow below the paragraph (Tufte, Koos, Distill) or promote to popup/footnote (gwern). Nobody keeps a narrow margin note at narrow widths.
4. The sidenote breakpoint is a computed consequence: measure + gutter + note-width + slack. 760px (Tufte), 800px (Nystrom), 820–1080px (Koos), 1761px (gwern, both margins reserved).
5. Full-bleed headers belong to docs frameworks; text-first sites keep the header on the prose spine (Ciechanowski, gwern, this site). Distill puts it on the same grid. Craig Mod widens it to the grid but keeps the grid. Starlight goes full-bleed then does arithmetic to re-align it.

Judgements for this site (44rem, 18px serif, two-row header with tall mark):
1. Keep the header on the prose container, not wider (agent's view; Ciechanowski as proof).
2. Change what 44rem is: adopt Distill's model — one grid on a wrapper with named lines page / text / gutter, text = 44rem, header/main/footer spanning by class. Alignment by construction.
3. Size the gutter now: 12rem gutter + 2.5rem gap → page 1168px, breakpoint ≈ 1200px (derived). Note type 0.85em (15.3px). Below the breakpoint, collapse the gutter into text and let notes fall in-flow; hide with left:-99999px, not display:none.
4. line-height 1.6 is above Butterick's 1.2–1.45 band; defensible at 37em but should be a recorded decision.

## (d) Sources

- https://raw.githubusercontent.com/edwardtufte/tufte-css/gh-pages/tufte.css
- https://gwern.net/static/css/head.css, /static/css/default.css, /static/css/style.css, /static/js/sidenotes.js; https://gwern.net/design; https://gwern.net/sidenote
- https://distill.pub/template.v2.js (embedded layout/style strings); https://distill.pub/guide/
- https://notes.andymatuschak.org/ (inline style), /assets/main.js, /notes/manifest.json, /About_these_notes
- https://practicaltypography.com/styles.css; /line-length.html, /page-margins.html, /point-size.html, /line-spacing.html, /responsive-web-design.html, /websites.html
- https://www.kooslooijesteijn.net/blog/semantic-sidenotes, /blog/sidenotes-without-js
- https://starlight.astro.build/_astro/common.C5ERfuK9.css
- https://docusaurus.io/assets/css/styles.a5d66605.css
- https://doc.rust-lang.org/book/css/ (variables, general, chrome)
- https://ciechanow.ski/css/base.css, /css/moon.css
- https://craigmod.com/css/1140.css, /css/master-1140.css, /css/cmod.css
- https://robinrendle.com/ (inline style)

Flags: CPL inferred throughout. Column arithmetic for Distill, Craig Mod, Starlight, Docusaurus computed from read declarations. Koos's article breakpoint contradicts shipped CSS. Craig Mod has no write-up beyond the CSS comment. Matuschak has no write-up at all (verified absent).
