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
companion log makes long work resumable across sessions — read it first, then consult
the relevant plan context without re-exploring the whole codebase.

## File layout & naming convention

Canonical layout for new files:

```
.agents/plans/
  <NAME>_PLAN.md                  executable plan (SCREAMING_SNAKE_CASE)
  <NAME>_IMPLEMENTATION_LOG.md    its companion log — same <NAME>, same folder
  <topic>-<doc>.md                standing docs (checklists, indexes) — kebab-case
  done/                           archived plan+log pairs (moved together)
.agents/logs/                     scratch command output — gitignored, disposable
```

Rules:

- **`<NAME>`** is `SCREAMING_SNAKE_CASE`, a short topic (1–4 words): `ERROR_LOGGING`,
  `BILLING_AUDIT`. Follow-up rounds of the same topic append `_ROUND<N>`:
  `BILLING_AUDIT_ROUND3`. Never `kebab-case`, never a bare `<name>.md` for plans.
- **The `_PLAN.md` suffix is the discovery mechanism.** A file is a runnable plan
  iff it ends in `_PLAN.md`. Standing documents (checklists, matrices, notes) use
  `kebab-case` and never carry the `_PLAN`/`_IMPLEMENTATION_LOG` suffixes. An
  explicitly named legacy plan may use another name.
- **Plan ↔ log is a 1:1 pair.** Derive the log name mechanically: replace
  `_PLAN.md` with `_IMPLEMENTATION_LOG.md` in the same folder. For a legacy plan
  without that suffix, preserve an existing companion; if none is identifiable,
  ask the user to agree on its name and location before creating one.
- **Archive deliberately, without changing the truth.** A plan is complete only
  when every stage is ✅ or explicitly removed from scope with the user's approval
  (❌), final verification passes, and no acceptance criterion or approval remains
  outstanding. The user may also request or approve archiving an unfinished,
  blocked, superseded or abandoned plan. Before moving it, explain unresolved
  stages, checks and approvals; record the archive reason and outstanding work in
  the log without changing their statuses or calling the plan complete. Never
  archive merely because the agent cannot proceed. Ask before moving any plan
  and log to `done/`, unless the user already requested that specific move. Move
  the pair together, check destination conflicts and affected links, update links
  as needed, and never overwrite existing files.
- **Deletion is separate from archiving.** A plan, log or other file may be
  deleted only after explicit confirmation for the specific files and deletion
  action. First identify the affected paths, companion, remaining work, history
  and links; explain what will be lost and offer archiving when appropriate.
  Do not treat general permission to clean up, an archive request, or permission
  for a different deletion as approval. Preserve any companion not explicitly
  approved for deletion and repair affected links without inventing history.
- **`.agents/logs/` is scratch only.** Redirect bulky command output there during
  a stage (`cmd > .agents/logs/<name>-stage<n>.txt`), but the permanent record is
  the log's **Verification** line (command + result). Keep the directory in
  `.gitignore`; never treat it as source of truth.

Existing plans in legacy locations (`.devin/plans/`, `docs/plans/`) or `done/`
stay in place when read or edited; do not silently move or rename them. If an
archived plan has unfinished work and the user asks to resume it, explicitly flag
that it is active despite its location. Offer to move its pair back to the active
folder, but ask first and check conflicts and links as above. Until moved, tell
the user to name its path when resuming because automatic discovery excludes `done/`.

## Find the plan

- If the user named a plan file, use that path, including a legacy or `done/` path.
- Otherwise list `.agents/plans/` and pick the `*_PLAN.md` matching the request —
  `done/` and kebab-case files are not candidates; ask only if genuinely ambiguous.
- **No plan exists** → create one via "Creating or editing a plan" below (plan +
  empty log), then continue to execution if implementation was requested.
- If the user asks to create or edit a plan without implementation, use "Creating
  or editing a plan" and stop after planning. If editing, find and read the existing
  plan and its log first if present; do not create a replacement over them.

## Companion log

For canonical plans the log lives next to the plan with the derived name:
`<NAME>_PLAN.md` → `<NAME>_IMPLEMENTATION_LOG.md`.

- **Exists** → read its statuses, decisions, verification and discoveries; then use
  "Resume workflow" to select work. Do not redo completed implementation by default.
  If it predates the final verification section, add one when writing is allowed,
  without overwriting history; use ❔ unless its state is supported by recorded
  evidence.
- **Missing for a new plan** → create it from the template below, with each stage
  ⬜ and final verification ⬜.
- **Missing for an existing plan** → recover what can be supported by evidence from
  the plan, repository and user; record the evidence and that earlier history is
  unavailable. Create a log with ❔ for each stage whose status is not established,
  rather than assuming ⬜ or ✅. Mark ✅ only with evidence of passing verification;
  record final verification as ❔ unless its state is established. Resolve uncertainty
  before acting on the affected stage or its dependants; ask the user if evidence
  cannot establish what to do. Never overwrite or fabricate previous history.

### Statuses and dependencies

