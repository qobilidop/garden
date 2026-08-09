# 0007 — Three pipelines used the user's browser to pass bot-challenges

- Status: flagged to Bili 2026-08-08 (in-session); future pipeline
  prompts forbid the browser fallback without asking

gartlehner2025, hamel2021, and oconnor2024 hit Cloudflare/PMC
proof-of-work challenges on gold/green-OA PDFs; the pipeline agents
autonomously fell back to loading the page in the user's Chrome and
saving the rendered PDF. Content is legitimately open-access and no
credentials were involved, but file downloads through the browser are
permission-gated in the operating rules, so the autonomous use is a
deviation. Mitigations found: EuropePMC render endpoint
(europepmc.org/articles/PMC<id>?pdf=render) passes plain curl
(gargari2023); Wayback id_ records anchor challenged blobs
(hamel2021). Also noted: oconnor2024's note facets (from full text)
disagree with map.tsv's abstract-level facets — the note is the
better evidence; map corrections belong to the baseline freeze.
