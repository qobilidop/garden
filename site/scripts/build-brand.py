#!/usr/bin/env python3
"""Derive the logo variants and favicons from brand/ into site/public/.

brand/logo.svg is the canonical mark and brand/favicon.svg its 16-unit
reduction for tab icons; both are 1-unit stroke paths on a unit grid,
stroke="currentColor". Everything else is a derived view:

  site/public/brand/logo-black.svg   stroke #000 (light backgrounds)
  site/public/brand/logo-white.svg   stroke #fff (dark backgrounds)
  site/public/brand/logo-auto.svg    #000, #fff under prefers-color-scheme: dark
  site/public/brand/logo-black.png   black on white, the 1024² master raster
  site/public/brand/logo-white.png   white on black, same framing
  site/public/favicon.svg            brand/favicon.svg as the auto variant
  site/public/favicon.png            black on white, 32², raster fallback

The master raster puts the 9×22 mark in 1024² at 40 px per unit,
exactly centered (even px/unit keeps the half-unit center on a whole
pixel): 880 px tall, 86% of the frame, feet at 90% of the inscribed
circle's radius; halves to 512 and 256 on whole pixels. It is the one
raster to upload anywhere.

No dependencies beyond the standard library: the canonical path grammar
is `M<col> <row>h<len>|v<len>` tokens (square caps), so the glyph is a
cell set and the PNG is an exact area-coverage render of it.
"""
import re
import struct
import zlib
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
SRC = REPO / "brand" / "logo.svg"
FAVICON_SRC = REPO / "brand" / "favicon.svg"
PUBLIC = REPO / "site" / "public"
STROKE = re.compile(r'stroke="currentColor"')
TOKEN = re.compile(r"M(-?\d+) (-?\d+)([hv])(\d+)")
FAVICON_PNG_SIZE = 32  # 2 px per unit of the 16-unit favicon grid
MASTER_PNG_SIZE = 1024
MASTER_PX_PER_UNIT = 40  # even, so the odd-width mark centers on whole pixels
AUTO_STYLE = (
    "<style>path{stroke:#000}"
    "@media(prefers-color-scheme:dark){path{stroke:#fff}}</style>"
)


def attr(svg: str, name: str) -> str:
    m = re.search(rf'{name}="([^"]*)"', svg)
    assert m, f"no {name} attribute in {svg[:60]!r}"
    return m.group(1)


def cells_of(svg: str) -> set[tuple[int, int]]:
    cells = set()
    for x, y, o, n in TOKEN.findall(attr(svg, "d")):
        x, y, n = int(x), int(y), int(n)
        cells |= {(y, x + i) if o == "h" else (y + i, x) for i in range(n + 1)}
    return cells


def variant(svg: str, color: str) -> str:
    return STROKE.sub(f'stroke="{color}"', svg)


def auto(svg: str) -> str:
    return STROKE.sub('stroke="#000"', svg).replace("<path", AUTO_STYLE + "\n  <path", 1)


def square(svg: str, side: float) -> str:
    """Center the glyph's viewBox on a square canvas of `side` units."""
    x, y, w, h = (float(v) for v in attr(svg, "viewBox").split())
    assert side >= max(w, h), f"frame {side} smaller than glyph {w}x{h}"
    box = f"{x - (side - w) / 2:g} {y - (side - h) / 2:g} {side:g} {side:g}"
    return re.sub(r'viewBox="[^"]*"', f'viewBox="{box}"', svg)


def png_gray(size: int, svg: str, cells: set[tuple[int, int]], invert: bool = False) -> bytes:
    """Glyph on a solid ground, exact area coverage; `svg` supplies the viewBox.
    Default black on white; `invert` gives white on black."""
    x0, y0, w, _ = (float(v) for v in attr(svg, "viewBox").split())
    s = w / size  # canvas units per pixel

    def overlap(p: int, lo: float) -> float:
        """Fraction of pixel p's extent inside the unit interval [lo, lo + 1]."""
        return max(0.0, min((p + 1) * s, lo + 1) - max(p * s, lo)) / s

    # cell (r, c) spans x in [c - .5, c + .5], y in [r - .5, r + .5]; coverage
    # factors into a per-row x profile times a per-pixel-row y weight.
    rows = {r for r, _ in cells}
    wy = {r: [overlap(p, r - 0.5 - y0) for p in range(size)] for r in rows}
    xprof = {
        r: [sum(overlap(px, c - 0.5 - x0) for rr, c in cells if rr == r) for px in range(size)]
        for r in rows
    }
    raw = bytearray()
    for py in range(size):
        raw.append(0)  # filter: none
        live = [(wy[r][py], xprof[r]) for r in rows if wy[r][py] > 0]
        for px in range(size):
            cov = min(1.0, sum(w * prof[px] for w, prof in live))
            raw.append(round(255 * (cov if invert else 1 - cov)))

    def chunk(kind: bytes, body: bytes) -> bytes:
        return struct.pack(">I", len(body)) + kind + body + struct.pack(">I", zlib.crc32(kind + body))

    return (
        b"\x89PNG\r\n\x1a\n"
        + chunk(b"IHDR", struct.pack(">IIBBBBB", size, size, 8, 0, 0, 0, 0))
        + chunk(b"IDAT", zlib.compress(bytes(raw), 9))
        + chunk(b"IEND", b"")
    )


def main() -> None:
    svg = SRC.read_text()
    cells = cells_of(svg)
    out = PUBLIC / "brand"
    out.mkdir(parents=True, exist_ok=True)
    (out / "logo-black.svg").write_text(variant(svg, "#000"))
    (out / "logo-white.svg").write_text(variant(svg, "#fff"))
    (out / "logo-auto.svg").write_text(auto(svg))
    master = square(svg, MASTER_PNG_SIZE / MASTER_PX_PER_UNIT)
    (out / "logo-black.png").write_bytes(png_gray(MASTER_PNG_SIZE, master, cells))
    (out / "logo-white.png").write_bytes(png_gray(MASTER_PNG_SIZE, master, cells, invert=True))
    favicon = FAVICON_SRC.read_text()
    (PUBLIC / "favicon.svg").write_text(auto(favicon))
    (PUBLIC / "favicon.png").write_bytes(png_gray(FAVICON_PNG_SIZE, favicon, cells_of(favicon)))
    print(f"brand: {len(cells)} cells -> {out.relative_to(REPO)}/, favicon.svg, favicon.png")


if __name__ == "__main__":
    main()
