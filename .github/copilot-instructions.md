# MaxPowerPlatformWebsite — Project Overlay

> Shared baseline: `FullStackBestPractices/.github/copilot-instructions.md`
> This file extends it with project-specific rules for the public marketing Power Pages site.

## Project Identity

- **Repo**: `MaxPowerPlatformWebsite`
- **Domain**: `www.maxpowerplatform.com`
- **Power Pages**: `https://mpp2.powerappsportals.com/` (tenant: `mpp`)
- **PAC profile names**: `mpp-website-dev`, `mpp-website-uat`, `mpp-website-prod`
- **Azure AD app**: `mpp-pages-website`

## Power Pages Workflow

### Editing

Two modes — **pick one per session**:

1. **Studio-first** (web UI): make changes in Power Pages Studio → `pwsh ./scripts/pages-download.ps1 -Env dev` → commit → push.
2. **Code-first** (local): edit Liquid/JSON/CSS in `src/portal/` → commit → push → `pwsh ./scripts/pages-upload.ps1 -Env dev`.

Studio always wins on conflict — it's the live source.

### Script Reference

| Script | Purpose |
|---|---|
| `bootstrap-azure-identity.ps1` | One-time: create SP + federated credentials (idempotent) |
| `list-sites.ps1` | Discover website IDs for `.site-ids.json` |
| `pages-download.ps1 -Env <dev|uat|prod>` | Pull live site into `src/portal/` |
| `pages-upload.ps1 -Env <dev|uat|prod>` | Push local `src/portal/` to live site |
| `Build-Site.ps1` | Build/validate Liquid templates |
| `Cleanup-Orphans.ps1` | Remove orphaned pages/files |
| `Generate-ModulePages.ps1` | Scaffold module drill-through pages |
| `Generate-Nav.ps1` | Regenerate navigation from page structure |
| `Setup-LeadForm.ps1` | Configure lead capture form |
| `Update-Content.ps1` | Bulk content updates |

### Deployment Pipeline

```
Dev (unmanaged, Studio or code-first)
  → nightly drift PR (pages-export.yml)
  → UAT (pages-deploy-uat.yml, auto on dev push)
  → Prod (pages-deploy-prod.yml, GH environment review gate, typed PROD confirm)
```

### Key Site Settings

- `nonprofit-suite/tiles-json` — home page tile grid data
- `Authentication/OpenIdConnect/AAD-B2C_1/*` — B2C auth config (`mppportalusers.b2clogin.com`)
- `Site/BootstrapV5Enabled` — `true`
- `Search/Enabled` — `true`

### Content Notes

This site contains TWO categories of pages:
1. **Nonprofit Suite marketing tiles**: hbe, dpa, hrrp, fundraising, grants, volunteers, bulk-email
2. **Other MPP pages**: accounts-payable, procurement, property-management, cms, plan-manager, find-jurisdiction, hr, lms

The site is the umbrella marketing front for all Max Power Platform services, not just the nonprofit suite.

## Branch Model

```
feature/* → dev → main
release/* → main (when needed)
hotfix/* → main (emergency only)
```

Default branch: `main`. Active development: `dev`.

## Safety Rules

- **Never run `pages-upload.ps1` against Prod without `-ConfirmProd`** and explicit user approval.
- Dev is unmanaged. UAT and Prod are managed-only.
- Use `pac pages download` before starting a Studio session to avoid drift.
- Do not edit `src/portal/` while Studio has unsaved changes — download first.
