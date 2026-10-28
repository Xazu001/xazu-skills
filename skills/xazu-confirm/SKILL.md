---
name: xazu-confirm
description: Restate the user's request back as a polished, structured summary and ask for confirmation before doing anything.
---

# Confirm — echo of intent

Do NOT implement anything. Restate what the user just asked in your own words —
structured and polished — then ask if that's what they meant.

## Language

Mirror the user's language: they write Polish → you answer in Polish;
English → English; mixed → the dominant language of their message.

## Format

Polish:

```
## Rozumiem to tak

**Cel:** <one sentence>
**Zakres:**
- <concrete items, in plain words>

**Poza zakresem / czego NIE zrobię:**
- <things they didn't ask for, if worth stating>

**Pytania:** (only if something is genuinely ambiguous)
- <short question>

Czy o to chodziło?
```

English — same shape: `## Here's what I understood` / **Goal** / **Scope** /
**Out of scope** / **Questions** / `Is that what you meant?`

## Rules

- **Rephrase, don't parrot** — demonstrate understanding, don't echo their words back.
- Expand shorthand the user used ("płatności" → which subsystem you'd touch),
  so misunderstandings surface now, not after work starts.
- Keep it short: the summary should be tighter than the original message, not longer.
- Ambiguity → ask ONE focused question, don't list five.
- When the ask_user_question tool is available, you may present the
  confirmation as a choice (e.g. "Tak — rób" / "Nie — poprawię").
- After "yes", proceed with the actual task. After "no", restate the corrected
  version once more and confirm again — no work until confirmed.
