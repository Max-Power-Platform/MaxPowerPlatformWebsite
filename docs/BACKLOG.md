# Backlog — MaxPowerPlatform.com Marketing Refresh
## Managed M365 MSP + Max Power Platform Suite

**Version**: 1.0  
**Date**: 2026-08-02  
**Status**: Draft — pending planning review  
**Goal**: Reposition `maxpowerplatform.com` as the unified storefront for both **Managed Microsoft 365 for Nonprofits** and the **Max Power Platform Affordable Housing Suite**, with clear conversion paths for each buyer.

---

## Epic

### EPIC-1: Reposition `maxpowerplatform.com` as the unified M365 + Suite storefront

**Business outcome**: A visitor to the homepage immediately understands that Max Power Platform offers (a) managed IT/security/AI through M365 Business Premium and (b) a connected affordable-housing application suite built on the same Microsoft cloud. Either offering can be the entry point; the site captures the right lead for the right conversation.

**Success metrics**:
- M365 service page accounts for ≥ 20% of new lead form submissions within 90 days of launch.
- Home page bounce rate does not increase vs. baseline.
- All top-nav links resolve; zero 404s from removed HRRP assets.
- Lighthouse accessibility score ≥ 90 on Home and `/m365/`.

**In scope**:
- Home page: new M365 hero, refreshed suite tiles, HRRP removal.
- Navigation: add Managed M365 top-level item, remove HRRP, adjust roadmap labels.
- New `/m365/` drill-through page.
- Archive `/hrrp/`.
- Enrich all 14 suite module drill-through pages.
- Lead-capture alignment: form subject routing, page-level CTAs.
- Analytics + SEO instrumentation.

**Out of scope** (separate epics):
- E-commerce or self-service checkout.
- Multi-language localization.
- Blog / news engine.
- Major portal re-theme beyond M365 brand accent.
- Building the actual M365 TenantOps product (this epic is marketing content only).

---

## Features

