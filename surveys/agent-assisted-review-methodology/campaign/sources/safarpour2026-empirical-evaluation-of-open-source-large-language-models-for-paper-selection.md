# safarpour2026-empirical-evaluation-of-open-source-large-language-models-for-paper-selection — Open-source LLMs vs. GPT for title-only screening

- **Status:** abstract-only (no OA PDF found: unpaywall closed, OpenAlex closed, no arXiv preprint)
- **Work:** doi:10.1109/saner-c67878.2026.00047
- **Source:** abstract via Semantic Scholar (DOI:10.1109/SANER-C67878.2026.00047) and OpenAlex
- **Facets:** stage=screen, contribution=evaluation, setting=se

## Evidence
- Benchmarks open-source LLMs against a proprietary model for title-only relevance screening in scoping reviews: Mistral v2 (7B) and Llama 3.3 (70B) vs. GPT-4.1.
- Three SE literature domains, each a separate screening dataset by paper count: verbalization methods (9,265 papers), program slicing (5,942 papers), reactive programming (9,942 papers) — 25,149 papers total across domains.
- Screening pipeline uses paper titles only (no abstracts) to make large-scale scoping-review screening feasible.
- Validation method: model outputs checked against expert reviewers via two protocols — blind review (reviewers do not see model predictions) and informed review, with informed review focused only on cases of model/reviewer disagreement.
- Reported finding (qualitative, no numeric accuracy/precision/recall/F1 given in the abstract): "Results show varying performance across domains and models. Mistral and Llama show different patterns than GPT, with more conservative screening." Authors conclude open-source LLMs are "reproducible and cost effective," positioning them as viable local alternatives to commercial LLM/API screening.
- Motivation cited for open-source alternatives: data sovereignty, reproducibility, and long-term cost concerns with relying on commercial LLM/bibliography-service APIs for large-scale screening.
- No open-vs-proprietary performance gap is quantified in the abstract — only the directional claim that Mistral/Llama screen "more conservatively" than GPT-4.1.

## Bearing on RQs
Bears on RQ2 (reliability/metrics) by name only — the abstract asserts a model-vs-model performance comparison and a validation protocol (blind + disagreement-focused informed review) but supplies no extractable numbers (no accuracy, precision/recall, or agreement statistics), so it cannot support quantitative synthesis without the full text. Bears on RQ4 (model-family independence) as a directly relevant design: a three-model, open-vs-proprietary comparison (Mistral v2 7B, Llama 3.3 70B, GPT-4.1) is exactly the kind of cross-family evidence RQ4 asks for, and the claimed "different screening patterns" between open and proprietary models is a candidate data point for model-family diversity arguments — contingent on obtaining the full text to extract actual figures.

## Evidence limits
- Abstract-only: no PDF accessible via unpaywall (is_oa=false, oa_status=closed), OpenAlex (best_oa_location=null), or arXiv title search (zero hits). IEEE closed-access companion proceedings (SANER-C 2026).
- All facts above are drawn from the abstract text (Semantic Scholar/OpenAlex) only; no numeric performance metrics, dataset composition (positive/negative label counts), or statistical tests could be verified — the abstract explicitly withholds these.
- Single-institution study (University of Szeged); no cross-institution replication signal available at abstract level.
- Should be revisited for full-text deep-read if IEEE Xplore access becomes available, given direct relevance to RQ4.
