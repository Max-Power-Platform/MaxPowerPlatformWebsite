# Website Update Plan
## MaxPowerPlatformWebsite — `www.maxpowerplatform.com`

**Version**: 1.0  
**Date**: 2026-08-02  
**Status**: Plan — Awaiting Approval  
**Based on**: Suite repo survey conducted 2026-08-02

---

## Executive Summary

The website was set up with basic placeholder content during Phase 0 (2026-05-15). Since then, **16 suite repos** have been built to varying degrees of maturity. The site now significantly under-represents what Max Power Platform offers.

Additionally, the site currently presents only the **Max Power Suite** — it completely omits the **M365 Managed Services (MSP)** offering, which is the other half of the business.

---

## 1. Two Product Lines

Max Power Platform sells **two distinct offerings**:

| # | Product Line | Repo | What It Is |
|---|---|---|---|
| **1** | **M365 Managed Services** | `M365TennantAdmin` | Microsoft 365 tenant operations — managed client administration, offboarding, license/subscription health, audit, Graph orchestration |
| **2** | **Max Power Suite** | 15+ suite repos | Affordable housing nonprofit platform — 15 connected Power Platform modules |

The website must present **both** clearly on the home page, not just the Suite.

---

## 2. Current Site vs. Reality — Module-by-Module Gap Analysis

### 2.1 Housing Programs (5 tiles)

| Module | Site Says | Reality | Gap |
|---|---|---|---|
| **HBE** | "HUD-style classes, 1:1 counseling, education lock-in, and certificate issuance" | ✅ Accurate but **understates**: HUD-9902 ARM reporting pipeline, SHIP Rental Income Certification, SignNow e-signature, 79 Dataverse tables, 1,794+ custom fields, React Console SPA, live in Prod | Needs richer feature list |
| **DPA** | "SHIP & HOME-funded purchase assistance: applications, underwriting, awards, closings, liens, and HUD reporting" | ✅ Accurate but understates: DPA Console SPA, multi-jurisdiction (Tampa, Clearwater, Largo, St. Pete, Hillsborough, Pinellas), multi-funding (HTF, HOME+SHIP blend), cross-solution HBE funding integration | Needs jurisdiction/funding detail |
| **HRRP** | "City-referred housing repair/replacement programs: outreach, scope of work, contractor handoff, draws, and compliance" | ✅ Accurate but understates: HRRP Console SPA with Dashboard/Cases/Validation/Case Summary, Copilot Studio multi-agent (HRRP Manager + Write Steward), AP bill cross-linking, insurance coordination | Needs AI/automation mention |
| **CMS** | "Construction project management: proforma, deals, dev consoles, draws, time tracking, payment approvals, and document control" | ✅ Accurate but understates: Proforma Console, Deal Console, Dev Console (3 SPAs), 55 entities, ProformaAgent Copilot integration, SharePoint taxonomy, vendor portal planned | Needs console detail |
| **Property Management** | "Real-estate portfolio, units, tenants, rent rolls, and onboarding workflows" | ✅ Accurate but understates: PropertyConsoleWR SPA (workspace, ledger, vacancy, turn-time, tasks), FL-specific lease notices, 10-phase roadmap (E1–E10), Power Pages tenant portal | Needs SPA + portal mention |

### 2.2 Back-Office Operations (3 tiles)

| Module | Site Says | Reality | Gap |
|---|---|---|---|
| **Accounts Payable** | "Vendor invoice intake, multi-step approvals, AP role teams, and Copilot Studio AP agents" | ✅ Accurate but understates: AI extraction (Azure CU + OpenAI gpt-4.1-mini), QuickBooks Online live integration (MCP Service on Azure Container Apps), email-intake thin-flow, AP Dashboard SPA with bulk actions, live in Prod | Needs AI + QBO detail |
| **Procurement** | "RFPs, vendor evaluation, awards, funding sources, vendor certificates, document links — with a real-time analytics console" | ⚠️ **Overstates** — architecture defined only, not built. Describes things that don't exist yet | Downgrade to "planned" or add disclaimer |
| **Property Analyzer** | "Florida address → jurisdiction, zoning, permits, flood, utilities, and a public-records CMA/ARV forecast" | ✅ Accurate: Hillsborough, Pinellas, Pasco counties, Azure Maps, PAI Console SPA, printable reports, 3-county PA APIs | Good — minor: mention county coverage |

