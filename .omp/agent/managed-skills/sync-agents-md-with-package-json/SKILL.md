---
name: sync-agents-md-with-package-json
description: "When updating AGENTS.md or after any dependency changes, cross-reference package.json versions against AGENTS.md to ensure accuracy"
---

# Sync AGENTS.md with package.json

## When to Use
After any dependency update, when reviewing AGENTS.md for accuracy, or when asked to update documentation.

## Procedure

1. **Read `package.json`** — focus on `devDependencies`, `dependencies`, and `resolutions` sections. Extract exact version strings (e.g., `~56.2.11`, `^19.1.0-rc.1`).

2. **Compare against AGENTS.md's Tech Stack Notes section** — check each line:
   - Expo SDK / Expo Router version
   - React version
   - Reanimated version
   - React Native version
   - TypeScript version
   - Any other major framework/library versions

3. **Identify stale entries** — common patterns of drift:
   - Shorthand versions (e.g., `56`) that should be more precise (e.g., `~56.2.11`)
   - Exact versions that changed (e.g., Reanimated 4.2.1 → 4.3.1)
   - Major version jumps (e.g., TypeScript 5.9.x → 6.0.3) — these are critical to flag

4. **Identify missing entries** — packages in package.json that aren't documented:
   - `react-native-paper` + `react-native-paper-dates`
   - `@shopify/flash-list`
   - Other significant dependencies that affect developer workflow

5. **Update AGENTS.md** — make targeted edits to the Tech Stack Notes section only. Do not change unrelated sections.

6. **Verify** — re-read the updated section to confirm all versions match package.json exactly.

## Key Rules
- Never guess versions from memory — always read package.json first
- Major version jumps (TypeScript 5→6, React Native 0.83→0.85) are high-risk; always note them
- Use exact version strings from package.json when available (`~`, `^`, exact)
- If a version is already correct, leave it alone — don't "improve" working documentation

## Project-Specific Notes
- This project uses TypeScript ~6.0.3 (not 5.9.x) — a major version bump that affects type inference
- Expo SDK 56 ecosystem: all expo-* packages should be on the ~56.x line
- React Native 0.85.3 — significant jump from older 0.83.x lines
