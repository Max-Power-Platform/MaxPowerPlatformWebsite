# Technical Design Document (TDD)
## MaxPowerPlatformWebsite — `www.maxpowerplatform.com`

**Version**: 1.0  
**Date**: 2026-08-02  
**Status**: As-Is Documentation

---

## 1. Repository Structure

```
MaxPowerPlatformWebsite/
├── .github/
│   ├── copilot-instructions.md       # AI agent project overlay
│   └── workflows/
│       ├── pages-export.yml          # Nightly drift detection
│       ├── pages-deploy-uat.yml      # Auto-deploy to UAT
│       └── pages-deploy-prod.yml     # Manual deploy to Prod
├── .vscode/
│   └── settings.json                 # Editor config, watcher exclusions
├── docs/
│   ├── AUTH.md                       # Auth bootstrap guide
│   ├── EDIT-WORKFLOW.md              # Workflow editing guide
│   ├── PRD.md                        # Product Requirements
│   ├── SA.md                         # Solution Architecture
│   ├── TDD.md                        # This file
│   ├── FDD.md                        # Functional Design
│   ├── DATA-DICTIONARY.md            # Site settings & entities
│   ├── ERD.md                        # Entity relationships
│   └── SITE-MAP.md                   # Page hierarchy
├── scripts/
│   ├── .site-ids.json                # Website IDs per env (gitignored)
│   ├── bootstrap-azure-identity.ps1  # One-time Azure SP setup
│   ├── Build-Site.ps1                # Build/validate Liquid templates
│   ├── Cleanup-Orphans.ps1           # Remove orphaned content
│   ├── Generate-ModulePages.ps1      # Scaffold module pages
│   ├── Generate-Nav.ps1              # Regenerate navigation
│   ├── list-sites.ps1                # List website IDs
│   ├── pages-download.ps1            # Pull live site → local
│   ├── pages-upload.ps1              # Push local → live site
│   ├── Setup-LeadForm.ps1            # Configure lead capture
│   └── Update-Content.ps1            # Bulk content updates
├── src/
│   └── portal/
│       └── mpp2---mpp2/              # Power Pages export
│           ├── .portalconfig/         # Deployment manifest
│           ├── botconsumer.yml
│           ├── content-snippets/      # 11 snippets
│           ├── page-templates/        # 4 templates
│           ├── publishingstate.yml
│           ├── sitemarker.yml         # 5 site markers
│           ├── sitesetting.yml        # 24 settings
│           ├── web-files/             # 62 files (logos, CSS, images)
│           ├── web-pages/             # 25 pages
│           ├── web-templates/         # 12 templates
│           ├── weblink-sets/          # 2 link sets (16 links)
│           ├── webpagerule.yml
│           ├── webrole.yml
│           ├── website.yml
│           ├── websiteaccess.yml
│           └── websitelanguage.yml
├── .gitignore
├── CHANGELOG.md
├── CODEOWNERS
├── OWNERS.md
├── README.md
└── SESSION_HANDOFF.md
```

---

## 2. Page Template Architecture

### Default Studio Template (used by 22 of 25 pages)

```
page request
  → Default studio template (page template, type: Web Template)
    → Default studio template (web template)
      → Layout 2 Column Wide Left (web template, extends)
        → Header (web template, global)
        → Breadcrumbs (web template)
        → Page Header (web template) → renders adx_title
        → Page Copy (web template) → renders adx_copy (editable HTML)
        → Footer (web template, global)
```

### Search Page

```
page request
  → Search (page template, type: Rewrite URL → ~/Pages/Search.aspx)
    → Search Results (web template, extends Layout 2 Column Wide Left)
      → {% searchindex %} Liquid query
      → Pagination (web template)
```

### Profile Page

```
page request
  → Profile (page template, type: Rewrite URL → ~/Pages/Profile.aspx)
    → Built-in Power Pages profile page
```

### Access Denied

```
page request
  → Access Denied (page template, type: Rewrite URL → ~/Pages/AccessDenied.aspx)
    → Built-in Power Pages access denied page
```

---

## 3. Web Template Details

### 3.1 `header` (Template ID: `8dac0351`)
- **Type**: Global (configured in `website.yml`)
- **Framework**: Bootstrap 5 `navbar-dark static-top`
- **Elements**:
  - Logo (`<img>`) from Mobile Header content snippet
  - Skip-to-content link (accessibility)
  - Toggle navigation button (mobile hamburger)
  - Language dropdown link
  - Search link
  - Sign in / Profile link
- **Caching**: Enabled (`Header/OutputCache/Enabled: True`)

### 3.2 `footer` (Template ID: `daa90212`)
- **Type**: Global
- **Styling**: `background-color: #1A4F8C`
- **Content**: Renders Footer content snippet (HTML)
- **Features**: Accessibility link container, language-switching JS
- **Caching**: Enabled (`Footer/OutputCache/Enabled: True`)

