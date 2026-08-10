#import "../../../style.typ": proposition, theorem, proof

= Compositional extension <sec-composition>

The core framework treats one requested graph independently of any
implementation strategy. This section extends that semantics to sequential
components. It states when demand-parametric guarded summaries preserve the
same observations as graph flattening, including contextual site identity and
sharing. The result is an exactness theorem, not a compactness claim.

== Graph substitution and sharing

Consider sequential components $G_1 : X -> Y$ and $H : Y -> Z$ with disjoint
site namespaces and a type-preserving bijection
$rho : I_H -> O_(G_1)$. Flattening removes the input nodes of $H$, retains one
context-prefixed copy $c dot (V_H without I_H)$, and redirects every edge that
targeted $i in I_H$ to $rho(i)$. Call the resulting graph $F$. Two uses of one
retained node in either component remain shared; a second component occurrence
receives a different contextual prefix.

Embed every downstream node into the flattened graph by

$
  iota_H(v) = cases(
    rho(v) & "if " v in I_H,
    c dot v & "if " v in.not I_H,
  ),
  quad O_F = iota_H(O_H).
$

For input $x$ and requested roots $R subset.eq O_H$, define the boundary
valuation $y_i = op("val")_x(rho(i))$. The downstream enabled closure determines
the demanded boundary inputs and hence the upstream root demand:

$
  delta_H = I_H inter D_H(y,R),
  quad R_1 = rho(delta_H).
$

#proposition("flattening and contextual sharing")[
  The flattened enabled closure decomposes as
  $
    D_F(x,iota_H(R)) inter c dot (V_H without I_H)
      = c dot (D_H(y,R) without I_H)
  $
  and
  $
    D_F(x,iota_H(R)) inter V_(G_1) = D_(G_1)(x,R_1).
  $
  Consequently,
  $
    T_F(x,iota_H(R))
      = T_(G_1)(x,R_1) union c dot T_H(y,R).
  $
  The union is compatible and records each shared internal site once.
]

#proof[
  A topological induction first gives value substitution: every retained $H$
  node in $F$ has the value it has under boundary valuation $y$, while every
  $G_1$ node keeps its value under $x$. Enabled reachability among retained
  $H$ nodes therefore follows exactly $D_H(y,R) without I_H$. Its boundary
  crossings are exactly $delta_H$ and are redirected to $R_1$. Starting from
  those roots, the upstream restriction is exactly $D_(G_1)(x,R_1)$; no other
  retained $H$ edge enters $G_1$. Restricting both sets to selection sites
  yields the observation equation. Root-demand union preserves sharing, and
  contextual prefixes make distinct occurrences disjoint.
]

Operationally, picture a pipeline $G_1 arrow.r H$. A downstream summary for
$H$ says which boundary inputs it needs. Those ports select the requested roots
for an upstream summary of $G_1$; the upstream residuals are then substituted
into the downstream guard and residual. The contract below states exactly when
that familiar substitution covers each flattened-graph input once.

A _demand-parametric exact summary_ is defined by the structural projection

$
  Pi_(G,R)(x) = (delta_G(x,R), T_G(x,R)),
  quad delta_G(x,R) = I_G inter D_G(x,R).
$

#proposition("demanded-port locality")[
  If $Pi_(G,R)(x)=(delta,tau)$ and a typed input $x'$ agrees with $x$ on
  $delta$, then
  $
    Pi_(G,R)(x')=(delta,tau)
    quad "and" quad
    op("val")_(x')|_R=op("val")_x|_R.
  $
]

#proof[
  Couple a topological value induction with the reachability approximants of
  the enabled closure. Every operand of a reached ordinary node is reached,
  and the selector operand of every reached selection is reached. Therefore
  every external input capable of changing a reached value, observed outcome,
  or subsequently enabled edge lies in $delta$. Agreement on those inputs
  preserves values on the current closure; equal selection outcomes then
  preserve the next reachability approximant. Induction gives the same closure,
  structural projection, and requested values.
]

For every $(delta,tau) in op("im")(Pi_(G,R))$, the summary has exactly one
record $(g,delta,tau,r)$ with

$
  g : product_(i in delta) cal(D)_i -> BB,
  quad r : product_(i in delta) cal(D)_i
    -> product_(o in R) cal(D)_o,
$

such that, for every full component input $x in cal(X)_G$,

$
  g(x|_delta) <=> Pi_(G,R)(x)=(delta,tau),
  quad g(x|_delta) => r(x|_delta)=op("val")_x|_R.
$

This is the _exact-summary contract_. It is a full-domain contract with no
independent precondition: if an interface precondition mentions an otherwise
undemanded input, that input must be charged as interface support. For fixed
$R$, the lockstep argument behind the exact observed-outcome guard shows that
$tau$ determines $delta$; the demanded-port set remains explicit because it is
needed by component interfaces.

For a downstream record
$(h,delta_H,tau_H,r_H)$ of $H$ at demand $R$, and an upstream record
$(g,delta_1,tau_1,r_1)$ of $G_1$ at demand $rho(delta_H)$, the summary contract
gives the following exact guard and residual types:

$
  h : product_(i in delta_H) cal(D)_i -> BB,
  quad r_H : product_(i in delta_H) cal(D)_i
    -> product_(o in R) cal(D)_o,
$

$
  g : product_(j in delta_1) cal(D)_j -> BB,
  quad r_1 : product_(j in delta_1) cal(D)_j
    -> product_(o in rho(delta_H)) cal(D)_o.
$

Thus every expression below consumes precisely the demanded boundary tuple.
For a full caller input $x$, write $x|_(delta_1)$ for its restriction to the
demanded upstream ports. Reindex the upstream residual at the downstream inputs
by

$
  hat(r)_1(x)_i = r_1(x|_(delta_1))_(rho(i)), quad i in delta_H.
$

Their composed record is

$
  (g(x|_(delta_1)) and h(hat(r)_1(x)),
   delta_1,
   tau_1 union c dot tau_H,
   r_H(hat(r)_1(x))).
$

Infeasible guard conjunctions are discarded.

#theorem("exact guarded-summary composition")[
  The feasible composed records form exactly the structural partition of
  $F$: every caller input satisfies one record; its demanded inputs,
  contextual observation, and residual agree with flattened evaluation; and
  no two records have the same composite structural projection.
]

#proof[
  The concrete boundary value selects one exact downstream record. Its
  $delta_H$ selects the upstream demand and hence one exact upstream record.
  Demanded-port locality makes both selections and both residuals depend only
  on the displayed port restrictions, so the component contracts are
  well-typed rather than assumptions about ignored inputs. Guard and residual
  substitution, together with the flattening proposition, proves soundness and coverage. If two composed records had the same
  structural projection, disjoint contextual namespaces would make both
  component observations equal. The observed-outcome lockstep argument fixes
  their demanded boundary sets, so the exact-summary contract makes both
  component records, and hence the composed records, identical.
]

This is equality with flattening, not a compactness theorem. A summary may
contain one family for each of $2^(abs(O_H))$ root-demand sets, and compatible
record products may still be exponential. Guard substitution and exact
piecewise residual composition are established techniques
@geyer2010mode; the graph-specific
content is requested-root demand, demanded-input propagation, contextual
identity, and preserved DAG sharing.
