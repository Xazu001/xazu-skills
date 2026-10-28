---
name: review
description: Code review of a diff, staged changes, branch, PR, or pasted code — findings by severity, read-only.
argument-hint: "[branch|pr|staged|file|commit]"
allowed-tools:
  - read
  - grep
  - glob
  - exec
permissions:
  deny:
    - edit
---

# Review

Review code like a careful teammate. Read-only — report findings, never modify.

## Pick the target

- `staged` / no arg → `git diff --staged` (fall back to `git diff` if empty).
- `branch` / branch name → `git diff <base>...HEAD` — base is the merge-base
  with the default branch (`git merge-base`).
- `pr` / number → `gh pr diff <n>` + `gh pr view` for context.
- `<commit-sha>` → `git show <sha>`.
- file/dir path → review those files (read them + their closest dependencies).
- Pasted snippet → review inline.

## Read smart

Start from the diff. Pull only the context needed to judge it: the function
surrounding a changed line, the interface it implements, the callers it breaks.
Don't read the whole module to review a 10-line change.

## Checklist

1. **Correctness** — logic errors, off-by-one, null/edge handling, async races,
   error paths that grant/succeed wrongly.
2. **Security** — injections, missing authz/authn checks, secrets or sensitive
   data in logs/URLs/output, trust of client-supplied values.
3. **Contracts** — broken callers/types/migrations, API shape changes, removed
   behaviors users relied on.
4. **Conventions** — repo naming/style/test patterns (check neighboring files).
5. **Tests** — is new behavior covered? Do existing tests still describe reality?

## Output

```
## Findings
| Sev | Where | What |
|-----|-------|------|
| 🔴  | file:line | one-line issue + suggested fix |
| 🟡  | file:line | ... |

## Notes
- non-blocking observations, questions for the author

## Verdict
<approve / request changes + why>
```

Severities: 🔴 must fix (bug/security/data risk) · 🟡 should fix (design,
edge case, convention) · 🔵 optional (nits — list max 3).
Every finding gets `file:line` and a concrete suggestion. No findings → say so
plainly, don't invent them.
