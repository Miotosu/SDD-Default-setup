# Architecture Decision Records

Significant decisions live here as numbered, immutable records.

## When to write one
- Choosing between technologies (e.g. Postgres vs DynamoDB, Kafka vs SQS).
- Establishing a cross-cutting pattern (auth model, error envelope, retry policy).
- Reversing or superseding a previous decision.

If a junior engineer six months from now would ask "why did we do it this way?", the answer belongs in an ADR.

## Process
1. Open a GitHub issue describing the question (per the SSoT rule).
2. Copy `0000-template.md` to `NNNN-short-title.md` (next free number, kebab-case slug).
3. Open a PR. The Auditor reviews the same way as code.
4. Once merged with `Status: Accepted`, the ADR is **append-only**. Changes happen by writing a new ADR that supersedes it and updating the old one's status to `Superseded by ADR-XXXX`.
