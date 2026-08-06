# Sprint Plan — MaxPowerPlatform.com Marketing Refresh
## Managed M365 MSP + Max Power Platform Suite

**Version**: 1.0  
**Date**: 2026-08-02  
**Status**: Draft — pending planning review  
**Sprint duration**: 1 week each  
**Team**: 1 owner + reviewer

---

## Summary

| Sprint | Theme | PRs | Deliverable |
|---|---|---|---|
| Sprint 0 | Planning + workflow decision | — | Approved backlog, resolved source-of-truth, dev branch ready |
| Sprint 1 | M365 foundation | PR-1, PR-2 | M365 Home section + `/m365/` page + nav + footer |
| Sprint 2 | Suite catalog refresh | PR-3, PR-4 | HRRP removed, tile copy updated, roadmap restyled |
| Sprint 3 | Module page enrichment | PR-5, PR-6, PR-7 | All 14 suite module pages rewritten |
| Sprint 4 | Conversion + analytics + go-live | PR-8, PR-9 | Analytics, SEO, lead routing, UAT/Prod deploy |

---

## Sprint 0 — Planning & Source-of-Truth Decision

**Goal**: Resolve workflow ambiguity and finalize naming before any code/content changes.

### Tasks
- [x] AB2044 accepted the controlled repository-first hybrid: `Build-Site.ps1` owns declared generated outputs, other canonical files are hand-authored Git source, and Studio is comparison evidence only.
- [ ] Update `SESSION_HANDOFF.md` or `.github/copilot-instructions.md` to reflect the decision.
- [ ] Resolve "Plan Manager" naming conflict with product owner.
- [ ] Review `/m365/` copy with M365 MSP operations lead for accuracy.
- [ ] Confirm QBO MCP service is production-live if AP page claims live sync.
- [ ] Confirm bulk-email journeys are live if copy claims automated journeys.
- [ ] Create feature branches from `dev` for Sprint 1.

### Exit criteria
- [ ] Decision recorded in repo (`docs/EDIT-WORKFLOW.md` updated or new `docs/CONTENT-SOURCE-OF-TRUTH.md`).
- [ ] Backlog approved and committed to `dev`.
- [ ] No uncommitted planning docs.

---

## Sprint 1 — M365 Foundation

**Goal**: Ship the Managed M365 storefront on the site.

### PR-1: Add M365 Home section and service page
**Branch**: `feat/m365-home-and-page`  
**Scope**:
- Add M365 hero section to Home above existing Suite hero.
- Add 5 M365 tiles per `WEBSITE-UPDATE-PLAN.md` §4.
- Create `/m365/` Power Pages page (root + content YAML/HTML).
- Write `/m365/` page copy per `PREFLIGHT-CONTENT-UPDATE.md`.

**Acceptance criteria**:
- [ ] Home renders M365 section first on desktop and mobile.
- [ ] `/m365/` loads without 404 and matches module-page template.
- [ ] No HRRP or suite changes included in this PR.

**Reviewer focus**: Copy accuracy, mobile layout, no accidental edits to Suite hero.

### PR-2: Navigation and footer for M365
**Branch**: `feat/m365-nav-and-footer`  
**Depends on**: PR-1  
**Scope**:
- Add "Managed M365" as first top-level nav item.
- Add `/m365/` to footer link row without breaking layout.
- Update `docs/SITE-MAP.md` and `docs/PRD.md` for M365.

**Acceptance criteria**:
- [ ] Nav order matches F3-REQ-01.
- [ ] Footer does not wrap awkwardly at 1024px.
- [ ] Docs reflect the new page.

**Reviewer focus**: Nav consistency, footer responsive behavior.

### Sprint 1 exit criteria
- [ ] PR-1 and PR-2 merged to `dev`.
- [ ] UAT deploy triggered and smoke-tested.
- [ ] No regression on existing Suite hero or contact form.

---

## Sprint 2 — Suite Catalog Refresh

**Goal**: Remove HRRP, refresh all suite tile copy, and restyle roadmap.

### PR-3: Remove HRRP and update suite hero
**Branch**: `feat/remove-hrrp-refresh-hero`  
**Scope**:
- Remove HRRP from site generation source or files.
- Delete/unpublish `/hrrp/`.
- Update Suite hero paragraph (remove "home repair", fix module count).

**Acceptance criteria**:
- [ ] HRRP tile absent from Home.
- [ ] HRRP absent from nav and footer.
- [ ] `/hrrp/` returns 404 or a soft redirect page.
- [ ] Suite hero copy updated.

**Reviewer focus**: No stale HRRP references anywhere in repo.

### PR-4: Refresh suite tile copy and roadmap styling
**Branch**: `feat/refresh-suite-tiles`  
**Depends on**: PR-3  
**Scope**:
- Update all 14 suite tile descriptions per approved copy.
- Resolve Plan Manager naming and update its copy.
- Remove "coming soon" badges and gray borders from Roadmap tiles.

**Acceptance criteria**:
- [ ] All Housing, Operations, Engagement tiles match approved copy.
- [ ] Roadmap tiles look identical to live-module tiles.
- [ ] Plan Manager name/description consistent with decision.

**Reviewer focus**: Copy fidelity, visual parity, no broken links.

### Sprint 2 exit criteria
- [ ] PR-3 and PR-4 merged to `dev`.
- [ ] UAT deploy smoke-tested.
- [ ] Home page fully reflects new catalog.

