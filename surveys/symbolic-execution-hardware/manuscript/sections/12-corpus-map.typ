= Include-level corpus map <sec-corpus-map>

This table exposes the complete 31-publication map behind the aggregate matrix
in @sec-method. “Target” names the hardware representation about which the
paper makes its claim; it need not be the executor's operational input.
“Depth” separates the 17 source-anchored technical readings from the 14
mapping-only chronology and facet records.

#let corpus = csv("../../record/catalog.tsv", delimiter: "\t", row-type: dictionary)
#let included = corpus.filter(
  row => row.at("status") == "deep-read" or row.at("status") == "included"
).sorted(key: row => row.at("year") + row.at("title"))
#let cells = included.map(row => (
  [#row.at("year")],
  [#row.at("title")],
  [#row.at("artifact")],
  [#row.at("execution")],
  [#row.at("goal")],
  [#row.at("evidence")],
  [#if row.at("status") == "deep-read" { [deep] } else { [map] }],
)).flatten()

#set text(size: 7.2pt)
#table(
  columns: (6%, 31%, 12%, 13%, 13%, 13%, 8%),
  inset: 2.2pt,
  stroke: 0.35pt,
  table.header(
    repeat: true,
    [*Year*], [*Publication*], [*Target*], [*Regime*], [*Goal*],
    [*Evidence*], [*Depth*],
  ),
  ..cells
) <tab-corpus-map>
#set text(size: 10.5pt)

The canonical rows, rationales, URLs, and citation-chase provenance remain in
the public survey record; this rendered table is a direct view, not a second
hand-maintained data source.
