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

## 7. Integration Points

| Integration | Details |
|---|---|
| **Dataverse** | Backend for Contacts, bot consumer, search index |
| **Copilot Studio** | Embedded chatbot via `PvaEmbeddedWebChat` |
| **Azure AD B2C** | User authentication and profile mapping |
| **Azure (CI)** | Service Principal `mpp-pages-website` + federated OIDC credentials |

---

## 8. Technical Constraints

| Constraint | Detail |
|---|---|
| **Power Pages limits** | SaaS-imposed: page count, bandwidth, storage |
| **Single language** | English only (no multi-language configured) |
| **Managed environments** | UAT and Prod are managed-only |
| **No custom code** | All customization via Liquid templates + Bootstrap CSS — no server-side plugins |
| **pac modelVersion 2** | Export format is v2 (`--modelVersion 2`) |
| **Studio vs Code editing** | Must pick one per session to avoid drift |
