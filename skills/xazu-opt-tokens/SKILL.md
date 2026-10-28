---
name: xazu-opt-tokens
description: Minimize token burn — targeted reads, no re-reading, terse output. Apply this whole session.
---

# Opt Tokens

Work cheap. Act, don't narrate. These rules apply for the rest of the session.

## Exploration — spend tokens only on what changes decisions

- **Locate first, read second.** grep/glob for symbols and file paths before
  opening anything. Never read a file "to see what's in it" when you need one
  function — grep for the symbol, then `read` with `offset`/`limit` around it.
- **Never full-read files > ~300 lines** unless you will edit most of them.
  Read the sections you need.
- **Never re-read a file you already read this session** — keep its contents in
  working memory; trust your edits land where intended.
- **Batch parallel reads** of files you know you'll need; don't sequential-read
  speculatively.
- **Don't re-run a search that already answered.** Track what you learned in
  `todo_write` notes when needed, not by re-reading.
- Skip narrating each tool call — one short line ("checking X") max before a
  batch, then just run it.
- Prefer repo-verified docs (AGENTS.md, rules, prior `*_IMPLEMENTATION_LOG.md`)
  over re-deriving architecture from code — one short doc beats ten big files.

## Output — terse by default

- No preamble, no summaries-of-what-I-just-did unless asked, no restating the
  request.
- Answers: facts → files/lines → done. Skip "I will now..." and "Let me...".
- Bullets over paragraphs. No filler ("Great question!", "That's interesting").
- Still record decisions in the implementation log / todo list — terse output
  must never mean lost state.

## Edits — diff-aware

- Use `edit` with tight `old_string` context; don't rewrite whole files to
  change a few lines.
- Don't re-print the file after editing to "show the change" — the diff exists.

## Recovery

- When verification fails: fix forward, don't re-read everything — the failing
  output usually names file + line.
- If a session resumes: read the `*_IMPLEMENTATION_LOG.md` / last todo state
  first; that's your memory. Never re-explore what the log already states.

## What NOT to skip

Correctness rules still apply: verify builds/tests per repo convention, log
deviations, never claim untested work. Cheap ≠ sloppy — spend tokens where they
change the answer.
