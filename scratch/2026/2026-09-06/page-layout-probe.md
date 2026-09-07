---
author: Claude Sonnet 5
---

# How notable personal/technical sites frame the page

Research subagent report, orchestrated by Claude Fable 5.1 in the
landing-page layout session. Siblings: `page-layout-principles.md`,
`page-layout-precedents.md`, `page-layout-decision.md`. Caveat added
by the orchestrator: the chars/line column divides by 0.5em per
character; the principles note measured Charter and Georgia at
0.44em, so for serif sites the true count is roughly 1.1× the figure
here. The classifications are unaffected.

Method: fetched each homepage and one article/post page (plus linked stylesheets, `@import`s, and inline `<style>` CSS) with `curl` (plain GET, `Mozilla/5.0 (research bot; contact <email>)`, 15s timeout) on 2026-09-06. No JavaScript was executed, so client-hydrated chrome (noted per-site) could not always be observed. Every classification is my own reading of the fetched CSS/HTML, with the load-bearing rule quoted. "Chars/line" = max-width(px) ÷ (body font-size(px) × 0.5).

## Table

| Site | Body font | Prose max-width (rule → px → chars) | Header vs prose | Footer vs prose | Margin content | Breakpoint(s) | Notes |
|---|---|---|---|---|---|---|---|
| gwern.net | serif, 20px (`:root{font-size:20px}`, 18px <650px); `"Source Serif 4"...` | `main{max-width:var(--GW-body-max-width)}`=935px → ~94ch | Same — `#navbar`/`#navigation` inside `<main>` | Same — `#footer` div inside `<main>` | **Yes**: `#sidenote-column-left/right{max-width:550px}` + floating `#TOC` | 650, 901, 961, 1180, 1200, 1497, 1761px | Signature sidenote/TOC design |
| danluu.com | default browser serif ~16px (no CSS sets font/width) | **none** — no max-width rule exists; runs full viewport width | Same (trivially — unstyled) | Same (trivially) | No | none (zero `@media`) | 170-byte CSS payload; deliberately unstyled |
| paulgraham.com | sans, `<font size="2" face="verdana">` ≈13px (no CSS site-wide) | `<table width="435">` → 435px → ~67ch | N/A — separate 69px image-map nav table beside content | Unverified | Arguably yes (nav column beside content) | none (fixed table layout) | No CSS anywhere; 2000s nested `<table>`s |
| jvns.ca | serif "PT Serif"; 16px | `#wrap{max-width:45em}`=720px → 90ch | Same — `<header>` inside `#wrap` | Same — `<footer>` nests inside `#wrap` | No | 531, 866, 992px | — |
| overreacted.io | sans `ui-sans-serif,system-ui`; 16px | `.max-w-2xl{max-width:42rem}`=672px → 84ch (on `<body>` itself) | Same — `<header>` is a child of `<body>` | Same — `<footer>` likewise | No | Tailwind defaults 400–1536px (no real collapse) | `max-w-2xl` utility on `<body>` |
| ciechanow.ski | sans "IBM Plex Sans"; `.article p{font-size:1.2em}`≈19.2px | `.article>*{max-width:44rem}`=704px → ~73ch | Same — `#banner_wrapper{max-width:44rem}` | **Wider/full-bleed** — `#footer{width:100%;position:absolute}` | No | many (350–760px, interactive diagrams) | Full-bleed interactive-essay site |
| matklad.github.io | serif "EB Garamond"; 16px | `body{max-width:80ch}`=640px outer; `article>*{max-width:55ch}` inner → 55ch | **Wider** — nav is a `<body>` child (80ch), wider than 55ch prose | **Wider** — `<footer>` shares the 80ch outer box | No | none | Two nested measures (80ch shell / 55ch text) |
| fasterthanli.me | sans `"Commissioner"` | `--page-width:920px` var on a nav flex `.container`; article's `.page-markup` CSS not found in fetched bundle | **Unverified** — `#page-topnav` is empty in static HTML (client-hydrated) | Unverified | Unverified | 699/700/950/1400px (named custom props) | SvelteKit route CSS not statically linked |
| xeiaso.net | — | — | — | — | — | — | **Unfetchable**: Anubis JS challenge page returned instead of content |
| simonwillison.net | sans "Helvetica Neue"; 16px | `#primary{width:560px}` inside `#wrapper{width:940px}` → 70ch | **Wider** — `#smallhead-inner{width:940px}` matches outer wrapper, not 560px prose | N/A — no sitewide footer, only in-prose `.entryFooter` | **Yes** — `#secondary{width:280px}` sidebar | 480, 800/801, 940px | Two-column w/ sidebar |
| karpathy (article on karpathy.github.io) | sans "Helvetica, Arial"; 16px | Jekyll `.wrap{max-width:800px}` → 100ch | Same — header/content share `.wrap` | Same — footer too | No | 600, 750px | karpathy.ai portfolio uses a different `.container{width:970px}` |
| sive.rs | serif Georgia; `1.25rem`=20px | `body{max-width:60ch}`=600px → 60ch | Same — `<header>` is a `<body>` child | Same | No | none | `body` itself is the box, no wrapper div |
| drewdevault.com | serif "Alegreya"; 16px (14px<480px) | `body{max-width:66ch+3ch×2}` → ~66ch | Same — `.site-nav` is a `<body>` child | Same | No | 480px | — |
| jefftk.com | default browser serif ≈16px (no override) | `.content{max-width:550px}` → ~69ch | **Wider/full-bleed** — `.headfoot` has no width rule | **Wider/full-bleed** — same `.headfoot` | **Yes** — `#right-column` ads/related ≥1000px | 550, 700, 780, 1000, 1450px | — |
| idlewords.com | sans; `0.9em`≈14.4px | `#entries{width:580px}` inside `#main{width:950px}` → ~81ch | Same — nav/logo sits inside `#entries` | **Between** — `#footer{width:800px}` | Homepage only: `#blogroll{width:280px}` | none | — |
| brendangregg.com (blog) | sans "Avenir, Arial" (blog only; portfolio pages use serif Garamond); 14.5px | `.site{max-width:740px}` → 102ch | Same — `.header` nested in `.site` | Same — `.footer` nested in `.site` | **Yes** — `.nav{width:100px}` fixed sidebar | 480, 600, 960, 1050, 1250, 1700px | — |
| lilianweng.github.io | sans system-ui; 16px | `.main`/`.footer{max-width:768px}` (main-width+gap×2) → 96ch | **Wider** — `.nav{max-width:1072px}` | Same — `.footer` shares `.main` formula | No | 768, 900px | — |
| colah.github.io | sans; default.css's 18px wins cascade | Bootstrap `.container{width:970px}` @≥992; prose `.col-md-8`≈620px → ~69ch | Same — nav/content share `.container` | Same | **Yes** — `.col-md-4#toc-wrapper` floating TOC | 768, 992, 1200px | Bootstrap 3 grid |
| blog.jim-nielsen.com | sans system-ui; `1.125rem`=18px | `.wrapper{max-width:32rem}`=576px → 64ch | Same — header uses `.wrapper` | Same — `<footer class="wrapper">` | No | 520, 768, 1200, 1600px | — |
| craigmod.com | serif Typekit; root `62.5%` trick | `.row{max-width:1140px}`; prose `.eightcol`≈745px | Same — nav uses same `.row`/`.container` grid | Same | No | 768px | 1140-grid rebuilt on CSS Grid |
| robinrendle.com | serif "Newzald"; `font:400 110%`≈17.6px | `.wrapper{max-width:43em}`→86ch, becomes 12-col grid @≥921px | N/A — no header/nav element on page | N/A — no footer element | No on this template | 500, 570, 600, 768, 1000px | First URL tried was a bespoke scrollytelling piece; re-fetched a normal essay |
| macwright.com | sans (system stack); `1rem`=16px | `.limiter{max-width:640px}` → 80ch | Same — nav div reuses `.limiter` | Same — sign-off is inside `.limiter.content` | No | 640, 1025px | — |
| chriscoyier.net | sans, **fluid** `clamp(1rem,1rem+0.5vw,2rem)`≈20–24px | `.content{max-width:min(100%,1050px)}` → ~95ch | Same — header nested in `.content` | **Wider/full-bleed** — footer is a `<body>`-level sibling, no width rule | No | 320–1400px (768/992/1200 structural) | — |
| adamsilver.io | sans "Inter Variable"; 16px | `-measure` classes = 1000px; inner `.content p{max-width:38.75rem}`=620px → 78ch | Same (all three `-measure` classes = 1000px) | Same | No | none found | Explicitly named "measure" classes |
| lea.verou.me | serif "Vollkorn"; root `130%`@>700px=20.8px | `--content-width-m:50rem`≈1040px → ~100ch | **Wider** — header uses smaller `--min-padding` inset | Same as main (shares margin formula) | **Yes** — `.pullquote` bleeds into margin + `.has-toc` sidebar mechanism | 600, 700, 800, 820px | `@property`-based layout tokens |
| joelonsoftware.com | sans "Source Sans Pro"; 20px | `.entry-content{max-width:600px}` inside `.content-area{max-width:1000px}` → 60ch | **N/A/other** — `.site-header` is a fixed **left sidebar** (20%/220px), not a header bar | **Wider/full-bleed** — `.site-footer{width:100%}` | Fixed nav rail is itself margin-adjacent | 420, 768/769, 782px | "Header" is architecturally a sidebar |
| evanmiller.org | serif "georgia"; 16px | `div#content{max-width:1000px;width:90%}` → ~125ch | Same — `.header` nested in `#content` | Same — sign-off inside `.article` | No | 600, 1084px | Outlier: notably wide measure |
| benkuhn.net | serif Georgia; 18px | `.center{max-width:670px}` → 74ch | Same — `<header>` reuses `.center` | **Wider/full-bleed** — `footer{width:100%;position:absolute}` | **Yes** — `.sn-text` sidenotes (right) + `.toc` sticky (left) | 768, 1180px | Full Tufte-style dual margins |
| jsomers.net | serif Georgia; base 13px, but `#coreContent p{font-size:1.4em}`≈18.2px actual | `#siteWrapper{width:500px}` holds everything → 55ch | Same — nav inside `#siteWrapper` | Same — `#footer` inside `#siteWrapper` | No | none | Fixed 500px, non-fluid |
| andymatuschak.org (`/hmwl`) | sans "Alegreya Sans"; `22px` | `.PostBodyContainer{max-width:600px}` → 55ch | **Wider** — `.PostContainer header{max-width:750px}` | N/A — no footer on template | **Yes** — `.MarginNote{max-width:500px}` | 350, 800, 1024, 1200, 1440, 1600px | Fetched a talk-transcript page using the standard template |
| practicaltypography.com | **fluid** `html{font-size:2.4vw}` (~31px@1280, ~38px@1600) | `body{max-width:1000px}` → ~65ch @1280px | N/A — no semantic header/nav on page | N/A — no footer element | Unverified | 520, 1000, 1200px | Self-tuning viewport-relative measure |
| edwardtufte.github.io/tufte-css | serif "et-book"; `15px` | `body{width:87.5%;max-width:1400px}`; `section>p{width:55%}`≈770px → ~103ch | N/A — single static demo, no site header | **Same as prose** — `section>footer{width:55%}`, identical selector to `p` | **Yes** — the defining feature: `.sidenote,.marginnote{float:right;width:50%;margin-right:-60%}` | 760px | Canonical sidenote-margin reference |
| distill.pub | sans (-apple-system/Roboto); `dt-article{font-size:20px}`@≥1024 | Named grid: `.l-body{width:648px}` inside `.l-page{width:984px}` → 65ch | **Wider/full-bleed** — `dt-header{width:100%}` | **Wider/full-bleed** — `dt-footer` (no width rule ⇒ 100%) | **Yes** — `.l-gutter`≈144px margin column for citations | 768, 1024, 1080, 1200px | Distill's named-grid template (v1, `dt-` elements) |
| notes.andymatuschak.org | sans system stack; 17px | `.NoteContainer{max-width:625px}`@≥801 → 73ch | **Wider/full-bleed** — `#header{width:100%}` | N/A — no footer element | **Yes-ish** — `.BacklinksContainer` + stacked adjacent-note-column UI | 800/801px | Separate product from andymatuschak.org |

