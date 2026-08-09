---
citekey: arno2022-accuracy-and-efficiency-of-machine-learning-assisted-risk-of-bias-assessments-in-real-world-systematic-reviews
work:
  title: "Accuracy and Efficiency of Machine Learning–Assisted Risk-of-Bias Assessments in “Real-World” Systematic Reviews: A Noninferiority Randomized Controlled Trial"
  author: "Anneliese Arno, James Thomas, Byron Wallace, Iain J. Marshall, Joanne E. McKenzie, Julian H. Elliott"
  venue: "Annals of Internal Medicine"
  date: 2022
  doi: 10.7326/m22-0092
read: abstract-only
source: "abstract via PubMed (PMID:35635850) and Europe PMC; metadata via OpenAlex and Unpaywall; OA search: no OA PDF found: unpaywall closed, Semantic Scholar openAccessPdf empty, Europe PMC isOpenAccess=N/hasPDF=N, no UCL Discovery or Monash Research Repository copy"
facets:
  stage: "appraise"
  contribution: "evaluation"
  evidence: "human-agree"
  setting: "med"
retrieved: 2026-08-08
notes-by: Claude Sonnet-class (survey deep-read pipeline)
notes-date: 2026-08-08
synthesis: "RobotReviewer-assisted vs. blank-form RoB assessment, noninferiority RCT"
---

# Accuracy and Efficiency of Machine Learning–Assisted Risk-of-Bias Assessments in “Real-World” Systematic Reviews: A Noninferiority Randomized Controlled Trial

## Evidence
- ML system: RobotReviewer, used to prepopulate a Cochrane risk-of-bias (RoB) assessment form (the "old" RoB 1 tool, per Cochrane-review context) with machine-suggested judgments and supporting-quote highlights, which reviewers could accept, edit, or override.
- Design: noninferiority RCT, two parallel arms, individually randomized 1:1 — RobotReviewer-prepopulated form vs. blank form — conducted February 2018 to May 2020, using Covidence systematic-review software.
- Participants: systematic reviewers naive to RobotReviewer, recruited as review teams conducting real Cochrane (or Cochrane-standard) health systematic reviews — not a simulated/retrospective corpus but embedded in live review production ("real-world" framing in the title contrasts with prior lab-only RobotReviewer evaluations, e.g. Gates et al.).
- Recruitment/completion: 15 teams recruited, only 7 completed the trial; 145 studies had RoB assessed across those teams — substantial attrition (>50% of recruited teams did not complete).
- Primary outcomes: (1) individual reviewer overall RoB-assessment accuracy against a reference standard, (2) person-time (minutes) per assessment. Secondary outcome: domain-level (per-RoB-domain) accuracy.
- Accuracy result: RobotReviewer-assisted arm 88.8% vs. blank-form arm 90.2% overall accuracy — met the noninferiority criterion (RobotReviewer-assisted assessments were noninferior, not superior).
- Time result: inconclusive/imprecise — abstract reports a possible ~1.40-minute time saving per assessment with RobotReviewer assistance, but confidence is described as low ("inconclusive").
- Conclusion (authors' own framing): "RoB assessments conducted with RobotReviewer assistance are noninferior in accuracy to those conducted without RobotReviewer assistance" — an equivalence/non-harm claim, not an efficiency-gain claim, given the inconclusive time data.

## Bearing on RQs
Directly relevant to RQ2 as a pre-LLM appraisal-stage baseline: this is a risk-of-bias/appraisal-stage (not screening-stage) automation evaluation, using a pre-LLM, purpose-built ML tool (RobotReviewer, trained/fine-tuned classifiers + span extraction, not a general-purpose generative model) in a human-in-the-loop prepopulate-and-edit design rather than autonomous judgment. It is one of very few RCT-level (not just retrospective-agreement) evaluations of automation in the appraisal stage, and the "real-world" framing (live Cochrane review teams, not simulated corpora) is a useful contrast point for RQ2's evidence-quality question — most other sources in this survey are retrospective/simulated accuracy studies at the screening stage, not RCTs at appraisal. The noninferiority (not superiority) result and inconclusive time savings are a useful calibrating data point against inflated efficiency claims for later LLM-based appraisal tools.

## Evidence limits
- Abstract-only: full text is paywalled (Annals of Internal Medicine, ACP journals — 403 on direct fetch); no OA copy found via Unpaywall, Semantic Scholar, Europe PMC, UCL Discovery (EPPI-Centre is UCL-affiliated), or Monash Research Repository (co-authors affiliated with Monash). Per pipeline policy, no pirate-mirror fallback was attempted.
- All facts above are drawn from the PubMed/Europe PMC abstract only — no access to full methods (e.g., exact RoB domains assessed, statistical test for the accuracy comparison, per-domain secondary-outcome numbers, or the reasons 8/15 teams did not complete).
- Substantial attrition (7/15 teams completed) is reported but its effect on generalizability/bias is not assessable without full text (no sensitivity analysis or attrition-bias discussion available at abstract level).
- Predates general-purpose LLM-based appraisal tools by several years (2018–2020 trial period, published 2022); RobotReviewer is a narrow, RoB-specific ML system rather than an LLM agent, so relevance to this survey's core (agent-assisted review) is as a methodological/baseline anchor, not as a directly comparable agentic method.
