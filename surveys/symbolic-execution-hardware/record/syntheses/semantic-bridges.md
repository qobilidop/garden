# Semantic bridges

## Current conclusion

The catalog's `artifact` value names the design representation about which the
paper claims—not necessarily the program interpreted by the symbolic engine.
That distinction is load-bearing. Among deep reads, the operational object may
be direct SystemC or RTL semantics, a handwritten RTL-to-C transition program,
Verilator-generated C++, lifted machine IR, a netlist translated to C, HLS
C++ source, or a coupled implementation/reference model. The manuscript must
call the facet **design target** and state the operational object separately.

## Support and limits

Harrath and Lin implement SystemC scheduler semantics directly; V2C translates
Verilog under a declared synthesis subset; SE4RDV and FuSS rely on generated
software representations; EISec translates a netlist; Hu executes HLS source;
and COVERIF, Bruns, and Rudkowski couple semantic levels. Witness replay checks
one path through a bridge. It does not establish equivalence of all source and
derived executions. Full semantic conformance is rarely demonstrated, so the
survey compares obligations rather than ranking bridge fidelity.

## Manuscript consequence

RQ2 is answered on two levels: the catalog maps design targets across all
include-level records, while the critical synthesis compares operational
representations and bridge obligations only where a deep-read note supports
them. This distinction belongs in the abstract, method, artifact, contract, and
limitations passages.
