# Solution Architecture (SA)
## MaxPowerPlatformWebsite — `www.maxpowerplatform.com`

**Version**: 1.0  
**Date**: 2026-08-02  
**Status**: As-Is Documentation

---

## 1. Architecture Overview

```mermaid
graph TB
    subgraph "End Users"
        V[Visitors<br/>browser]
        A[Authenticated Users<br/>Azure AD B2C]
    end

    subgraph "Power Pages SaaS"
        PP[Power Pages Portal<br/>mpp2.powerappsportals.com]
        CDN[Power Pages CDN]
        LIQ[Liquid Engine]
        SRCH[Search Index]
    end

    subgraph "Azure AD B2C"
        B2C[Azure AD B2C Tenant<br/>mppportalusers.b2clogin.com]
        B2CP[Policies<br/>SignIn/SignUp/PasswordReset]
    end

    subgraph "Power Platform Backend"
        D365[Dataverse<br/>mpp1.crm.dynamics.com]
        CS[Copilot Studio Bot<br/>cr27b_99c91920]
    end

    subgraph "CI/CD"
        GH[GitHub Actions]
        PAC[pac CLI]
    end

    V --> CDN
    V --> PP
    A --> B2C
    B2C --> PP
    PP --> LIQ
    PP --> SRCH
    PP --> D365
    PP --> CS
    GH --> PAC
    PAC --> PP
```

---

## 2. Technology Stack

| Layer | Technology | Version/Purpose |
|---|---|---|
| **Portal Platform** | Microsoft Power Pages | SaaS, modelVersion 2 |
| **Frontend Framework** | Bootstrap 5 | `bootstrap.min.css`, `Site/BootstrapV5Enabled: true` |
| **Template Engine** | Liquid (Power Pages) | 12 custom web templates |
| **Authentication** | Azure AD B2C (OIDC) | `mppportalusers.b2clogin.com`, policy `b2c_1_loginflow` |
| **Backend Data** | Microsoft Dataverse | `mpp1.crm.dynamics.com` |
| **Chatbot** | Copilot Studio (PVA) | `PvaEmbeddedWebChat.renderWebChat()` |
| **CI/CD** | GitHub Actions | 3 workflows: export, deploy-uat, deploy-prod |
| **CLI** | Power Platform CLI (`pac`) | `--azureCliAuth`, `pages download/upload` |
| **Auth (CI)** | Azure Service Principal + OIDC | `mpp-pages-website` app registration |

---

## 3. Portal Component Architecture

```mermaid
graph LR
    subgraph "Website (websiteId: 379c4182)"
        W[website.yml]
    end

    W --> PT[Page Templates<br/>4 total]
    W --> WT[Web Templates<br/>12 total]
    W --> WP[Web Pages<br/>25 total]
    W --> CS[Content Snippets<br/>11 total]
    W --> SS[Site Settings<br/>24 total]
    W --> WF[Web Files<br/>62 total]
    W --> WL[Web Link Sets<br/>2 total]
    W --> WR[Web Roles<br/>3 total]
    W --> SM[Site Markers<br/>5 total]

    PT --> WT
    WP --> PT
    WT --> CS
    WT --> WF
    WL --> WP
```

### Key Relationships

1. **Website** → **Header/Footer** web templates (configured in `website.yml`)
2. **Page Template** `Default studio template` (web template type) → **Default studio template** web template → renders `adx_copy`
3. **Web Pages** → each assigned a **Page Template** and a **Parent Page**
4. **Web Link Sets** → link to **Web Pages**, forming the navigation menu
5. **Content Snippets** → referenced by **Web Templates** (e.g., Footer, Header, Mobile Header)
6. **Site Markers** → point to specific **Web Pages** (Home, Search, Profile, Access Denied, Page Not Found)
7. **Web Roles** → assigned to **Website Access Permissions** and **Web Page Access Rules**

---

## 4. Authentication Flow

```mermaid
sequenceDiagram
    participant U as User Browser
    participant PP as Power Pages
    participant B2C as Azure AD B2C
    participant DV as Dataverse

    U->>PP: Visit www.maxpowerplatform.com
    PP->>U: Anonymous access (Anonymous Users role)
    U->>PP: Click Sign In
    PP->>B2C: Redirect to B2C login
    B2C->>U: Sign In / Sign Up page
    U->>B2C: Email + password
    B2C->>PP: OIDC redirect with token
    PP->>DV: Map B2C user to Contact record
    PP->>U: Authenticated session (Authenticated Users role)
```

### B2C Configuration
- **Tenant**: `mppportalusers.b2clogin.com`
- **Client ID**: `7c253859-d3b9-42e2-9142-7f1778c69efb`
- **Policy**: `b2c_1_loginflow` (SignIn/SignUp), `B2C_1_passwordreset`
- **Redirect URI**: `https://mpp2.powerappsportals.com/signin-aad-b2c_1`
- **Contact Mapping**: `AllowContactMappingWithEmail: true`
- **Local Login**: Disabled (`LocalLoginEnabled: false`)

---

## 5. Deployment Architecture

