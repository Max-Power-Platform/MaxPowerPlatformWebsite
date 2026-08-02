# Pre-Flight Content Update Document
## MaxPowerPlatformWebsite — What Gets Updated, Exactly

**Date**: 2026-08-02
**Sources**: Suite PRDs, repo READMEs, M365 MSP sales collateral, existing drill-through pages
**Purpose**: Definitive content source before touching the live site. Every word below is traceable to a repo PRD or existing page.

---

## How to Use This Document

1. **Tile copy** → goes into the home page HTML (the one-liner under each tile)
2. **Drill-through content** → goes into each `/module-slug/` page (what the module does, who it's for, built on)
3. **M365 section** → new section added above the existing Suite hero
4. **Existing Suite hero** → UNCHANGED
5. **HRRP** → removed entirely

---

## SECTION: Existing Suite Hero — NO CHANGES

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

Changed: Remove "home repair" from the paragraph (was HRRP). Replace with just: "...deliver homebuyer education, down payment assistance, construction and property management, and the fundraising, grants, volunteer, and back-office work that surrounds them."

---

## NEW SECTION: Managed Microsoft 365 (added above Suite hero)

### Hero

```
[badge] Frontier-first · Secure-first

[  H1] Managed Microsoft 365 for Nonprofits

[  P1] Professional email, files, phones, security, and device management on one
       platform — managed for you so you don't need an IT hire. Replaces Zoom,
       Dropbox, antivirus, and phone systems with one vendor and one bill. New
       starter up in minutes. Leaver off in one click.

[  P2] Business Premium + conditional access + Defender for Endpoint + Purview
       data loss prevention + Copilot Chat — enterprise-grade security and AI that
       used to be reserved for companies with a thousand seats, managed and
       monitored by a team that knows your nonprofit.
```

### Tile 1: Enterprise Security & Compliance
- **Icon**: 🔐
- **Copy**: "Multi-factor authentication on every account. Conditional access that blocks sign-ins from risky countries and unmanaged devices. Defender for Endpoint on every laptop. Purview sensitivity labels. Data loss prevention that catches Social Security numbers, card numbers, and bank details before they leave your tenant. Cyber insurance ready from day one."

### Tile 2: One Platform, One Bill
- **Icon**: 🏢
- **Copy**: "Professional email on your own domain. Teams for chat, video, and your business phone. 1 TB of cloud storage per person. One vendor replacing Zoom, Dropbox, antivirus, phone systems, and file shares. New person starts — one action, they have everything. Someone leaves — one click, they have nothing. One bill. One place to manage it all."

### Tile 3: AI Built In
- **Icon**: 🤖
- **Copy**: "Microsoft 365 Copilot Chat — frontier AI inside your work account. Ask anything. Upload a contract and interrogate it. Word, Excel, and PowerPoint agents that build documents from a description. Enterprise data protection — your prompts and data are never used to train models. Included at no extra cost."

### Tile 4: Startup IT Foundation
- **Icon**: 📋
- **Copy**: "Domain registered to the company. A tenant built properly from day one. One identity per person across email, files, apps, and devices. MFA, conditional access, password manager, single sign-on. SPF, DKIM, and DMARC so your invoices don't land in spam. Costs less than a fraction of one IT hire."

### Tile 5: Protecting Personal Data
- **Icon**: 🛡️
- **Copy**: "Social Security numbers, card numbers, bank details, passport and driver's licence scans — automatically detected in email, files, and chat. Warned on, encrypted, or blocked before they leave your tenant. Know where your data is before you're asked — every state has breach notification law."

---

## SECTION: Suite Tiles — Updated Copy

### Housing Programs

#### 🏠 Homebuyer Education
**Tile**: "HUD-style classes, 1:1 counseling, education lock-in, and certificate issuance. HUD-9902 compliant reporting built in. Electronic signatures. One console your counselors, educators, and directors all use — the front door to every assistance program."

**Source**: HBE PRD §3.1: self-service education application, e-signature (FR-EDU-03), class scheduling (FR-EDU-05), attendance tracking (FR-EDU-11), certificates (FR-EDU-12), HUD-9902 ARM pipeline.

**Drill-through page** (`/hbe/`): "The HBE Console delivers the full housing counseling lifecycle — intake, financial assessment, education classes, 1:1 counseling, and HUD-9902 ARM reporting. Clients apply online and sign electronically. Staff schedule in-person and virtual classes with capacity management. Attendance is tracked per person, certificates issue automatically, and every step is auditable. Built on Dataverse with a React/TypeScript Console SPA, the shared TBNHS Power Pages portal, SignNow e-signature, and Copilot Studio agents wired through the native Dataverse MCP server."

---

#### 💰 Down Payment Assistance
**Tile**: "SHIP, HOME, and HTF-funded purchase assistance — applications, underwriting, awards, closings, liens, and HUD reporting. Multi-jurisdiction and multi-funding-source support. Real-time financial calculations."

**Source**: HBE PRD §3.3 DPA functional requirements; existing DPA drill-through page mentions City of Clearwater SHIP program (up to $75,000 loans), multi-funding (SHIP, HOME, ARPA, county-specific).

**Drill-through page** (`/dpa/`): Existing content is good — mentions Clearwater SHIP program, multi-funding sources, React/TypeScript DPA Console SPA, configurable program parameters. Keep as-is but ensure "Built on" section matches the standard template.

---

#### 🏟 Construction Management
**Tile**: "Construction project management — proformas, deals, development tracking, draws, time tracking, payment approvals, and document control. Three purpose-built consoles. AI agent alongside your project managers. SharePoint document control."

**Source**: CMS PRD §2: land acquisition → property development → construction contracting → budgeting → financing → payments. Three apps: Construction Management MDA, CMS Contracts MDA, App for Outlook. Core entities: `mpp_land`, `mpp_property`, `mpp_ConstructionContract`, `mpp_ProformaTemplate`, `mpp_Bill`.

**Drill-through page** (`/cms/`): "The Construction Management System runs the full lifecycle — from land acquisition and proforma through construction contracting, budgeting, draws, and payment approvals. Three dedicated consoles: a Construction Management app for project managers, a Contracts app for architectural plans and vendor approvals, and Outlook integration for field access. ProformaAgent — a Copilot Studio AI agent — works alongside your project managers directly on the property form. SharePoint document control with full taxonomy. Built on Dataverse with React SPAs, .NET plugins, and Power Automate workflows."

---

#### 🏛 Property Management
**Tile**: "Real-estate portfolio, units, tenants, leases, and rent rolls in one console. Vacancy and turn-time metrics. Florida-specific lease notices. Tenant self-service portal. Work order management."

**Source**: PropertyManagement PRD §1: two tightly coupled apps — Back-Office MDA for staff, Tenant Self-Service Power Pages Portal. §5 covers portfolio management, rental intake, tenant management, lease admin, payments, vendor bills, maintenance, documents.

**Drill-through page** (`/property-management/`): "The Property Management Platform handles the full residential real-estate lifecycle — portfolio tracking, rental applications, tenant onboarding, lease administration, rent collection, maintenance case management, and vendor bill processing. Staff work in a model-driven back-office app. Tenants have a self-service Power Pages portal to apply, pay rent, and request maintenance. Florida-specific lease notices. Built on Dataverse with React SPAs, Power Pages, Power Automate, and Copilot Studio agents."

---

### Back-Office Operations

#### 🥶 Accounts Payable
**Tile**: "AI reads your invoices — PDFs, images, and emails — and extracts the data automatically. QuickBooks Online syncs live. Approval workflows in Teams. One dashboard for everything your AP team touches — built on the shared mpp_bill family."

**Source**: AP PRD §1: email-intake thin-flow, AI extraction (Azure AI Content Understanding + Azure OpenAI), approval routing via Teams adaptive cards, QuickBooks Online MCP Service (Azure Container App), AP Dashboard SPA. Live in Prod. Zero-flow architecture (C# plugins, not Power Automate).

**Drill-through page** (`/accounts-payable/`): "Accounts Payable automates every step from invoice to payment. Bills arrive by email — AI reads PDFs, images, and email bodies and extracts vendor, amount, and line items automatically. Approvals route through Teams with a full audit trail. Approved bills sync to QuickBooks Online through a live MCP service — zero re-keying. The AP Dashboard SPA gives finance leadership real-time pipeline visibility with bulk actions. Built on Dataverse with C# plugins, Azure AI Content Understanding, Azure OpenAI, and the QuickBooks MCP Service on Azure Container Apps."

---

#### 📦 Procurement
**Tile**: "Sealed bidding, vendor compliance, contract buyout, and purchase order matching — the full procure-to-pay lifecycle. Funding-source tracking for audit-ready procurement. Real-time analytics console."

**Source**: Procurement PRD §1: RFP lifecycle (draft → bidder invite → vendor response → evaluation → award → contract). Operator SPA for day-to-day work. MDA for admin/data stewardship. Sprint 2 primitives live in Dev: vendor profile, compliance watchlist, financial transaction ledger, analytics WR with spend + tolerance charts.

**Drill-through page** (`/procurement/`): "Procurement manages the full RFP-to-contract lifecycle — draft RFPs scoped to properties, invite bidders, capture vendor responses with line-item detail, evaluate proposals side-by-side, award the winning vendor, and generate the RFP contract. The Operator SPA handles day-to-day work. An analytics console shows real-time spend and tolerance. Vendor compliance tracking, sealed bidding, and funding-source tracking for audit-ready procurement. Built on Dataverse with a React/TypeScript Operator SPA, .NET plugins, and Power Automate."

---

#### 📍 Property Analyzer
**Tile**: "Florida address → instant jurisdiction, zoning, flood, permits, and utilities. Multi-county coverage with server-side address suggestions. Public-records CMA and ARV forecast. One printable report for your land committee."

**Source**: PAI PRD §1: address-first search, county property-appraiser enrichment, Dataverse upsert. Hillsborough (HCPA), Pinellas (PCPAO), Pasco (PASCOPAO). Zoning, FLU, flood/coastal, permits, inspections, utilities. Printable report. Local CMA/ARV Forecast with real map.

**Drill-through page** (`/find-jurisdiction/`): Existing content is accurate and thorough — mentions Hillsborough, Pinellas, Pasco counties, Azure Maps server-side proxy, single-purpose plugin pack consumed by HBE, DPA, CMS, and Property Management. Keep as-is.

---

### Fundraising & Engagement

#### 💝 Fundraising & Engagement
**Tile**: "Donors, gifts, pledges, recurring giving, events, silent auctions, planned giving, GL export. Stripe-powered donation processing. Real-time auction with proxy bidding. Donor portal for self-service history."

**Source**: FAE PRD §1: 10-solution architecture, Stripe integration (PaymentIntent, Customer, Subscription, HMAC-verified webhooks), silent auction (real-time bidding, proxy bidding, winner checkout, outbid notifications), gift lifecycle (pledges, recurring, installments), GL export (QBO, Intacct, MIP), donor portal (Phase 2).

**Drill-through page** (`/fundraising/`): "Fundraising & Engagement is the end-to-end nonprofit development platform — gift processing, campaigns, silent auctions, events, planned giving, and donor communications. Stripe-powered donations with PCI-compliant processing. Real-time silent auctions with proxy bidding and automated winner checkout. Donor portal for self-service giving history. General ledger export to QuickBooks, Intacct, or MIP. Nine Power Automate flows and a .NET plugin assembly. Built on Dataverse with Stripe, Azure Communication Services, and Copilot Studio agents."

---

#### 📝 Grant Management
**Tile**: "Track grant opportunities, applications, awards, and budget commitments. Automated deadline alerts at 90, 60, 30, 14, and 7 days. AI grant agent to match opportunities to your programs."

**Source**: GM PRD §1: first Dataverse-native GMS for affordable housing. CDBG, HOME, NFMC, SHIP, ESG compliance frameworks. Opportunity pipeline, fit scoring, org profiles (SAM.gov, EIN, UEI), compliance flag tracking. HUD 9902 / CAPER reporting automation.

**Drill-through page** (`/grants/`): "MPP Grant Management is the first Dataverse-native grant management solution built specifically for affordable housing nonprofits. Track opportunities with structured fit scoring. Manage applications with automated deadline alerts. Monitor post-award compliance — Davis-Bacon, BABA, Section 3 — with flag tracking. Automate HUD 9902 and CAPER reporting. Link grant performance directly to client outcomes. AI grant agent matches opportunities to your organizational profile and program capacity. Built on Dataverse with Copilot Studio and Power Automate."

---

#### 🤝 Volunteer Management
**Tile**: "Recruit, schedule, track hours, and recognize volunteers — tied to the same Dataverse contact and program records. Recognition and retention dashboards."

**Drill-through page** (`/volunteers/`): Keep existing content. Note: no dedicated Volunteer Management repo found; this may be part of the TBNHS portal or a planned module.

---

#### 📧 Bulk Email & Newsletter
**Tile**: "Newsletters and segmented bulk email through Azure Communication Services. Built-in quota management. One-click unsubscribe. Email validation. Automated journeys — welcome series, renewal reminders, event follow-ups."

**Source**: Suite survey: React SPA (Dashboard, Campaigns, Templates, Subscribers, Lists, Hygiene), ACS Enqueue/Drain pipeline with quota throttling, RFC-8058 one-click unsubscribe, ZeroBounce integration, journey automation with enrollment scanner and goal-met watcher. Live in Prod.

**Drill-through page** (`/bulk-email/`): "Bulk Email & Newsletter delivers segmented email campaigns through Azure Communication Services. The React SPA manages campaigns, templates, subscriber lists, and list hygiene. An Enqueue/Drain pipeline throttles sends against your ACS quota with a cooperative circuit breaker. One-click unsubscribe per RFC-8058. Email validation through ZeroBounce protects your sender reputation. Automated journeys — welcome series, renewal reminders, event follow-ups. Built on Dataverse with ACS Email + Event Grid and Power Automate."

---

### Roadmap

#### 📊 Plan Manager
**Tile**: "Architectural plan and drawing management for construction projects — version control, markups, submittals, RFIs, and approval workflows. Connected to the same property and project records your team already works from."

**Note**: Plan Manager manages architectural plans (blueprints, drawings), not project scheduling. CMS PRD references `mpp_ArchitecturalPlanPage` entity. Keep this tile in the Roadmap section.

---

#### 👥 Human Resources
**Tile**: "Staff onboarding, time-off tracking, performance reviews, and HR document control — all connected to the same platform your programs run on."

---

#### 🎓 Learning Management
**Tile**: "Training catalog, course completions, certifications, and CEU tracking. Your staff and partner agencies stay current — tracked and auditable."

---

## What Gets Removed

| Item | Action |
|---|---|
| HRRP tile from "Housing programs" section | Remove the `<a>` block entirely |
| "home repair" from Suite hero paragraph | Replace with just the remaining modules |
| HRRP from Programs nav dropdown | Remove the weblink |
| HRRP drill-through page (`/hrrp/`) | Archive (set to Draft or remove) |
| "Coming soon" badges on Roadmap tiles | Remove the yellow `<span>` elements |
| Gray top borders on Roadmap tiles (`#bdbdbd`) | Change to `#1F66B5` (match other tiles) |
| Roadmap tile opacity (`opacity:0.85`) | Change to `opacity:1` (match other tiles) |

---

## Navigation Changes

Add as first nav item: **Managed M365** → `/m365/`

Programs dropdown: Remove HRRP (4 items remain: HBE, DPA, CMS, Property Management)

Roadmap dropdown: Keep "Plan Manager" (do not rename)

---

## New Page: `/m365/`

The M365 drill-through page follows the same pattern as existing module pages:

```
← Managed M365 for Nonprofits

What this service does

[Full description from MSP collateral]

Who it's for

Nonprofits that need professional IT without an IT hire. Small teams that want
enterprise security. Organizations switching from Google, Dropbox, or Zoom.
Startups building their IT foundation deliberately from day one.

What's included

- Professional email on your domain with 100 GB mailbox
- Teams for chat, video, and business phone
- 1 TB cloud storage per person
- Multi-factor authentication + conditional access
- Defender for Endpoint on every device
- Purview data loss prevention
- Copilot Chat with enterprise data protection
- SPF, DKIM, and DMARC configuration
- Immutable audit trail on admin actions
- Automated onboarding and offboarding workflows

Built on

Microsoft 365 Business Premium + Microsoft Graph + Azure Durable Functions +
Dataverse + Power Platform — managed and monitored by Max Power Platform.
```

---

## Implementation Order

1. **Add M365 section** to home page HTML (above existing Suite hero)
2. **Remove HRRP** from home page tiles
3. **Update tile copy** for all 14 modules + 3 roadmap (copy above)
4. **Remove "coming soon" badges** and gray borders from Roadmap tiles
5. **Update Suite hero paragraph** — remove "home repair"
6. **Update navigation** — add Managed M365, remove HRRP
7. **Create `/m365/` page**
8. **Archive `/hrrp/` page**
9. **Update drill-through pages** (Phase 2 — later)
