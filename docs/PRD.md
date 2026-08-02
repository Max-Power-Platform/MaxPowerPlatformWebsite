# Product Requirements Document (PRD)
## MaxPowerPlatformWebsite — `www.maxpowerplatform.com`

**Version**: 1.0  
**Date**: 2026-08-02  
**Status**: As-Is Documentation (current state)  
**Owner**: max@maxpowerplatform.com

---

## 1. Executive Summary

MaxPowerPlatform.com is the public marketing website for **Max Power Platform**, a Microsoft Power Platform-based suite of 15 connected modules serving nonprofit housing agencies. The site serves as the umbrella storefront — introducing the platform, describing each module, and providing legal pages (Privacy, Terms/OptIn).

The site is built on **Microsoft Power Pages** (hosted at `mpp2.powerappsportals.com`) with a custom domain `www.maxpowerplatform.com`. It uses Azure AD B2C for authentication, Bootstrap 5 theming, and custom Liquid templates.

---

## 2. Target Audience

| Audience | Need |
|---|---|
| **Nonprofit housing agency executives** | Understand what modules exist and how they fit together |
| **Program directors** (HBE, DPA, HRRP, etc.) | Deep-dive into specific module capabilities |
| **Finance/operations staff** | Learn about back-office modules (AP, Procurement) |
| **Grant writers / fundraisers** | Understand engagement tools (Fundraising, Grants) |
| **Existing TBNHS clients** | Reference site for ongoing services |
| **Prospective clients** (FSI, etc.) | Evaluate the platform for their own use |

---

## 3. Site Goals

| Goal | Priority |
|---|---|
| Present the full 15-module suite as one unified platform | P0 |
| Drive inbound inquiries (`max@maxpowerplatform.com`) | P0 |
| Provide module drill-through pages with feature detail | P1 |
| Host legal pages (Privacy Policy, OptIn/Terms) | P1 |
| Support authenticated profile for registered users | P2 |
| Offer site-wide search | P2 |
| Embed Copilot Studio chatbot for visitor assistance | P2 |

---

## 4. Module Catalog (15 Modules)

### Housing Programs (5)

| # | Module | Tile ID | Page URL | Description |
|---|---|---|---|---|
| 1 | Homebuyer Education | `hbe` | `/hbe/` | HUD-style classes, 1:1 counseling, education lock-in, certificate issuance |
| 2 | Down Payment Assistance | `dpa` | `/dpa/` | SHIP & HOME-funded purchase assistance: applications, underwriting, awards, closings, liens |
| 3 | Home Repair & Rehab | `hrrp` | `/hrrp/` | City-referred housing repair/replacement: outreach, scope of work, contractor handoff, draws |
| 4 | Construction Management | `cms` | `/cms/` | Proforma, deals, dev consoles, draws, time tracking, payment approvals, document control |
| 5 | Property Management | `property-management` | `/property-management/` | Portfolio, units, tenants, rent rolls, onboarding for nonprofit-owned properties |

### Back-Office Operations (3)

| # | Module | Tile ID | Page URL | Description |
|---|---|---|---|---|
| 6 | Accounts Payable | `accounts-payable` | `/accounts-payable/` | Vendor invoice intake, multi-step approvals, AP role teams, Copilot Studio AP agents |
| 7 | Procurement | `procurement` | `/procurement/` | RFPs, vendor evaluation, awards, funding sources, vendor certificates, analytics console |
| 8 | Property Analyzer | `find-jurisdiction` | `/find-jurisdiction/` | Florida address → jurisdiction, zoning, permits, flood, utilities, CMA/ARV forecast |

### Fundraising & Engagement (4)

| # | Module | Tile ID | Page URL | Description |
|---|---|---|---|---|
| 9 | Fundraising & Engagement | `fundraising` | `/fundraising/` | Donor management, campaigns, giving tracking |
| 10 | Grant Management | `grants` | `/grants/` | Grant lifecycle: applications, reporting, compliance |
| 11 | Volunteer Management | `volunteers` | `/volunteers/` | Volunteer onboarding, scheduling, hour tracking |
| 12 | Bulk Email & Newsletter | `bulk-email` | `/bulk-email/` | Email campaigns, newsletter distribution |

### Future / Roadmap (3)

| # | Module | Tile ID | Page URL | Description |
|---|---|---|---|---|
| 13 | Human Resources | `hr` | `/hr/` | HR management for nonprofit staff |
| 14 | Learning Management | `lms` | `/lms/` | Training and certification tracking |
| 15 | Plan Manager | `plan-manager` | `/plan-manager/` | Strategic planning and project management |

---

## 5. Functional Requirements

### FR-1: Home Page
- Logo + tagline ("Frontier-first · AI-first")
- Hero: "Affordable Housing Nonprofit Suite"
- Three tile sections: Housing Programs (5), Back-Office Operations (3), Fundraising & Engagement (4)
- Each tile: icon, title, one-sentence description, link to drill-through page
- Roadmap section for future modules
- Contact CTA: "Have a housing nonprofit need that doesn't fit a tile? Get in touch."

### FR-2: Module Drill-Through Pages
- Each of the 15 modules has a dedicated page at `/module-slug/`
- Content managed via Power Pages Studio (not hardcoded Liquid)

### FR-3: Navigation
- Main nav: Home, Programs (dropdown), Operations (dropdown), Engagement (dropdown), Roadmap (dropdown)
- Profile nav: Profile link for authenticated users

### FR-4: Authentication
- Azure AD B2C (`mppportalusers.b2clogin.com`)
- Email-based sign-up/sign-in
- Password reset support
- Profile page for authenticated users

### FR-5: Search
- Full-text site search via Power Pages search index
- Results page with pagination
- No-results handling

### FR-6: Legal Pages
- Privacy Policy at `/privacy/`
- OptIn / Terms at `/optin/`
- Access Denied page
- Page Not Found (404) page

### FR-7: Chatbot
- Copilot Studio / Power Virtual Agents embedded via `PvaEmbeddedWebChat`

---

## 6. Non-Functional Requirements

| Requirement | Detail |
|---|---|
| **Platform** | Microsoft Power Pages |
| **Hosting** | Power Pages SaaS (`mpp2.powerappsportals.com`) |
| **Custom Domain** | `www.maxpowerplatform.com` |
| **SSL** | Managed by Power Pages |
| **CDN** | Managed by Power Pages |
| **Responsive** | Bootstrap 5, mobile-first |
| **Auth** | Azure AD B2C (SAML/OIDC) |
| **Search** | Power Pages built-in search index |
| **Caching** | Header/Footer output caching enabled |
| **Security** | `X-Frame-Options: SAMEORIGIN` |
| **Accessibility** | Skip-to-content link, semantic HTML, ARIA labels |
| **Languages** | English only (LCID 1033) |

---

## 7. Out of Scope (Current State)

- E-commerce / payment processing
- Multi-language support
- Blog / news section
- Dynamic tile content from Dataverse (tiles are hardcoded HTML)
- User-generated content / comments
- A/B testing or analytics integration
