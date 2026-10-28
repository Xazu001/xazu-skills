---
name: xazu-commit-me
description: Create a commit authored by the USER (their configured git identity), following repo commit style.
argument-hint: "[scope/files]"
allowed-tools:
  - exec
  - read
  - grep
  - glob
---

# Commit as the User

Same discipline as `commit-devin`, but the author is the user — the identity
already configured in this repo/environment. **Never** run `git config` to set
or override `user.name`/`user.email`.

## Flow

1. Parallel: `git status`, `git diff --staged` + `git diff`,
   `git log --oneline -5`, `git config user.name` + `git config user.email`.
   If no identity is configured → stop and ask which identity to use; do not
   invent or set one.
2. Draft the message (why over what; repo's existing style).
3. Stage explicit paths matching the scope; check staged diff for secrets.
4. Commit with the user's own identity (plain `git commit` — their config
   resolves the author). Keep the attribution footer:

```bash
git commit -m "$(cat <<'EOF'
<message>

Generated with [Devin](https://devin.ai)

Co-Authored-By: Devin <158243242+devin-ai-integration[bot]@users.noreply.github.com>
EOF
)"
```

(Author = user; the trailer keeps honest Devin attribution without stealing
authorship. Drop the trailer only if the user asks.)

5. Pre-commit hook edits files → restage and retry once. Never `--no-verify`
   without being asked.

## Rules

- Never `-i`, never amend unless asked, never `git config`.
- Empty tree → report, don't fake a commit.