### 2.3 Fundraising & Engagement (4 tiles)

| Module | Site Says | Reality | Gap |
|---|---|---|---|
| **Fundraising** | "Donors, gifts, pledges, recurring giving, events, silent auctions, planned giving, GL export — with Stripe and donor portal" | ✅ Phase 1 complete (Foundation MDA). Stripe live. Silent auction with real-time bidding. Phases 2–7 pending | Accurate for current state — mark future phases |
| **Grants** | "Track grant opportunities, applications, awards, budget commitments, and 90/60/30/14/7-day deadline alerts" | ⚠️ **Overstates** — Pre-dev only. Word docs exist, no code. Describes functionality that doesn't exist | Move to Roadmap section |
| **Volunteers** | "Recruit, schedule, track hours, and recognize volunteers — tied to the same Dataverse contact and program records" | ⚠️ **No dedicated repo found** in suite survey. May be planned/aspirational. Referenced in tbnhs-portal and tbnhsnonprofit inventory as `Volunteer Management` MDA | Verify existence; move to Roadmap if not built |
| **Bulk Email** | "Newsletters and segmented bulk email through Azure Communication Services with marketing-list automation and unsubscribe handling" | ✅ Accurate: React SPA (Dashboard, Campaigns, Templates, Subscribers, Lists, Hygiene), ACS Enqueue/Drain with quota throttling, RFC-8058 one-click unsubscribe, ZeroBounce integration, journey automation, live in Prod | Needs more feature detail |

### 2.4 Roadmap / "Coming Soon" (3 tiles)

| Module | Site Says | Reality | Gap |
|---|---|---|---|
| **HR** | "Coming soon — staff onboarding, time-off, performance reviews, and HR document control" | ⚠️ **No dedicated repo found.** Listed as `HR` in original suite-scope but not built | Accurate — keep in roadmap |
| **LMS** | "Coming soon — training catalog, course completions, certifications, and CEU tracking" | ⚠️ **No dedicated repo found.** Listed as `LMS` in original suite-scope but not built | Accurate — keep in roadmap |
| **Plan Manager** | "Coming soon — strategic plan, outcomes, KPIs, and quarterly progress tracking" | ⚠️ **Misleading** — MPPProjectManagement is actively built with 14 tables, scheduling engine, 189 tests, React SPA. But it's a *project management* module, not exactly "strategic plan/KPI tracking" | Rename and reposition |

### 2.5 Missing Modules (not on site at all)

| Module | Repo | Status | Should Appear? |
|---|---|---|---|
| **Proforma Agent** | `ProformaAgent` | Copilot Studio agent on CMS property form, 8 topics, PCF control, Direct Line API | ✅ Yes — showcase AI capabilities |
| **Website Admin** | `WebsiteAdmin` | MDA for dynamic content, program types | ❌ Internal tool — don't feature |
| **TBNHS Portal** | `tbnhs-portal` | Shared Power Pages portal for all personas | ⚠️ Client-specific — mention as example deployment |

---

## 3. New Section: M365 Managed Services

### Current State
- **Not on the website at all**
- `M365TennantAdmin` repo is actively built: model-driven app + React SPA Console + .NET Azure Functions/Durable Functions + Microsoft Graph
- Selling point: "Managed Microsoft 365 for nonprofits"

### Proposed Tile

| Field | Content |
|---|---|
| **Section** | New section: "Managed IT Services" or standalone hero sub-section |
| **Title** | "Microsoft 365 Managed Services" |
| **Tagline** | "Managed Microsoft 365 for nonprofits — tenant operations, security, compliance, and support" |
| **Features** | Tenant inventory & sync, user lifecycle (onboard/offboard wizards), license & subscription health, immutable audit trail, Graph-powered automation, help desk delegation |

---

## 4. Proposed Site Structure (Updated)