```mermaid
graph TB
    subgraph "Development"
        DEV[Power Pages Dev]
        STUDIO[Power Pages Studio]
    end

    subgraph "CI/CD — GitHub Actions"
        EXPORT[pages-export.yml<br/>Nightly drift PR]
        DEPLOY_UAT[pages-deploy-uat.yml<br/>Auto on dev push]
        DEPLOY_PROD[pages-deploy-prod.yml<br/>Manual + PROD confirm]
    end

    subgraph "Environments"
        UAT[Power Pages UAT]
        PROD[Power Pages Prod<br/>mpp2.powerappsportals.com]
    end

    STUDIO -->|Studio edits| DEV
    DEV -->|pac pages download| REPO[GitHub Repo<br/>src/portal/]
    REPO -->|pac pages upload| DEV
    REPO --> EXPORT
    REPO --> DEPLOY_UAT
    DEPLOY_UAT --> UAT
    DEPLOY_PROD --> PROD
```

### CI/CD Pipelines

| Pipeline | Trigger | Action |
|---|---|---|
| `pages-export.yml` | Nightly schedule | Downloads live Dev → creates drift PR |
| `pages-deploy-uat.yml` | Push to `dev` | Uploads `src/portal/` to UAT |
| `pages-deploy-prod.yml` | Manual (`workflow_dispatch`) | Requires typed `PROD` + GH environment review → uploads to Prod |

### PAC Profiles

| Profile | Environment | Auth |
|---|---|---|
| `mpp-website-dev` | Dev | `--azureCliAuth` |
| `mpp-website-uat` | UAT | `--azureCliAuth` |
| `mpp-website-prod` | Prod (`mpp2`) | `--azureCliAuth` |

---

## 6. Security Model

| Aspect | Configuration |
|---|---|
| **Authentication** | Azure AD B2C OIDC, email-based |
| **Anonymous access** | All public pages (Anonymous Users role) |
| **Authenticated pages** | Profile page |
| **Admin access** | Administrators role (full permissions) |
| **Frame protection** | `X-Frame-Options: SAMEORIGIN` |
| **Secrets** | No client secrets in repo — Azure SP + OIDC for CI |
| **Prod deploy gate** | GitHub Environment review + typed `PROD` confirmation |

---

## 7. Interactive OS Diagram (Operating System Page)

The `/operating-system/` page hosts a vanilla JavaScript concentric-ring diagram showing how every module fits together.

### Architecture

```
Power Pages Page Content (Copy HTML)
  └── <script src="/mpp-os.js?v=N"></script>    ← static web-file tag (allowed by CSP)
      └── mpp-os.js (~27KB, IIFE)
          ├── embedded data (rings, nodes, modules, transactions)
          ├── SVG builder (donut paths, nodes, labels, glow filter)
          ├── DOM builder (header, controls, cards, module tile grid)
          ├── hover tooltips (ring name + description, module description)
          └── transaction playback (setInterval, ring highlighting)
```

### Why vanilla JS (no React)

- **CSP restriction**: Power Pages strips inline `<script>` tags from page content. Static `<script src>` tags are allowed but the portal script loader can interfere with framework bundles.
- **No build step**: `mpp-os.js` and `mpp-os.css` are hand-authored and committed directly to `src/portal/mpp2---mpp2/web-files/`.
- **Size**: 27KB vs 447KB (previous React+Fluent bundled version via Vite).
- **No dependency conflicts**: The portal ships React 16.14; our vanilla code has zero dependencies.

### Web-file pattern

Interactive components are uploaded as **web-files** (Dataverse `adx_webfile` entities). The page content HTML references them via static `<script src>` and `<link rel="stylesheet">` tags. This bypasses the 1MB `powerpagecomponent.content` limit while allowing arbitrarily complex frontend code.

The `Build-Site.ps1` script ensures YAML metadata files exist for each web-file (with stable GUIDs).

### Data flow

```
Build-Site.ps1                pac pages upload            Portal Runtime
──────────────                ────────────────            ──────────────
Defines modules           →   Writes page content    →   Serves HTML with
Generates page HTML           & web-files to              <script src> tag
Writes web-files              Dataverse                   Browser loads mpp-os.js
                                                          IIFE builds SVG + DOM
```

## 8. Integration Points

| Integration | Details |
|---|---|
| **Dataverse** | Backend for Contacts, bot consumer, search index |
| **Copilot Studio** | Embedded chatbot via `PvaEmbeddedWebChat` |
| **Azure AD B2C** | User authentication and profile mapping |
| **Azure (CI)** | Service Principal `mpp-pages-website` + federated OIDC credentials |

---

## 9. Technical Constraints

| Constraint | Detail |
|---|---|
| **Power Pages limits** | SaaS-imposed: page count, bandwidth, storage; `powerpagecomponent.content` max 1MB |
| **CSP inline scripts** | Power Pages strips inline `<script>` tags from page content — use web-files |
| **Single language** | English only (no multi-language configured) |
| **Direct-to-Prod** | Current operating model targets live production — no Dev/UAT in active use |
| **pac modelVersion 2** | Export format is v2 (`--modelVersion 2`) |
| **`.js` blocked by default** | Environment-level setting — must unblock in Power Platform Admin Center (Privacy + Security)
