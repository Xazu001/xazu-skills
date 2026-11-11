---
name: xazu-debug
description: Investigate bugs and failures systematically, identify the root cause, and verify a minimal fix when implementation is requested.
argument-hint: "<bug, error, or failing test>"
allowed-tools:
  - read
  - grep
  - glob
---

# Debug

Investigate before changing code. Use this for bugs, failing tests, unexpected
behavior and build or integration failures. Match the user's request: diagnosis
alone does not authorize a fix, and planning mode does not authorize edits.

## Workflow

1. **Define the problem.** Record expected and observed behavior, the affected
   environment and the exact symptom. Inspect relevant project rules, recent
   changes and existing tests. Separate observations from assumptions.
2. **Reproduce safely.** Find the smallest reliable reproduction or a relevant
   failing test. Capture the command or steps and actual result. If reproduction
   is intermittent, unsafe or unavailable, say so and gather bounded evidence
   instead; do not claim the bug was reproduced.
3. **Trace the cause.** Follow the affected code path and compare a working case
   when useful. State a falsifiable hypothesis, test one variable at a time, and
   revise it when evidence disagrees. Distinguish the root cause from symptoms;
   if it remains uncertain, report the missing evidence instead of guessing.
4. **Fix only when requested and permitted.** Prefer a regression test that
   fails for the observed bug before changing implementation, when practical.
   Make the smallest root-cause fix consistent with project conventions. If a
   test cannot be written or run, explain the limitation and alternative check.
5. **Verify.** Rerun the reproduction or regression test, then appropriate
   nearby checks. Record commands or manual steps and their actual results.
   Report unrelated failures separately; never claim the fix works without
   evidence. If the fix fails, revisit the hypothesis rather than stacking
   speculative changes.

## Safety and scope

- Respect user exclusions and existing work; do not reset, revert or overwrite
  unrelated changes. Ask before expanding scope or modifying shared resources.
- Do not run destructive commands or trigger real-world side effects to reproduce
  a bug without explicit approval. Prefer isolated test data and read-only checks.
- Never print secrets, complete environment variables or sensitive payloads.
  If diagnostic logging is needed, minimize and redact it; remove only temporary
  instrumentation you added, without disturbing user changes.
- Do not guess commands, dependencies or production access. Report blockers and
  request missing permissions or information when needed.

## Report

Summarize the symptom, reproduction and evidence, root cause or remaining
uncertainty, fix if made, and exact verification results or gaps. Keep diagnosis,
planned changes and completed work distinct.
