# Website Update Plan — Marketing Refresh
## MaxPowerPlatformWebsite — `www.maxpowerplatform.com`

**Version**: 5.0
**Date**: 2026-08-02
**Status**: Plan — Awaiting Approval
**Principle**: Build on the existing voice. The current hero is strong. Add the M365 offering alongside it.

**Companion documents**:
- `docs/BACKLOG.md` — Epic, features, requirements, risk register.
- `docs/SPRINT-PLAN.md` — Sprint-by-sprint PR plan and definition of done.

**Critical prerequisite**: Resolve the content source-of-truth conflict before Sprint 1. `SESSION_HANDOFF.md` calls `scripts/Build-Site.ps1` the single source of truth, while newer docs describe Studio-first / code-first file editing. This plan assumes a decision is recorded in `docs/EDIT-WORKFLOW.md` or a new `docs/CONTENT-SOURCE-OF-TRUTH.md` before any content is changed.

---

## 1. Current Voice (Keep This)

```
Frontier-first · AI-first

Affordable Housing Nonprofit Suite

A frontier-first, AI-first platform for nonprofit housing agencies — 15 connected
modules built on Microsoft Power Platform that deliver homebuyer education, down
payment assistance, home repair, construction and property management, and the
fundraising, grants, volunteer, and back-office work that surrounds them.

Dataverse + model-driven apps + Power Pages + Copilot Studio agents wired through
the native Dataverse MCP server — one platform, one constituent record, one set of
reports, with frontier AI models acting on the same data the staff see.
```

This is the template: badge → H1 → what-it-is paragraph → tech-credibility paragraph.

---

## 2. What Changes

### Hero becomes two sections — M365 first, then Suite

The existing Suite hero stays. A new M365 hero is added above it, following the same structural pattern.

```
SECTION: Managed Microsoft 365
─────────────────────────────
[badge] Frontier-first · Secure-first
[H1]    Managed Microsoft 365 for Nonprofits
[P1]    Professional email, files, phones, security, and device management on one
        platform — managed for you so you don't need an IT hire. Replaces Zoom,
        Dropbox, antivirus, and phone systems with one vendor and one bill. New
        starter up in minutes. Leaver off in one click.
[P2]    Business Premium + conditional access + Defender for Endpoint + Purview
        data loss prevention + Copilot Chat — enterprise-grade security and AI that
        used to be reserved for companies with a thousand seats, managed and
        monitored by a team that knows your nonprofit.
```

### Suite hero stays — tiles enriched

The existing Suite hero is preserved as-is but the tiles below get updated copy per the table below.

---

## 3. Home Page Structure (Final)

```
SECTION: Managed Microsoft 365 [NEW]
  Badge + H1 + 2 paragraphs (frontier/secure positioning)
  5 tiles:
    🔐 Enterprise Security & Compliance
    🏢 One Platform, One Bill
    🤖 AI Built In
    📋 Startup IT Foundation
    🛡️ Protecting Personal Data

SECTION: Affordable Housing Nonprofit Suite [EXISTING — enriched]
  Badge + H1 + 2 paragraphs (frontier/AI positioning — unchanged!)
  Sub: Housing programs (4 tiles — HRRP removed)
    🏠 Homebuyer Education       (enriched)
    💰 Down Payment Assistance   (enriched)
    🏟  Construction Management   (enriched)
    🏛  Property Management       (enriched)
  Sub: Back-office operations (3 tiles)
    🥶  Accounts Payable          (enriched)
    📦 Procurement               (enriched)
    📍 Property Analyzer          (enriched)
  Sub: Fundraising and engagement (4 tiles)
    💝 Fundraising               (enriched)
    📝 Grants                    (enriched)
    🤝 Volunteers                (enriched)
    📧 Bulk Email                (enriched)
  Sub: On the roadmap (3 tiles)
    📊 Project Management        (renamed from Plan Manager)
    👥 Human Resources           (minor polish)
    🎓 Learning Management       (minor polish)

CONTACT (unchanged)
```

---

## 4. M365 Tile Copy

