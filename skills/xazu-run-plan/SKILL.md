---
name: xazu-run-plan
description: Execute a plan file stage-by-stage (creating it if missing) with a companion *_IMPLEMENTATION_LOG.md — resumable across sessions, minimal re-exploration, accumulates discoveries.
argument-hint: "[plan file or stage]"
allowed-tools:
  - read
  - edit
  - grep
  - glob
  - exec
---

# Run Plan — log-driven execution

Use this skill to **execute** a plan that lives in a file (e.g. `.agents/plans/X_PLAN.md`,
`docs/plans/x.md`), or to **create** a plan + log scaffold before work starts. The
companion log makes long work resumable across sessions — the next session reads ONE
log file instead of re-exploring the codebase.

## Find the plan

- If the user named a plan file, use it.
- Otherwise check `.agents/plans/`, `.devin/plans/`, `docs/plans/` — pick the file
  matching the request; ask only if genuinely ambiguous.
- **No plan exists** → create one via "Creating a plan" below (plan + empty log),
  then continue to execution — this skill was invoked to get work done.
- If the user asked you to PLAN (not implement), jump to "Creating a plan".

## Companion log

The log lives next to the plan: replace `_PLAN.md` with `_IMPLEMENTATION_LOG.md`, or
append `_IMPLEMENTATION_LOG` to the base name (`x.md` → `x_IMPLEMENTATION_LOG.md`).

- **Exists** → read it (usually the only file you need to fully re-read), resume from
  the first non-✅ stage. Never redo a ✅ stage unless the user asks.
- **Missing** → create it from the template below before writing any code.

## Executing a stage

1. Read the plan section for THIS stage only — not the whole plan again.
2. Read the repo's rule/index files (AGENTS.md, .agents/rules/) only if not already
   known this session.
3. Write a short "Plan for stage N" note in the log: files to touch + approach.
4. Implement. One stage at a time — do not start N+1 before N is ✅/🟡.
5. Verify with the repo's build/test command (find it in AGENTS.md/README — do not
   guess). Only mark ✅ after a green result; 🟡 when verification needs a manual
   step; ⛔ when blocked (always with reason).
6. Update the log: status, scope, files changed, decisions/deviations, the exact
   verification command + result. Append anything non-obvious you learned while
   implementing to `## Discoveries`. Then next stage.

## Rules

- **Never mark ✅ without a passing verification** for the affected target.
- **Log deviations** — when reality forces a change vs. the plan, record it under
  Decyzje/Decisions with the reason. Do not silently diverge.
- **Log discoveries as you go** — the moment you learn something non-obvious (where
  X lives, a repo quirk, a command that works, a gotcha that cost you time), append
  it to the log's `## Discoveries` section tagged with the stage. The log is the
  single place for hard-won context — keep it close, keep it current.
- **Never claim tests/sandbox/E2E you didn't run.** Mocked or "should work" is not done.
- **Preserve contracts** — if a "do not break" item must break, stop and ask.
- Use `todo_write` to mirror stages for live visibility.
- Prefer narrow tests of the changed area during a stage; one full repo-check at the end.
- Keep exploration cheap: grep + offset reads of specific functions instead of
  full-file reads; do not re-read files you already know this session.

## Creating a plan (planning mode)

When the user asks to plan work rather than implement it — or no plan file exists:

1. Explore cheaply (see `opt-tokens` if available).
2. Write `<NAME>_PLAN.md` with: goal, in/out of scope, numbered stages ordered by
   dependency (foundation → features → migration → docs → verification), key
   decisions, non-negotiable contracts, and a test/acceptance section.
3. Create the empty `<NAME>_IMPLEMENTATION_LOG.md` from the template — one section
   per stage, all ⬜.
4. Stop only if the user asked for a plan alone; when the plan was missing during
   execution, continue straight to "Executing a stage".

## Log template

```markdown
# <Plan Name> — Implementation Log

> Documents what was ACTUALLY done for `<PLAN_FILE>`. Never mark planned
> verification as executed.

## Status legend
- ✅ done, verification green
- 🟡 done, verification pending / manual check needed
- ⬜ not started
- ⛔ blocked / rejected (with reason)

---

## Discoveries

> Running knowledge base — non-obvious findings that make this work easier:
> where things live, repo quirks, commands that work, gotchas. Add the moment
> you learn them, tag with the stage. Read this first on resume.

- <stage> — <discovery>

---

## Stage 0 — <title>

**Status:** ⬜

**Plan for stage:**
- <file> — <what and why>

**Scope:**
- <what was done>

**Files:** `<file1>`, `<file2>`

**Decisions:** <none / deviation + reason>

**Verification:** `<command>` → <result>

---
```

## Resume workflow

When the user says "continue" / "dalej": read the log (stage statuses + the whole
`## Discoveries` section — that's your recovered context) → find first ⬜/🟡 stage →
resume at "Executing a stage". No full re-exploration.
