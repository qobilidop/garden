# Prior surveys & related work

Existing surveys, by lineage — the related-work anchors and the "am I reinventing this?" check. Confidence noted.

**Gap-check run 2026-06-20 (web search).** Bottom line: **no unifying cross-lineage survey under this project's framing was found** — the gap holds. The closest existing umbrella ("An Overview of Formal Hardware Specification Languages") is ~2002, verification-framed, and predates executable ISA specs entirely. Per-lineage surveys exist but stop at lineage boundaries. New items found are folded in below and marked `[found 2026-06-20]`.

**Naming-collision warning.** "A Survey of Architecture Description Languages" (Medvidovic & Taylor, IEEE, 1997/2000), AADL (SAE standard), and ISO/IEC/IEEE 42010 are all about **software/systems architecture** — a *different field* that happens to share the "ADL" acronym. Not the processor/hardware ADLs (nML, LISA) this survey means. Don't conflate; cite the Mishra & Dutt lineage, not the Medvidovic lineage.

## ADLs — thoroughly surveyed

- Mishra & Dutt, *Processor Description Languages* (Morgan Kaufmann, 2008). Book-length survey.
- Mishra & Dutt, "Architecture Description Languages for Programmable Embedded Systems" (IEE Proceedings — Computers and Digital Techniques, 2005).
- Tomiyama, Halambi, Grun, Dutt, Nicolau, "Architecture Description Languages for Systems-on-Chip Design" (APCHDL, 1999).
- Qin & Malik, "Architecture Description Languages for Retargetable Compilation" — chapter in *The Compiler Design Handbook* (2002).

## Synchronous languages — well-mapped

- Benveniste, Caspi, Edwards, Halbwachs, Le Guernic & de Simone, **"The Synchronous Languages 12 Years Later"** (Proceedings of the IEEE, 2003). The canonical survey.
- Halbwachs, *Synchronous Programming of Reactive Systems* (Kluwer, 1993). Book.

## Formal hardware specification languages — the closest existing umbrella

- **"An Overview of Formal Hardware Specification Languages"** `[found 2026-06-20]` — a taxonomy of formal HW spec languages aimed at standard-compliance verification. Circa 2002, verification-framed, and **predates Sail / executable ISA specs entirely**. The closest thing to this project's umbrella that exists — but stale and on a different axis (verification, not the spec→derived-tooling story). Worth reading as "the last time someone tried the umbrella, and what's changed since."
- Chen, **"A Short Historical Survey of Functional Hardware Languages"** (ISRN Electronics, 2012) `[found 2026-06-20]` — functional HW languages (Lava, ReWire, Clash lineage). Adjacent: clean-semantics functional descriptions; some sit near the spec boundary.

## Formal hardware verification — adjacent, not the topic

These survey the *consumer* of specs (proving designs correct), not executable specification itself. Useful for framing the boundary.

- Kern & Greenstreet, "Formal Verification in Hardware Design: A Survey" (ACM TODAES, 1999).
- Gupta, "Formal Hardware Verification Methods: A Survey" (Formal Methods in System Design, 1992).
- Garavel, ter Beek & van de Pol, "The 2020 Expert Survey on Formal Methods" `[found 2026-06-20]` — broad formal-methods landscape; context, not specific to HW spec.

## Executable formal ISA specification — no dedicated survey found

Confirmed by the 2026-06-20 search: no standalone survey. Knowledge lives in related-work sections of primary papers, and the field is *active* (these are primary works, not surveys, but anchor the related work):

- Armstrong et al. (Sail), POPL 2019 — related-work section.
- Reid, ASL papers (FMCAD 2016 and follow-ups); ASL formal-semantics tutorial at POPL 2024 `[found 2026-06-20]`.
- Dasgupta et al., "A Complete Formal Semantics of x86-64 User-Level ISA" (PLDI 2019) `[found 2026-06-20]`.
- "A Complete Formal Semantics of eBPF ISA for Solana" (PACMPL 2025, Isabelle/HOL) `[found 2026-06-20]`.
- "Accurate and Extensible Symbolic Execution of Binary Code based on Formal ISA Semantics" (arXiv 2404.04132, 2024) `[found 2026-06-20]` — directly the spec→symbolic-executor derived-artifact story.
- "The Simulation Semantics of Synthesisable Verilog" (arXiv 2502.19348, 2025) `[found 2026-06-20]`.

## The cross-lineage synthesis — confirmed gap

No survey draws the boundary this project draws: ADLs + synchronous + ISA-semantics + mechanized-HDL, compared across the model-of-computation spine. The per-silo surveys exist; the cross-silo comparison is the gap. (As confirmed as a negative can be at this search depth — absence of evidence, not proof.)

## Verification status

- [x] Web search to confirm no unifying survey under this framing — confirmed, gap holds.
- [x] Catch recent per-lineage / primary work post-cutoff — folded in above, marked `[found 2026-06-20]`.