| Tile | Copy |
|---|---|
| 🔐 **Enterprise Security & Compliance** | "Multi-factor authentication on every account. Conditional access that blocks sign-ins from risky countries and unmanaged devices. Defender for Endpoint on every laptop. Purview sensitivity labels. Data loss prevention that catches Social Security numbers, card numbers, and bank details before they leave your tenant. Cyber insurance ready from day one." |
| 🏢 **One Platform, One Bill** | "Professional email on your own domain. Teams for chat, video, and your business phone. 1 TB of cloud storage per person. One vendor replacing Zoom, Dropbox, antivirus, phone systems, and file shares. New person starts — one action, they have everything. Someone leaves — one click, they have nothing. One bill. One place to manage it all." |
| 🤖 **AI Built In** | "Microsoft 365 Copilot Chat — frontier AI inside your work account. Ask anything. Upload a contract and interrogate it. Word, Excel, and PowerPoint agents that build documents from a description. Enterprise data protection — your prompts and data are never used to train models. Included at no extra cost." |
| 📋 **Startup IT Foundation** | "Domain registered to the company. A tenant built properly from day one. One identity per person across email, files, apps, and devices. MFA, conditional access, password manager, single sign-on. SPF, DKIM, and DMARC so your invoices don't land in spam. Costs less than a fraction of one IT hire." |
| 🛡️ **Protecting Personal Data** | "Social Security numbers, card numbers, bank details, passport and driver's licence scans — automatically detected in email, files, and chat. Warned on, encrypted, or blocked before they leave your tenant. Know where your data is before you're asked — every state has breach notification law." |

---

## 5. Suite Tile Copy (Enriched — Same Voice)

### Housing Programs

| Tile | Copy |
|---|---|
| 🏠 **Homebuyer Education** | "HUD-style classes, 1:1 counseling, education lock-in, and certificate issuance. HUD-9902 compliant reporting built in. Electronic signatures. One console your counselors, educators, and directors all use — the front door to every assistance program." |
| 💰 **Down Payment Assistance** | "SHIP, HOME, and HTF-funded purchase assistance — applications, underwriting, awards, closings, liens, and HUD reporting. Multi-jurisdiction and multi-funding-source support. Real-time financial calculations." |
| 🏟  **Construction Management** | "Construction project management — proformas, deals, development tracking, draws, time tracking, payment approvals, and document control. Three purpose-built consoles. AI agent alongside your project managers. SharePoint document control." |
| 🏛  **Property Management** | "Real-estate portfolio, units, tenants, leases, and rent rolls in one console. Vacancy and turn-time metrics. Florida-specific lease notices. Tenant self-service portal. Work order management." |

### Back-Office

| Tile | Copy |
|---|---|
| 🥶  **Accounts Payable** | "AI reads your invoices — PDFs, images, and emails — and extracts the data automatically. QuickBooks Online syncs live. Approval workflows in Teams. One dashboard for everything your AP team touches — built on the shared mpp_bill family." |
| 📦 **Procurement** | "Sealed bidding, vendor compliance, contract buyout, and purchase order matching — the full procure-to-pay lifecycle. Funding-source tracking for audit-ready procurement. Real-time analytics console." |
| 📍 **Property Analyzer** | "Florida address → instant jurisdiction, zoning, flood, permits, and utilities. Multi-county coverage with server-side address suggestions. Public-records CMA and ARV forecast. One printable report for your land committee." |

### Engagement

| Tile | Copy |
|---|---|
| 💝 **Fundraising & Engagement** | "Donors, gifts, pledges, recurring giving, events, silent auctions, planned giving, GL export. Stripe-powered donation processing. Real-time auction with proxy bidding. Donor portal for self-service history." |
| 📝 **Grants** | "Track grant opportunities, applications, awards, and budget commitments. Automated deadline alerts at 90, 60, 30, 14, and 7 days. AI grant agent to match opportunities to your programs." |
| 🤝 **Volunteers** | "Recruit, schedule, track hours, and recognize volunteers — tied to the same Dataverse contact and program records. Recognition and retention dashboards." |
| 📧 **Bulk Email & Newsletter** | "Newsletters and segmented bulk email through Azure Communication Services. Built-in quota management. One-click unsubscribe. Email validation. Automated journeys — welcome series, renewal reminders, event follow-ups." |

### Roadmap

| Tile | Copy |
|---|---|
| 📊 **Plan Manager** | "Architectural plan and drawing management for construction projects — version control, markups, submittals, RFIs, and approval workflows. Connected to the same property and project records your team already works from." |
| 👥 **Human Resources** | "Staff onboarding, time-off tracking, performance reviews, and HR document control — all connected to the same platform your programs run on." |
| 🎓 **Learning Management** | "Training catalog, course completions, certifications, and CEU tracking. Your staff and partner agencies stay current — tracked and auditable." |

---

## 6. What Gets Removed

