---
citekey: weng2026-scaling-laws
work:
  title: Scaling Laws, Carefully
  author: Lilian Weng
  date: 2026-06-24
source:  # snapshot → shadow; figures (15 PNGs) → store
  url: https://lilianweng.github.io/posts/2026-06-24-scaling-laws/
  archived:  # none yet — SPN triggered 2026-08-10; retry on next touch
  # The interactive toy simulation remains executable in the HTML snapshot;
  # 15 load-bearing plots went to store, while one decorative image was omitted.
discussions:
  - https://news.ycombinator.com/item?id=48689744  # 2026-06-26
retrieved: 2026-08-10
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-10
synthesis: "Scaling laws are extrapolation instruments, not universal constants: their value comes from regime-specific empirical regularity, while parameter counting, fit range, optimizer termination, numerical precision, and finite-data repetition can materially move the inferred compute-optimal frontier."
---

# Scaling Laws, Carefully

Lil'Log technical survey (25-minute read, 15 references) reconstructing how
deep-learning scaling laws grew from learning curves into a practical method
for allocating a fixed compute budget between model parameters and training
data. Weng's contribution is not a new law or experiment. It is a connected,
equation-level account of three regimes that are often discussed separately:
classical loss predictability, compute-optimal language-model training with
effectively unlimited unique data, and training when high-quality data must be
repeated. The post ends by turning the history's disagreements into a fitting
discipline: extrapolation is useful only when definitions and non-scale factors
are controlled, and small procedural differences can become large forecast
errors orders of magnitude away from the fitted runs.

## Predictability has a regime

The starting object is a joint empirical loss model,
$\hat L(N,D) \approx A/N^\alpha + B/D^\beta + E$. Earlier learning-curve
work supplies two qualifications that remain important after the formula
became associated with large language models. First, the straight line occupies
only a middle region between small-data near-guessing and an irreducible-error
floor. Second, model size and data interact: the Hestness plots show small
models plateauing as data grows, while the Rosenfeld surfaces make the fitted
region and extrapolated configurations explicit. A power-law fit is therefore
not a claim that one exponent governs every scale or every source of error.

Kaplan et al. made this predictability operational for Transformer language
models and supplied the familiar training-compute approximation $C \approx
6ND$. Their fitted compute-optimal frontier, $N_\text{opt} \propto C^{0.73}$,
favored making models grow faster than their token budgets: for 10× more
compute, about 5.5× more parameters and 1.8× more tokens. Hoffmann et al.'s
Chinchilla experiments instead made three complementary estimates—training-
curve minima, IsoFLOP profiles, and a parametric loss fit—and put both model
size and tokens near $C^{0.5}$. The resulting 70B-parameter Chinchilla used
roughly four times the tokens of 280B-parameter Gopher at the same compute and
outperformed it.

The post's useful move is to resist treating this as a clean replacement of
one universal coefficient by another. Kaplan's experiments covered a smaller
model regime and excluded embeddings from parameter and compute counts;
Chinchilla included them. Through Pearce and Song's reconciliation, the
Kaplan-like exponent becomes a *local* slope produced by the embedding-heavy
small-model regime, while the slope tends toward the Chinchilla value as
models grow. An exponent can encode a measurement convention and a fit window,
not only a property of learning.

## Finite data changes the model, not just the token count

Classic compute-optimal laws assume effectively unlimited unique, already
cleaned data. Once data repeats, total tokens $D$ cease to measure independent
training signal. The post follows three increasingly explicit treatments of
that failure:

- Hernandez et al.'s controlled mixtures show plateaus and double descent as a
  small repeated subset is emphasized; scaling curves can worsen midway
  through training rather than decay smoothly.
- Muennighoff et al. split tokens into unique data $U_D$ and repetitions $R_D$
  and replace raw data/model size with discounted effective quantities. The
  fitted value of another pass decays toward a ceiling, and the model
  underestimates the final loss of some heavily repeated failing runs.
- Lovelace et al. replace the symmetric effective-size assumption with an
  explicit overfitting penalty that grows with repetitions and the capacity
  ratio $N/U_D$. Their plots show larger models suffering more from repetition;
  a strong-weight-decay case reduces, but does not erase, the penalty.

The practical conclusion is sharper than “repetition is bad.” Under a unique-
data constraint, extra epochs can be worth more than extra parameters, but
their value is diminishing and depends on model capacity and regularization.
Both data-limited formulas remain empirical curve fits; Weng explicitly leaves
their exact functional forms and free parameters theoretically unexplained.

## Fitting is part of the claim

A scaling experiment is interpretable only if scale is the changing factor.
Architecture, optimizer, learning-rate schedule, batch ramp, tokenizer, data
mix, and tuning quality otherwise enter the exponent through the back door.
The Besiroglu et al. replication makes the point concrete: in the Chinchilla
parametric fit, averaging rather than summing tiny Huber losses changed the
L-BFGS-B termination behavior; early termination affected the estimates and
confidence intervals; rounding $\alpha$ and $\beta$ to two decimals distorted
derived coefficients.

The embedded toy simulation turns those warnings into an instrument. Starting
from a known synthetic loss surface, it varies reported loss precision,
milli-loss-scale noise, and whether the fit sees small, medium, or all model
sizes. Each can move the recovered parameters and extrapolation. The lesson is
not that scaling laws are fragile enough to discard, but that a forecast must
travel with its parameter-count convention, training regime, fit region,
optimization procedure, precision, residuals, and uncertainty.

## Assessment

Like the later [[weng2026-harness]], this is an opinionated researcher's map
rather than a neutral bibliography. Here the narrower subject and worked
derivations make the editorial joins especially valuable: the post connects
the Kaplan–Chinchilla disagreement, its partial reconciliation, finite-data
extensions, and a replication failure into one argument about extrapolation
discipline.

- **Durable:** the separation of infinite- and finite-data regimes; the demand
  to hold non-scale factors fixed; and the principle that definitions, fitting
  code, residuals, and uncertainty are part of a scaling-law result rather
  than implementation trivia.
- **Era-bound:** the concrete frontier-training constraints and the newest
  data-repetition model are snapshots of 2026 practice. Better data mixtures,
  architectures, objectives, or regularization can move the fitted constants
  and may require different functional forms.
- **Caveats:** this is a selective secondary synthesis, not an independent
  replication or systematic review. Its two sketches for *why* power laws
  arise are hypotheses, and the data-limited forms remain phenomenological.
  The ChatGPT-created toy simulation is explanatory evidence about sensitivity,
  not evidence that any particular production forecast failed.

The post earns its “carefully”: a scaling law is best read as a calibrated
instrument with a stated operating range, not as a universal constant of
intelligence.
