# Website Update Plan — Marketing Refresh
## MaxPowerPlatformWebsite — `www.maxpowerplatform.com`

**Version**: 2.0  
**Date**: 2026-08-02  
**Status**: Plan — Awaiting Approval

---

## 1. Strategic Framing

The site is a **marketing catalog** for Max Power Platform. It sells the vision to potential clients — nonprofit housing agency executives, program directors, and operations leads. The question it answers is:

> *"What does my nonprofit need, and how does Max Power Platform deliver it?"*

It is **not** a build-status dashboard. All modules in the suite vision appear regardless of current development phase. The site communicates what's possible, not what's deployed.

---

## 2. Two Product Lines

Max Power Platform sells **two offerings**. Both must appear:

| # | Offering | Client Need | What We Deliver |
|---|---|---|---|
| **1** | **M365 Managed Services** | "We need someone to manage our Microsoft 365 — users, licenses, security, compliance." | Tenant ops console, onboarding/offboarding automation, license health, audit trail, Graph-powered help desk delegation |
| **Max Power Suite** | "We need a modern platform to run our housing programs, back-office, and fundraising — all connected." | 14 live Power Platform modules on a shared Dataverse tenant, with AI agents, React SPAs, and integrations |

---

## 3. Hero & Positioning Changes

| Current | Should Be |
|---|---|
| Tagline: "Frontier-first · AI-first" | "Modern operations for nonprofit housing — M365 management + an AI-first program platform" |
| H1: "Affordable Housing Nonprofit Suite" | "Everything your housing nonprofit runs on" |
| Describes 15 modules only | Describes **two offerings**: managed IT + program platform |
| No mention of AI | Mentions Copilot agents, AI extraction, MCP Server |

---

## 4. Module Tile Upgrades — Marketing Language

### 4.1 Housing Programs (4 tiles — HRRP removed)

| Module | Current | Upgrade |
|---|---|---|
| **Homebuyer Education** | "HUD-style classes, 1:1 counseling, education lock-in, and certificate issuance — the front door to every assistance program." | "HUD-style classes, 1:1 counseling, and certificate issuance. HUD-9902 compliant reporting built in. Electronic signatures. One console your counselors, educators, and directors all use — the front door to every assistance program." |
| **Down Payment Assistance** | "SHIP & HOME-funded purchase assistance: applications, underwriting, awards, closings, liens, and HUD reporting." | "SHIP, HOME, and HTF-funded purchase assistance — applications, underwriting, awards, closings, and liens across Tampa, Clearwater, Largo, St. Petersburg, Hillsborough, and Pinellas. Real-time financial calculations. HUD reporting." |
| **Construction Management** | "Construction project management: proforma, deals, dev consoles, draws, time tracking, payment approvals, and document control." | "Full construction project lifecycle — proformas, deals, development tracking, draws, time, and payment approvals. Three purpose-built consoles. AI agent alongside your project managers. SharePoint document control." |
| **Property Management** | "Real-estate portfolio, units, tenants, rent rolls, and onboarding workflows for nonprofit-owned properties." | "Portfolio, units, tenants, leases, and rent rolls in one console. Vacancy and turn-time metrics. Florida-specific lease notices. Tenant self-service portal. Work order management." |

### 4.2 Back-Office Operations (3 tiles)

| Module | Current | Upgrade |
|---|---|---|
| **Accounts Payable** | "Vendor invoice intake, multi-step approvals, AP role teams, and Copilot Studio AP agents — built on the shared mpp_bill family." | "AI reads your invoices — PDFs, images, emails — and extracts the data. QuickBooks Online syncs live. Approval workflows in Teams. One dashboard for everything your AP team touches." |
| **Procurement** | "RFPs, vendor evaluation, awards, funding sources, vendor certificates, document links — with a real-time analytics console." | "Sealed bidding, vendor compliance, contract buyout, and purchase order matching — the full procure-to-pay lifecycle. Real-time analytics console. Funding-source tracking for audit-ready procurement." |
| **Property Analyzer** | "Florida address → jurisdiction, zoning, permits, flood, utilities, and a public-records CMA/ARV forecast — the full property due-diligence packet in one tab." | "Florida address → instant jurisdiction, zoning, flood, permits, and utilities across Hillsborough, Pinellas, and Pasco counties. Public-records CMA and ARV forecast. One printable report for your land committee." |

### 4.3 Fundraising & Engagement (4 tiles)

| Module | Current | Upgrade |
|---|---|---|
| **Fundraising & Engagement** | "Donors, gifts, pledges, recurring giving, events, silent auctions, planned giving, GL export — with Stripe and donor portal." | "Stripe-powered donations with PCI-compliant processing. Real-time silent auctions with proxy bidding. Donor portal for self-service giving history. General ledger export to QuickBooks, Intacct, or MIP." |
| **Grant Management** | "Track grant opportunities, applications, awards, budget commitments, and 90/60/30/14/7-day deadline alerts." | "Track grant opportunities, applications, awards, and budget commitments. Automated deadline alerts at 90, 60, 30, 14, and 7 days. AI grant agent to match opportunities to your programs." |
| **Volunteer Management** | "Recruit, schedule, track hours, and recognize volunteers — tied to the same Dataverse contact and program records." | "Recruit, schedule, track hours, and recognize volunteers — tied to the same contact and program records. One system for clients and volunteers. Recognition and retention dashboards." |
| **Bulk Email & Newsletter** | "Newsletters and segmented bulk email through Azure Communication Services with marketing-list automation and unsubscribe handling." | "Send thousands of emails with built-in quota management. One-click unsubscribe. Email validation to protect your sender reputation. Automated journeys — welcome series, renewal reminders, event follow-ups." |

### 4.4 Roadmap (3 tiles)

