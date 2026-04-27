# CLS Standard (Contract Language for Specs)

Every feature spec written under `specs/features/` must conform to this five-section structure. The canonical template lives at [`specs/features/template.md`](../specs/features/template.md).

## Sections

1. **Intent (Why / Who)** — the problem, the audience, and what is out of scope.
2. **Behavior (How / When)** — triggers, logic flow, and state transitions.
3. **Boundaries (Input / Output / Constraints)** — data contracts and operational limits.
4. **Safety (Access / Prohibited States)** — access control, forbidden state combinations, and audit requirements.
5. **Failure Modes (Errors / Resilience)** — expected errors, recovery paths, observability hooks.

## Acceptance rule

A spec is accepted only when **all five sections are non-empty and unambiguous**. Refiner will not hand off to Decomposer until this holds.
