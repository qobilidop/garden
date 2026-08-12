---
citekey: shaughnessy2023-cryptol-saw
work:
  title: Cryptol, SAW, and the Galois Origin Story
  author: Andrew Shaughnessy
  date: 2023-11-06
source: https://www.galois.com/articles/cryptol-saw-and-the-galois-origin-story
retrieved: 2026-08-11
notes-by: Codex GPT-5.6 Sol
notes-date: 2026-08-11
synthesis: "Cryptol and SAW form a specification-to-implementation bridge: executable cryptographic models are compared with lifted software or hardware IR, letting one verification architecture span source languages, optimized code, and RTL while concentrating trust in the lifting and proof chain."
---

# Cryptol, SAW, and the Galois Origin Story

Shaughnessy tells the history of Cryptol and the Software Analysis Workbench
(SAW) as the history of Galois itself. The corporate narrative is promotional,
but its technical epilogue exposes a useful architecture: write an executable
mathematical specification in a cryptography-specific language, lift an
implementation into a common intermediate representation, and ask a solver to
establish equivalence or selected properties between them.

## A specification language became a comparison point

Cryptol began from late-1990s work modeling cryptographic hardware and a 1999
government contract for a domain-specific language. The post says it was used
to express and compare AES candidates, later generated test vectors and logic,
and acquired a VHDL backend so a specification and a circuit description could
be reduced to comparable logic. Cryptol 2 was publicly released in 2014.

Elliptic-curve implementations made whole-circuit equivalence insufficient.
Verification needed decomposed obligations and support for implementations in
C, Java, and other languages. SAW supplied that bridge by lifting program
representations and giving users controlled access to SAT/SMT-backed proofs.
Rather than build a frontend for every source language, it targets shared IRs:
initially LLVM and JVM bytecode, later including Ghidra P-code and hardware
languages such as Verilog and Bluespec SystemVerilog.

That is the article's durable technical contribution. A common IR multiplies
language reach, but it also moves the trusted boundary. A result now depends on
the fidelity of each compiler or lifter, the semantics preserved in the IR,
the decomposition of proof obligations, and the Cryptol specification itself.
Generation backends invert the relation: Cryptol or SAW IR can produce C,
LLVM bitcode, JVM, or Verilog artifacts for use as golden models or deployable
implementations.

## Deployment evidence is real but reported by the vendor

The post describes continuous verification work with AWS Cryptography from
2015 and quotes Galois founder John Launchbury saying that 98% of the process
was automatic. It also attributes discovery of an exploitable arithmetic
error in Bouncy Castle to Cryptol-based verification and cites later use in
post-quantum-cryptography work. These are important adoption claims, but the
article does not identify the exact AWS library, denominator behind 98%, proof
maintenance cost, false-start rate, or independent evaluation. Claims of
global protection and generated implementations competitive with all public
expert code are not accompanied by benchmarks here.

No indexed Hacker News discussion was found to provide external adjudication.
The source is therefore strongest for project lineage and architecture, not
for comparative effectiveness.

The hardware connection sits beside [[baldoni2016-symbolic]] but is broader
than symbolic execution. SAW may symbolically reason about implementation IR,
while Cryptol supplies a specification and equivalence target; generated RTL,
test benches, and solver proofs cross specification, software, and hardware
boundaries. [[verbeure2019-under-hood]] starts from temporal RTL properties,
whereas this flow starts from algorithmic meaning and asks whether multiple
implementations preserve it.

- **Durable:** domain-specific executable specifications; IR-centered lifting
  across source languages; equivalence between specification and optimized
  implementation; and bidirectional use of an IR for verification and code
  generation.
- **Era-bound:** the tool backend roster, organizational history, deployment
  claims, and open-source status described in 2023.
- **Evidence boundary:** named case studies and founder recollections replace
  reproducible evaluation. The technical epilogue explains mechanism but does
  not audit the trusted computing base or compare SAW with alternatives.
- **Commercial stake:** this is a Galois marketing article about Galois tools,
  contracts, and impact. It deserves substantial discount on superlatives and
  unattributed client reports even where the underlying projects are public.

For a hardware survey, the post is a reminder that "hardware formal" need not
begin at RTL. A cryptographic algorithm can be the stable semantic object,
with software and HDL implementations treated as multiple compilation targets
whose equivalence must survive optimization and representation changes.
