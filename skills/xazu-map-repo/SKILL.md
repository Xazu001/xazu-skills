---
name: xazu-map-repo
description: One-time deep exploration → writes a compact REPO_MAP so future sessions read 1 file instead of re-exploring the codebase.
argument-hint: "[refresh | section]"
allowed-tools:
  - read
  - grep
  - glob
  - exec
  - edit
---

# Map Repo

Produce a compact, high-signal map of this repository so later sessions never
re-derive architecture. Spend tokens once, save them forever.

## Output file

- If the repo has an obvious docs/rules convention (`AGENTS.md` appendix,
  `docs/`, `.agents/`, `.devin/`), put the map there under a stable name —
  default `.devin/REPO_MAP.md`.
- One file, plain markdown, aimed at a future agent — not a human essay.

## What to gather (targeted reads only)

1. Manifests first: `package.json`, `build.gradle*`, `Cargo.toml`, `go.mod`,
   `wrangler.*`, `docker-compose*`, `Makefile` — get stack + commands in 5 files.
2. Entry points: main/app/worker entry, router/routes index, DI/module root.
3. Layout: `ls` top dirs; for each, ONE line: what lives there + key file.
4. Build/test/lint/format commands — copy exact ones from README/AGENTS/CI,
   verify only if cheap.
5. Conventions that matter for edits: naming, file placement, import aliases,
   test location/style, migration workflow.
6. Landmines: files >500 lines (warn "section-read only"), generated code,
   non-obvious env requirements, flaky/slow commands.

## Map format

```
# REPO_MAP — <name> (mapped <date>, commit <sha>)
Stack: <langs/frameworks/runtimes>
Verify: <exact commands: typecheck / lint / test / build>
Dirs:   <dir> — <purpose> [<key files>]
Flow:   <1-3 lines on request/data flow>
Conventions: <naming, aliases, test style, migrations>
Landmines: <big files, generated code, env needs>
```

Rules: bullets over prose; every claim backed by a file you actually saw;
mark unknowns as `?` instead of guessing. Keep it under ~120 lines — a map
that needs a map fails its purpose.

## Refresh mode

`refresh` / an existing map found → read the map, check `git log` since its
recorded commit, update only the drifted sections, bump the commit sha. Do not
re-explore what didn't change.