### 3.3 `default-studio-template`
- **Purpose**: Content wrapper; renders the `adx_copy` (editable HTML) field of the current page
- **Wrapper**: `<div class="page-copy">`

### 3.4 `layout-2-column-wide-left`
- **Layout**: Bootstrap grid — 8-col main + 4-col aside
- **Blocks**: Breadcrumbs → Page Header → Page Copy (main), aside block (extendable)

### 3.5 `breadcrumbs`
- **Logic**: Iterates `page.breadcrumbs`, outputs `<ul class="breadcrumb">`
- **Active crumb**: Truncated to 24 characters

### 3.6 `page-header`
- **Renders**: `<h1>` with `adx_title`

### 3.7 `page-copy`
- **Renders**: `adx_copy` (rich HTML content from Power Pages Studio)

### 3.8 `search`
- **Form**: `<form method="GET">` targeting Search sitemarker
- **Features**: Optional filter dropdown, tooltip from `Header/Search/ToolTip` snippet

### 3.9 `search-results`
- **Extends**: `Layout 2 Column Wide Left`
- **Query**: `{% searchindex %}` Liquid tag
- **Results**: Title, URL, fragment, pagination
- **Snippets used**: Search/ResultsCount, Search/NoResults, Search/ResultsTitle

### 3.10 `pagination`
- **Params**: `current_page`, `page_size`, `total`
- **Output**: Prev/Next links with limited page-range window

### 3.11 `power-virtual-agents`
- **JS API**: `PvaEmbeddedWebChat.renderWebChat()`
- **Config**: Reads bot details from `adx_botconsumer` entity

### 3.12 `languages-dropdown`
- **Renders**: Bootstrap dropdown of portal languages
- **Note**: Only English configured; dropdown is present but single-item

---

## 4. Home Page Content Structure

The home page (`/`) content is stored in `web-pages/home/content-pages/Home.en-US.webpage.copy.html`:

```
Section 1: Hero
  - MPP Logo (mpp-logo.png)
  - Tagline badge: "Frontier-first · AI-first"
  - H1: "Affordable Housing Nonprofit Suite"
  - Description paragraph
  - Tech stack callout: Dataverse + model-driven apps + Power Pages + Copilot Studio

Section 2: Housing Programs (#programs)
  - Title: "Housing programs"
  - 5 tiles: HBE, DPA, HRRP, CMS, Property Management

Section 3: Back-Office Operations (#operations)
  - Title: "Back-office operations"
  - 3 tiles: Accounts Payable, Procurement, Property Analyzer

Section 4: Fundraising and Engagement (#engagement)
  - Title: "Fundraising and engagement"
  - 4 tiles: Fundraising, Grants, Volunteers, Bulk Email

Section 5: Roadmap (#roadmap)
  - Title: "Roadmap"
  - 3 tiles: HR, Learning Management, Plan Manager

Section 6: Contact CTA
  - "Have a housing nonprofit need that doesn't fit a tile? Get in touch."
  - Email: max@maxpowerplatform.com
```

---

## 5. CSS & Theming

| File | Purpose | Source |
|---|---|---|
| `bootstrap.min.css` | Bootstrap 5 framework | Uploaded web file |
| `portalbasictheme.css` | Power Apps portals base theme | Auto-generated |
| `theme.css` | Custom overrides | Uploaded web file |
| `thumbnail.css` | Thumbnail styles | Uploaded web file |

### Theme Configuration
- **Theme V2** enabled via site setting `ThemeFeature`
- **Selected Theme ID**: `0f6ab1e0-f1d6-45a7-92d5-e07bd7bb9b6b`
- **Primary Color**: `#1F66B5` (tile borders, headings)
- **Footer Color**: `#1A4F8C`
- **Background Sections**: `#f7f8fa` (light gray), `#ffffff` (hero)

---

## 6. Script Reference

### `pages-download.ps1`
```powershell
pwsh ./scripts/pages-download.ps1 -Env dev|uat|prod
```
- Selects pac profile `nonprofit-website-{Env}`
- Reads websiteId from `scripts/.site-ids.json`
- Runs `pac pages download --webSiteId {id} --path src/website --modelVersion 2 --overwrite`

### `pages-upload.ps1`
```powershell
pwsh ./scripts/pages-upload.ps1 -Env dev|uat|prod [-ConfirmProd]
```
- Prod requires `-ConfirmProd` + typed `PROD` confirmation

### `bootstrap-azure-identity.ps1`
- Creates Azure AD app `mpp-pages-website` + Service Principal
- Sets up federated OIDC credentials per environment
- Idempotent — safe to re-run

---

## 7. Portal Configuration Manifest

The `.portalconfig/mpp1.crm.dynamics.com-manifest.yml` tracks deployment state:

| Component Type | Count Tracked |
|---|---|
| Bot Consumer | 1 |
| Content Snippets | 11 |
| Page Templates | 4 |
| Portal Language | 1 |
| Publishing States | 2 |
| Site Markers | 5 |

Each entry has: `RecordId`, `DisplayName`, `CheckSum`, `IsDeleted`.