### F1 — Managed M365 hero + service page
**Requirement set**: [F1-REQ](#f1-requirements)

Add a new top-of-page section above the existing Suite hero that introduces the Managed M365 offering, plus a dedicated `/m365/` page. The page must match the visual pattern of suite module pages and be reachable from the main nav and footer.

**Acceptance criteria**:
- [ ] M365 hero section renders first on Home, above Suite hero.
- [ ] Five M365 tiles render with approved copy and icons.
- [ ] `/m365/` page exists, is linked from nav + footer, and renders correctly on mobile.
- [ ] M365 page includes lead form CTA and subject defaults to "Managed M365 inquiry".

---

### F2 — Suite catalog refresh
**Requirement set**: [F2-REQ](#f2-requirements)

Remove HRRP, update all remaining suite tile copy to reflect current PRDs, restyle roadmap tiles to match live modules, and fix the module count / hero paragraph.

**Acceptance criteria**:
- [ ] HRRP tile removed from Home and HRRP link removed from nav.
- [ ] Suite hero paragraph no longer references "home repair" and no longer hardcodes "15" modules.
- [ ] All 14 remaining suite tiles use approved copy from `WEBSITE-UPDATE-PLAN.md` §5.
- [ ] Roadmap tiles render with the same border color, opacity, and no "soon" badge.
- [ ] `/hrrp/` page archived (unpublished or deleted) and no orphan weblinks remain.

---

### F3 — Navigation + site map alignment
**Requirement set**: [F3-REQ](#f3-requirements)

Update the primary nav weblink set and the documented site map to match the new structure.

**Acceptance criteria**:
- [ ] Main nav order: Managed M365, Programs ▾, Operations ▾, Engagement ▾, Roadmap ▾.
- [ ] Programs dropdown contains 4 items (HBE, DPA, CMS, Property Management).
- [ ] Roadmap dropdown labels are consistent with the final naming decision.
- [ ] `docs/SITE-MAP.md` updated to reflect new structure and page visibility.

---

### F4 — Module drill-through page enrichment
**Requirement set**: [F4-REQ](#f4-requirements)

Rewrite the 14 live suite module pages with the deeper "What this module does / Who it's for / Built on" copy sourced from PRDs. Update the HBE page first as the template.

**Acceptance criteria**:
- [ ] HBE, DPA, CMS, Property Management pages updated per approved copy.
- [ ] Accounts Payable, Procurement, Property Analyzer pages updated.
- [ ] Fundraising, Grants, Volunteers, Bulk Email pages updated.
- [ ] All module pages link back to Home and have consistent "Built on" paragraph.
- [ ] No broken internal links after HRRP removal.

---

### F5 — Lead capture and conversion alignment
**Requirement set**: [F5-REQ](#f5-requirements)

Make sure every major offering has a clear CTA and that leads are tagged by interest so sales follow-up is routed correctly.

**Acceptance criteria**:
- [ ] Home contact form supports optional "I'm interested in" dropdown (Managed M365 / Suite modules / Both / Not sure).
- [ ] `/m365/` page has a dedicated CTA that pre-selects "Managed M365".
- [ ] Suite module pages have a secondary CTA: "Talk to us about [Module Name]".
- [ ] Lead `subject` and `description` carry enough context for routing.
- [ ] Fallback email copy remains `max@maxpowerplatform.com` everywhere.

---

### F6 — Analytics, SEO, and trust signals
**Requirement set**: [F6-REQ](#f6-requirements)

Instrument the refreshed site so we can measure the epic's success and improve discoverability.

**Acceptance criteria**:
- [ ] Page `<title>` and meta description updated for Home and `/m365/`.
- [ ] Open Graph / Twitter Card meta tags present on Home and `/m365/`.
- [ ] Google Analytics 4 or Microsoft Clarity tag added via site setting / web file (decision recorded).
- [ ] Event tracking on tile clicks, nav clicks, and form submissions.
- [ ] Sitemap XML regenerated and submitted to search consoles if custom domain is verified.
- [ ] Accessibility: all images have alt text, color contrast passes, keyboard-navigable tiles.

---

### F7 — Governance, testing, and deployment safety
**Requirement set**: [F7-REQ](#f7-requirements)

Ensure the refresh ships safely through Dev → UAT → Prod with rollback capability and does not break existing leads or search indexing.

**Acceptance criteria**:
- [ ] A single source-of-truth decision is documented: `Build-Site.ps1` generator vs. Studio-first vs. code-first.
- [ ] All changes are committed and reviewed via PR before UAT deploy.
- [ ] UAT smoke test passes: nav, tiles, `/m365/`, contact form, 3 module pages, mobile.
- [ ] Prod deploy uses the existing `pages-deploy-prod.yml` environment gate.
- [ ] Rollback plan tested: previous commit can be redeployed to Prod in < 30 min.
- [ ] `CHANGELOG.md` updated with version, date, approver, and summary.

---

## Requirements

### F1-REQ — Managed M365 hero + service page

| ID | Requirement | Priority | Notes |
|---|---|---|---|
| F1-REQ-01 | Add a new Home section immediately after the header, before the existing Suite hero, with badge "Frontier-first · Secure-first", H1 "Managed Microsoft 365 for Nonprofits", and two positioning paragraphs. | P0 | Copy from `WEBSITE-UPDATE-PLAN.md` §2. |
| F1-REQ-02 | Render five M365 tiles in a responsive grid: Enterprise Security & Compliance, One Platform One Bill, AI Built In, Startup IT Foundation, Protecting Personal Data. | P0 | Icons and copy from `WEBSITE-UPDATE-PLAN.md` §4. |
| F1-REQ-03 | Create a new Power Pages page at `/m365/` with root + content records, following the same YAML shape as suite module pages. | P0 | Slug `m365`; folder `m365`; pretty name `M365`. |
| F1-REQ-04 | Write `/m365/` page copy: hero, What this service does, Who it's for, What's included list, Built on, CTA. | P0 | Copy from `PREFLIGHT-CONTENT-UPDATE.md` §"New Page: `/m365/`". |
| F1-REQ-05 | Add "Managed M365" to the primary nav as the first top-level item, linked to `/m365/`. | P0 | Not a dropdown. |
| F1-REQ-06 | Add `/m365/` to the footer link row. | P1 | Keep footer from becoming too wide; consider grouping if needed. |
| F1-REQ-07 | Ensure M365 section uses brand colors (`#1F66B5` primary, `#1A4F8C` accents) and does not clash with existing Suite hero styling. | P1 | Consider a subtle background tint to separate sections. |

### F2-REQ — Suite catalog refresh

| ID | Requirement | Priority | Notes |
|---|---|---|---|
| F2-REQ-01 | Remove the HRRP hashtable/entry from the site generation source and delete the `hrrp/` page folder from `src/portal/`. | P0 | See **open decision** on whether `Build-Site.ps1` or manual files are source of truth. |
| F2-REQ-02 | Update the Suite hero paragraph to remove the words "home repair" and update the module count (or remove the number). | P0 | Final count: 14 suite modules + M365 as a separate offering. |
| F2-REQ-03 | Update Housing Program tiles per `WEBSITE-UPDATE-PLAN.md` §5: HBE, DPA, CMS, Property Management. | P0 | |
| F2-REQ-04 | Update Back-Office tiles per plan: Accounts Payable, Procurement, Property Analyzer. | P0 | |
| F2-REQ-05 | Update Engagement tiles per plan: Fundraising & Engagement, Grants, Volunteers, Bulk Email & Newsletter. | P0 | |
| F2-REQ-06 | Resolve the "Plan Manager" naming conflict: decide whether it is architectural plan management, strategic plan/outcomes, or project management. | P0 | See risk register. |
| F2-REQ-07 | Remove "coming soon" badges and change Roadmap tile styling (`#bdbdbd` → `#1F66B5`, opacity `0.85` → `1`). | P0 | |
| F2-REQ-08 | Archive `/hrrp/` in Dataverse (unpublish or delete) and ensure no nav/footer/sitemap references remain. | P0 | Use `Cleanup-Orphans.ps1` or manual Studio action. |

### F3-REQ — Navigation + site map alignment

| ID | Requirement | Priority | Notes |
|---|---|---|---|
| F3-REQ-01 | Primary nav order: Managed M365, Programs, Operations, Engagement, Roadmap. | P0 | |
| F3-REQ-02 | Programs dropdown contains Homebuyer Education, Down Payment Assistance, Construction Management, Property Management only. | P0 | |
| F3-REQ-03 | Roadmap dropdown labels match the final naming decision from F2-REQ-06. | P0 | |
| F3-REQ-04 | Update `docs/SITE-MAP.md` to reflect: `/m365/` added, `/hrrp/` removed, new module count, updated nav structure. | P1 | |
| F3-REQ-05 | Update `docs/PRD.md` module catalog (remove HRRP, add M365 service, fix Plan Manager description). | P1 | |

### F4-REQ — Module drill-through page enrichment

| ID | Requirement | Priority | Notes |
|---|---|---|---|
| F4-REQ-01 | Rewrite `/hbe/` page per `PREFLIGHT-CONTENT-UPDATE.md` as the canonical template. | P0 | |
| F4-REQ-02 | Rewrite `/dpa/` page; preserve the Clearwater SHIP example but align "Built on" paragraph. | P0 | |
| F4-REQ-03 | Rewrite `/cms/` page with three-console narrative and ProformaAgent mention. | P0 | |
| F4-REQ-04 | Rewrite `/property-management/` page with tenant portal and Florida notices detail. | P0 | |
| F4-REQ-05 | Rewrite `/accounts-payable/` page with AI extraction, Teams approvals, QBO MCP service narrative. | P0 | Verify QBO MCP service is Prod-live before publish. |
| F4-REQ-06 | Rewrite `/procurement/` page with RFP lifecycle, Operator SPA, analytics console. | P0 | |
| F4-REQ-07 | Keep `/find-jurisdiction/` page mostly as-is; refresh "Built on" paragraph only. | P1 | |
| F4-REQ-08 | Rewrite `/fundraising/` page with Stripe, silent auction, donor portal, GL export. | P0 | |
| F4-REQ-09 | Rewrite `/grants/` page with opportunity fit scoring, compliance flags, AI grant agent. | P0 | |
| F4-REQ-10 | Keep `/volunteers/` page mostly as-is; refresh "Built on" paragraph. | P1 | |
| F4-REQ-11 | Rewrite `/bulk-email/` page with ACS, quota throttling, RFC-8058 unsubscribe, journeys. | P0 | |
| F4-REQ-12 | Rewrite the roadmap module page consistent with the final naming decision. | P1 | |

### F5-REQ — Lead capture and conversion alignment

| ID | Requirement | Priority | Notes |
|---|---|---|---|
| F5-REQ-01 | Add an "I'm interested in" field to the contact form with options: Managed M365, Suite modules, Both, Not sure. | P1 | Default to empty / Not sure. |
| F5-REQ-02 | `/m365/` CTA pre-selects "Managed M365" in the form when navigating back to Home CTA, or uses a query parameter. | P2 | Alternative: separate inline form on `/m365/`. |
| F5-REQ-03 | Each module page CTA sets the subject to "Website inquiry — [Module Name]". | P1 | Requires JS or per-page form snippet. |
| F5-REQ-04 | Preserve existing Dataverse `lead` schema: `firstname`, `lastname`, `emailaddress1`, `companyname`, `telephone1`, `subject`, `description`. | P0 | Do not break existing Web API config. |

### F6-REQ — Analytics, SEO, and trust signals

| ID | Requirement | Priority | Notes |
|---|---|---|---|
| F6-REQ-01 | Update Home `<title>` to "Managed Microsoft 365 + Affordable Housing Suite — Max Power Platform" or equivalent. | P1 | Keep under 60 chars. |
| F6-REQ-02 | Add meta description to Home and `/m365/` via content snippet or page summary. | P1 | |
| F6-REQ-03 | Add Open Graph tags: title, description, image (`/mpp-logo.png`), type, URL. | P2 | |
| F6-REQ-04 | Choose analytics provider (GA4 vs Microsoft Clarity) and record decision in `docs/`. | P2 | Prefer Microsoft Clarity for privacy alignment with M365 messaging. |
| F6-REQ-05 | Add event tracking attributes to tile links and nav links (`data-analytics-id`). | P2 | |
| F6-REQ-06 | Verify all interactive elements are keyboard accessible and pass Lighthouse a11y. | P1 | |

### F7-REQ — Governance, testing, and deployment safety

| ID | Requirement | Priority | Notes |
|---|---|---|---|
| F7-REQ-01 | Document the authoritative content editing workflow: resolve the `Build-Site.ps1` vs Studio-first vs code-first conflict. | P0 | See **critical risk** in risk register. |
| F7-REQ-02 | Every change ships via PR to `dev`, then UAT workflow, then Prod workflow. | P0 | |
| F7-REQ-03 | UAT smoke test script covers: Home hero, M365 section, nav dropdowns, `/m365/`, 3 suite module pages, contact form submit, mobile viewport. | P1 | Could be manual + Playwright. |
| F7-REQ-04 | Prod rollback: identify the previous known-good commit and confirm `pages-deploy-prod.yml` can redeploy it. | P1 | |
| F7-REQ-05 | Update `CHANGELOG.md` with version bump, date, approver, and summary of changes. | P0 | |
| F7-REQ-06 | Archive `PREFLIGHT-CONTENT-UPDATE.md` and `WEBSITE-UPDATE-PLAN.md` once this backlog is approved, or mark them superseded. | P2 | Avoid stale planning docs. |

---

## Risk Register

| ID | Risk | Impact | Mitigation | Owner |
|---|---|---|---|---|
| R1 | `Build-Site.ps1` is described as the single source of truth in `SESSION_HANDOFF.md`, but newer docs describe Studio-first/code-first workflow. A developer editing files directly will be overwritten by `Build-Site.ps1`, or vice versa. | High — wasted work, broken site | Decide source of truth before Sprint 1; update `SESSION_HANDOFF.md` or retire `Build-Site.ps1` as generator. | max@maxpowerplatform.com |
| R2 | Plan Manager / Project Management / mppprojectmanagement repo naming collision causes buyer confusion and incorrect product expectations. | High — mis-sold capability | Resolve F2-REQ-06 explicitly; do not rename until product owner confirms scope. | max@maxpowerplatform.com |
| R3 | M365 MSP content promises capabilities (Defender, Purview DLP, conditional access) not yet packaged as a sellable service. | High — legal/commercial risk | Legal/ops review of `/m365/` copy before Prod; add "available service tiers" footnote if needed. | max@maxpowerplatform.com |
| R4 | HRRP page removal breaks external inbound links or bookmarks. | Medium — 404s, SEO | Leave `/hrrp/` unpublished with a redirect, or return a soft 404 with a link to CMS / Suite. | max@maxpowerplatform.com |
| R5 | Removing "15 modules" and HRRP without updating all docs leaves inconsistent claims across repo. | Medium — brand inconsistency | Audit `README.md`, `PRD.md`, `SITE-MAP.md`, module pages, and footer for stale references. | max@maxpowerplatform.com |
| R6 | Contact form changes break lead creation in Dataverse. | Medium — lost leads | Test form submission end-to-end in UAT before Prod; keep fallback email visible. | max@maxpowerplatform.com |

---

## Open Decisions

1. **Source of truth for site content**: `Build-Site.ps1` generator vs. Studio-first/code-first manual files. Must be resolved before Sprint 1.
2. **Plan Manager naming**: Keep "Plan Manager" (architectural plans), rename to "Project Management" (general PM), or align with `mppprojectmanagement` repo scope.
3. **M365 pricing / tiers**: Should `/m365/` mention starting price or remain tier-agnostic?
4. **Analytics provider**: GA4, Microsoft Clarity, or both?
5. **Lead routing field**: Add dropdown to existing form, or create a separate `/m365/` inline form?