| Item | Reason |
|---|---|
| HRRP tile from Housing section | Not marketed |
| HRRP from Programs nav dropdown | Removed |
| HRRP drill-through page (`/hrrp/`) | Archived |
| "Coming soon" badges on Roadmap tiles | Not needed |
| Gray borders on Roadmap tiles | Treat same as others |
| Plan Manager | Not marketed outside TBNHS. Stays as-is in Roadmap — no changes to copy or positioning. |

---

## 7. Navigation

```
[Logo]  Managed M365  Programs ▾  Operations ▾  Engagement ▾  Roadmap ▾  [🔍] [👤]

Managed M365 → /m365/

Programs ▾                    Operations ▾              Engagement ▾               Roadmap ▾
├─ Homebuyer Education        ├─ Accounts Payable       ├─ Fundraising              ├─ Project Management
├─ Down Payment Assistance    ├─ Procurement            ├─ Grants                   ├─ Human Resources
├─ Construction Management    └─ Property Analyzer      ├─ Volunteers               └─ Learning Management
└─ Property Management                                  └─ Bulk Email
```

---

## 8. Corrected Implementation Phases

> **Do not execute the original phases above until the source-of-truth decision is recorded.** See `docs/BACKLOG.md` for full requirement IDs and `docs/SPRINT-PLAN.md` for the PR-by-PR schedule.

### Pre-Phase: Resolve workflow and naming (Sprint 0)
| # | Task | Output |
|---|---|---|
| 0.1 | Decide content source of truth (`Build-Site.ps1` vs Studio-first vs code-first) | Updated `docs/EDIT-WORKFLOW.md` or `docs/CONTENT-SOURCE-OF-TRUTH.md` |
| 0.2 | Resolve Plan Manager naming conflict with product owner | Decision recorded in this doc §8.4 |
| 0.3 | Verify M365 MSP service capabilities match `/m365/` copy | Ops sign-off in backlog risk register |
| 0.4 | Verify AP QBO sync and Bulk Email journeys are production-live | Evidence attached to F4-REQ-05 / F4-REQ-11 |

### Phase 1: M365 foundation (Sprint 1)
| # | Task | PR |
|---|---|---|
| 1.1 | Add M365 hero section + 5 tiles above existing Suite hero | `feat/m365-home-and-page` |
| 1.2 | Create `/m365/` service page with full drill-through copy | `feat/m365-home-and-page` |
| 1.3 | Add "Managed M365" to primary nav and footer | `feat/m365-nav-and-footer` |
| 1.4 | Update `SITE-MAP.md` and `PRD.md` for the new page | `feat/m365-nav-and-footer` |

### Phase 2: Suite catalog refresh (Sprint 2)
| # | Task | PR |
|---|---|---|
| 2.1 | Remove HRRP from site source, nav, footer; archive `/hrrp/` | `feat/remove-hrrp-refresh-hero` |
| 2.2 | Update Suite hero paragraph (remove "home repair"; fix module count) | `feat/remove-hrrp-refresh-hero` |
| 2.3 | Enrich 4 Housing Program tile descriptions | `feat/refresh-suite-tiles` |
| 2.4 | Enrich 3 Back-Office tile descriptions | `feat/refresh-suite-tiles` |
| 2.5 | Enrich 4 Engagement tile descriptions | `feat/refresh-suite-tiles` |
| 2.6 | Remove "coming soon" badges + gray borders from Roadmap tiles | `feat/refresh-suite-tiles` |
| 2.7 | Apply final Plan Manager naming decision (§8.4) | `feat/refresh-suite-tiles` |

### Phase 3: Module page enrichment (Sprint 3)
| # | Task | PR |
|---|---|---|
| 3.1 | Enrich `/hbe/`, `/dpa/`, `/cms/`, `/property-management/` | `feat/enrich-housing-module-pages` |
| 3.2 | Enrich `/accounts-payable/`, `/procurement/`, `/find-jurisdiction/` | `feat/enrich-backoffice-module-pages` |
| 3.3 | Enrich `/fundraising/`, `/grants/`, `/volunteers/`, `/bulk-email/` | `feat/enrich-engagement-module-pages` |
| 3.4 | Update roadmap module page per §8.4 naming decision | `feat/enrich-engagement-module-pages` |

