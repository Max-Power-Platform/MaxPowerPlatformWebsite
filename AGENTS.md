# MPPWebsite agent execution overlay

Canonical shared governance: [FullStackBestPractices](https://github.com/Max-Power-Platform/FullStackBestPractices)
Owning Azure DevOps project: [MPP](https://dev.azure.com/maxpowerplatform/MPP)
Owning work item: [AB#2042](https://dev.azure.com/maxpowerplatform/MPP/_workitems/edit/2042)

This file is the repository-local executable overlay for `MaxPowerPlatformWebsite`. It may narrow
the shared FullStackBestPractices (FSBP) contract for this repository, but it must not redefine or
contradict FSBP.

## Four-layer authority

1. **FSBP** owns shared governance, orchestrator, approval, evidence, release, rollback, and
   multi-agent coordination standards.
2. **Azure Boards** owns backlog, current work, ownership, checkpoints, blockers, approvals,
   evidence links, and crash recovery. Use AB#2042 for this workstream until it is completed.
3. **MPP Wiki** is a discoverability and portfolio-guidance layer. It summarizes and links to FSBP;
   it is not an independently maintained governance authority.
4. **Repository and GitHub** own the local executable overlay, product source, tests, workflows,
   branches, commits, and pull requests. GitHub source state never replaces an ADO checkpoint.

When surfaces disagree, stop. FSBP wins for shared rules, Azure Boards wins for current delivery
state, and Git/GitHub wins for source state. Record the discrepancy and coordination need on the
owning ADO item before changing another workstream.

## Required startup

1. Read the applicable FSBP standards from the canonical repository.
2. Read AB#2042 (or its explicitly linked successor), including its latest structured checkpoint,
   relations, approvals, blockers, and evidence.
3. Confirm the repository, worktree, branch, HEAD, remote, and dirty paths with Git.
4. State the exact objective, scope, owner, write set, exclusions, approval boundary, proof, and
   rollback before mutation.
5. Re-run relevant state checks. Do not reconstruct current state from chat or a repository ledger.

## Repository-local execution rules

- Work only inside the `MPPWebsite` ownership boundary unless a linked ADO dependency records
  coordination with the other owner.
- Use `MPP\MPPWebsite\PlatformAndALM` for repository governance/ALM work.
- Sprints and capacity use Monday through Sunday.
- Put `AB#<id>` in branch, commit, and PR metadata where supported.
- Keep pull requests unmerged until the exact merge approval is recorded in Azure Boards.
- Do not invent Story Points. Use `NeedsSizing` until sizing is approved.
- User-visible claims require live evidence under the applicable FSBP standard; source or CI green
  alone is not a release claim.
- A repository edit or PR does not authorize a Power Platform, deployment, environment, service
  connection, artifact publication, DNS, portal, or production mutation.

## Durable checkpoint and recovery

Azure Boards is the only mutable recovery authority. At start, after a material result, before a
governed mutation, on a blocker, and before stopping, append a structured checkpoint to the owning
Story containing:

- objective and scope;
- current branch, worktree, and commit;
- completed and remaining work;
- blockers;
- approvals granted and still required;
- evidence and artifact links;
- rollback; and
- one exact next direction.

Do not create or maintain `SESSION_HANDOFF.md`, `LEDGER.md`, `NEXT.md`, `RESUME.md`, chat-session
files, `.claude/session/`, or a host-specific equivalent as active state. The retained
`SESSION_HANDOFF.md` is only a deprecation pointer.

## Current corrected Batch 2 boundary

Allowed: repository governance files, CI-only governance validation, the isolated branch and PR,
MPPWebsite team working-day configuration, AB#2042 checkpoints/links, and the MPPWebsite Wiki
discoverability update.

Excluded: deployment, Power Platform access, service connections, artifact publication, portal
mutation, Production changes, and M365 Tenant Admin backlog changes.
