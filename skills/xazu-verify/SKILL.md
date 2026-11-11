---
name: xazu-verify
description: Verify the requested changes or claims with scope-appropriate evidence, and report passed, failed, skipped and unavailable checks.
argument-hint: "[change, file, claim, or verification scope]"
allowed-tools:
  - read
  - grep
  - glob
---

# Verify

Verify what the user asked about; do not implement or repair code unless asked.
Choose checks based on the actual change and risk, not a fixed stack or a
mandatory full suite. Respect the active mode, user exclusions and project rules.

## Workflow

1. **Set the scope.** Identify the requested behavior or claim and the relevant
   files, changes and acceptance criteria. Do not include unrelated work silently.
2. **Find the checks.** Read relevant project instructions, manifests, tests and
   CI documentation. Choose documented commands and/or practical manual checks
   that exercise the affected behavior. Note prerequisites, side effects and
   checks that are too expensive, unavailable or excluded.
3. **Run appropriate checks.** Prefer a narrow behavior or regression test first,
   followed by broader tests, lint, typecheck, build or manual checks when useful
   and permitted. Do not guess commands, install dependencies, change configuration,
   access production or trigger real-world side effects without approval.
4. **Evaluate evidence.** Inspect the actual output and exit status; a command
   running is not proof that it passed or that the relevant behavior was tested.
   Distinguish checks run in this session from previous evidence. Investigate
   failures enough to distinguish affected work from known or suspected unrelated
   failures, without claiming an unverified cause.
5. **Report honestly.** Map each claim or acceptance criterion to the actual
   command/manual steps and result. List failures, skipped checks, blockers and
   remaining uncertainty. A static check does not prove runtime behavior; a
   partial check does not prove the whole suite passes.

## Rules

- Never claim tests passed, a bug is fixed or a feature works without evidence
  supporting that specific claim. If a check cannot run, report why and the next
  practical verification step.
- Respect existing work. Do not reset or revert code to test it, change tests
  merely to make them pass, or run excluded, destructive or unsafe checks.
- Keep secrets and sensitive output out of logs and reports. Do not send data to
  external services or create shared resources without explicit approval.
- When a plan log exists and updates are requested or part of the agreed workflow,
  record only checks actually run and their results.

## Output

- **Scope:** what was verified.
- **Results:** each command or manual check and its actual outcome.
- **Not verified:** skipped checks, limitations and the next step, if any.