| Module | Current | Upgrade |
|---|---|---|
| **Project Management** *(was "Plan Manager")* | "Coming soon — strategic plan, outcomes, KPIs, and quarterly progress tracking" | "Full Microsoft Project parity — WBS, dependencies, cascade scheduling, working calendars, baselines, and critical path. Built natively on Dataverse, independent of Microsoft Project for the Web. Live in production." |
| **Human Resources** | "Coming soon — staff onboarding, time-off, performance reviews, and HR document control" | "Staff onboarding, time-off tracking, performance reviews, and HR document control — all connected to the same platform your programs run on. On the roadmap." |
| **Learning Management** | "Coming soon — training catalog, course completions, certifications, and CEU tracking" | "Training catalog, course completions, certifications, and CEU tracking. Your staff and partner agencies stay current — tracked and auditable. On the roadmap." |

---

## 5. Proposed Site Structure

```
www.maxpowerplatform.com
│
├── Hero (rewritten)
│   "Everything your housing nonprofit runs on"
│   "Modern operations — M365 management + an AI-first program platform"
│
├── SECTION: M365 Managed Services (NEW — 3 tiles)
│   ├── Tenant Operations
│   ├── Security & Compliance
│   └── Help Desk
│
├── SECTION: Housing Programs (4 tiles — HRRP removed)
│   ├── Homebuyer Education (enriched)
│   ├── Down Payment Assistance (enriched)
│   ├── Construction Management (enriched)
│   └── Property Management (enriched)
│
├── SECTION: Back-Office Operations (3 tiles)
│   ├── Accounts Payable (enriched)
│   ├── Procurement (minor polish)
│   └── Property Analyzer (enriched)
│
├── SECTION: Fundraising & Engagement (4 tiles)
│   ├── Fundraising & Engagement (enriched)
│   ├── Grant Management (minor polish)
│   ├── Volunteer Management (minor polish)
│   └── Bulk Email & Newsletter (enriched)
│
├── SECTION: On the Roadmap (3 tiles)
│   ├── Project Management (renamed, enriched)
│   ├── Human Resources (minor polish)
│   └── Learning Management (minor polish)
│
└── Contact / CTA (unchanged)
```

---

## 6. What Gets Removed

| Item | Reason |
|---|---|
| **HRRP tile** | Per owner direction — not a marketed module |
| **HRRP drill-through page** | Remove from web-pages + nav |
| **HRRP nav link** | Remove from Programs dropdown |
| **"Coming soon" badges** | Marketing catalog — don't apologize for the vision |
| **Gray top borders on Roadmap tiles** | Treat same as other tiles visually (blue top border) |

---

## 7. M365 Section — New Tile Detail

### Tile 1: Tenant Operations
- **Icon**: 🏢
- **Copy**: "We manage your Microsoft 365 tenant — user lifecycle, license inventory, subscription health, and sync status — in one console backed by Dataverse and Microsoft Graph."

### Tile 2: Security & Compliance
- **Icon**: 🛡️
- **Copy**: "Immutable audit trail on every administrative action. Automated offboarding that revokes access in minutes. Secure Score monitoring. Delegated roles so the right people have the right access."

### Tile 3: Help Desk
- **Icon**: 🎧
- **Copy**: "Tier-1 tasks delegated to your team with tenant-scoped access. Password resets, temporary access passes, group management — all controlled, all audited."

---

## 8. Implementation Phases

### Phase 1: Home Page Rewrite (P0)

| # | Task |
|---|---|
| 1.1 | Rewrite hero: new H1, subtitle, CTA structure |
| 1.2 | Remove HRRP tile from Housing Programs |
| 1.3 | Add M365 Managed Services section (3 new tiles) |
| 1.4 | Enrich 4 Housing Program tiles |
| 1.5 | Enrich 3 Back-Office tiles |
| 1.6 | Enrich 4 Engagement tiles |
| 1.7 | Rename "Plan Manager" → "Project Management" + new copy |
| 1.8 | Remove "coming soon" badges, gray borders from Roadmap |
| 1.9 | Polish HR and LMS copy |

### Phase 2: Navigation + New Pages (P1)

| # | Task |
|---|---|
| 2.1 | Remove HRRP from Programs nav dropdown |
| 2.2 | Add M365 MSP as top-level nav or dropdown |
| 2.3 | Rename "Plan Manager" → "Project Management" in Roadmap dropdown |
| 2.4 | Create `/m365/` module page |
| 2.5 | Archive `/hrrp/` page |
| 2.6 | Verify all tile links work |

### Phase 3: Module Page Enrichment (P2 — later)

| # | Task |
|---|---|
| 3.1 | Update `/hbe/` with ARM, e-sign, SPA detail |
| 3.2 | Update `/dpa/` with jurisdiction + funding detail |
| 3.3 | Update `/cms/` with 3-console + ProformaAgent detail |
| 3.4 | Update `/accounts-payable/` with AI + QuickBooks detail |
| 3.5 | Update `/bulk-email/` with ACS pipeline detail |
| 3.6 | Update `/fundraising/` with Stripe + phases |
| 3.7 | Update `/find-jurisdiction/` with county coverage |
| 3.8 | Update `/property-management/` with SPA + portal detail |

---

## 9. Risk Notes

| Risk | Mitigation |
|---|---|
| Editing live Prod HTML | Follow DEPLOYMENT.md: download → edit → review diff → upload with confirm |
| M365 section makes page too long | 4 housing + 3 ops + 4 engagement + 3 M365 + 3 roadmap = 17 tiles across 5 sections. Current: 18 tiles across 4 sections — equivalent |
| HRRP removal leaves a gap | 4 housing tiles is fine visually |
| Nav has too many items | Programs: 4 (was 5). Add M365 as standalone. Roadmap: 3 |
