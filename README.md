# MaxPowerPlatformWebsite

Public marketing site for **Max Power Platform** (Managed M365 + Affordable Housing Nonprofit Suite), hosted on Power Pages.

| Detail | Value |
|---|---|
| **Domain** | `www.maxpowerplatform.com` |
| **Power Pages URL** | `https://mpp2.powerappsportals.com` |
| **Environment** | Prod (MPP), org ID `82a26b7d-9edb-ee11-9048-0022482ab210` |
| **GitHub** | https://github.com/Max-Power-Platform/MaxPowerPlatformWebsite |
| **Branches** | task branch → `dev` integration; approved `dev` → `main` release |

## Architecture

**Power Pages V2** (Enhanced Data Model). The reviewed tree at `src/portal/mpp2---mpp2/` is the only deployable source. `scripts/Build-Site.ps1` owns its declared generated artifacts; other portal files are hand-authored Git source. See [AB2044](docs/technical-design/AB-2044-content-authority-and-alm.md).

### OS page (interactive diagram)

A **vanilla JavaScript** concentric-ring diagram at `/operating-system/` that shows how every module fits together. ~27KB, no dependencies, no build step. Lives in `src/portal/mpp2---mpp2/web-files/mpp-os.js` and `mpp-os.css`. Power Pages loads it via a static `<script src>` tag in the page content HTML.

The diagram shows four concentric rings (Your Back Office → Your Programs → Your Constituents → One Record) plus a QuickBooks outer ring. Hover tooltips explain each module. Transaction playback traces constituent journeys across rings.

## Offline validation

```powershell
pwsh ./scripts/Test-Governance.ps1
pwsh ./scripts/Test-ContentAuthority.ps1
pwsh ./tests/ContentAuthority.Tests.ps1
```

No npm install, no Vite, no TypeScript build. The OS page JS is hand-authored and loaded directly as a web-file.

## Repo layout

```
MaxPowerPlatformWebsite/
├── docs/                Architecture, deployment, brand, environments
├── scripts/
│   ├── Build-Site.ps1           Authority for its declared generated outputs
│   ├── content-authority.ids.json  Committed stable fallback identifiers
│   └── Test-ContentAuthority.ps1  Offline authority/determinism prover
├── src/portal/mpp2---mpp2/      Power Pages exported source
│   ├── web-files/               Static files (mpp-os.js, mpp-os.css, mpp-logo.png)
│   ├── web-pages/               Page content (home, operating-system, module pages)
│   └── weblink-sets/            Primary nav
├── CHANGELOG.md
├── SESSION_HANDOFF.md           Deprecated compatibility pointer only
└── README.md
```

> Migrated from `non-suite/nonprofit-suite-website` on 2026-08-02. React+Fluent bundled version (447KB) replaced by 27KB vanilla JS on 2026-08-03.
