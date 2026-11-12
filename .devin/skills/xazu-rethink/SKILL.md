---
name: xazu-rethink
description: Rethink a feature or architecture from its goal without consulting the existing implementation, then implement it when requested.
argument-hint: "<goal, feature, or architecture to rethink>"
---

# Rethink

Start with the outcome, not the current implementation. Design a fresh solution
for the requested feature or architecture before looking at the existing code.
Use this workflow when the user wants a clean-slate rethink, not a routine
refactor or a review of the current design.

## 1. Define the goal

- Establish the desired behavior, scope, users, acceptance criteria and any
  constraints explicitly provided by the user. Separate facts from assumptions.
- Ask focused questions if the goal or essential constraints are too unclear to
  design responsibly. Do not infer requirements from the current implementation.
- Follow applicable instructions, project rules, safety requirements and the
  active mode. Rules are not permission to examine the implementation at this
  stage; if a required instruction conflicts with the clean-slate boundary,
  explain the conflict rather than pretending the design is independent.

## 2. Design without the existing solution

- Do not inspect the target's code, architecture, tests, repository maps, prior
  plans, history or implementation documentation while developing the design.
  Do not use existing implementation details already seen in this conversation
  as design requirements. Use only the goal, user-provided constraints and
  general knowledge; mark assumptions and unknowns clearly.
- If prior context makes an independent design impossible, say so and offer a
  fresh session with only the goal and constraints. Do not claim the design is
  unbiased when it cannot be.
- Consider appropriate alternatives and trade-offs, then choose a coherent
  solution. Describe its responsibilities, interfaces, key flows, failure and
  security considerations, and how to verify the acceptance criteria. Scale
  detail to the request.
- Present the resulting design and assumptions before examining the existing
  implementation. Do not invent compatibility requirements or promise that
  the design can be integrated unchanged.

## 3. Integrate only when requested

- A request for ideas or a design alone does not authorize edits. If the user
  requested implementation and the active mode permits it, inspect the minimum
  existing code, tests, contracts and project conventions needed to integrate
  safely, only after the fresh design is complete. Respect any stricter user
  prohibition on inspecting existing code; explain blockers instead of guessing.
- Compare the design with actual interfaces, dependencies, data, security,
  operational constraints and uncommitted work. Identify what must be preserved
  or migrated and adapt the design only where needed, explaining material changes.
  Ask before expanding scope or making incompatible changes not already agreed.
- Implement within the requested scope. Do not overwrite unrelated work, remove
  existing behavior without agreement, run destructive operations, modify shared
  resources or trigger external side effects without the required explicit
  approval. If safe integration cannot be established, stop and explain why.
- Verify the requested behavior with appropriate tests or checks, including
  integration and regression coverage where practical. Report actual results,
  skipped checks and remaining risks; do not claim verification without evidence.

## Report

Distinguish the clean-slate design from findings discovered during integration.
Summarize the chosen approach, assumptions, necessary deviations, changes made
and verification results. If no implementation was requested, stop at the design.
