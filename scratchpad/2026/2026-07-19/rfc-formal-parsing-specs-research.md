# Formal specs for protocol wire formats: what's been tried, what it teaches Pakeles

Question: what approaches exist for giving RFC wire formats formal / machine-readable specifications, what lessons emerged, and is "hand-write RFC specs in an IR + generate parser conformance tests" a useful value statement or just a demo?

Method: deep-research run (2026-07-19), 5 search angles, 21 primary sources fetched, 105 claims extracted, top 25 adversarially verified (3 votes each) → 22 confirmed, 3 refuted. Verified claims are marked ✓; claims cited from primary sources but not panel-verified are marked (unverified). Coverage note: the verification budget concentrated on the standards-track thread; the parser-toolchain thread rests on extracted-but-unverified primary-source claims.

## Thread 1 — notations the standards process tried

### Syntax metalanguages: ABNF, ASN.1, TLS presentation language, CDDL

- These are the notations that actually appear in RFCs. They are syntax-only: they describe the shape of data but cannot express multi-stage parsing with persistent state — e.g. in QUIC, decryption must be modelled *inside* parsing to make progress. ✓ [ANRW 2020](https://www.irtf.org/anrw/2020/anrw2020-final21.pdf)
- A refuted framing worth recording: the claim that these ad-hoc notations "are not machine-readable enough for code generation" was killed 0–3 in verification. They are machine-readable; the limitation is expressiveness (no typed semantics, no parser state), not parseability.

### Formal description techniques (Estelle / LOTOS / SDL class)

- "Formal protocol description techniques have failed to gain traction within the standards community... the vast majority of standards published do not make use of formal techniques." Reasons documented as both technical (formalisms model communication patterns, not protocol data) and social (unfamiliar concepts, tooling burden on authors, disruption to the consensus-driven prose process). ✓ [IFIP Networking 2021](https://dl.ifip.org/db/conf/networking/networking2021/1570702659.pdf), [ANRW 2020](https://www.irtf.org/anrw/2020/anrw2020-final21.pdf)

### Glasgow "Improving Protocol Standards" project — closest prior art to Pakeles

- Augmented Packet Header Diagrams (APHD): a machine-readable format deliberately designed as a minimal delta on the ASCII packet diagrams RFCs already use, "designed to maintain human readability, while also supporting automated parser generation from protocol specification documents." Expresses variable-width fields, lengths derived from other fields, presence conditions (TCP Options: `size(Options) == (DOffset-5)*32`, present only when `DOffset > 5`). ✓ [draft-mcquistin-augmented-ascii-diagrams](https://www.ietf.org/archive/id/draft-mcquistin-augmented-ascii-diagrams-13.html)
- Compiles to a typed Network Packet Representation IR: strongly typed persistent parsing context, dependently typed arrays, field/structure constraints, typed transform functions — because modern PDUs cannot be parsed in isolation (out-of-band signalling, prior packets). Demonstrated on QUIC Initial/Protected packets; prototype generates Rust (nom) parsers. ✓ [ANRW 2020](https://www.irtf.org/anrw/2020/anrw2020-final21.pdf)
- Stated adoption principles: documents stay human-first; machine-readable elements should be the canonical spec, not a duplicate; no specific tooling required of authors; minimize change to authoring workflows. (unverified) [ANRW 2020](https://www.irtf.org/anrw/2020/anrw2020-final21.pdf)
- Adoption outcome, two-sided: the standalone draft went through 13 revisions (last Oct 2023), stayed an individual submission, and expired April 2024 without WG adoption; tooling's last release Nov 2020. But the diagram style itself entered the TCP spec update and survived into RFC 9293 §3.1 — the changelog calls it "slight changes to the header diagram for compatibility with tooling." The parsable style was adopted; the constraint language was not adopted as normative apparatus. ✓ [datatracker](https://datatracker.ietf.org/doc/draft-mcquistin-augmented-ascii-diagrams/), [IFIP 2021](https://dl.ifip.org/db/conf/networking/networking2021/1570702659.pdf)
- The named gap: "With a formal representation of the protocol's syntax, it should be possible to generate test cases for that protocol. This would add to the tooling demonstrated in this paper, and contribute to a step change in how protocols are developed." Their evaluation packets were hand-built in scapy from the prose standard. Conformance-test generation from the formal syntax was explicitly future work as of 2021; no verified evidence of later work closing it. ✓ [IFIP 2021](https://dl.ifip.org/db/conf/networking/networking2021/1570702659.pdf)

### IRTF Usable Formal Methods RG (UFMRG)

- Active, chartered RG; premise is that prose specs "suffer from the ambiguity of natural language and the inability to use automated tools to reason about, and validate, the specifications." Charter treats non-technical adoption barriers (unfamiliar languages/tooling, effects on consensus-building) as first-class, and lists retroactive formal analyses of existing IETF protocols plus open-source tooling among desired outputs. Grew out of an IETF 115 side meeting (Nov 2022) that also conceded prose has been largely successful at producing interoperable implementations. ✓ [UFMRG charter](https://datatracker.ietf.org/rg/ufmrg/about/), [csperkins.org](https://csperkins.org/research/protocol-standards/)

## Thread 2 — parser-description languages and verified parsers

All claims in this section: extracted from primary sources, not panel-verified.

### EverParse / 3D (production evidence)

- Deployed in the Windows kernel (Hyper-V network virtualization stack) for years: ~100 message formats across four proprietary protocols, hand-specified in 3D; ~5,000 lines of spec generate >23,000 lines of verified C, integrated into the Windows build so ordinary developers regenerate from specs. [PLDI 2022](https://fstar-lang.org/papers/EverParse3D.pdf), [MSR blog](https://www.microsoft.com/en-us/research/blog/everparse-hardening-critical-attack-surfaces-with-formally-proven-message-parsers/)
- Expressiveness result: a small dependent type algebra — base types, refinements, dependent pairs, conditional types, **no recursion** — suffices for real packet formats up through TLS-level messages; arrays covered every unbounded structure encountered.
- Adoption was conditioned on performance parity: ≤2% cycles-per-byte overhead and zero functionality regressions; generated code met the bar and was sometimes faster (systematic double-fetch-freedom).
- Test-generation connection: after the verified parsers were integrated, existing fuzzers stopped reaching deep paths (inputs all rejected), so the team began using the formal specs to drive fuzzers that only produce well-formed inputs — spec-derived input generation emerged as a valued byproduct, not the headline. The headline value was proven-correct generated code.

### Narcissus (Coq)

- Derives encoder + decoder from one nonredundant format spec with machine-checked inverse proofs; covers Ethernet, ARP, IPv4, TCP, UDP including IP/pseudoheader checksums, union-typed fields, reserved bits, field interdependencies. Hand-written specs were compact: ~10–20 lines of declarative serialization + ~10–20 lines of type declarations per format. [arXiv 1803.04870](https://arxiv.org/pdf/1803.04870)
- Dropping the derived parsers into mirage-tcpip surfaced conformance laxness in the incumbent: one existing test *expected* packets with bad checksums to parse; the hand-written decoders skipped checksum/consistency validation the strict derived ones enforce.

### Nail / langsec

- Binary formats need offset, length, and checksum dependencies that classical grammar formalisms can't express; Nail's answer is a semantic bijection (parser = generator's inverse) plus an explicit escape hatch (`raw_depend`) for checksums/crypto rather than making the constraint language Turing-complete — flagged as a deliberate boundary on what a declarative language should express internally. [Nail langsec paper](https://people.csail.mit.edu/nickolai/papers/bangert-nail-langsec.pdf)
- Cautionary result: Nail's DNS grammar omitted label compression and therefore occasionally rejected valid real-world traffic — an incomplete formal grammar produces false rejects, poisoning spec-derived conformance/differential testing.

## Cross-cutting — test generation from formal specs, and demand

### QUIC / Ivy (the strongest existence proof) ✓

- A formal Ivy spec of draft-QUIC, compiled into a test generator using symbolic execution / weakest preconditions + SMT to produce solver-derived stimuli (the same mechanism as Pakeles's testgen), found 27 errors across four server implementations already under regular interop testing — including an off-path DoS traceable to the draft standard itself and a heartbleed-like memory leak. 18 of 23 root-caused errors required adverse stimuli outside normal protocol flow; four traced to ambiguities/contradictions in the standard. Mechanism: generated testers emit packets "legal according to the wire specification but may or may not be produced by any existing implementation" — behavior space interop testing structurally cannot reach. ✓ [SIGCOMM 2019](https://mcmil.net/pubs/SIGCOMM19.pdf), [CACM 2025](https://cacm.acm.org/research/it-takes-a-village-bridging-the-gaps-between-current-and-formal-specifications-for-protocols/)
- Cost caveats (unverified, same sources): a large fraction of the draft could not be formalized testably because normative statements reference implementation-internal events invisible on the wire; SMT packet generation was initially far too slow and reached ~10 Hz only after layering the spec and factoring large byte arrays out of solver constraints.

### TLS-Anvil (unverified)

- State-of-the-art TLS conformance suite: 408 test templates hand-extracted from RFC 2119 keywords in prose — no machine-readable spec existed to generate from. Found real bugs in 13 mature libraries (2 MatrixSSL exploits, 5 crypto issues, 15 interop issues, 116 alert-handling problems). [USENIX Sec 2022](https://www.usenix.org/system/files/sec22-maehren.pdf)
- Two lessons: (1) prose is an incomplete conformance basis — 47/408 templates cover requirements only *implicit* in the RFCs (TLS 1.2 never states MAC verification as a MUST); (2) pure differential testing against a reference implementation (miTLS, nqsb-TLS) failed as an oracle — protocols admit multiple valid responses, so false positives swamped signal. A caution for tshark-diffing as the only oracle; less severe for pure parsing (more deterministic) than for protocol behavior.
- Length-field manipulation is the big test-volume amplifier: one RFC 5246 sentence about rejecting invalid messages expands to a template per length field per message — parse-path enumeration is exactly where generation pays off.

### Frankencerts (unverified)

- 8M+ certificates generated by recombining real-certificate parts with parts synthesized from the X.509 ASN.1 grammar; differential testing found 208 discrepancies across SSL/TLS implementations, several exploitable (GnuTLS accepted any X.509 v1 cert as a rogue CA). GnuTLS's own hand-curated suite contained only v3 certs, so that bug was structurally undetectable by it. [IEEE S&P 2014](https://pmc.ncbi.nlm.nih.gov/articles/PMC4232952/)

### ParDiff / ParCleanse — the current research frontier (unverified)

- ParDiff (OOPSLA 2024): parsers harbor silent, non-crashing spec-violation bugs that fuzzing/symbolic execution can't flag without a protocol-specific oracle — and oracles don't exist because specs are prose. Its FSM + first-order-constraint model, compared via SMT, found 41 bugs (25 confirmed) across 14 protocols; differential fuzzing found 3 in the same budget and 25 with 720× more time. Example: CVE-2022-26129 (Babel/RFC 8966) reads beyond a protocol-specified TLV bound while staying memory-safe — conformance, not crash-freedom, is what implementers fail at. [ACM](https://dl.acm.org/doi/full/10.1145/3649854)
- ParCleanse (2025): generates positive and negative conformance packets from a formal format spec (LLM-extracted from RFCs); 69 bugs (36 confirmed) across nine protocols, beating ParDiff. Two directly relevant results: (1) a spec-derived oracle catches bugs *shared* by all implementations (a Babel RouterId validation bug existed in multiple independent implementations — differential testing is blind there); (2) feeding the whole constraint set to a solver explores the space poorly — effective suites isolate constraints per field/structure. Its required format syntax (arrays sized by arithmetic over other fields, tag-controlled case layouts, cross-field constraints) matches Pakeles's expressiveness checklist. [arXiv 2504.18050](https://arxiv.org/pdf/2504.18050)

### Parser differentials as the demand signal (unverified)

- LangSec 2023: spec ambiguity alone produces exploitable differentials even among standard-compliant parsers (PKI Layer Cake); grammar-based differential fuzzing finds many but guarantees nothing about completeness — the stated gap a path-complete solver-derived suite addresses. Exploited inputs are usually *outside* the specified language (parsers accept what they should reject), so reject/truncation-path coverage targets where real differentials live. Limit: parse-tree-level comparison misses semantic differentials (e.g. HTTP method-override bypasses). [LangSec 2023](https://langsec.org/spw23/papers/Ali_LangSec23.pdf)
- JSON: RFC 8259 deliberately leaves duplicate-key handling undefined and only recommends binary64 numbers; 49 parsers across ten ecosystems diverge exploitably as a direct result. Spec-level open-endedness, not implementation sloppiness, is a root cause. [Bishop Fox](https://bishopfox.com/blog/json-interoperability-vulnerabilities)
- Android Master Key: one parser read a 16-bit length as signed, another as unsigned — a wire-format-primitive differential with system-wide security impact. [LangSec 2023](https://langsec.org/spw23/papers/Ali_LangSec23.pdf)

## Design lessons for Pakeles

1. **Typed persistent parsing context is the entry ticket for modern protocols.** QUIC needs decryption modelled inside parsing; PDUs depend on out-of-band state and prior packets. Syntax-only description is the documented failure mode of ABNF/ASN.1/TLS-language. (ANRW 2020 ✓)
2. **No recursion needed.** EverParse3D's algebra (refinements, dependent pairs, conditional types, arrays) covered ~100 production formats through TLS-level messages. Boundedness is not just compatible with real formats — it's sufficient.
3. **Checksums/crypto belong behind a typed escape hatch, not in the constraint language.** Nail's argument: extending the declarative language to cover them recreates a Turing-complete language with all the original pitfalls.
4. **Solver-generation tactics matter.** Whole-constraint-set generation explores poorly (ParCleanse) — isolate constraints per field/structure. Large byte arrays inside solver constraints killed Ivy/QUIC throughput until factored out and the spec layered.
5. **Reject/truncation paths are the payload.** Exploited inputs are typically outside the specified language; hand-curated suites structurally miss whole bug classes (GnuTLS v1 certs). Pakeles's truncation/reject witnesses are aimed at the documented sweet spot.
6. **Differential oracles need a laxness story.** Reference-diffing failed for TLS behavior (multiple valid responses); for parsing it's stronger, but the tshark diff should anticipate legitimate divergence (e.g. lenient dissection of nonconforming packets — the mirage-tcpip checksum episode shows incumbents are often deliberately lax).
7. **A spec-derived oracle beats differential testing exactly where it's blind: bugs shared by every implementation.** (ParCleanse/Babel.)
8. **Grammar completeness is a correctness requirement for the spec itself.** An RFC-unfaithful spec (Nail's missing DNS label compression) false-rejects valid traffic and discredits the suite. Budget for spec validation against real captures — which Pakeles's pcap diffing already provides.
9. **Adoption follows the minimal-delta rule.** The only standards win in this corpus is a diagram style indistinguishable from existing practice (RFC 9293); every notation demanding new authoring workflow expired. Position the IR as implementer/tester tooling, not an authoring format.
10. **Scope honestly: wire-observable only.** A large fraction of QUIC's normative text is untestable from the wire (internal events). A parsing-focused spec dodges that problem by construction — worth stating as a deliberate scope choice, with the semantic-differential class (LangSec 2023) named as out of scope.

## Refuted in verification (do not reuse)

- "The APHD draft documents concrete diagram/text inconsistencies in published RFCs (QUIC RESET_STREAM naming, DHCPv6, TCP)" — 0–3. Not in the draft.
- "The ANRW 2020 paper parses standards documents ... explicitly to eliminate hand-written parsing code" — 1–2 as stated; use the verified formulations above instead.
- "IETF ad-hoc notations are not machine-readable enough for code generation" — 0–3. The limitation is expressiveness, not machine-readability.

## Open questions

- Per-protocol authoring cost at RFC scale: Narcissus suggests tens of lines per classic header; Ivy/QUIC suggests expert-heavy effort for stateful modern protocols. Where does the Pakeles IR land?
- Does path-complete symbolic generation measurably beat Ivy-style randomized spec-based testing per unit of authoring effort?
- Demonstrated *paying* consumers of generated conformance suites (conformance labs, dissector maintainers, auditors) — this corpus shows research demand, not commercial demand.
- Strongest first demo targets: protocols with documented differential/conformance pain. Candidates from this corpus: Babel/RFC 8966 (shared-bug story), DNS (compression pitfalls), TLV-heavy routing protocols (ParDiff's hunting ground), X.509/DER if scope ever extends to serialization.

## Verdict: value statement or demo?

Both — and defensibly a value statement, under one positioning condition.

For: (1) the mechanism is proven — spec-derived, solver-generated tests found draft-standard-level flaws and implementation bugs in QUIC that years of interop testing missed (✓); (2) the gap is named but unfilled — the group closest to the RFC process explicitly listed conformance-test generation from formal syntax as future work in 2021 and hand-built its test packets in scapy (✓); (3) demand is institutionally acknowledged — UFMRG's charter asks for exactly "formal analyses for existing IETF protocols, or open source software" (✓); (4) the current research frontier (ParDiff, ParCleanse) is converging on the same architecture — formal format model + solver-derived positive/negative packets — from the harder direction of extracting the model from code or LLMs, which makes a hand-authored, validated IR the clean-input version of what others are approximating.

Against, and the condition: every notation that asked RFC authors to change how they write died; the one adoption win was invisible. So the value statement holds only when aimed at implementers, testers, and auditors (conformance suites, differential harnesses, parser hardening) — not at RFC authors. "Write the spec once, get a path-complete conformance suite with reject/truncation witnesses" is a claim no surveyed system delivers today: Glasgow generated parsers but not tests; EverParse generates proofs, with fuzzing corpora as a byproduct; Ivy generates randomized (not path-complete) tests at high spec-authoring cost; TLS-Anvil hand-wrote its suite from prose. The demo — a few RFC protocols specced by hand, suites generated — is simultaneously the evidence for the value statement, provided each demo protocol comes with at least one bug or divergence the suite actually surfaces.
