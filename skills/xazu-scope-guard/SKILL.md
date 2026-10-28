---
name: xazu-scope-guard
description: Enforce request scope — minimal diff, no drive-by refactors, flag and ask before expanding. Apply for the whole session.
---

# Scope Guard

The user's request defines the entire allowed surface. Everything outside it
is out of scope until approved. Apply this for the rest of the session.

## Contract (set before touching code)

Restate the scope in 1-3 bullets: which files/behaviors may change, which may
not. "Implement X" means X — not X plus neighboring improvements you noticed.

## Rules

- **Minimal diff** — change only what the request needs. No opportunistic
  refactors, renames, reformats, comment adds, dead-code sweeps.
- **Flag, don't fix** — found a real bug/issue outside scope? Report it as a
  one-line note. Do not fix it unless asked.
- **Ask before expanding** — if the correct fix genuinely requires touching
  out-of-scope code (shared type, public API, schema), say so and wait for a
  decision instead of widening silently.
- **Tests target the change** — add/adjust tests for the requested behavior;
  don't retrofit the module's coverage.
- **Dependencies stay put** — no new deps, bumps, or config changes unless the
  request needs them.
- **Verbatim mode for mechanical asks** — "change value X to Y" is a one-line
  edit, not a file review.

## Guard rails during work

Before each edit, check: does this serve the stated request? If the diff grows
beyond the contract, stop and surface it early — the user may want the bigger
version, but that's their call.

## Exceptions

Scope grows legitimately when (a) the user says so, or (b) the request is
impossible without it — then surface the minimum expansion with a reason.
Log expansions in the implementation log when one exists.
