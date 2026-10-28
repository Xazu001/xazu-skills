# xazu-skills

Global [Devin CLI](https://devin.ai) skills, synced across machines.

| Skill | Purpose |
| ----- | ------- |
| `run-plan` | Execute a `*_PLAN.md` stage-by-stage with a companion `*_IMPLEMENTATION_LOG.md` — resumable across sessions without re-exploring the codebase. |
| `opt-tokens` | Token-economy mode: targeted reads, no re-reads, terse output. |
| `map-repo` | One-time deep exploration → compact `REPO_MAP.md` future sessions read instead of re-exploring. Supports `refresh`. |
| `session-handoff` | Saves session state (done / in-progress / blockers / next / hard-won context) to `HANDOFF.md` for cheap resume. |
| `scope-guard` | Session-wide scope enforcement — minimal diff, no drive-by refactors, ask before expanding. |
| `review` | Read-only code review of staged diff / branch / PR / commit / files — findings by severity with `file:line`. |
| `commit-devin` | Commit authored by Devin (identity + attribution trailer, `-c` flags, never touches git config). |
| `commit-me` | Commit authored by you (your configured git identity). |
| `split-commits` | Splits current work into multiple logical commits via file/hunk-level staging. |
| `new-branch` | Starts the requested work on a fresh conventionally-named branch, safely with dirty trees. |
| `open-pr` | Pushes the branch and opens a `gh` PR — Summary covering all commits + test plan. |

## Install

```bash
# macOS / Linux / Git Bash
./install.sh
```

```powershell
# Windows PowerShell
powershell -ExecutionPolicy Bypass -File install.ps1
```

Installs to `~/.config/devin/skills/` (macOS/Linux) or `%APPDATA%\devin\skills\` (Windows). Then invoke `/run-plan` or `/opt-tokens` in a session — or ask the agent to "use run-plan" and it will pick the skill up.

## Update

Edit `skills/<name>/SKILL.md`, push, re-run the installer on each machine.