## Distribution (recomputed from the table; 34 sites total)

**Header vs. prose container:**
- Same width: **19** — gwern, danluu, jvns, overreacted, ciechanowski, karpathy, sivers, drewdevault, idlewords, brendangregg, colah, jim-nielsen, craigmod, macwright, chriscoyier, adamsilver, evanmiller, benkuhn, jsomers
- Wider (not full-bleed): **5** — matklad, simonwillison, lilianweng, leaverou, andymatuschak
- Full-bleed: **3** — jefftk, distill, notes.andymatuschak
- N/A or other structure: **5** — paulgraham, robinrendle, joelonsoftware (sidebar not header), practicaltypography, tuftecss
- Unverified/unfetchable: **2** — fasterthanlime, xeiaso
- 19+5+3+5+2 = **34** ✓

**Footer vs. prose container:**
- Same width: **18** — gwern, danluu, jvns, overreacted, karpathy, sivers, drewdevault, brendangregg, lilianweng, colah, jim-nielsen, craigmod, macwright, adamsilver, leaverou, evanmiller, jsomers, tuftecss
- Wider/full-bleed (or intermediate, not matching): **8** — ciechanowski, matklad, jefftk, chriscoyier, joelonsoftware, benkuhn, distill, idlewords
- N/A (no footer element): **5** — robinrendle, andymatuschak, practicaltypography, notes.andymatuschak, simonwillison
- Unverified: **2** — paulgraham, fasterthanlime
- Unfetchable: **1** — xeiaso
- 18+8+5+2+1 = **34** ✓

