# xazu-skills

Global [Devin CLI](https://devin.ai) skills, synced across machines.

| Skill | Purpose |
| ----- | ------- |
| `run-plan` | Execute a `*_PLAN.md` stage-by-stage with a companion `*_IMPLEMENTATION_LOG.md` — resumable across sessions without re-exploring the codebase. |
| `opt-tokens` | Token-economy mode: targeted reads, no re-reads, terse output. |

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