### Phase 4: Conversion, analytics, and go-live (Sprint 4)
| # | Task | PR |
|---|---|---|
| 4.1 | Add "I'm interested in" dropdown or per-page CTAs | `feat/conversion-and-analytics` |
| 4.2 | Update `<title>`, meta descriptions, Open Graph tags | `feat/conversion-and-analytics` |
| 4.3 | Add analytics tag (Microsoft Clarity recommended) and event tracking | `feat/conversion-and-analytics` |
| 4.4 | UAT smoke test + Prod deploy via `pages-deploy-prod.yml` | `chore/deploy-and-docs` |
| 4.5 | Update `CHANGELOG.md` and mark planning docs superseded | `chore/deploy-and-docs` |

---

## 8.1 Source-of-Truth Decision (Required Before Sprint 1)

`SESSION_HANDOFF.md` describes `scripts/Build-Site.ps1` as the single source of truth: it generates the home page, all module pages, the nav, and the footer. Newer docs describe a Studio-first / code-first workflow where individual files are edited and uploaded with `pages-upload.ps1`.

**These cannot both be true.** Pick one and update the docs:

| Option | Pros | Cons | Best for |
|---|---|---|---|
| **A. Keep `Build-Site.ps1` as generator** | One `$modules` array controls everything; bulk copy changes are fast. | Requires PowerShell 7 and MPP Dev environment; less friendly to Studio edits. | Bulk refreshes like this one. |
| **B. Retire `Build-Site.ps1` generator; edit files / Studio directly** | Matches current `.github/copilot-instructions.md` and `DEPLOYMENT.md`; copywriters can use Studio. | Must manually keep Home, nav, footer, and module pages in sync. | Ongoing copy tweaks after the refresh. |
| **C. Hybrid: `Build-Site.ps1` for bulk regeneration, but Studio edits allowed if re-downloaded** | Flexible. | Risk of drift; requires disciplined conflict resolution. | Experienced owner only. |

**Recommendation**: Option A for this refresh (it is the fastest way to bulk-update 14 modules + nav + footer), then evaluate Option B for maintenance. Update `SESSION_HANDOFF.md`, `.github/copilot-instructions.md`, and `docs/DEPLOYMENT.md` to match.

---

## 8.2 Module Count After HRRP Removal

After removing HRRP, the Affordable Housing Nonprofit Suite has **14 live + roadmap modules**. The M365 offering is **not** a suite module — it is a separate managed service. Recommended hero wording:

> "A frontier-first, AI-first platform for nonprofit housing agencies — 14 connected modules built on Microsoft Power Platform that deliver homebuyer education, down payment assistance, construction and property management, and the fundraising, grants, volunteer, and back-office work that surrounds them."

If you prefer to keep a round number, drop the count entirely:

> "A frontier-first, AI-first platform for nonprofit housing agencies — connected modules built on Microsoft Power Platform that deliver homebuyer education, down payment assistance, construction and property management, and the fundraising, grants, volunteer, and back-office work that surrounds them."

---

## 8.3 M365 Messaging Guardrails

Before publishing `/m365/`, confirm with the M365 operations lead that the following are true or rephrase:

- **Defender for Endpoint** — licensed and deployed as a managed service?
- **Purview DLP** — configured with the listed sensitive information types?
- **Conditional access** — blocks risky countries / unmanaged devices?
- **Copilot Chat** — included in the service tier being sold?
- **SPF/DKIM/DMARC** — part of standard onboarding?

If any are aspirational, add qualifying language such as "included in our standard deployment" or "configured during onboarding" rather than implying they are active on day zero for every tenant.

---

## 8.4 Plan Manager Naming Conflict — Do Not Rename Yet

The plan's original instruction to rename "Plan Manager" → "Project Management" conflicts with the existing `mppprojectmanagement` repo (`feat/pm-lite`), which appears to be a real project-management product. There are at least three possible scopes for the roadmap tile:

1. **Architectural plan / drawing management** — what the current `plan-manager/` page describes (`mpp_ArchitecturalPlanPage`).
2. **Strategic planning / outcomes / KPIs** — what `Build-Site.ps1` currently describes.
3. **General project management** — what the `mppprojectmanagement` repo name suggests.

**Decision needed**: Which product does the roadmap tile represent? Until the product owner decides, keep the slug `/plan-manager/` and the display label "Plan Manager". Do not rename to "Project Management" in nav or copy.

---

## 8.5 What Changed from Version 4.0

- Added explicit source-of-truth prerequisite.
- Renumbered implementation phases into sprints aligned with `docs/SPRINT-PLAN.md`.
- Removed the "Rename Plan Manager → Project Management" instruction pending product-owner decision.
- Added module-count guidance after HRRP removal.
- Added M365 messaging guardrails.
- Cross-referenced new `BACKLOG.md` and `SPRINT-PLAN.md`.
