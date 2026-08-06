# MPPWebsite governance and delivery traceability

Canonical shared governance: [FullStackBestPractices](https://github.com/Max-Power-Platform/FullStackBestPractices)
Owning Azure DevOps project: [MPP](https://dev.azure.com/maxpowerplatform/MPP)
Owning work item: [AB#2042](https://dev.azure.com/maxpowerplatform/MPP/_workitems/edit/2042)

## Authority map

| Layer | Authority | Required trace |
| --- | --- | --- |
| FSBP | Shared governance, approvals, evidence, release, rollback, orchestration | Canonical FSBP URL and governing revision when available |
| Azure Boards | Backlog, current work, checkpoints, blockers, approvals, dependencies, evidence and recovery | Project, work-item ID, Area, Iteration, state, owner, relations and latest checkpoint |
| MPP Wiki | Discoverability, portfolio summaries, decisions, inventories and project guidance linked to FSBP | Wiki/page URL and referenced FSBP location; no copied mutable rule set |
| Repository/GitHub | Local executable overlay, source, tests, workflows, branch, commit and PR | Repository, branch, commit SHA, PR, check run and changed paths |

No layer silently replaces another. Repository files may narrow shared rules locally but cannot
contradict FSBP. Wiki summaries do not become independent governance. Git state does not replace an
ADO checkpoint, and ADO does not replace source/PR history.

## Work-item checkpoint contract

The owning Story Discussion is the only mutable recovery record and must include:

- UTC timestamp and stable orchestrator ID;
- objective, scope, owning Area and excluded writes;
- repository, worktree, branch and commit SHA;
- completed and remaining work;
- blockers and cross-workstream dependencies;
- approvals granted, consumed and still required;
- tests, check runs, evidence and artifact links, or explicit `none`;
- dirty or unpublished paths without secrets;
- rollback; and
- one exact executable next direction.

## Source and pull-request trace

Use this minimum chain:

`ADO Story → repository → branch → commit SHA → pull request → CI check → approval → merge`

- Include `AB#2042` in the commit and PR.
- Keep the PR open until exact merge approval is recorded in ADO.
- Link the PR and CI check back to AB#2042.
- A green CI check proves repository governance structure only. It is not deployment, environment,
  artifact, portal, or user-visible evidence.

## Release and environment trace

This corrected Batch 2 has environment boundary `none` and publishes no artifact. Future governed
release work must additionally record artifact version/hash, target environment, deployment record,
approval, live evidence, rollback target and final status in the shared project inventory.

## Recovery rule

Recover from the latest AB#2042 structured checkpoint plus measured Git state and applicable FSBP
standards. Do not use `SESSION_HANDOFF.md`, `LEDGER.md`, `NEXT.md`, `RESUME.md`, chat-session files,
`.claude/session/`, or host-specific equivalents as current state.