- ⬜ **Not started** — no implementation has begun.
- 🔄 **In progress** — work has started but is not complete; record what remains.
- 🟡 **Verification or approval pending** — implementation is complete, but a
  required check or gate remains; record the owner, next action and reason.
- ✅ **Complete** — required verification passed, with evidence in the log.
- ⛔ **Blocked** — work or verification cannot proceed; record the blocker and
  what could unblock it. Notify the user; do not treat it as completed or rejected.
- ❔ **Unknown** — the prior state or evidence is insufficient; investigate or ask
  before implementation or dependent work.
- ❌ **Removed from scope** — only after explicit user approval; record the reason
  and update affected dependencies and acceptance criteria. This is not a blocker.

Older logs may use ⛔ for either blocked or rejected. Inspect their reason and
approval evidence before interpreting them; if ambiguous, ask rather than assuming
they are complete. Preserve the original history when recording the resolution.

A stage may start only when its prerequisites are satisfied. In particular, 🟡,
⛔ and ❔ do not satisfy a dependency that requires their result or approval.
Independent work may proceed where authorized, but report unresolved items and
never silently skip them. Do not repeat implementation for 🟡; complete its
remaining check or gate and record the outcome.

## Executing a stage

1. Read the stage plus the plan's relevant goal, requirements, contracts,
   acceptance criteria, decisions and dependencies. Reuse context already known.
2. Read the repo's rule/index files (AGENTS.md, .agents/rules/) only if not already
   known this session.
3. Confirm prerequisites and approvals are satisfied; record a short "Plan for
   stage N" note in the log with files to touch and approach.
4. Implement or resume the stage, one at a time. Set 🔄 when work starts.
5. Run the relevant documented checks or an appropriate manual check; never guess
   commands or run checks the user excluded. Record exact commands or manual steps
   and results. Mark ✅ only after all required checks pass, 🟡 for a pending
   check or approval, or ⛔ for a blocker, with the next action and reason.
6. Update scope, files, decisions/deviations and `## Discoveries` as work proceeds.
   Select the next stage using "Resume workflow"; do not bypass unmet dependencies.
7. Once stages are complete or approved out of scope, perform the plan's final
   verification against its acceptance criteria and record the actual results in
   the log. Record pending checks or blockers rather than claiming completion.

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
- Prefer narrow checks during a stage and a documented final check appropriate to
  the scope; respect user exclusions and record any resulting verification gaps.
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
5. Write a new `.agents/plans/<NAME>_PLAN.md` following the convention above, or
   edit the existing plan in its current location. A compact structure, adapted to
   the chosen level, is:

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
   section per stage and final verification, all ⬜. For an existing plan, update
   it in place and preserve unrelated content, completed work, existing stage
   identifiers and log history.
   Add log sections for new stages without resetting statuses; if completed work
   needs changes, add a follow-up stage rather than silently marking it undone.
   Record substantive revisions and their reason in the log. If the log is missing,
   recover it as described in "Companion log" without claiming past work or
   verification; stages newly added in this edit are known to be ⬜. When new work
   invalidates a prior final check, preserve its result as history and mark a new
   final verification ⬜.
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
- ⬜ not started
- 🔄 in progress
- 🟡 verification or approval pending
- ✅ complete, required verification passed
- ⛔ blocked
- ❔ prior state unknown
- ❌ removed from scope with user approval

---

## Discoveries

> Running knowledge base — non-obvious findings that make this work easier:
> where things live, repo quirks, commands that work, gotchas. Add the moment
> you learn them, tag with the stage. Read this first on resume.

- <stage> — <discovery>

---

## Stage 1 — <title>

**Status:** ⬜

**Plan for stage:**
- <file> — <what and why>

**Scope:**
- <what was done>

**Files:** `<file1>`, `<file2>`

**Decisions:** <none / deviation + reason>

**Verification:** <command or manual check> → <actual result / not run>

**Next action / blocker:** <action, owner and reason if applicable>

---

## Final verification

**Status:** ⬜

**Acceptance checks:** <actual command or manual check and result / not run>

**Next action / blocker:** <action, owner and reason if applicable>

---
```

## Resume workflow

When the user says "continue" / "dalej":

1. Read the log's statuses, decisions, verification and `## Discoveries`, then the
   relevant plan context and dependencies. Recover a missing log as above.
2. Skip ✅ and approved ❌ stages unless the user explicitly asks to revisit them.
   For 🔄, inspect recorded work and resume what remains before starting another
   stage; never redo blindly.
3. For 🟡, perform only the outstanding check or request the approval if possible;
   record the result. For ⛔ or ❔, investigate the blocker or missing evidence and
   notify or ask the user as needed. Keep each unresolved status visible in the log.
4. Start the next ⬜ stage whose prerequisites are satisfied. Independent stages
   can proceed while a gate or blocker remains, if authorized; dependent stages
   cannot. If nothing is actionable, stop and report the next action and owner.
5. After stages are resolved, complete and record final verification. Archive or
   delete only under the rules above. Avoid full re-exploration when existing
   context suffices.
