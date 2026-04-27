# 🏗️ Project: SDD-Automata
## ⚖️ Engineering Laws (Non-Negotiable)

### 1. The Single Source of Truth (SSoT)
* **Issue-Driven Development:** Every unit of work—features, ADRs, refactors, or follow-ups—**must** exist as a GitHub Issue *before* any code is written. No private TODOs or scratchpads.
* **The Linkage Rule:** All Pull Requests must use `Closes #N` in the description to link back to their parent issue.

### 2. The PR-Only Workflow
* **No Direct Pushes:** Pushing directly to `[main]` is strictly prohibited. All changes require a Pull Request.
* **The Template Rule:** PR descriptions must follow the template in `protocols/pr_template.md`.
* **Lifecycle Management:** All merges must be **Squash and Merge**. Branches must be deleted immediately after a successful merge.

### 3. The Mandatory Audit
* **The Sentinel Rule:** An `audit` review is mandatory on every PR before merge.
* **Hard Blockers (Merge-Blocking):**
  - Missing/failing tests.
  - Secrets/tokens detected in the diff.
  - Use of `any` type without technical justification.
  - Unparameterized SQL or injection risks.
  - Untimed external calls.
  - "Buy/Trade/Profit" verbs found in user copy.

---

## 🛰️ Platform Orchestration (Visibility Mandate)
*No work shall be performed that is invisible to the Repository's tracking infrastructure.*

### 1. GitHub Milestones (The Feature Container)
Every new `.md` file created in `specs/features/` **MUST** trigger the creation of a corresponding **GitHub Milestone**. 
- The Milestone name must match the Feature Name.
- All tasks (Issues) generated for that feature **must** be assigned to this Milestone.

### 2. GitHub Projects (The Command Center)
All active work must be visible on the central **Kanban Project Board**. No issue shall exist in a "hidden" state. The board must track movement through these stages:
`Backlog/Refinement` $\rightarrow$ `Planning` $\rightarrow$ `In Progress` $\rightarrow$ `Verification` $\rightarrow$ `Security Audit` $\rightarrow$ `Done`.

---

## 🤖 The Agentic Hierarchy
The system operates via four specialized agent roles found in `/agents`:
**Refiner $\rightarrow$ Decomposer $\rightarrow$ Implementer $\rightarrow$ Auditor.**

*(Refer to `/agents/*.md` for specific operational protocols.)*
