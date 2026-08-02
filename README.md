# MaxPowerPlatformWebsite

Public marketing / module-info website for **Max Power Platform**, hosted on Power Pages.

| Detail | Value |
|---|---|
| **Domain** | `www.maxpowerplatform.com` |
| **Power Pages URL** | `https://mpp2.powerappsportals.com/` |
| **Tenant** | `mpp` (Max Power Platform) |
| **GitHub** | https://github.com/Max-Power-Platform/MaxPowerPlatformWebsite |

## What lives here

The exported source of the Power Pages site (web pages, web templates, web files, content snippets, site settings, basic forms, lists, tables). Edited two ways:

1. **In Power Pages Studio** (web UI) → `pwsh ./scripts/pages-download.ps1 -Env dev` → commit.
2. **Locally** (Liquid + JSON) → commit → `pwsh ./scripts/pages-upload.ps1 -Env dev` → see in Studio.

Pick one editor at a time per session to avoid drift. Studio always wins on conflict because it's the live source.

## Quick start

```pwsh
# 0. One-time auth bootstrap — see docs/AUTH.md
az login --tenant <MPP_TENANT_ID>
pwsh ./scripts/bootstrap-azure-identity.ps1

# 1. Create local pac profiles (once per machine, per env)
pac auth create --name mpp-website-dev  --environment <DEV_URL>  --azureCliAuth
pac auth create --name mpp-website-uat  --environment <UAT_URL>  --azureCliAuth
pac auth create --name mpp-website-prod --environment <PROD_URL> --azureCliAuth

# 2. Pull the live Dev site into src/portal/
pwsh ./scripts/pages-download.ps1 -Env dev
```

## Branch model

```text
feature/* -> dev -> main
release/* -> main when needed
hotfix/* -> main for emergencies only
```

## Repo layout

```
MaxPowerPlatformWebsite/
├── .github/workflows/   CI/CD (export, deploy UAT/Prod)
├── docs/                Auth setup, environments, architecture
├── scripts/             PowerShell automation (download, upload, bootstrap)
├── src/portal/          Power Pages exported source
├── README.md
├── OWNERS.md
├── CODEOWNERS
└── CHANGELOG.md
```

> **Migrated from** `non-suite/nonprofit-suite-website` on 2026-08-02.
