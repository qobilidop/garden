---
author: Claude Opus 5
---

# What governs the layout of a text-centred page, and what follows for qobilidop.com

Research subagent report, orchestrated by Claude Fable 5.1 in the
landing-page layout session. Sibling notes: `page-layout-precedents.md`
(measured CSS of 13 sites), `page-layout-probe.md` (container survey
of notable personal sites), `page-layout-decision.md` (the synthesis).
Where a claim rests on a source the agent could not open, it says so.

## (a) Principles

**1. The measure is the design. Everything else is derived.**
Bringhurst, *Elements of Typographic Style* §2.1.2: "Anything from 45 to 75 characters is widely regarded as satisfactory... The 66-character line is widely regarded as ideal. For multiple column work, a better average is 40 to 50 characters." (Verified verbatim; the 40-50 clause was confirmed by full-text search inside the book at archive.org.) The band exists because of the return sweep: too long and the eye loses the next line's start; too short and returns and hyphenation multiply. *Implication:* the measure is chosen first; margins, sidenotes and header width are consequences of it, not independent decisions.

**2. Butterick's band is wider, and his measuring method is font-relative.**
*Practical Typography*, "Line length": 45-90 characters, or 2-3 lowercase alphabets set at the text size. *Implication:* the alphabet test is the only line-length check that travels with the typeface, and it can be computed exactly from font metrics.

**3. WCAG 2.x SC 1.4.8 (Visual Presentation, level AAA)** caps line width at "no more than 80 characters or glyphs" and requires line spacing of at least 1.5 within paragraphs and paragraph spacing "at least 1.5 times larger than the line spacing." *Implication:* 80 is a hard ceiling, and the paragraph-spacing clause is a second, usually forgotten, numeric constraint.

