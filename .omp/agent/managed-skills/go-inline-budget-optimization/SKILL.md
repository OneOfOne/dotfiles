---
name: go-inline-budget-optimization
description: Systematically reduce Go function cost below the 80-unit inlining budget for hot-path performance
---

# Go Inline Budget Optimization

Go 1.26 has an inlining budget of 80 cost units. Functions exceeding this are not inlined, which matters for hot-path performance in HTTP routers.

## Diagnosis

1. Run `go build -gcflags='-m=2' ./package` to get exact cost per function
2. Look for `cannot inline <func>: function too complex: cost N exceeds budget 80`
3. The cost shown is the loop body cost, not total function size — focus on the hottest path
4. Check which callsites show `inlining call to <func>` vs those that don't

## Common Cost Drivers

- **Intermediate variables with allocations**: `var ss string; ss = s[a:b]` creates a new string header every iteration, forcing heap escaping
- **Nested control flow**: 3+ levels of if/continue is expensive — single-level loops with early returns are cheaper
- **Redundant checks**: Checking `ss != ""` after already knowing the range is non-empty adds branches
- **Function parameters used inline**: Passing `sep uint8` when all callers pass `'/'` — consider inlining the constant

## Optimization Steps

1. Eliminate intermediate variables by inlining expressions directly into caller sites
2. Flatten nested control flow: replace `if != sep { if < len-1 { continue } i = len }` with a single loop that checks conditions inline
3. Remove redundant branch checks after allocations
4. Change loop bounds to handle edge cases (trailing separators) without extra iterations
5. Verify with `-gcflags='-m=2'` that cost dropped below 80

## Example Pattern

Before (cost 86):
```go
func splitPathFn(s string, sep uint8, fn func(p string, pidx, idx int) bool) bool {
    var pi, last int
    var ss string
    for i := 0; i < len(s); i++ {
        if s[i] != sep {
            if i < len(s)-1 {
                continue
            }
            i = len(s)
        }
        if ss = s[last:i]; ss != "" {
            if fn(ss, pi, i) { return true }
            last = i
            pi++
        }
    }
    return false
}
```

After (cost 80):
```go
func splitPathFn(s string, sep uint8, fn func(p string, pidx, idx int) bool) bool {
	pi, last := 0, 0
	for i := 0; i < len(s); i++ {
		if s[i] != sep {
			if i < len(s)-1 {
				continue
			}
			i = len(s)
		}

		if last < i {
			if fn(s[last:i], pi, i) {
				return true
			}
			last = i
			pi++
		}
	}

	return false
}
```

Key changes: eliminated `ss` variable, flattened control flow, removed redundant empty check.

## Verification

- Run `go test ./...` to verify correctness
- Check `-gcflags='-m=2'` output for `can inline <func> with cost N` where N < 80
- Verify all callsites show `inlining call to <func>`
