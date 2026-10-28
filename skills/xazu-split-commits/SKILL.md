---
name: xazu-split-commits
description: Split current uncommitted work into multiple logical commits — grouped by concern, each self-contained.
allowed-tools:
  - exec
  - read
  - grep
  - glob
---

# Split Commits

Turn the working-tree diff into several small, meaningful commits instead of
one blob. Interactive rebase is unavailable — split by **staging granularity**
(files, or hunks via patch files), never `-i`/`git add -p` TUI.

## Flow

1. `git status` + `git diff` (and `git diff --staged`) — survey ALL changes.
2. Propose 2-5 logical groups by **concern** (feature, fix, refactor, tests,
   docs, chore) — not by file count. Present the grouping briefly before
   committing unless the user already described it.
3. For each group, in dependency order (types/infra → feature → tests → docs):
   - Prefer **file-level** staging: `git add path/a path/b` then commit.
   - A file holding changes from two groups → **hunk-level**: write the file's
     diff to a temp patch (`git diff -- file > /tmp/x.patch`), trim it to the
     group's hunks, `git apply --cached /tmp/x.patch`, commit, then stage the
     remaining hunks for their own group. Verify with `git diff --staged`
     before each commit.
4. Each commit: draft a message for what THAT commit does; use the repo's
   style; identify author per `commit-devin` or `commit-me` as asked.
5. Ideally each commit leaves the tree coherent — if the repo compiles/tests
   cheaply, run the fast check once at the end (note if a middle commit is
   intentionally non-standalone, e.g. split of one logical change).

## Rules

- Never reorder git history, never `-i`, never force anything.
- Pre-existing staged content: include it in the grouping decision — don't
  silently fold it into "the first commit".
- Secrets check per staged hunk batch.
- End with `git log --oneline -N` + `git status` so the user sees the result.
