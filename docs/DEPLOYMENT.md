# MPPWebsite release runbook

Canonical governance: [FullStackBestPractices](https://github.com/Max-Power-Platform/FullStackBestPractices)

Delivery authority: [MPP Azure Boards](https://dev.azure.com/maxpowerplatform/MPP)

Repository authority: `src/portal/mpp2---mpp2/`

## Branch and release direction

```text
task branch -> pull request targeting dev -> reviewed dev integration
            -> exact UAT release approval -> UAT
            -> exact Production release approval -> main/Production
```

`dev` is the integration branch and `main` is the release branch. `master` is obsolete. A branch,
commit, green check, or merge is source evidence only and never authorizes an environment write.

## Required release envelope

Before any Dev environment write, the owning Story/Bug must name the exact tenant, identity,
environment, commit/artifact, commands, scope, security/dependency/lock results, evidence,
rollback, recovery checkpoint, and exclusions. Ordinary non-destructive MPP Dev work may then run
inside that unchanged envelope under `MPP-INDEPENDENT-ORCHESTRATOR-01`.

Before the first UAT or Production write, obtain Max's exact release approval unless the same
bounded release envelope already contains an active approval. Destructive data, identity,
permission, credential, consent, paid-resource, tenant-wide, shared-service-connection, emergency
lock, and out-of-envelope work always requires separate approval.

## Source validation

```powershell
pwsh ./scripts/Test-Governance.ps1
pwsh ./scripts/Test-ContentAuthority.ps1
pwsh ./tests/ContentAuthority.Tests.ps1
```

These checks perform no PAC, Azure, Dataverse, portal, pipeline, or environment operation.
`scripts/Build-Site.ps1` uses committed IDs from `scripts/content-authority.ids.json`; the three
older content generators fail closed.

## Transfer wrappers

- `pages-download.ps1` requires an isolated comparison path outside `src/`.
- `pages-upload.ps1` uploads only `src/portal/mpp2---mpp2/`; this does not grant permission to run it.
- The drift workflow is manual and evidence-only; it cannot commit or open a source PR.

## Evidence and rollback

Checkpoint the exact branch, commit, PR, CI, artifact hash, target, live visual evidence, and
rollback on the owning Azure Boards item. Roll back source by reverting the exact PR. Environment
rollback must be named and proven in the release envelope before the write.
