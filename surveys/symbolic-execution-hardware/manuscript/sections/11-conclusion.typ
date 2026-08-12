= Conclusion <sec-conclusion>

Symbolic execution of digital hardware designs is a coherent survey scope when
the name is tied to an operational test. The design or faithful executable
representation must run with symbolic hardware values; distinguishable
control- or time-indexed paths must have predicates; feasibility must affect
which execution is constructed next; and that mechanism must produce the
paper's verification evidence. This boundary includes classical, concolic,
and selective-hybrid execution. It excludes symbolic simulation, STE, BMC,
trace-only search, and generic synthesizable-source analysis unless they also
meet the same path conditions.

The bounded map is neither empty nor enormous. Thirty-one full-text-qualified
works support a focused account, with RTL at the center and smaller SystemC,
mixed-level, netlist, other-HDL, and HLS edges. The concentration of the corpus
is itself informative: path-conditioned execution is a specialized hardware-
verification niche whose strongest use is often generation of a difficult,
replayable witness.

Hardware changes the technique at its semantic core. Time, scheduling,
concurrency, reset, translation, and environment determine path identity and
claim strength. Guidance, backward search, fragments, caching, time
abstraction, and fuzzing handoffs make useful searches practical by relocating
work, not by generally eliminating the behavioral product.

The resulting discipline is simple. State the executed artifact, initial
state, time model, environment, exactness, returned evidence, and completion.
Report positive witnesses separately from bounded exhaustion and incomplete
search. With semantic conformance, shared benchmarks, outcome partitions, and
effort measurements, this small field can become much easier to evaluate and
reuse without losing the narrow definition that makes it intelligible.