```
www.maxpowerplatform.com
│
├── Hero: "Two platforms. One mission."
│   ├── Max Power Suite — 15-module affordable housing platform
│   └── M365 Managed Services — MSP for nonprofits
│
├── Section: Housing Programs (5 tiles)
│   ├── Homebuyer Education   ← UPDATE: mention ARM, e-sign, SPA
│   ├── Down Payment Assistance ← UPDATE: mention multi-jurisdiction, HTF
│   ├── Home Repair           ← UPDATE: mention Copilot agents, AP link
│   ├── Construction Management ← UPDATE: mention 3 SPAs, ProformaAgent
│   └── Property Management   ← UPDATE: mention tenant portal, SPA
│
├── Section: Back-Office Operations (3 tiles)
│   ├── Accounts Payable      ← UPDATE: mention AI extraction, QuickBooks
│   ├── Procurement           ← DOWNGRADE: "In design" badge
│   └── Property Analyzer     ← OK: mention 3-county coverage
│
├── Section: Fundraising & Engagement (3 tiles)
│   ├── Fundraising           ← OK: mention Stripe, auction, phases
│   ├── Bulk Email            ← UPDATE: mention ACS, journeys, hygiene
│   └── Grants → MOVE to Roadmap
│
├── Section: AI & Automation (NEW — 2 tiles)
│   ├── Proforma Agent        ← NEW: Copilot agent for property proformas
│   └── HRRP Agents           ← NEW: multi-agent Copilot system
│
├── Section: M365 Managed Services (NEW — 1-3 tiles)
│   ├── Tenant Operations     ← NEW: tenant inventory, offboarding, license health
│   ├── Security & Compliance ← NEW: audit trail, Secure Score, risk monitoring
│   └── Help Desk             ← NEW: delegated admin, TAP, password reset
│
├── Section: On the Roadmap (updated)
│   ├── Grant Management      ← MOVED from Engagement
│   ├── Procurement           ← MOVED from Operations (downgraded)
│   ├── Project Management    ← RENAMED from Plan Manager, updated status
│   ├── Volunteer Management  ← MOVED (verify repo status first)
│   ├── HR
│   └── LMS
│
└── Contact / CTA
```

---

## 5. Implementation Plan (Phased)

### Phase 1: Quick Wins (1-2 hours)
**Goal**: Fix the most misleading content immediately

