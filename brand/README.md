# brand/

Two canonical glyphs, one grammar. `logo.svg` is the personal mark;
`favicon.svg` is its reduction for 16 px tab icons, which exists only
because 16 px exists. Every other rendering is derived from them by
`site/scripts/build-brand.py` at site build and served under
<https://qobilidop.com/brand/> — never committed.

## Canonical form

- A glyph on a unit grid, drawn as one `<path>` of 1-unit strokes with
  square caps. Each `d` token is one stroke, `M<col> <row>h<len>` or
  `v<len>`, where `len` is the run length in cells minus one
  (`M0 7h8` = row 7, columns 0–8). Grid coordinates are cell centers,
  hence the `-.5 -.5` viewBox origin.
- `logo.svg`: 9×22, tight viewBox. `favicon.svg`: 8×14 on its 16×16
  frame (`viewBox="-.5 -.5 16 16"`) — the frame is part of the design,
  an even width that centers exactly at 16 and 32 px.
- `stroke="currentColor"`: inline it or use it as a CSS mask and it
  takes the surrounding text color; as a plain `<img>` it renders black.
- Edit the token list, not a rendering; the build script parses exactly
  this grammar.

## Derived renderings

One name, one axis: `logo` + glyph color; a PNG's ground is the opposite
of its glyph.

| path | what |
| --- | --- |
| `/brand/logo-black.svg`, `/brand/logo-white.svg` | fixed color, for light / dark grounds |
| `/brand/logo-auto.svg` | black, white under `prefers-color-scheme: dark` |
| `/brand/logo-black.png`, `/brand/logo-white.png` | the master raster: 1024², an even number of pixels per unit so the mark is exactly centered and pure black and white, sized to sit inside a circle crop — the one file to upload anywhere (framing constants in `site/scripts/build-brand.py`) |
| `/favicon.svg`, `/favicon.png` | `favicon.svg` as the auto variant; 32² black-on-white fallback (2 px/unit) |
