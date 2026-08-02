# Site Map
## MaxPowerPlatformWebsite — `www.maxpowerplatform.com`

**Version**: 1.0  
**Date**: 2026-08-02  
**Status**: As-Is Documentation

---

## 1. Full Site Map

```
www.maxpowerplatform.com (mpp2.powerappsportals.com)
│
├── / (Home)
│   ├── Hero: "Affordable Housing Nonprofit Suite"
│   ├── Section: Housing Programs (5 tiles)
│   ├── Section: Back-Office Operations (3 tiles)
│   ├── Section: Fundraising & Engagement (4 tiles)
│   ├── Section: Roadmap (3 tiles)
│   └── CTA: Contact email
│
├── /hbe/ — Homebuyer Education
├── /dpa/ — Down Payment Assistance
├── /hrrp/ — Home Repair & Rehab
├── /cms/ — Construction Management System
├── /property-management/ — Property Management
│
├── /accounts-payable/ — Accounts Payable
├── /procurement/ — Procurement
├── /find-jurisdiction/ — Property Analyzer
│
├── /fundraising/ — Fundraising & Engagement
├── /grants/ — Grant Management
├── /volunteers/ — Volunteer Management
├── /bulk-email/ — Bulk Email & Newsletter
│
├── /hr/ — Human Resources (roadmap)
├── /lms/ — Learning Management (roadmap)
├── /plan-manager/ — Plan Manager (roadmap)
│
├── /profile/ — User Profile (authenticated)
├── /search/ — Site Search
│
├── /privacy/ — Privacy Policy
├── /optin/ — SMS Opt-In / Terms
│
├── /access-denied/ — Access Denied
├── /page-not-found/ — 404 Page
│
└── /page/
    ├── /page/subpage-one/ — Subpage one (stub)
    └── /page/subpage-two/ — Subpage two (stub)
```

---

## 2. Page Visibility Matrix

| Page | In Navigation | In Sitemap | In Search | Auth Required |
|---|---|---|---|---|
| Home | ✅ | ✅ | ✅ | ❌ |
| HBE | ✅ (Programs) | ❌ | ✅ | ❌ |
| DPA | ✅ (Programs) | ❌ | ✅ | ❌ |
| HRRP | ✅ (Programs) | ❌ | ✅ | ❌ |
| CMS | ✅ (Programs) | ❌ | ✅ | ❌ |
| Property Management | ✅ (Programs) | ❌ | ✅ | ❌ |
| Accounts Payable | ✅ (Operations) | ❌ | ✅ | ❌ |
| Procurement | ✅ (Operations) | ❌ | ✅ | ❌ |
| Property Analyzer | ✅ (Operations) | ❌ | ✅ | ❌ |
| Fundraising | ✅ (Engagement) | ❌ | ✅ | ❌ |
| Grant Management | ✅ (Engagement) | ❌ | ✅ | ❌ |
| Volunteer Management | ✅ (Engagement) | ❌ | ✅ | ❌ |
| Bulk Email | ✅ (Engagement) | ❌ | ✅ | ❌ |
| HR | ✅ (Roadmap) | ❌ | ✅ | ❌ |
| LMS | ✅ (Roadmap) | ❌ | ✅ | ❌ |
| Plan Manager | ✅ (Roadmap) | ❌ | ✅ | ❌ |
| Profile | ✅ (Profile nav) | ❌ | ✅ | ✅ |
| Search | ❌ | ❌ | ❌ | ❌ |
| Privacy | ❌ | ❌ | ✅ | ❌ |
| OptIn | ❌ | ❌ | ✅ | ❌ |
| Access Denied | ❌ | ❌ | ❌ | ❌ |
| Page Not Found | ❌ | ❌ | ❌ | ❌ |
| Page (container) | ❌ | ✅ | ✅ | ❌ |
| Subpage one | ❌ | ✅ | ✅ | ❌ |
| Subpage two | ❌ | ✅ | ✅ | ❌ |

---

## 3. Navigation Structure

### Main Nav (Web Link Set: `default`)