| # | Task | File to Edit |
|---|---|---|
| 1.1 | Move **Grants** from Engagement section to Roadmap (it's pre-dev) | `Home.en-US.webpage.copy.html` |
| 1.2 | Move **Procurement** from Operations to Roadmap (architecture only) | `Home.en-US.webpage.copy.html` |
| 1.3 | Add **"In Design"** badge to Procurement tile (yellow, like "soon") | `Home.en-US.webpage.copy.html` |
| 1.4 | Add **"Pre-Development"** badge to Grants tile | `Home.en-US.webpage.copy.html` |
| 1.5 | Rename **Plan Manager** → **Project Management** and update status: "189 tests passing, scheduling engine live in Dev" | `Home.en-US.webpage.copy.html` |
| 1.6 | Verify **Volunteer Management** repo exists; if not, move to Roadmap | Investigate first |

### Phase 2: Feature Enrichment (2-3 hours)
**Goal**: Update existing tiles with real features that exist today

| # | Task |
|---|---|
| 2.1 | **HBE**: Add "HUD-9902 ARM reporting, SHIP Rental Income Cert, SignNow e-signature, React Console SPA" |
| 2.2 | **DPA**: Add "Multi-jurisdiction (Tampa, Clearwater, Largo, St. Pete, Pinellas, Hillsborough), HTF/HOME/SHIP blend, DPA Console SPA" |
| 2.3 | **HRRP**: Add "Copilot Studio multi-agent system, HRRP Console SPA with Dashboards, AP bill cross-linking" |
| 2.4 | **CMS**: Add "Three dedicated SPAs (Proforma, Deal, Dev Console), Copilot agent on property forms, SharePoint taxonomy" |
| 2.5 | **Property Management**: Add "PropertyConsoleWR SPA (workspace, ledger, vacancy, tasks), FL lease notices, TBNHS tenant portal" |
| 2.6 | **Accounts Payable**: Add "AI extraction (Azure AI + OpenAI), QuickBooks Online MCP integration, AP Dashboard SPA with bulk actions" |
| 2.7 | **Bulk Email**: Add "ACS Enqueue/Drain pipeline with quota throttling, RFC-8058 one-click unsubscribe, ZeroBounce hygiene, journey automation" |
| 2.8 | **Property Analyzer**: Add "3-county coverage (Hillsborough, Pinellas, Pasco), PAI Console SPA, printable reports" |
| 2.9 | **Fundraising**: Add "Stripe integration (live), real-time silent auctions with proxy bidding, 7-phase roadmap (Phase 1 complete)" |

### Phase 3: New Sections (2-3 hours)
**Goal**: Add the missing product line and new modules

| # | Task |
|---|---|
| 3.1 | **NEW**: M365 Managed Services section — 3 tiles (Tenant Ops, Security, Help Desk) |
| 3.2 | **NEW**: AI & Automation section — ProformaAgent, HRRP Agents tiles |
| 3.3 | **Update Hero**: Change from "Affordable Housing Nonprofit Suite" to "Two platforms. One mission." with both offerings |
| 3.4 | **Update Tagline**: "Frontier-first · AI-first · Nonprofit-first" |
| 3.5 | Add **M365 MSP** page at `/m365/` (new module page) |
| 3.6 | Add **Proforma Agent** page at `/proforma-agent/` (new module page) |

### Phase 4: Drill-Through Pages (3-4 hours)
**Goal**: Each module page gets real feature content, not stubs

| # | Task |
|---|---|
| 4.1 | Update `/hbe/` with full feature list from HBE repo |
| 4.2 | Update `/dpa/` with jurisdiction + funding detail |
| 4.3 | Update `/hrrp/` with Copilot agent architecture |
| 4.4 | Update `/cms/` with 3-console architecture |
| 4.5 | Update `/accounts-payable/` with AI + QuickBooks story |
| 4.6 | Update `/bulk-email/` with ACS pipeline detail |
| 4.7 | Create `/m365/` page content |
| 4.8 | Create `/proforma-agent/` page content |
| 4.9 | Update `/fundraising/` with Stripe + phases |

### Phase 5: Navigation & Polish (1 hour)
**Goal**: Navigation reflects new structure

| # | Task |
|---|---|
| 5.1 | Update main nav: Add "M365 MSP" nav item |
| 5.2 | Update main nav: Add "AI Agents" nav item |
| 5.3 | Update main nav: Move "Grants" and "Procurement" to Roadmap dropdown |
| 5.4 | Update Roadmap nav: Rename "Plan Manager" → "Project Management" |
| 5.5 | Verify all links work, mobile responsive |
| 5.6 | Download from live, commit, push |

---

## 6. Priority Matrix

| Priority | Module | Action | Reason |
|---|---|---|---|
| 🔴 **P0** | Grants | Move to Roadmap | **Site is lying** — no code exists |
| 🔴 **P0** | Procurement | Move to Roadmap | **Site is lying** — architecture only |
| 🔴 **P0** | M365 MSP | Add new section | **Missing product line** — half the business |
| 🟡 **P1** | HBE, DPA, HRRP, CMS, AP, Bulk Email | Enrich tiles | Real features exist, not reflected |
| 🟡 **P1** | Hero / Tagline | Update messaging | Doesn't mention M365 offering |
| 🟢 **P2** | ProformaAgent, HRRP Agents | New AI section | Showcase AI capabilities |
| 🟢 **P2** | Plan Manager | Rename to Project Management | Real module, wrong name |
| ⚪ **P3** | Drill-through pages | Full content | Nice to have, not urgent |
| ⚪ **P3** | Volunteer Management | Verify and reposition | Status unclear |

---

## 7. Risk Notes

| Risk | Mitigation |
|---|---|
| Editing live Prod HTML | Follow DEPLOYMENT.md workflow: download → edit → review diff → upload with PROD confirm |
| Tile grid breaks with new sections | Test responsive at 375px, 768px, 1024px, 1440px before upload |
| Navigation overflow (too many items) | Consolidate: "AI" dropdown covers ProformaAgent + HRRP Agents; "M365 MSP" could be a standalone top-level item |
| Grants/Procurement "downgrade" looks bad publicly | Frame as "transparency" — these are real planned modules, just being honest about timeline |

---

## 8. Success Metrics

After Phase 1-3:
- [ ] Home page presents **both** M365 MSP and Max Power Suite
- [ ] No module claims functionality that doesn't exist
- [ ] Every "live in Prod" module has at least 2 accurate features listed
- [ ] "Coming soon" modules are clearly marked
- [ ] AI capabilities (Copilot agents) are visible
- [ ] QuickBooks, Stripe, SignNow integrations are mentioned
