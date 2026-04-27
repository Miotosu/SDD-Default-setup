# SDD-Automata

Reusable scaffolding for **Spec-Driven Development** with AI agents, orchestrated through GitHub.

The agentic hierarchy:

```
Refiner  →  Decomposer  →  Implementer  →  Auditor
 (spec)      (issues)        (code+PR)       (review)
```

## How to use this scaffold

1. **Fork or copy this repo** into a new project.
2. **Configure GitHub:**
   - Enable **branch protection** on `main`: require PRs, require the `Validate PR description and branch` and `Require approving review labelled "audit"` checks, require linear history, dismiss stale reviews.
   - Create a **Project (kanban)** with columns: `Backlog/Refinement` → `Planning` → `In Progress` → `Verification` → `Security Audit` → `Done`.
   - Add a `task` label (used by the issue template) and an `audit` label (used by the auditor agent).
3. **Drop a feature spec** into `specs/features/<feature>.md` using `specs/features/template.md`. The `Milestone from Spec` workflow auto-creates the matching GitHub Milestone on push to `main`.
4. **Let the agents run:** Refiner produces the spec, Decomposer files issues, Implementer ships PRs, Auditor reviews. See `agents/` for each agent's contract.

## What is included

- **`CLAUDE.md`** — the engineering laws and orchestration mandate (loaded automatically by Claude Code).
- **`agents/`** — four subagent definitions with proper Claude Code frontmatter.
- **`protocols/`** — shared standards (CLS spec format, PR template pointer).
- **`specs/features/template.md`** — the CLS spec template.
- **`.github/pull_request_template.md`** — auto-applied to every PR.
- **`.github/ISSUE_TEMPLATE/task.yml`** — atomic-task issue form for the Decomposer.
- **`.github/CODEOWNERS`** — auto-requests auditor review on every PR (replace `@your-org/auditors` placeholders).
- **`.github/dependabot.yml`** — weekly updates for GitHub Actions; add per-language ecosystems as you adopt them.
- **`.github/workflows/`** — enforcement:
  - `pr-checks.yml` — branch naming, Conventional-Commit-style title, `Closes #N`, referenced issue exists and is open, required template sections.
  - `audit-required.yml` — blocks merge until an `audit-approved` label or `[audit]`-tagged approving review is present.
  - `secret-scan.yml` — gitleaks on every PR.
  - `milestone-from-spec.yml` — creates a milestone when a new spec lands on `main`.
- **`.claude/settings.json` + `.claude/hooks/`** — local guardrails (refuses direct pushes to `main`, blocks force pushes, allow-lists common `gh` and `git` operations).
- **`docs/adr/`** — Architecture Decision Records: template plus process notes. Append-only.

## What is *not* included

- **`src/` and `tests/`** are intentionally empty — drop your application code in.
- **No language-specific tooling** (lint, typecheck, test runner) — add a CI workflow per project. The Auditor's "tests must pass" rule presumes you have one.
- **No project-specific copy / UX rules** — add them to `CLAUDE.md` under *Hard Blockers* per project.

## Required GitHub setup checklist

- [ ] Branch protection on `main`: require PR, require status checks `Validate PR description and branch` and `Require auditor sign-off`, require review from Code Owners, require linear history.
- [ ] Squash-and-merge as the only allowed merge type.
- [ ] Auto-delete head branches on merge.
- [ ] Update `.github/CODEOWNERS` with the project's real auditor / maintainer handles (the scaffold defaults to `@Miotosu`; multi-person projects should swap in a team handle and split maintainers from auditors).
- [ ] Labels: `task`, `audit`, `audit-approved`, `dependencies`, `github-actions`.
- [ ] Project board with the six SDD columns.