**4. The empirical literature does not endorse the 66-character line - it splits by outcome measure.**
Dyson, "How physical text layout affects reading from screen," *Behaviour & Information Technology* 23(6):377-393 (2004), a peer-reviewed synthesis, is the best primary summary:
- *Speed favours long lines.* Dyson & Kipping (1998a) tested 25-100 cpl at constant type size; "the longest line read faster." Duchnicky & Kolers (1983), Gould & Grischkowsky (1986) and Youngman & Scharff (1998) point the same way - Youngman & Scharff's fastest reaction time came with the longest line and no margin at all.
- *Comprehension favours moderate lines.* "Dyson and Haselgrove (2001) found that line length influences readers' comprehension with documents at 55 characters per line producing better comprehension scores than the longest line length (100 characters per line)... Differences in comprehension were not cancelled out by differences in reading rate as there was no speed-accuracy trade-off." 25 cpl fell in between.
- *Preference favours moderate lines.* Bernard, Fernandez & Hull (2002, *Usability News*) compared 45 / 76 / 132 cpl and found no reading-time or efficiency differences, but adults preferred shorter than full-screen, with 76 cpl judged most desirable.
- Dyson's own conclusion: "Although longer line lengths may be read faster, people prefer a more moderate length. With columns, a single wide column is read faster, but narrow multiple columns are preferred." She also warns that the speed advantage of long lines is partly a scrolling artefact - longer lines mean fewer lines, hence less scrolling - and that this "does not appear to completely account for differences."
- Nanavati & Bias, "Optimal Line Length in Reading - A Literature Review," *Visible Language* 39(2) (2005), concludes the literature is mixed but that "line length should not exceed about 70 characters per line." (Publisher abstract; I could not retrieve the full PDF - the journal's download URL returns HTML. **Unverified beyond the abstract.**)
- Baymard's line-length article recommends <=80, but its authority is WCAG plus Emil Ruder's 50-60; its own evidence is about willingness to engage, not speed.
- Ling & van Schaik (2006, *IJHCS* 64(5):395-404) is often cited here but is a **visual-search and information-retrieval** study, not continuous reading, so it does not settle prose measure. I could not reach the publisher abstract (403). **Unverified.**

**5. Page canons define everything from the text block, not the sheet.**
Van de Graaf's construction (1946), popularised by Tschichold in *The Form of the Book* (1991): type-area height equals page width; margins fall in the ratio 2:3:4:6 (inner:top:outer:bottom) at a 2:3 page, i.e. inner 1/9 and outer 2/9 of the width - the outer margin is twice the inner. Bringhurst §1.2.5, verified by full-text search: "Shape the page and frame the textblock so that it honors and reveals every element"; and the margins "must do three things. They must lock the textblock to the page and lock the facing pages to each other... Second, they must frame the textblock in a manner that suits its design. Third [protect it]."
*Implication for a scroll:* the vertical half of every canon is inapplicable - there is no page height and no facing page. What survives is horizontal and functional: margins are *asymmetric by design*, the wider one carries the apparatus, and the frame is defined by the text block rather than the viewport.

**6. Marginalia has a measured, and remarkably stable, proportion.**
Two primary implementations of Tufte's own book layout agree:
- `tufte-latex`, `tufte-common.def` line 446: `textwidth=26pc, marginparsep=2pc, marginparwidth=12pc`. That is sidenote = **0.462x** measure, gutter = **0.077x**, frame = **1.538x**. Margin font is `\footnotesize` = 8pt against `\normalsize` 10pt/14pt - a **0.80** size ratio.
- `tufte-css` (`tufte.css`): prose `width: 55%`; sidenote `width: 50%; margin-right: -60%` resolved against the paragraph. That is sidenote = **0.500x** measure, gutter = **0.100x**, frame = **1.600x**, font ratio 1.1rem/1.4rem = **0.786**.
Independently, a 12pc sidenote at 8pt is roughly 40 characters - the bottom of Bringhurst's 40-50 multiple-column band. The manuscript-gloss tradition and Tufte's books converge on the same arithmetic: **a sidenote column is about half the measure, separated by a gutter under a tenth of the measure, set at about 0.8 of the text size, and is itself a legitimate 40-50-character column.**
I could not verify any *stated ratio in Tufte's own prose*: his "Book design: advice and examples" thread gives no measurements and defers to Bringhurst, McLean, Wilson and Williamson. **The ratios above are from the code, not from Tufte's writing.**

**7. Vertical rhythm still applies, but only as a spacing scale.**
Bringhurst §2.2.2, quoted in Rutter's *Elements of Typographic Style Applied to the Web*: "Headings, subheads, block quotations, footnotes, illustrations, captions and other intrusions... create syncopations and variations against the base rhythm of regularly leaded lines. These variations can and should add life to the page, but the main text should also return after each variation precisely on beat and in phase." Rutter's web translation is to make every vertical interval a multiple of the base line box and to recompute heading line-heights to fit. *Implication:* a true cross-column baseline grid is unattainable on the web once a second column is set at a different size; what is attainable is (i) one spacing unit for all vertical margins and (ii) first-baseline alignment between a sidenote and its reference.

**8. Units: `ch` is theoretically attractive and empirically wrong for this stack.**
Computed from the actual fonts (fontTools 4.64.0, macOS `Charter.ttc` and `Georgia.ttf`, both 2048 upem), mean advance over a 2141-character English prose corpus, no kerning:

| | mean prose advance | lowercase alphabet | `0` (= 1`ch`) |
|---|---|---|---|
| Charter Roman | 0.4385 em | 12.748 em | 0.5562 em |
| Georgia | 0.4392 em | 12.978 em | 0.6138 em |

The two faces have effectively **identical prose advance** (0.16% apart) but digits 10% apart. So a `rem`/`px` measure is *stable* across the `Charter, Georgia, serif` stack (664px -> 84.1 chars in Charter, 84.0 in Georgia), while a `ch` measure is *not* (55ch -> 69.8 chars in Charter, 76.9 in Georgia). **Keep the measure in `rem`; use Butterick's alphabet count, not `ch`, as the font-relative sanity check.**

## (b) Where the sources conflict, and my resolution

**Speed vs. comprehension vs. preference.** The screen studies that measure words-per-minute favour lines far longer than any typographer would set; the one study using an elaborate comprehension instrument (Dyson & Haselgrove 2001) reverses the ranking with no speed-accuracy trade-off; every study that asked readers what they wanted got "shorter than full screen." Dyson herself attributes part of the speed effect to reduced scrolling - an artefact of the medium, not of reading.

I resolve it by asking what this site optimises. A digital garden is read voluntarily, in one sitting, for understanding, by a reader who can close the tab. Words-per-minute is not the objective function; finishing and understanding is. That selects the comprehension-and-preference band (55-76 cpl), which WCAG then caps at 80 and Nanavati & Bias at ~70. Bringhurst's 66 sits in the middle of the intersection rather than at the edge of any one band - the classical number survives not because the empirical work confirms it but because it is the only value all three lines of evidence tolerate.

**Bringhurst 45-75 vs. Butterick 45-90.** Butterick's ceiling is for print at fixed reading distance with generous leading; the screen studies that go above 80 chars are measuring speed, not comfort. Prefer Bringhurst's ceiling, and treat 80 as the accessibility backstop.

**The marginalia constraint settles the tie.** Sidenotes need a margin; a margin needs the text column to give up width. A 66-character measure and a Tufte-proportioned margin are the same decision made twice. This is the strongest argument against the current 84-character line: it is not merely long, it leaves no room for the feature the owner is planning.

**Where I could not resolve anything because I could not read the source:** Bringhurst on running heads and folios, and Mueller-Brockmann's *Grid Systems*. I could search inside *Elements* only for phrases rare enough to surface, and neither "running heads" nor any marginalia phrasing I tried returned a hit; I did not consult the pirated scan available on archive.org. **Every claim below about apparatus alignment rests on the Van de Graaf/Tschichold canon and on Bringhurst §1.2.5, not on his running-head guidance, which I have not verified.**

## (c) Concrete numbers for this site

Base: prose 18px Charter, line-height 1.6, body padding `0 1.25rem`, `box-sizing: border-box` (so `max-width` includes 40px of padding).

**Finding first: the current measure is not what the CSS comment claims.** `max-width: 44rem` gives a 664px content box = **84.1 characters** and **2.89 alphabets**, not the "75-80 characters" the comment asserts. It is above Bringhurst's 75, above WCAG's 80, and at the very top of Butterick's 2-3-alphabet band. The comment should be corrected regardless of what else changes.

| Element | Value | Traced to |
|---|---|---|
| **Measure** | `max-width: 35rem` -> 520px content -> **65.9 chars**, 2.27 alphabets | Bringhurst §2.1.2 ideal 66; inside Butterick's band; under WCAG's 80; inside Nanavati & Bias's <=70 |
| - max defensible alternative | `40rem` -> 76.0 chars | Bernard et al. 2002 "most desirable" 76 cpl; still under WCAG 80. Use only to preserve the original "top of the band" intent |
| - hard ceiling | `41.5rem` -> 79.1 chars | SC 1.4.8 |
| **Sidenote column** | `16rem` (256px) = **0.492 x measure** | tufte-css 0.500, tufte-latex 0.462 |
| **Sidenote size** | `0.8rem` ~ 14.4px = **0.80 x prose** | tufte-latex 8/10pt; tufte-css 0.786 |
| - resulting sidenote measure | 256 / (0.4385 x 14.4) = **40.5 chars** | Bringhurst's 40-50 for multiple-column work |
| - sidenote leading | 1.45 (~20.9px), *not* on the main grid | a 14.4px note on a 28.8px grid needs line-height 2.0; align first baselines only (principle 7) |
| **Gutter** | `2.5rem` (40px) = **0.077 x measure** | tufte-latex exactly; tufte-css 0.100 |
| **TOC track** | `10rem` (160px), sans `0.85rem`, right-aligned to its gutter | apparatus convention already on the site; ~23 chars/line, enough for section labels; TOC:sidenote ~ 1:1.6, echoing the canon's inner:outer 1:2 |
| **Frame** | measure + gutter + sidenote = 816px = **51rem**, ratio **1.569 x measure** | between tufte-latex 1.538 and tufte-css 1.600 |
| **Reserved width** | `69.5rem` (1112px): 16 + 2.5 + 32.5 + 2.5 + 16 rem, reserving the sidenote width on *both* sides so the prose stays centred in the viewport | keeps one spine across page types; the TOC simply sets narrower inside its track |

**Header / footer alignment.** Align both to the **prose column** - same left edge, same right edge, on every page and every tier. The left edge of the text block is the reader's return-sweep anchor (Dyson 2004, citing Bouma 1980: "the left-hand margin should be justified"), and Bringhurst §1.2.5's margins exist to *lock the textblock to the page*; a header that runs to the frame edge creates a second rectangle with a second left edge and forces the eye to re-find the prose axis on every page. Concretely: nav, footer, `.work-meta` rules and `.work-list` all stay at 32.5rem content width; only sidenotes and the TOC live outside it. Keep the frame reserved on pages with no marginalia so the spine never shifts between an index page and an essay - a book does not reflow its text block on spreads that happen to have no glosses.

**Vertical spacing.** Base unit = the line box = 18 x 1.6 = 28.8px = **`1.8rem`** exactly (the CSS already names this number once, in `.work-list .tag`). Make every vertical margin a multiple of half that unit, `0.9rem`:
- `p, li { margin: 0.9rem 0 }`. **This is a fix, not a preference:** the current `0.5rem` margins collapse to 8px, giving 36.8px baseline-to-baseline across a paragraph break against 28.8px within - a ratio of 1.28, which **fails SC 1.4.8's "paragraph spacing at least 1.5 times the line spacing."** `0.9rem` yields exactly 43.2px, ratio 1.50.
- `h2 { margin-top: 3.6rem; margin-bottom: 0.9rem }`, `hr { margin: 3.6rem 0 }`, `blockquote { margin: 1.8rem 0 }` - all multiples.
- Heading line-heights chosen so each heading line box is exactly one 28.8px unit: `h1` (1.6em = 28.8px) -> `line-height: 1`; `h2` (1.25em = 22.5px) -> `1.28`; `h3` (1.05em = 18.9px) -> `1.524`. Then a heading of any number of lines returns the text "precisely on beat and in phase" (Bringhurst §2.2.2).

**Breakpoints.**
- **>= 69.5rem (1112px)** - full frame: TOC left, sidenotes right, prose centred.
- **54rem-69.5rem (864-1112px)** - drop the TOC track first; it is navigation and degrades to a disclosure at the top of the article. Sidenotes remain. 32.5 + 2.5 + 16 + 2x1.25 = 53.5rem, so 54rem is the floor at which the sidenote column still holds 40 characters. Below it a sidenote would fall under Bringhurst's 40-character column floor, which is the principled place to collapse.
- **35rem-54rem** - single column at 35rem centred; sidenotes become inline, collapsed blocks after their paragraph. Do not hide them: they are content.
- **< 25rem (400px)** - drop to 17px. **Move the existing 600px step down.** Under a 35rem measure the 600px step no longer does anything for the measure (at 600px the line is already 65.9 chars); the step earns its place only where the viewport pushes the line under Bringhurst's 45-character floor, which is at ~395px (a 390px phone gives 44.3 chars at 18px, 46.9 at 17px).

**One consistency note in the site's own idiom:** the existing `.work-list .tag` hang uses a 9rem track at a 64rem breakpoint. If the TOC track is 10rem, these are two numbers that must agree; per the repo's own convention they should become one custom property (`--margin-track: 10rem`) rather than two literals that can drift.

## (d) Sources

- Bringhurst, *The Elements of Typographic Style* §2.1.2, §1.2.5, §2.2.2 - quotes verified via <http://webtypography.net/2.1.2>, <http://webtypography.net/2.2.2>, and archive.org full-text search inside the book (<https://openlibrary.org/search/inside>, item `elementsoftypogr0000brin`)
- Rutter, *The Elements of Typographic Style Applied to the Web* - <http://webtypography.net/toc/>
- Butterick, *Practical Typography*, "Line length" - <https://practicaltypography.com/line-length.html>; "Page margins" - <https://practicaltypography.com/page-margins.html>
- W3C, Understanding SC 1.4.8 Visual Presentation (AAA) - <https://www.w3.org/WAI/WCAG22/Understanding/visual-presentation.html>
- Dyson, M.C. (2004), "How physical text layout affects reading from screen," *Behaviour & Information Technology* 23(6):377-393 - full text at <https://stu.westga.edu/~ssynan1/literacy/Dyson.pdf>; DOI 10.1080/01449290410001715714
- Dyson & Haselgrove (2001), *IJHCS* 54:585-612 - <https://dl.acm.org/doi/10.1006/ijhc.2001.0458> (findings taken from Dyson 2004's account, not the original)
- Dyson & Kipping (1998a); Bernard, Fernandez & Hull (2002); Youngman & Scharff (1998); Duchnicky & Kolers (1983); Gould & Grischkowsky (1986) - all as reported in Dyson 2004
- Nanavati & Bias (2005), *Visible Language* 39(2) - <https://journals.uc.edu/index.php/vl/article/view/5765> (abstract only)
- Ling & van Schaik (2006), *IJHCS* 64(5):395-404 - <https://www.sciencedirect.com/science/article/abs/pii/S1071581905001679> (unverified; publisher returned 403)
- Baymard Institute, "Line Length Readability" - <https://baymard.com/blog/line-length-readability>
- Canons of page construction (Van de Graaf 1946; Tschichold, *The Form of the Book*, 1991; Rosarivo, *Divina proporcion tipografica*, 1953) - <https://en.wikipedia.org/wiki/Canons_of_page_construction>
- `tufte-latex`, `tufte-common.def` - <http://mirrors.ctan.org/macros/latex/contrib/tufte-latex/tufte-common.def> (geometry at line 446; font sizes lines 368-389)
- `tufte-css`, `tufte.css` - <https://raw.githubusercontent.com/edwardtufte/tufte-css/gh-pages/tufte.css>
- Tufte, "Book design: advice and examples" - <https://www.edwardtufte.com/notebook/book-design-advice-and-examples/> (no measurements given)
- Font metrics computed with fontTools 4.64.0 from `/System/Library/Fonts/Supplemental/Charter.ttc` and `Georgia.ttf`
- Mueller-Brockmann, *Grid Systems in Graphic Design* - **not consulted; no claim in this report rests on it**
