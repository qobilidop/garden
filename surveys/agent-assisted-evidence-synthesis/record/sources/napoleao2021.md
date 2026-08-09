---
citekey: napoleao2021
work:
  title: "Automated Support for Searching and Selecting Evidence in Software Engineering: A Cross-domain Systematic Mapping"
  author: "Bianca Minetto Napoleao, Fabio Petrillo, Sylvain Halle"
  venue: "2021 47th Euromicro Conference on Software Engineering and Advanced Applications (SEAA)"
  date: 2021
  doi: 10.1109/seaa53835.2021.00015
read: full-text
source: "shadow/library/papers/2021/napoleao2021-automated-support-for-searching-and-selecting-evidence-in-software-engineering/transcript.md"
facets:
  stage: "search"
  contribution: "evaluation"
  setting: "se"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "Automated Support for Searching and Selecting Evidence in Software Engineering: A Cross-domain Systematic Mapping"
---

# Automated Support for Searching and Selecting Evidence in Software Engineering: A Cross-domain Systematic Mapping

## Evidence

- **Scope:** a pre-LLM systematic mapping (search window through Dec 2020) of automation support for the search and selection stages of secondary studies, run cross-domain (SE vs. medicine) to transplant more-mature medical automation practice back into SE. Text Classification (TC: text mining + ML) is the organizing lens throughout, not LLMs — this is the classical-ML baseline the survey's LLM-era works supersede.
- **Search/selection funnel:** automatic search across IEEE Xplore, ACM DL, Scopus, Web of Science returned 212 items → 184 after dedup/removing conference announcements → 28 candidates after title/abstract/keyword screening → 24 included after full-text (Stage 1). Snowballing seed set = 24 + 1 well-known medicine TC-for-SLR review (O'Mara-Eves et al., >300 citations, 93 references); 4 backward + 3 forward iterations added 42 new studies (Stage 2), stopped on yield decay. Total included: 66 studies — coincidentally 33 SE / 33 medicine. First-author selection, second-author review, 100% agreement reported (no kappa given).
- **RQ1 (search/selection automation approaches, SE):** of automated approaches identified, 14 studies address only selection, 4 address only search, 1 study ([17], Ros et al. 2017) integrates search+selection — **Finding 1: integrated search+selection approaches are largely unexplored.** Visual Text Mining (VTM), introduced to SE in 2007 (Malheiros et al.), recurs across the approach timeline (Fig. 2, 2007–2020); SVM and active learning are the most recent models with the strongest reported results (**Finding 2**).
- **RQ1 (tools, SE):** Table II catalogs 7 general SLR tools (SLR-TOOL 2010, SLuRp 2012, Slrtool 2014, SESRA 2015, StArt 2016, SLR Toolkit 2018, SLR-Tool 2020) and 5 specific search/selection tools (PEx 2007, ReViS 2014, SLR.qub 2015, SLRPSS 2017, FAST2 2018; 3/5 use VTM). None fully automates search or selection — all are partial-support only.
- **RQ2 (TC approaches, cross-domain, Table III):** SE explores a wider variety of TC techniques; medicine is more consolidated around Naïve Bayes and SVM. Approaches explored in SE but not (yet, per this mapping) in medicine: HFSRM, VSM, LSA, Reinforcement Learning, Decision Trees, Rules7, BACA, VTM. Approaches explored in medicine but not SE: Rocchio, LDA, LMT, Neural Network (**Finding 4**, framed as a bidirectional transfer opportunity).
- **Practical adoption gap (Finding 5):** medicine reports practical use/evaluation of 8 distinct well-established screening tools (Abstrackr, RobotAnalyst, DistillerSR, RelRank, SWIFT-Review) vs. only 2 in SE (StArt, ReViS) among the selected studies — attributed to prototype-only status, broken access links, weak validation/documentation, and poor usability. Most studies in both fields provide no replication package or working tool link.
- **RQ3 (assessment methods/metrics):** 46/66 studies report an assessment. Cross-validation (10-fold most common, 7 studies; then 5-fold, 5 studies; 7-fold, 1; Monte-Carlo, 1 — Hassler et al.) and experiment-against-manually-conducted-SLRs are the two dominant assessment methods (**Finding 6**). Metrics (Table IV): recall/precision/F-measure used by 21/46 studies (45.65%); WSS@95% used in 11 medicine studies vs. only 1 SE study; AUC, Burden, Yield, Utility appear only in medicine studies — a quantified cross-domain gap in evaluation rigor/maturity, not just tooling.
- **Discussion:** validation across studies is fragmented (single-DL corpora, small/heterogeneous populations), preventing head-to-head efficiency comparison across proposed approaches; the paper frames SLR-update scenarios (training data = the original SLR's included/excluded set) as the most promising near-term TC application (citing Watanabe et al. and Felizardo et al.'s update-context results).

## Bearing on RQs

- **RQ1 (landscape, search stage):** direct pre-LLM SE anchor for the search and selection stages — establishes the classical TC/ML/VTM baseline (tools, approach families, adoption levels) that later LLM-based screening/search work in this survey should be read as extending or displacing. Also the paper the survey's own cross-domain (SE-vs-medicine) framing echoes, applied here one generation earlier and to non-LLM methods.
- **SE anchor:** wholly SE + medicine dual-domain mapping (33/33 split), giving quantified cross-domain baselines (tool count, adoption, metric maturity) useful as a "before LLMs" comparison point for any RQ2 claims about how much LLM-era work has closed the SE-vs-medicine automation-maturity gap.

## Evidence limits

Construct validity: automated search did not query medical databases directly (relied on general DLs + one medicine snowball seed); authors judge coverage sufficient but this is a stated, not verified, mitigation. Conclusion validity: heterogeneous datasets/approaches/metrics across the 66 studies (and frequent lack of released code/data) explicitly prevented the authors from performing quantitative cross-approach performance comparison — the mapping stays descriptive/categorical rather than pooling accuracy numbers across studies. No inter-rater reliability statistic given beyond "100% agreement" between two reviewers on inclusion decisions.
