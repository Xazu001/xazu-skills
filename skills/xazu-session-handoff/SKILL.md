---
name: xazu-session-handoff
description: Save session state to a handoff file so the next session resumes without re-exploring — use at session end or before switching tasks.
allowed-tools:
  - read
  - edit
  - grep
  - glob
  - exec
---

# Session Handoff

Persist what this session knows so the next one doesn't pay the exploration
cost again. Cheap insurance for any work that spans sessions.

## Where

- If a `*_IMPLEMENTATION_LOG.md` exists for this work → append/update it (see
  `run-plan`) instead of creating a separate file.
- Otherwise create/update `HANDOFF.md` at the repo root (or `.devin/HANDOFF.md`
  if the repo uses `.devin/`). One file, always the same name.

## What to write — facts only

```
# Handoff — <date> (<branch>, commit <sha>)

## Done
- <what was changed/completed + files>

## In progress
- <exact state: what works, what compiles, what's half-edited>

## Blocked / waiting on
- <blockers, decisions needed, missing access>

## Next
- <ordered next steps, numbered>

## Context that cost tokens to learn
- <non-obvious findings: key file:line, wrong first guesses, gotchas>

## Verify
- <commands run → results; commands NOT yet run>
```

## Rules

- Record REAL state, not intent. Half-finished means half-finished.
- The "Context" section is the point: write down what took you minutes to
  discover (dead ends, actual entry points, surprising conventions) — that's
  what the next session would otherwise re-learn at full price.
- Include `git status` summary (uncommitted files) so nothing is lost if the
  worktree moves.
- Terse bullets; a handoff longer than the work it describes is waste.

## Resume (when invoked at session start)

Read the handoff → confirm repo state matches (branch, uncommitted files) →
resume at "Next". Never re-explore what the handoff already documents.
