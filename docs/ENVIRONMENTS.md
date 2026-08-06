# MPPWebsite environment boundaries

Canonical governance: [FullStackBestPractices](https://github.com/Max-Power-Platform/FullStackBestPractices)

Current inventory and release authority: [MPP Azure Boards](https://dev.azure.com/maxpowerplatform/MPP)

## Authority and isolation

Environment URLs, website IDs, PAC profiles, identities, subscriptions, service connections, and
release status are operational inventory—not source defaults. Read them from the exact owning ADO
release envelope and verify them immediately before use.

MPP may use only MPP tenant resources. It must never select or use a TBNHS identity, subscription,
service connection, PAC context, browser profile, environment URL, or environment. Any mismatch
fails closed before access.

## Environment classes

| Class | Purpose | Write authority |
|---|---|---|
| Dev | Bounded implementation and live validation | Exact Story/Bug envelope plus all required gates |
| UAT | Release validation | Max's exact UAT approval before first write unless active in the envelope |
| Production | Public release | Max's exact Production approval before first write unless active in the envelope |

The MPP Wiki inventory is the discoverability view; Azure Boards owns current status, approvals,
evidence, blockers, and exact next direction. GitHub owns source branch, commit, and PR state.

## Required pre-write gates

Every environment envelope records and passes tenant, identity, dependency, security, lock,
artifact/source, rollback, and recovery gates. It also names exact commands and permitted records
or portal surfaces. No interactive CLI context is trusted by implication.

## Source transfer

The only deployable source is `src/portal/mpp2---mpp2/`. A permitted Studio snapshot downloads to
an isolated comparison directory outside `src/` and is reconciled through a task branch. Uploads
use the canonical path only after the owning environment envelope authorizes them.

## Always-escalated changes

Separate approval is required for destructive business data; identity, app registration,
credentials, consent, or permission changes; paid resources; tenant-wide settings; shared service
connections; emergency lock intervention; or any scope outside the recorded envelope.
