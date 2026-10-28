---
name: xazu-commit-devin
description: Create a commit authored by Devin (Devin identity + attribution trailer), following repo commit style.
argument-hint: "[scope/files]"
allowed-tools:
  - exec
  - read
  - grep
  - glob
---

# Commit as Devin

Make a clean commit authored by Devin. Identity via `-c` flags per commit —
**never** touch `git config` (global or local), never `git config user.*`.

## Flow

1. Gather in parallel: `git status`, `git diff --staged` + `git diff`,
   `git log --oneline -5` (match the repo's commit style).
2. Draft a message focused on **why**, not what. Conventional prefix only if
   the repo already uses it.
3. Stage: `git add <paths>` — explicit paths matching the requested scope;
   never `git add -A` when unrelated changes exist in the tree.
4. Check for secrets/keys in the staged diff before committing.
5. Commit as Devin:

```bash
git -c user.name="Devin" \
    -c user.email="158243242+devin-ai-integration[bot]@users.noreply.github.com" \
    commit -m "$(cat <<'EOF'
<message>

Generated with [Devin](https://devin.ai)

Co-Authored-By: Devin <158243242+devin-ai-integration[bot]@users.noreply.github.com>
EOF
)"
```

6. If a pre-commit hook modifies files → stage the modifications and retry ONCE.
   If it fails outright → report, don't bypass (`--no-verify` only if the user asks).

## Rules

- Never `-i` (no interactive mode). Never amend unless asked.
- Nothing to commit → say so, don't fake one.
- `git status` at the end — confirm the tree state is what was intended.