---

## Sprint 3 — Module Page Enrichment

**Goal**: Rewrite all 14 suite module drill-through pages.

### PR-5: Housing program module pages
**Branch**: `feat/enrich-housing-module-pages`  
**Scope**:
- `/hbe/`, `/dpa/`, `/cms/`, `/property-management/`.

**Acceptance criteria**:
- [ ] Each page has What / Who / Built on per template.
- [ ] Copy matches approved module narratives.
- [ ] Internal links to Home and other modules work.

### PR-6: Back-office module pages
**Branch**: `feat/enrich-backoffice-module-pages`  
**Scope**:
- `/accounts-payable/`, `/procurement/`, `/find-jurisdiction/`.

**Acceptance criteria**:
- [ ] AP page mentions AI extraction, Teams approvals, QBO MCP service only if confirmed live.
- [ ] Procurement page covers RFP lifecycle and analytics console.
- [ ] Property Analyzer page keeps existing accurate content.

### PR-7: Engagement and roadmap module pages
**Branch**: `feat/enrich-engagement-module-pages`  
**Scope**:
- `/fundraising/`, `/grants/`, `/volunteers/`, `/bulk-email/`, plus roadmap page.

**Acceptance criteria**:
- [ ] Fundraising page includes Stripe, silent auction, donor portal, GL export.
- [ ] Grants page includes deadline alerts, compliance flags, AI grant agent.
- [ ] Bulk Email page includes ACS, quota, unsubscribe, journeys.
- [ ] Roadmap page copy matches final naming decision.

### Sprint 3 exit criteria
- [ ] PR-5, PR-6, PR-7 merged to `dev`.
- [ ] UAT deploy tested: spot-check 3 pages per reviewer.

---

## Sprint 4 — Conversion, Analytics, and Go-Live

**Goal**: Instrument, convert, and ship to Production safely.

### PR-8: Lead capture + SEO + analytics
**Branch**: `feat/conversion-and-analytics`  
**Scope**:
- Add "I'm interested in" dropdown to contact form (optional).
- Module page CTAs with per-module subject.
- Meta titles/descriptions and Open Graph tags for Home and `/m365/`.
- Analytics tag decision and implementation.

**Acceptance criteria**:
- [ ] Form still creates Dataverse leads end-to-end.
- [ ] Home and `/m365/` have unique `<title>` and meta description.
- [ ] Analytics tag present and firing on form submit + tile click.

**Reviewer focus**: Do not break existing lead Web API; privacy disclosures if GA4 used.

### PR-9: Documentation, changelog, and Prod deploy
**Branch**: `chore/deploy-and-docs`  
**Depends on**: PR-8  
**Scope**:
- Update `CHANGELOG.md`.
- Finalize `docs/SITE-MAP.md`, `docs/PRD.md`, `docs/DEPLOYMENT.md`.
- Run UAT smoke test and Prod deploy.
- Mark old planning docs superseded.

**Acceptance criteria**:
- [ ] `CHANGELOG.md` entry for v0.3.0 (or agreed version) with date and approver.
- [ ] UAT smoke test checklist completed and signed off.
- [ ] Prod deploy through `pages-deploy-prod.yml` with environment review.
- [ ] Live verification: Home, `/m365/`, nav, contact form, mobile.

**Reviewer focus**: Deployment safety, docs completeness.

### Sprint 4 exit criteria
- [ ] All PRs merged to `dev` then `main`.
- [ ] Prod live and verified.
- [ ] Rollback commit identified and documented.

---

## Cross-Sprint Dependencies

```
Sprint 0 decisions
        │
        ▼
Sprint 1 ──► Sprint 2 ──► Sprint 3 ──► Sprint 4
  PR-1        PR-3        PR-5        PR-8
  PR-2        PR-4        PR-6        PR-9
                          PR-7
```

Sprint 1 and Sprint 2 are mostly independent and could run in parallel **if** the source-of-truth decision and HRRP removal do not conflict. To reduce risk, recommend sequential sprints.

---

## PR Naming Convention

```
feat(scope): short description

Scope options:
- content      copy / page content changes
- nav          navigation / footer
- m365         Managed M365 content
- suite        suite catalog changes
- module-page  individual drill-through pages
- conversion   forms / CTAs / analytics
- docs         documentation / runbooks
- deploy       deployment / CI changes

Examples:
feat(content): add Managed M365 hero and tiles to Home
feat(m365): create /m365/ service page
feat(nav): add Managed M365 to primary nav and footer
feat(suite): remove HRRP and refresh suite tile copy
feat(module-page): rewrite HBE, DPA, CMS, Property Management pages
feat(conversion): add interest dropdown and per-page CTAs
chore(deploy): update site docs and changelog for v0.3.0
```

---

## Definition of Done (per PR)

- [ ] Branch from latest `dev`.
- [ ] Changes scoped to the PR description.
- [ ] Local or Studio validation passed.
- [ ] `git diff` reviewed for accidental changes.
- [ ] No secrets, tokens, or env-specific GUIDs committed.
- [ ] PR description links to backlog feature/requirement IDs.
- [ ] Reviewer approved.
- [ ] Merged to `dev`.
- [ ] UAT deploy smoke-tested (for content PRs).
- [ ] `CHANGELOG.md` updated (final PR of sprint).