**Median measure:** of the 30 sites with a single well-defined fixed-px measure (excluding danluu [unbounded] and practicaltypography [viewport-relative fluid]), sorted values run from ~54.5ch (andymatuschak) to ~125ch (evanmiller); the two middle-ranked values (15th/16th of 30) are ~77.5ch (adamsilver) and ~80ch (macwright/matklad-outer), giving a **median ≈ 78 characters**.

**Sites using the margins for something** (sidenotes, floating/sticky TOC, or a persistent sidebar beside prose): **11 of 32 fetchable sites (≈34%)** — gwern, benkuhn, colah, jefftk, distill, tuftecss, andymatuschak, leaverou, simonwillison, notes.andymatuschak, brendangregg. No margin content: **21** of 32. 11+21 = **32** ✓ (+2 unfetchable/unverified = 34 total).

## Sites that could not be (fully) fetched, and why

- **xeiaso.net** — fully unfetchable via plain `curl`. Both homepage and every article URL return Anubis's anti-bot JS proof-of-work page (`<title>Making sure you're not a bot!</title>`), never real content.
- **fasterthanli.me** — homepage/article fetched fine (200 OK), but the article's actual prose-container CSS class wasn't present in any linked stylesheet, and the top nav is an empty client-hydrated `<div>` in the static HTML — so the header-vs-prose comparison and exact prose width are marked unverified rather than guessed.

All other 32 of the 34 requested sites (full Group 1 plus all four Group 2 sites) were fetched and analyzed successfully.
