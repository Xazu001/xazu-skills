---
name: new-branch
description: Do the requested work on a fresh, conventionally-named branch — safely handling uncommitted changes.
argument-hint: "<branch-name or task>"
allowed-tools:
  - exec
  - read
  - grep
  - glob
---

# New Branch

Move work onto a fresh branch without losing or disturbing in-flight changes.

## Flow

1. `git status` + `git branch --show-current` — know where you stand.
   On `main`/`master`/default with uncommitted changes → the changes come
   along onto the new branch (git carries uncommitted work on checkout;
   confirm it's the same base).
2. Name it conventionally: `feat/<slug>`, `fix/<slug>`, `chore/<slug>` —
   match whatever style `git branch -a` / recent history shows; kebab-case,
   short. If the user gave a name, use it.
3. Create + switch: `git checkout -b <name>` — from the current base unless
   the user wants `origin/main` (`git fetch` first, then `-b <name> origin/main`;
   note that switching bases with dirty files may conflict → offer stash first).
4. Do the requested work on the branch.
5. Commit(s) per `commit-devin`/`commit-me` when asked.

## Rules

- Never commit work directly on the default branch when a feature branch was
  requested — branch BEFORE editing.
- Dirty tree + base switch → prefer `git stash -u` → branch → `git stash pop`;
  report conflicts instead of forcing.
- Never `checkout` over uncommitted changes that would be clobbered — if git
  refuses, surface it, don't force.
- Don't push the branch unless asked (that's `open-pr`'s job).