```
┌─────────────────────────────────────────────────────────┐
│ [Logo]  Home  Programs ▾  Operations ▾  Engagement ▾  Roadmap ▾  [🔍] [👤] │
└─────────────────────────────────────────────────────────┘

Programs ▾                    Operations ▾              Engagement ▾               Roadmap ▾
├─ Homebuyer Education        ├─ Accounts Payable       ├─ Fundraising              ├─ Human Resources
├─ Down Payment Assistance    ├─ Procurement            ├─ Grants                   ├─ Learning Management
├─ Home Repair                └─ Property Analyzer      ├─ Volunteers               └─ Plan Manager
├─ Construction Management                              └─ Bulk Email
└─ Property Management
```

### Profile Nav (Web Link Set: `profile-navigation`)

```
[👤] ▾
└─ Profile
```

---

## 4. Component Map (per page type)

### Public Marketing Pages (Home + 15 Modules)

```
┌──────────────────────────────────────────────┐
│ HEADER                                       │
│  [Logo]  Nav  [Search]  [Sign In/Profile]    │
├──────────────────────────────────────────────┤
│ BREADCRUMBS                                  │
├──────────────────────────────────────────────┤
│                                              │
│  PAGE COPY (adx_copy — editable HTML)        │
│  • Home: 5 tile sections                     │
│  • Modules: feature detail content           │
│                                              │
├──────────────────────────────────────────────┤
│ FOOTER                                       │
│  Copyright | Links | Language                │
└──────────────────────────────────────────────┘
```

### Search Page

```
┌──────────────────────────────────────────────┐
│ HEADER                                       │
├──────────────────────────────────────────────┤
│  Search Form: [_____________] [Search]       │
│                                              │
│  Results: N results found                    │
│  ┌──────────────────────────────────────┐    │
│  │ Result 1 — Title                      │    │
│  │ /path/to/page — fragment...           │    │
│  ├──────────────────────────────────────┤    │
│  │ Result 2 — ...                        │    │
│  └──────────────────────────────────────┘    │
│  ◀ Previous  1  2  3  Next ▶               │
├──────────────────────────────────────────────┤
│ FOOTER                                       │
└──────────────────────────────────────────────┘
```

### Profile Page

```
┌──────────────────────────────────────────────┐
│ HEADER                                       │
├──────────────────────────────────────────────┤
│  Profile (built-in Power Pages)              │
│  • Contact information                       │
│  • Edit form                                 │
├──────────────────────────────────────────────┤
│ FOOTER                                       │
└──────────────────────────────────────────────┘
```

---

## 5. URL Routing

| URL Pattern | Page | Template Strategy |
|---|---|---|
| `/` | Home | Default studio template → Web Template |
| `/{module-slug}/` | Module page | Default studio template → Web Template |
| `/privacy/` | Privacy | Default studio template → Web Template |
| `/optin/` | OptIn | Default studio template → Web Template |
| `/profile/` | Profile | Rewrite URL → `~/Pages/Profile.aspx` |
| `/search/?q=...` | Search | Rewrite URL → `~/Pages/Search.aspx` + Search Results web template |
| `/access-denied/` | Access Denied | Rewrite URL → `~/Pages/AccessDenied.aspx` |
| `/page-not-found/` | Page Not Found | Default studio template → Web Template |
| `/page/subpage-one/` | Subpage one | Default studio template → Web Template |
| `/page/subpage-two/` | Subpage two | Default studio template → Web Template |

---

## 6. Content Snippet Usage Map

| Snippet | Used In |
|---|---|
| `Footer` | Footer web template |
| `Mobile Header` | Header web template (logo area) |
| `Logo URL` | Header web template |
| `Logo alt text` | Header web template |
| `Header/Search/ToolTip` | search web template |
| `Header/Toggle Navigation` | Header web template (mobile) |
| `Site name` | Browser `<title>` |
| `Search/Title` | search web template |
| `Search/Results Count` | search-results web template |
| `Search/Results Title` | search-results web template |
| `Search/No Results` | search-results web template |
