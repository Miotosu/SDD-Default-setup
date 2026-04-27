# Project: SDD-Automata

A reusable scaffold for **Spec-Driven Development** with AI agents, orchestrated through GitHub (Issues, Milestones, Projects, PRs, Actions).

## Engineering Laws (Non-Negotiable)

### 1. Single Source of Truth (SSoT)
- **Issue-Driven Development:** Every unit of work — features, ADRs, refactors, follow-ups — must exist as a GitHub Issue *before* code is written. No private TODOs or scratchpads.
- **Linkage Rule:** All Pull Requests must include `Closes #N` in the description, linking to a parent issue. Enforced by `.github/workflows/pr-checks.yml`.

### 2. PR-Only Workflow
- **No Direct Pushes:** Pushing directly to `main` is prohibited. All changes go through a Pull Request. (Configure GitHub branch protection on `main` to enforce.)
- **Template Rule:** PR descriptions must follow `.github/pull_request_template.md`.
- **Lifecycle:** Squash and Merge only. Branches deleted on merge.

### 3. Mandatory Audit
- **Sentinel Rule:** Every PR requires an `auditor` review before merge.
- **Hard Blockers (merge-blocking):**
  - Missing or failing tests.
  - Secrets or tokens in the diff.
  - Use of `any` (or equivalent escape hatches) without an inline justification.
  - Unparameterized SQL or other injection risks.
  - External calls without timeouts and error handling.
  - Project-specific copy/UX rules declared in `protocols/` (each project may add its own).

---

## Platform Orchestration (Visibility Mandate)

> No work shall be performed that is invisible to the repository's tracking infrastructure.

### 1. GitHub Milestones (Feature Container)
Every new file in `specs/features/` MUST have a corresponding GitHub Milestone.
- Milestone name matches the feature name.
- All issues for that feature are assigned to the milestone.
- Auto-creation handled by `.github/workflows/milestone-from-spec.yml`.

### 2. GitHub Projects (Command Center)
All active work must be visible on a central Kanban board, moving through:

`Backlog/Refinement` → `Planning` → `In Progress` → `Verification` → `Security Audit` → `Done`

---

## Agentic Hierarchy

The system runs four specialized agents in `agents/`:

**Refiner → Decomposer → Implementer → Auditor**

| Agent | Trigger | Output |
| --- | --- | --- |
| `refiner` | New idea / vague requirement | Bulletproof CLS-format spec in `specs/features/` |
| `decomposer` | New spec finalized | GitHub Milestone + atomic issues with DoD |
| `implementer` | Issue moved to *In Progress* | Branch + tests + PR using template |
| `auditor` | PR opened | Approve or block per Hard Blockers list |

See individual `agents/*.md` files for operational protocols.

---

## Repo Layout

```
.github/             GitHub orchestration: PR template, issue templates, CODEOWNERS, dependabot, workflows
agents/              Subagent definitions (Claude Code frontmatter)
docs/adr/            Architecture Decision Records (append-only)
protocols/           Shared standards (CLS, PR conventions)
specs/features/      Feature specs (one .md per feature; triggers a milestone)
src/                 Application code (project-specific)
tests/               Tests (project-specific)
scripts/             Local automation (optional)
```

## Auditor Sign-Off

A PR is mergeable only when one of these holds:
- The `audit-approved` label is present (preferred — applied by the auditor agent or a code owner).
- An approving review has been submitted whose body contains `[audit]` (manual fallback).

Both paths are checked by `.github/workflows/audit-required.yml`.

### Bot exemption
PRs authored by `dependabot[bot]` or `renovate[bot]` are **exempt** from the SDD/SNC gates and from human auditor sign-off. They still must pass the secret scan and any project-specific test suite. Dep bumps live outside the agentic SDD flow by design — they are upstream automation, not units of issue-driven work.
