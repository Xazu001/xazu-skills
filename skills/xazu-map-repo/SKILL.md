---
name: xazu-map-repo
description: Map repository architecture and conventions in .agents/REPO_MAP.md, with an AGENTS.md pointer; refresh or update sections as needed.
argument-hint: "[refresh | section]"
allowed-tools:
  - read
  - grep
  - glob
  - exec
  - edit
---

# Map Repo

Produce a useful, high-signal navigation map so later sessions can locate
relevant code and commands without re-exploring the whole repository. Go a
little deeper than a directory listing, but keep the map concise and actionable.

## Output and agent instructions

- Write the map to `.agents/REPO_MAP.md` at the root of the repository being
  mapped. Create `.agents/` if needed. Respect an explicit user-specified
  repository or scope; in a multi-repo workspace, do not combine repositories.
- Add a short, discoverable pointer in the root `AGENTS.md` so future agents
  know to consult `.agents/REPO_MAP.md` for navigation. State that it is a
  snapshot: follow current instructions and verify details against the source.
  Mention `/xazu-map-repo refresh` as the way to refresh it. Put the pointer in
  an existing relevant section or a short `Repository Map` section, for example:
  `Repository map: .agents/REPO_MAP.md (snapshot; verify against current code).
  Refresh with /xazu-map-repo refresh.`
- If `AGENTS.md` is missing, create a minimal one with the pointer. If the
  pointer already exists, update it only when needed; do not duplicate it.
  Preserve all other instructions and uncommitted changes.
- Check for an existing map and dirty work before writing. Never replace a map
  or agent instructions blindly. If the canonical map already exists, read and
  update it in place. If only a legacy map exists (e.g. `.devin/REPO_MAP.md`),
  use it as context, create the canonical map, and update any relevant map
  pointer in `AGENTS.md`; leave the legacy file untouched unless its removal
  is separately approved. If both exist, treat the canonical map as primary,
  note any conflict and preserve both.
- These instructions do not override the user's requested scope, read-only mode,
  repository rules or required approvals. If a file cannot be changed, report
  the missing map or pointer rather than claiming it was written.

## What to gather (targeted reads only)

1. Read the repository's `AGENTS.md` and relevant rule indexes first. Check
   `git status` and the current commit if available; do not assume a clean tree.
2. Inspect relevant manifests and configs (`package.json`, `build.gradle*`,
   `Cargo.toml`, `go.mod`, `wrangler.*`, `docker-compose*`, `Makefile`, etc.).
   Record the actual stack, package boundaries, runtime and entry points.
3. Map the important directories, key files and ownership boundaries. Trace the
   main request/data flow from entry point through routing, services and storage;
   include background jobs, clients or platform-specific paths when relevant.
4. Locate tests, fixtures and CI; capture exact setup, build, test, lint and
   format commands from manifests and project instructions. Distinguish commands
   merely found from checks actually run, and note prerequisites and side effects.
5. Record conventions that affect edits: naming, import boundaries, route/module
   placement, state or dependency injection, migrations and generated files.
   Link authoritative rule files rather than copying entire rules into the map.
6. Identify integration points and operational constraints: environment file
   roles and variable names, external services, data migrations, sensitive or
   destructive commands, large files, platform limitations and known pitfalls.
   Never read or include secret values; do not trigger services, installs,
   deployment, destructive commands or costly checks just to build a map.

## Map format and quality

Use plain Markdown, with short sections adapted to the repository:

- **Snapshot:** repository, date, inspected commit and whether the worktree was
  dirty; if Git metadata is unavailable, say so.
- **Stack and entry points:** languages, runtime, frameworks, package boundaries
  and key startup/router/DI files.
- **Directory and domain map:** important directories, responsibilities and
  entry files; include notable subdirectories when they help navigation.
- **Architecture and flows:** main request or application flow, data and storage
  boundaries, plus important background or platform-specific flows.
- **Development and verification:** exact commands, test locations, prerequisites,
  documented versus actually executed checks, and active or disabled CI.
- **Conventions and integration:** naming, aliases, migrations, generated code,
  environment roles, service boundaries and links to authoritative instructions.
- **Landmines and unknowns:** relevant large files, risky commands, limitations,
  unresolved questions and any areas not inspected.

Use bullets rather than essays and include concrete paths for significant claims.
Only state what inspected files support; mark uncertain or unverified details.
Prefer roughly 150–220 lines where useful, fewer for small repositories; do not
pad the map or impose a rigid limit that omits important context.

## Refresh and section updates

- For `refresh`, an existing map, or a requested section, read the current map
  and its snapshot first. Inspect relevant Git history since the recorded commit
  and current tracked/untracked worktree changes when available; if the commit
  is missing or history is unavailable, verify affected sections directly.
- Update only sections supported by current evidence and preserve useful existing
  information and unrelated user edits. For a section-only update, do not imply
  the whole map was revalidated; record the scope and date of the partial check.
- Update the overall snapshot commit/date only when the full map has been
  checked against the current state; otherwise retain the previous baseline and
  note what remains unchecked. Ensure the `AGENTS.md` pointer remains correct.
- Report which files changed, whether the map is new or refreshed, checks actually
  run, and any inaccessible or unverified areas.
