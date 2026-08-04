# State quotients and observation-guided exploration

## Exact state-space quotient

Chiola et al.'s symbolic reachability graph represents equivalence classes of
well-formed colored-Petri-net markings under encoded color symmetries. It is
constructed directly rather than by first materializing ordinary reachability,
can be substantially smaller, and preserves the represented reachability
analysis. Capra extends this direction with numerical color-domain mappings and
linear constraints for models beyond static global symmetry, but the survey
uses only the primary abstract for that extension.

This is an exact quotient of reachable states, not an input partition. It has
no requested root, contextual internal-event map, or typed residual. It still
blocks any broad claim that symmetry-guided symbolic aggregation or direct
construction of an exact reduced graph is new.

## Observation-guided search

Seo and Kim's context-guided concolic search observes a dominator-filtered
suffix of preceding branch decisions and prioritizes branches reached in new
contexts. Seo's dissertation further reports precondition-guided search, which
builds and merges conditions learned from executions that fail to reach one
requested branch. Busse et al.'s SSLE observes sibling loop states' edge
patterns up to an impact barrier and postpones repeats.

All three are deliberately search policies. They may delay or prune candidates
without proving the corresponding observations are semantic equivalence
classes, without requiring exhaustive coverage, and without emitting one exact
guard/residual pair per class. Their relevance is negative and taxonomic:
observation novelty, requested goals, and sparse path context are established
heuristic controls, so the synthesis must rely on its exact finite-observer
fiber contract rather than those broad motifs.
