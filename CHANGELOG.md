# CHANGELOG — `MaxPowerPlatformWebsite`

All notable changes to this repo's deployable artifacts.

Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Versions follow `1.YY.JJJ.B` per `suite-architecture §3.2`.

Every Prod promote MUST add an entry with: version, date, approver, ZIP SHA256, summary.

---

## [Unreleased]

### Added
### Changed
### Fixed
### Removed

---

## v0.2.0 — 2026-08-02 — Repo migration + re-scaffold

- **Migrated** from `non-suite/nonprofit-suite-website` into `MPP/MaxPowerPlatformWebsite`
- Renamed to match domain: `MaxPowerPlatformWebsite`
- Restructured `src/website/` → `src/portal/` for clarity
- Preserved MPP conventions: OWNERS.md, CODEOWNERS, CHANGELOG.md
- Previous history at `non-suite/nonprofit-suite-website` (v0.1.0 scaffold, 2026-05-15)

---

## v0.1.0 — 2026-05-15 — Phase 0 scaffold (historical, in nonprofit-suite-website)

- Public marketing / module-info Power Pages site for `https://mpp2.powerappsportals.com/`
- Auth: Azure CLI + Service Principal + GitHub OIDC (no client secrets)
- Scripts: `bootstrap-azure-identity.ps1`, `list-sites.ps1`, `pages-download.ps1`, `pages-upload.ps1`
- GitHub workflows: `pages-export.yml`, `pages-deploy-uat.yml`, `pages-deploy-prod.yml`
- See `MaxShared/docs/SUITE-SOLUTION-STRATEGY-2026-05-14.md` §17 (strategy v1.12)
