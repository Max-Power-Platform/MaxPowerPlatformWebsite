# GitHub Copilot entry point — MPPWebsite

Canonical shared governance: [FullStackBestPractices](https://github.com/Max-Power-Platform/FullStackBestPractices)
Owning Azure DevOps project: [MPP](https://dev.azure.com/maxpowerplatform/MPP)
Owning work item: [AB#2042](https://dev.azure.com/maxpowerplatform/MPP/_workitems/edit/2042)

Load and follow the repository overlay in [AGENTS.md](../AGENTS.md). This file is only the Copilot
discovery pointer and extension; it is not a second governance or recovery authority.

Repository-specific context:

- Product: MPP public marketing website.
- Source: Power Pages Enhanced Data Model under `src/portal/mpp2---mpp2/`.
- Owning Area: `MPP\MPPWebsite`; governance/ALM Area: `MPP\MPPWebsite\PlatformAndALM`.
- Branch flow: task branch → target `dev`; `main` is the release branch.
- Under the active ADO autonomy contract, a reviewed green PR may be merged normally to `dev`.
- No Power Platform upload, portal mutation, deployment, or environment write follows from source
  or PR approval; it requires its own exact ADO execution/release envelope and gates.
- Current status, blockers, approvals, evidence, rollback, and exact next direction come from
  Azure Boards, not `SESSION_HANDOFF.md`, chat, or a model-specific ledger.
