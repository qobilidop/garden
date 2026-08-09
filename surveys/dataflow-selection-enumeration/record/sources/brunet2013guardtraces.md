# brunet2013guardtraces — Guard dependencies in dataflow traces

- **Status:** screened; close concrete-trace dependency representation
- **Primary source:** https://doi.org/10.1109/CICSYN.2013.26
- **Version read:** Lund University institutional record and abstract
- **Bibliography key:** `brunet2013guardtraces`

## Evidence locations

- Institutional abstract: the method reconstructs a dynamic-dataflow
  program's feasible design space from a serial execution trace by using a
  homotopy-based representation.
- Dependency representation: the paper adds explicit Guard Enable and Guard
  Disable dependencies, carried in a tuple, to represent input-dependent actor
  behavior.
- Publication metadata: CICSyN 2013, pages 291--295.

## Relationship and evidence limit

The representation records more than token flow: it preserves guard-sensitive
dependencies for concrete action firings and is therefore a close precedent
for selection-sensitive dataflow analysis. Its input is a completed serial run
and its output is a finite, approximate design space. It neither enumerates all
symbolic caller-input fibers nor attaches a general residual value to every
guard observation.
