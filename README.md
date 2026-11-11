# xazu-skills

Global [Devin CLI](https://devin.ai) skills, synced across machines.

| Skill | Purpose |
| ----- | ------- |
| `xazu-run-plan` | Create, edit and execute plans with resumable logs; archive plans deliberately or delete specific files with explicit confirmation. |
| `xazu-opt-tokens` | Token-economy mode: targeted reads, no re-reads, terse output. |
| `xazu-map-repo` | Maps architecture and conventions in `.agents/REPO_MAP.md`, adds an `AGENTS.md` pointer and supports refresh or section updates. |
| `xazu-session-handoff` | Saves session state (done / in-progress / blockers / next / hard-won context) to `HANDOFF.md` for cheap resume. |
| `xazu-scope-guard` | Session-wide scope enforcement — minimal diff, no drive-by refactors, ask before expanding. |
| `xazu-review` | Read-only code review of staged diff / branch / PR / commit / files — findings by severity with `file:line`. |
| `xazu-debug` | Investigate bugs systematically, find their root cause and verify a minimal fix when requested. |
| `xazu-verify` | Verify changes with scope-appropriate evidence and report checks, failures and gaps. |
| `xazu-skill-check` | Review global and project skills or selected skills, and recommend project-specific additions. |
| `xazu-commit-devin` | Commit authored by Devin (identity + attribution trailer, `-c` flags, never touches git config). |
| `xazu-commit-me` | Commit authored by you (your configured git identity). |
| `xazu-split-commits` | Splits current work into multiple logical commits via file/hunk-level staging. |
| `xazu-new-branch` | Starts the requested work on a fresh conventionally-named branch, safely with dirty trees. |
| `xazu-open-pr` | Pushes the branch and opens a `gh` PR — Summary covering all commits + test plan. |
| `xazu-confirm` | Restates the request as a polished structured summary (PL/EN mirrored) and asks "is this what you meant?" before acting. |
| `xazu-skill-scout` | Finds Agent Skills on the internet for the task at hand, security-audits them, and applies/installs only the safe ones. |
| `xazu-solution-scout` | Pre-implementation scout — searches the internet for libraries, services, integrations, and prior art that make the planned approach cheaper/simpler/already-solved. |

## Install

```bash
# macOS / Linux / Git Bash
./install.sh
```

```powershell
# Windows PowerShell
powershell -ExecutionPolicy Bypass -File install.ps1
```

Installs to `~/.config/devin/skills/` (macOS/Linux) or `%APPDATA%\devin\skills\` (Windows). Then invoke `/xazu-run-plan` or `/xazu-opt-tokens` in a session — or ask the agent to "use xazu-run-plan" and it will pick the skill up.

## Update

Edit `skills/<name>/SKILL.md`, push, re-run the installer on each machine.
