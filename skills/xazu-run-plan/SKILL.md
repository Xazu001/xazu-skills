---
name: xazu-run-plan
description: Create or edit an actionable plan at the requested detail level, or execute it stage-by-stage with a resumable companion *_IMPLEMENTATION_LOG.md.
argument-hint: "[plan file or stage] [short | standard | detailed]"
allowed-tools:
  - read
  - edit
  - grep
  - glob
  - exec
---

# Run Plan — log-driven execution

Use this skill to **execute** a plan that lives in a file (`.agents/plans/<NAME>_PLAN.md`),
or to **create or edit** a plan + log scaffold before work starts. The
companion log makes long work resumable across sessions — the next session reads ONE
log file instead of re-exploring the codebase.

## File layout & naming convention

Canonical layout — apply it when creating files and when tidying a repo:

```
.agents/plans/
  <NAME>_PLAN.md                  executable plan (SCREAMING_SNAKE_CASE)
  <NAME>_IMPLEMENTATION_LOG.md    its companion log — same <NAME>, same folder
  <topic>-<doc>.md                standing docs (checklists, indexes) — kebab-case
  done/                           finished plan+log pairs (always moved together)
.agents/logs/                     scratch command output — gitignored, disposable
```

Rules:

- **`<NAME>`** is `SCREAMING_SNAKE_CASE`, a short topic (1–4 words): `ERROR_LOGGING`,
  `BILLING_AUDIT`. Follow-up rounds of the same topic append `_ROUND<N>`:
  `BILLING_AUDIT_ROUND3`. Never `kebab-case`, never a bare `<name>.md` for plans.
- **The `_PLAN.md` suffix is the discovery mechanism.** A file is a runnable plan
  iff it ends in `_PLAN.md`. Standing documents (checklists, matrices, notes) use
  `kebab-case` and never carry the `_PLAN`/`_IMPLEMENTATION_LOG` suffixes.
- **Plan ↔ log is a 1:1 pair.** Derive the log name mechanically: replace
  `_PLAN.md` with `_IMPLEMENTATION_LOG.md`. Never invent a different name or put
  the log in a different folder.
- **Finished work archives to `done/`.** When every stage reaches a terminal
  status (✅/🟡/⛔ — nothing ⬜ and no resumption expected), move BOTH files to
  `.agents/plans/done/`. Relative links between them keep working; the plans root
  then shows only live work. 🟡 stages pending manual/operator approval count as
  done from the agent's side — note the pending gate in the log before archiving.
- **`.agents/logs/` is scratch only.** Redirect bulky command output there during
  a stage (`cmd > .agents/logs/<name>-stage<n>.txt`), but the permanent record is
  the log's **Verification** line (command + result). Keep the directory in
  `.gitignore`; never treat it as source of truth.

Non-plan directories (`.devin/plans/`, `docs/plans/`) may hold legacy plans — when
you touch one, move it into `.agents/plans/` under this convention.

## Find the plan

- If the user named a plan file, use it (a path under `done/` is fine for reference).
- Otherwise list `.agents/plans/` and pick the `*_PLAN.md` matching the request —
  `done/` and kebab-case files are not candidates; ask only if genuinely ambiguous.
- **No plan exists** → create one via "Creating or editing a plan" below (plan +
  empty log), then continue to execution if implementation was requested.
- If the user asks to create or edit a plan without implementation, use "Creating
  or editing a plan" and stop after planning. If editing, find and read the existing
  plan and its log first; do not create a replacement over them.

## Companion log

The log lives next to the plan with the derived name:
`.agents/plans/<NAME>_PLAN.md` → `.agents/plans/<NAME>_IMPLEMENTATION_LOG.md`.

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

## Creating or editing a plan

Use this workflow when a plan is missing or the user asks to create, expand,
shorten, or otherwise edit one. Respect the active mode and approval requirements:
if files cannot be written yet, present the plan in chat instead and wait for
approval; a planning-only request never authorizes implementation.

### Detail level

Accept a level anywhere in the request, including natural language:

- **Short** (`short`, `concise`, `krótko`, `zwięźle`) — compact bullets; group
  closely related actions into a few stages. Keep the minimum below, not just titles.
- **Standard** (`standard`, `normalnie`) — the default when unspecified; give
  each stage an approach, relevant paths when known, dependencies and verification.
- **Detailed** (`detailed`, `szczegółowo`, `dokładnie`) — add actionable
  substeps, relevant interfaces and edge cases, concrete verification, risks and
  decision points where useful. Do not pad with speculative paths or code.

Examples: `/xazu-run-plan plan logowania krótko`, `/xazu-run-plan AUTH_PLAN.md
szczegółowo`, or "rozbuduj istniejący plan, ale bez implementacji". An explicit
level wins; otherwise preserve an existing plan's level when editing, or use
standard for a new plan. Scale detail to risk and complexity even at the chosen
level. Ask only when the choice materially affects the outcome, not just to select
a level.

### Planning workflow

1. Understand the request and explore only relevant repo rules, existing behavior,
   tests and conventions. Identify existing plans and the companion log before
   creating anything. Resolve questions from available context first; ask focused
   questions only for decisions or missing requirements that materially block
   planning. Mark other assumptions and open questions explicitly.
2. Describe the intended outcome and why it matters; separate requirements and
   constraints from assumptions. State in-scope and out-of-scope work, preserved
   contracts, and observable acceptance criteria. Include non-functional needs
   (e.g. security, compatibility, performance) only when relevant.
3. Choose an approach grounded in what was actually inspected. Record key decisions,
   alternatives or risks when they matter, and distinguish verified facts from
   proposed paths or unresolved choices. Do not invent files, commands or behavior.
4. Break work into numbered, dependency-ordered stages. For each stage specify
   the outcome, concrete actions, affected files/components if known, dependencies
   where relevant, and how to verify it. Include appropriate tests, edge cases,
   migration/docs and final checks when applicable; do not force irrelevant stages.
   Use discoverable project commands; if unknown, say what must be identified.
5. Write `.agents/plans/<NAME>_PLAN.md` following the convention above. A compact
   structure, adapted to the chosen level, is:

   ```markdown
   # <Plan name>

   **Goal:** <outcome and why>
   **Detail:** <short | standard | detailed>
   **Scope:** <in scope; out of scope>
   **Requirements and contracts:** <must-haves and constraints>
   **Acceptance:** <observable criteria>
   **Context and decisions:** <verified context, approach, relevant paths>
   **Assumptions / risks / open questions:** <only what matters>

   ## Stage 1 — <outcome>
   - Actions: <concrete work and affected files/components if known>
   - Depends on: <stage or none>
   - Verification: <test/check and expected result, or what must be identified>

   ## Final verification
   - <checks mapping back to acceptance criteria>
   ```

6. For a new plan, create its companion log from the template below with one
   section per stage, all ⬜. For an existing plan, update it in place and preserve
   unrelated content, completed work, existing stage identifiers and log history.
   Add log sections for new stages without resetting statuses; if completed work
   needs changes, add a follow-up stage rather than silently marking it undone.
   Record substantive revisions and their reason in the log. If the log is missing,
   create it without claiming past work or verification.
7. Review for traceability from goal and requirements to stages and acceptance
   checks, sensible ordering, actionable steps, unresolved blockers and consistency
   between plan and log. Avoid repeating context or presenting guesses as facts.
   Stop after a planning-only request. If a missing plan was created for requested
   implementation, continue to "Executing a stage" only when the active mode and
   any required approvals allow it.

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
