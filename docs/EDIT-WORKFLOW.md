# MPPWebsite edit workflow

Canonical governance: [FullStackBestPractices](https://github.com/Max-Power-Platform/FullStackBestPractices)

Current delivery authority: [MPP Azure Boards](https://dev.azure.com/maxpowerplatform/MPP)

Content-authority decision: [AB2044](https://dev.azure.com/maxpowerplatform/MPP/_workitems/edit/2044)

## Authority

The reviewed Git tree at `src/portal/mpp2---mpp2/` is the only deployable portal source.
`scripts/Build-Site.ps1` owns the artifacts declared in AB2044. Other files in the canonical tree
are hand-authored Git source. Power Pages Studio is a diagnostic editor, never an independent authority.

## Task branch workflow

1. Record an exact Story/Bug envelope and checkpoint in Azure Boards.
2. Create one task branch from current `dev`; target `dev` in the pull request.
3. Change generator input for generated artifacts, or the owning Git file for hand-authored ones.
4. Run `./scripts/Test-ContentAuthority.ps1` and `./scripts/Test-Governance.ps1`.
5. Include generated output with its owning generator change in the same PR.
6. Merge a reviewed, green PR to `dev` under the active ADO autonomy contract.

`main` is the release branch. Promotion from `dev` to `main`, and every UAT or Production write,
requires its applicable exact release envelope and approval. A source merge is not a deployment.

## Studio comparison

When an approved envelope permits a Dev Studio inspection, download only to an isolated,
non-deployable comparison directory:

```powershell
pwsh ./scripts/pages-download.ps1 -Env dev -ComparisonPath .worktree/portal-comparison/dev
```

Review the snapshot and selectively express differences in `Build-Site.ps1` or the owning
hand-authored file. Never overwrite the canonical tree with a download. Never auto-merge drift.

## Hard boundaries

- Azure Boards is the only mutable recovery authority.
- Never infer PAC, tenant, identity, environment, website ID, or permission from an interactive context.
- MPP work uses only MPP identities and resources; never use TBNHS contexts.
- UAT and Production require Max's exact release approval before the first write unless an active
  bounded release envelope already exists.
- Identity, permission, credential, paid-resource, tenant-wide, shared-service-connection,
  destructive-data, and emergency-lock changes always require separate approval.
