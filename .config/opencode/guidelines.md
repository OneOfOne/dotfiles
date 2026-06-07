# guidelines.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## 5. Prefer Built-in Tools Over Bash

**Use built-in tools and MCP servers instead of `bash` whenever possible.**

The built-in tools are safer, more reliable, and often faster than shell equivalents. They're also integrated with the environment (proper error handling, output formatting, security checks).

### File operations
- Use `read` over `bash cat` / `head` / `tail`
- Use `write` over `bash echo > file` / `cat <<EOF`
- Use `edit` over `bash sed` / `awk`
- Use `glob` over `bash find`
- Use `grep` over `bash grep` / `rg`
- Use `ast_grep_search` / `ast_grep_replace` for AST-aware code patterns

### Network operations
- Use `webfetch` over `bash curl`
- Use `websearch` over `bash curl` + search engine APIs

### Git operations
- Use the built-in git context and tools when available instead of raw `bash git` calls

### When bash is appropriate
- Installing packages (`bun`, `npm`, etc.)
- Running commands with side effects (builds, linters, formatters)
- Complex shell pipelines or process management
- Anything that requires shell-specific behavior

### General rule
If a built-in tool exists for the job, use it. Only fall back to `bash` when no suitable tool is available.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to over-complication, and clarifying questions come before implementation rather than after mistakes.
