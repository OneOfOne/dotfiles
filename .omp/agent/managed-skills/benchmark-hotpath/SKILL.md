---
name: benchmark-hotpath
description: "Add performance benchmarks to hot-path functions that run on every state update (settings, auth, etc.) to establish baselines and catch regressions"
---

# Benchmarking Hot-Path Functions

Hot-path functions in this codebase (like `diffObjects`, `fetch`, `store` operations) run on every state update. Establish performance baselines with Jest benchmarks.

## Procedure

1. **Identify the function** — find where it's called frequently (search for usage patterns, check state updates).

2. **Create benchmark file** — add a new `describe('X benchmarks')` block to the existing test file (e.g., `utils/__tests__/diff.test.ts`).

3. **Design test scenarios** — cover these categories:
   - **Primitives** — same value (fast path) + different values
   - **Small objects** — one property changed + identical (fast path)
   - **Nested objects** — 3-level deep change (recursive nesting)
   - **Arrays** — same length with change + different lengths (short-circuit)
   - **Null handling** — null → object expansion + object → null expansion

4. **Set iteration counts** — choose iterations so each test completes in ~20-50ms:
   - Primitives: 1M iterations (fast, no allocation)
   - Small objects: 100K iterations
   - Nested objects: 10K iterations
   - Arrays: 100K iterations
   - Null expansions: 100K iterations

5. **Use `performance.now()`** — measure elapsed time, assert it's under 500ms (sanity check).

6. **Run with filter** — `bun jest diff --testNamePattern="benchmarks"`

## Example Pattern

```typescript
describe('diffObjects benchmarks', () => {
  describe('primitive throughput', () => {
    it('primitives (same value)', () => {
      const a = 42;
      const b = 42;
      const iterations = 1_000_000;
      const start = performance.now();
      for (let i = 0; i < iterations; i++) {
        diffObjects(a, b);
      }
      const elapsed = performance.now() - start;
      expect(elapsed).toBeLessThan(500); // sanity: should be fast
    });
  });
});
```

## Key Points

- **Fast paths matter** — test both the optimized (same value) and normal case
- **Short-circuits matter** — test cases that exit early (array length mismatch, null expansions)
- **Keep it fast** — benchmarks should complete in <500ms total
- **Run selectively** — use `--testNamePattern="benchmarks"` to run only benchmarks
