---
citekey: lombaers2024
work:
  title: "Reproducibility and Data Storage for Active Learning-Aided Systematic Reviews"
  author: "Peter Lombaers, Jonathan de Bruin, Rens van de Schoot"
  venue: "Applied Sciences (MDPI), open access"
  date: 2024-04-30
  doi: 10.3390/app14093842
read: full-text
source: "https://www.mdpi.com/2076-3417/14/9/3842"
facets:
  stage: "screen"
  contribution: "guideline"
  evidence: "none"
  setting: "general"
retrieved: 2026-08-09
notes-by: Claude Sonnet 5
notes-date: 2026-08-09
synthesis: "RDAL checklist: reproducibility/data-storage prescriptions for active-learning-aided screening"
---

# Reproducibility and Data Storage for Active Learning-Aided Systematic Reviews

## Evidence

- Scope is deliberately narrow and explicitly bounded: only the
  *screening phase* of a systematic review using active learning (AL)
  for screening prioritization. The authors state they "do not look
  further at other phases of a systematic review, such as database
  searching or data extraction," "do not look at topics such as the
  performance of AI-aided screening or biases in AI-aided screening,"
  and do not consider AI use in phases other than screening. This is
  a reproducibility/data-storage paper, not an effectiveness or
  bias-evaluation paper.
- Defines "researcher-in-the-loop" (RITL) active learning against
  "classical" active learning (Box 1/Box 2): RITL requires (1) the
  primary output is the list of labeled records, not the trained
  model; (2) the annotator must have seen all relevant records by the
  end of the process; (3) the process must be transparent and
  reproducible. This is offered as a definitional/architectural
  constraint, not a voluntary best practice: under RITL, the model
  only ranks/prioritizes unscreened records for human review — "we do
  not want the model to make the final decision about whether an
  article is relevant." Software cited as implementing this pattern:
  Abstrackr, ASReview, Colandr, FASTREAD, Rayyan, RobotAnalyst,
  Research Screener, DistillerSR, robotreviewer.
- Names the specific PRISMA 2020 gap motivating the paper: the base
  PRISMA checklist item on automation only says to "specify the
  methods used to decide whether a study met the inclusion criteria
  of the review, including... details of automation tools used";
  the PRISMA 2020 expanded checklist adds two items (report how
  automation was integrated into study selection; if ML was used to
  prioritize screening, state the software and screening rules) —
  the paper argues these remain "not enough" for AL-aided pipelines
  because the annotator only ever sees part of the data, so two
  screeners on an identical dataset with identical inclusion criteria
  can diverge in which records get included, and PRISMA's items don't
  specify what must be stored to diagnose or resolve that divergence.
- Three reproducibility levels applied to the screening phase
  (adapting Goodman & Fanelli's method/results/inferential
  reproducibility taxonomy): "method reproducibility" (identical
  input, annotator, model choice, initial training set →  identical
  trained models, rankings, and labels in identical order);
  "results reproducibility" (same system, different annotator, same
  final included-record set); and a broader functional definition
  specific to RITL — final included-record set is stable even if
  other choices (model, feature extraction) vary — plus "inferential
  reproducibility" (final conclusions of the review are robust to
  variation in which records were screened).
- Concrete storage prescriptions (RDAL Checklist, "Reproducibility and
  Data storage for Active Learning-Aided [Systematic Reviews]
  Checklist"), reconstructed from the paper's Section 5 recommendations
  and the worked application to ASReview v1.0 (Appendix A; item
  numbering and "must store" status below are from that applied
  table, cross-checked against the generic Section 5 prose):
  1. Project metadata (title, description, contact, roles) — advised
     for pre-registration.
  2. Process: team/roles, collaboration plan, how the AL pipeline will
     be used — pre-registration only, not software-stored.
  3. Inclusion/exclusion criteria — pre-registration only.
  4. Software name plus version number.
  5. Intended model components: feature-extraction method,
     classifier, query strategy, balancing strategy.
  6. Intended stopping rule for labeling — pre-registration only.
  7. Training-data selection process and the prior-knowledge labels
     used to seed the model.
  8. Input data: persistent identifiers (e.g. DOIs) and, where
     copyright permits, the actual texts screened.
  9. Output data: every record's final label — seen-and-relevant,
     seen-and-irrelevant, or unseen.
  10. The feature matrix/matrices used.
  11. Random seed values (to make probabilistic model behavior
      reproducible; the paper flags that many GPU-trained models are
      not fully deterministic even with a fixed seed).
  12. Order of labeling and any changed labeling decisions.
  13. The actual model used per iteration (if it changed across
      iterations).
  14. Which record(s) trained which model iteration (recommended as:
      store the *count* of labeled records per iteration, not the
      record list again, since that is recoverable from item 9 in
      labeling order — this is the paper's key data-minimization
      move, turning quadratic relevance-score storage into a linear
      storage cost).
  15. Model output/relevance scores per iteration — marked optional;
      the paper's own worked example stores only the last iteration's
      ranking to save space.
  Publication guidance: items 1–7 should be pre-registered before data
  collection (e.g. OSF, PROSPERO); items 1–14 should be stored in a
  general-purpose or domain-specific repository under an open license
  (CC-BY 4.0 named as an example).
- Central technical argument (Sections 3–4): naively storing every
  active-learning model iteration's full relevance-score output scales
  *quadratically* with dataset size (worked example: ~8MB for 1,000
  records/1,000 model iterations, ~800MB at 10,000/10,000, terabytes
  at ~1,000,000) because there is one score per record per iteration
  and iterations scale with labeled records. The paper's proposed
  minimal-storage scheme (store model type + training-set size per
  iteration, not full relevance scores or record lists) instead scales
  linearly, trading exact/immediate reproduction for exact
  *reconstructability* (retraining from stored settings + seeds
  reproduces the same scores, at the cost of the original training
  time).
- Validation/adoption status: NOT validated or piloted on a real,
  completed systematic review, and not adopted by any software beyond
  the authors' own worked illustration. The checklist is demonstrated
  by application to one open-source tool, ASReview v1.0 (which two of
  the three authors — de Bruin and van de Schoot — are core
  developers of), showing which of the 15 checklist items ASReview's
  own output currently satisfies. Per that table, ASReview stores
  items 1, 4, 5, 8, 9, 10, 12, 13, 14 as software output, but items 2,
  3, 6, and 11 (team/roles, inclusion criteria, stopping rule, and —
  notably — random seed values) are NOT stored by the software itself
  and are left to the user's pre-registration; item 7 (prior-knowledge
  selection/labels) is only partly captured. This is a conformance
  self-check of one tool against its own authors' checklist, not an
  independent validation study, a multi-tool comparison, or an
  evaluation against real reproduction attempts.
