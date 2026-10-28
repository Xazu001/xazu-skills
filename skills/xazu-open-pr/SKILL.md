---
name: xazu-open-pr
description: Push the current branch and open a GitHub PR with a reviewed title/body via gh.
argument-hint: "[title | --draft]"
allowed-tools:
  - exec
  - read
  - grep
  - glob
---

# Open PR

Ship the current branch as a pull request. This skill authorizes pushing the
feature branch — still never force-push or rewrite shared history.

## Flow

1. State check (parallel): `git status`, `git log --oneline <base>..HEAD`,
   `git diff <base>...HEAD`, `git branch --show-current`. Base = merge-base
   with the default branch (`git merge-base HEAD origin/main` or the repo's
   default — detect via `git remote show origin`).
2. Review ALL commits in range — not just the latest. The PR describes the
   whole delta.
3. On `main`/`master`? → stop, run `new-branch` flow first (or ask).
4. Uncommitted changes → don't include them silently; ask or finish committing.
5. Draft the PR:

```bash
gh pr create --title "<concise why>" --body "$(cat <<'EOF'
## Summary
<bullets covering every commit in range>

#### Test plan
<checklist of what was verified / what to check>

Generated with [Devin](https://devin.ai)
EOF
)"
```

6. Push first if needed: `git push -u origin HEAD`. If push is rejected →
   fetch and report; never `--force` without explicit approval.
7. Return the PR URL.

## Rules

- Body mirrors reality: only what's actually in the diff — not planned work.
- `--draft` flag → pass `--draft` to gh.
- Repo checks (test/lint) run locally first when cheap; don't hold the PR for
  slow suites — note unchecked items in the test plan instead.
- `gh` unauthenticated → report `gh auth login` needed; don't work around auth.
