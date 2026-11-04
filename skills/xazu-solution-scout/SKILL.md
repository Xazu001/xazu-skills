---
name: xazu-solution-scout
description: Before committing to an implementation approach, search the internet for existing solutions — libraries, services, integrations, prior art — that the plan hasn't considered. Use when the user names specific tools to combine ("integrate X with Y"), asks for a better/easier way, or is about to build something that might already be solved.
argument-hint: "[problem or planned approach]"
allowed-tools:
  - web_search
  - webfetch
  - read
  - grep
  - exec
---

# Solution Scout

Find what the plan hasn't considered. When the user describes HOW they'll
build something ("integrate <toolA> with <toolB> because <constraint>"), scout
the problem space for libraries, services, integrations, and battle-tested
paths that make it cheaper, simpler, or already-solved — before code gets
written.

## 1. Frame the problem, not the plan

Extract the underlying need, stripped of chosen tools. "Integrate <toolA> with
<toolB> because <constraint>" → real need: the capability the constraint
actually demands, in the user's own terms. Split constraints into hard
(must-have features, platforms, legal) vs assumed (this vendor, this
architecture). The assumed ones are where better options hide.

## 2. Search across multiple angles — not just the named tools

Run ~3-6 focused queries, each attacking a different angle:

- **Direct bridge** — does an official/blessed integration already exist?
  `<toolA> <toolB> integration`, vendor docs for the other tool's name,
  `<toolA> webhook <toolB>` patterns.
- **Replacement** — could ONE tool cover both jobs?
  `unified <domain> platform`, `<toolA> alternatives`, `<domain> orchestration`.
- **Prior art** — who else solved this and wrote it up?
  `<problem> site:news.ycombinator.com`, `<problem> site:reddit.com`,
  `gh search repos "<problem>"` sorted by recent/stars, blog postmortems.
- **Ecosystem** — awesome lists (`awesome-<domain>`), registry search
  (`npm search`, `gh repo search`), vendor marketplaces/partner directories.

Check freshness — SDKs, pricing, and product names change fast. Prefer sources
< ~18 months old and flag anything stale. Product features announced on a blog
may not have shipped; confirm in current docs.

## 3. Vet candidates quickly

For each plausible find capture: what it replaces/eases, maintenance signal
(last release, stars), license/cost, fit with THIS stack, and **the catch** —
hidden limits, lock-in, the feature it claims but doesn't really have. Fetch
official docs to confirm the one claim that matters (the hard constraint from
step 1) — never recommend from a title or README alone. A tool that solves 80%
still belongs on the list, labeled with its gap.

## 4. Report a shortlist, let the user decide

| Option | What it changes | Maturity | The catch |

Include "stick with current plan" as an explicit option — "you're already on
the best path" is a valid scout result. Never silently switch approaches
mid-task; present findings and ask. If the user picks an alternative, verify
its key claim in official docs BEFORE rewriting the plan.

## Rules

- Problem-space queries first. Searching only the tools already chosen finds
  the wrapper for the thing you didn't need.
- Mark every claim verified / unverified. No invented APIs, features, pricing.
- Time-box it — scouting is cheap insurance, not a research project. If ~5
  searches surface nothing better, say so and proceed with the original plan.
- Pair with `xazu-skill-scout` when a found solution might itself have a
  usable skill.