- AI role stance: implicitly and structurally on the "AI as
  ranking/triage assistant, human retains the final decision" side —
  RITL's second defining criterion (the annotator must see all
  relevant records) makes human review of every included record a
  precondition of the method itself, not a QA-style secondary check
  after the fact and not an AI-primary-with-human-validation
  arrangement either; the paper does not frame this as a normative
  recommendation to weigh against alternatives (e.g. it does not
  discuss or endorse fully autonomous AI screening as a design
  option), it only describes the reproducibility implications of the
  RITL architecture as practiced by the named tools.
- Discussion/limitations (author-stated, Section 7): explicitly defers
  AI-screening bias evaluation and effectiveness to future work,
  suggesting the Noisy Label Framework and the SAFE stopping-rule
  procedure as candidate follow-on methods; also flags that standard
  inter-rater-reliability metrics (e.g. Cohen's Kappa) are complicated
  in AI-aided reviews by data missing-not-at-random (records the model
  never surfaces), pointing to alternative IRR metrics as future work.

## Bearing on RQs

RQ3 (norms): a distinct kind of guidance source for this survey — a
storage/reproducibility checklist for one operational stage (AL
screening) rather than a disclosure-of-AI-use checklist across stages
(cf. holst2025, degen2024, fernandes2026). It does not compete with or
duplicate the disclosure-content core the synthesis identifies (tool
name/version, stage/task, human role, verification): it assumes that
core and adds a fourth axis the norms synthesis does not currently
track — what raw *data* (not just narrative disclosure) must be
retained for an AI-aided review stage to be independently
reconstructable, at what storage cost, and with what
reproducibility/storage trade-off. Item 4 (software+version) and item
5 (model/strategy components) overlap with the existing disclosure
core; items 7, 11–14 (training-data provenance, seeds, per-iteration
model identity, labeling order) go beyond anything the five norms
sources catalogued in the synthesis currently specify. Also
unvalidated/unadopted beyond its authors' own tool, consistent with
the synthesis's "none reports validation or adoption" pattern for
guidance instruments — this is a fourth unvalidated instrument, in a
different sub-genre (data-storage, not disclosure-reporting).
Bears on RQ4 (design gap): RITL's structural requirement that the
annotator see every included record is itself an independence/verification
design choice — it keeps AI in a ranking-only role and locates the
inclusion decision with the human on every record, which is closer to
gartlehner2025/hamel2021's human-decision-retained line than to
fernandes2026's AI-first-pass-with-human-validation sanction, though
argued from a reproducibility rationale rather than a
risk-of-missed-studies rationale. No bearing on RQ2 (reliability): the
paper explicitly excludes AI-screening performance/accuracy from its
scope.

## Evidence limits

- Not an empirical evaluation: no application of the RDAL checklist to
  a completed, real systematic review; the only worked example
  (Section 6.2/Appendix A) is a hypothetical/illustrative screening
  sequence on ASReview v1.0, authored by two of ASReview's own
  developers — a conformance self-check, not an independent
  validation or field test, and a conflict-of-interest-adjacent
  demonstration (evaluating one's own tool against one's own
  proposed checklist).
- Checklist item numbering and per-item "must-store" status in this
  note are reconstructed from the paper's Section 5 prose
  recommendations plus the Appendix A table applied to ASReview; the
  paper's own generic "Table 2: The RDAL Checklist" (as distinct from
  the ASReview-specific application table) was not separately
  machine-extractable as text (only one `<table>` element rendered
  extractable text on the publisher page — presumed to be the
  Appendix A / ASReview-application table based on its
  software-specific "Stored Where?" column); Table 3 (the worked
  model-iteration data slice) was likewise not extracted. Cross-check
  against the PDF/HTML tables was not performed.
- Explicitly out of scope, by the authors' own statement: AI-aided
  screening performance, accuracy, or bias; database-search and
  data-extraction phases; any phase other than screening. Findings
  here cannot be used to support or refute claims about AI screening
  reliability (that is RQ2's territory, covered by other sources).
- Domain-general/methodological, not tied to health/medical settings;
  no claims here should be read as sanctioning or restricting any
  particular AI role beyond what RITL's own definition (human sees
  every included record) implies.
