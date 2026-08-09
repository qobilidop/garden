---
citekey: felizardo2024
work:
  title: "Data extraction for systematic mapping study using a large language model - a proof-of-concept study in software engineering"
  author: "Katia Romero Felizardo, Igor Steinmacher, Márcia Sampaio Lima, Anderson Deizepe, Tayana Uchôa Conte, Monalessa Perini Barcellos"
  venue: "Proceedings of the 18th ACM/IEEE International Symposium on Empirical Software Engineering and Measurement"
  date: 2024
  doi: 10.1145/3674805.3690743
read: abstract-only
source: "abstract via OpenAlex (abstract_inverted_index) and Semantic Scholar, cross-checked identical; OA search: no OA PDF found: unpaywall closed, OpenAlex best_oa_location=null, Semantic Scholar openAccessPdf.status=CLOSED, no arXiv preprint found by title search"
facets:
  stage: "extract"
  contribution: "evaluation"
  setting: "se"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "ChatGPT-4o data-extraction accuracy in one SE mapping study"
---

# Data extraction for systematic mapping study using a large language model - a proof-of-concept study in software engineering

## Evidence

- Proof-of-concept study: authors used ChatGPT-4.o to extract data for
  **one systematic mapping study (SMS)** and compared the model's
  extraction against the results the team had produced manually for
  that same SMS.
- Headline result: **accuracy of ChatGPT-4.o was 87.83%** against the
  manually-extracted ground truth. No further breakdown given in the
  abstract (no per-field accuracy, no precision/recall/F1, no
  inter-rater/agreement statistic, no count of extraction fields or
  primary studies covered).
- Framing: data extraction in SMS is characterized as "effort-demanding
  and time-consuming," motivating LLM assistance for this specific SR
  stage (distinct from screening/search).
- Authors' own conclusion is explicitly a **partial-automation**
  recommendation, not full replacement: "entirely replacing the manual
  data extraction with ChatGPT-4.o is not recommended," but
  "semi-automated data extraction to aid in evidence synthesis in SMS is
  promising." This is a direct, first-party accuracy-ceiling judgment
  from the same team running the comparison, not an external critique.
- DBLP record confirms venue as the ESEM '24 companion/short-papers
  track (conf/esem/FelizardoSLDCB24); this is presented as preliminary/
  proof-of-concept work, not a full empirical study.

## Bearing on RQs

Directly relevant to RQ2 (reliability): a named accuracy figure
(87.83%) for LLM-assisted data extraction against human-produced ground
truth, in the SE setting — the same stage and domain as sys0's own
mapping-study practice, giving this note above-average bearing on the
survey's own methodology even at abstract-only depth. The single-number,
single-SMS design (no breakdown by field/study, no second model, no
agreement statistic beyond raw accuracy) limits it to a landscape/anchor
data point for RQ1's extraction-stage cluster rather than a
methodologically strong RQ2 benchmark; full text would be needed to see
whether 87.83% is a simple field-match rate or something more granular,
and to check for failure-mode analysis.

## Evidence limits

- Abstract-only: ACM Digital Library is closed access; unpaywall
  (is_oa=false, oa_status=closed), OpenAlex (best_oa_location=null),
  and arXiv title search (zero hits) all returned no OA copy. No
  self-archived copy found via web search either — a differently-titled,
  later (2025) ICSEA paper by an overlapping-topic search surfaced but is
  a distinct work, not this one.
- All facts above are from the abstract only (OpenAlex/Semantic Scholar,
  text-identical); no method detail (extraction schema, number of
  primary studies/fields extracted, prompting approach, how "accuracy"
  was computed) is available beyond what's quoted.
- Single SMS, single model (ChatGPT-4.o), no comparison model or
  cross-domain replication signal in the abstract — explicitly framed by
  the authors themselves as preliminary/proof-of-concept.
- Should be revisited for full-text deep-read if ACM access becomes
  available, given the direct RQ2/SE-setting relevance.
