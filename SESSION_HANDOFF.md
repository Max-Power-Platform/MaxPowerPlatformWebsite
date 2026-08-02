# Session handoff — `mpp2.powerappsportals.com`

**Repo:** `Max-Power-Platform/nonprofit-suite-website` · branch `main` · last commit `36e93d5` (`feat(portal): replace mailto CTA with lead-creating contact form`)
**Live URL:** https://mpp2.powerappsportals.com/
**Power Pages model:** V2 (Enhanced Data Model — entities use `mspp_*` prefix, not `adx_*`)

---

## What this site is

A public marketing site for the **Max Power Platform Affordable Housing Nonprofit Suite** — 15 connected Power Platform modules pitched to housing nonprofits, with a frontier-/AI-first positioning hero, a categorized module catalog, and a lead-capture contact form that creates real Dataverse `lead` records.

---

## Target environment

| Item | Value |
|---|---|
| pac auth profile | `--index 2`, UNIVERSAL, `max@maxpowerplatform.com`, `https://mpp1.crm.dynamics.com/` |
| Tenant | `6e41b01e-9251-4daf-a8bc-75666adc3435` (Max Power Platform / `maxpowerplatform.com`) |
| Subscription | `a7defd4f-0547-4efb-b978-0003793e30d6` (MCPP Subscription) |
| WebsiteId (V2) | `379c4182-4ae2-46d0-9112-324244319bd6` |
| Public hostname | `mpp2.powerappsportals.com` |
| Anonymous Users webrole | `03913fd0-4985-4445-a833-9bacbd028a90` |
| Authenticated Users webrole | `f8dbe7a5-cd48-445c-8d8f-26381d157fe0` |
| Administrators webrole | `f82c2dd9-163e-45c9-81f4-4709b27b3768` |

> **Always pass `--environment` explicitly on any `pac` write command** — pac profile drift is a known trap (`/memories/power-platform.md`).

---

## Build / deploy pipeline

Three idempotent scripts under `scripts/`. Run in this order after any change:

```powershell
cd 'C:\Users\MaxMaraj\OneDrive - Max Power Platform\Repos\mpp\nonprofit-suite-website'

# 1. Regenerate every page, the home, the nav, and the footer
pwsh -NoProfile -File scripts/Build-Site.ps1

# 2. Push to Dataverse
pac auth select --index 2
pac pages upload --path src/portal/mpp2---mpp2 --modelVersion 2

# 3. Delete orphan V2 pages / weblinks not referenced on disk
pwsh -NoProfile -File scripts/Cleanup-Orphans.ps1

# 4. Commit + push
git add -A; git commit -m "..."; git push origin main
```

Then **restart MPP2 in Power Platform Admin Center** (verify env switcher = MPP, not D365Dev) → wait ~2 min → hard-refresh.

### Why three scripts

- **`Build-Site.ps1`** is the single source of truth. It defines all 15 modules in one `$modules` array and generates: every module's content-page HTML, the Home page (frontier/AI-first hero + 4 categorized tile sections + contact form), the nav weblink yml (Home + 4 dropdown parents + 15 children), and the Footer snippet. Idempotent — re-runs preserve `pageId` (read from on-disk yml) and `weblinkId` (preserved by pageId).
- **`pac pages upload`** is upsert-only — it never deletes records that disappear from yml.
- **`Cleanup-Orphans.ps1`** fixes that gap: scans every on-disk yml for canonical IDs, queries Dataverse for all V2 pages/weblinks belonging to this site/weblinkset, deletes anything not on disk.

### One-time provisioning (already done, idempotent)

```powershell
pwsh -NoProfile -File scripts/Setup-LeadForm.ps1
```

Provisions:
- `Webapi/lead/enabled = true`
- `Webapi/lead/fields = subject,firstname,lastname,emailaddress1,description,companyname,telephone1`
- `Webapi/error/innererror = true`
- Entity permission **"Lead - Anonymous Create (web form)"** on `lead`, scope **Global**, Create + Append + AppendTo, associated to **Anonymous Users** webrole

---

## What lives in the repo

```
src/portal/mpp2---mpp2/
  .portalconfig/
  content-snippets/         # Footer (deep brand-blue !important overrides), Mobile-Header (white + 3px brand-blue bottom border)
  page-templates/
  web-files/
  web-pages/                # 16 pages: home + 15 module roots, each with content-pages/<Pretty>.en-US.webpage.copy.html
  web-templates/            # Footer.webtemplate.source.html — orange portalThemeColor5 attr removed
  weblink-sets/default/     # Default.en-US.weblinkset.weblink.yml — Home + 4 parent dropdowns + 15 child links
scripts/
  Build-Site.ps1            # source of truth driver
  Cleanup-Orphans.ps1       # orphan cleanup via Dataverse Web API
  Setup-LeadForm.ps1        # one-time backend provisioning
  Update-Content.ps1        # legacy 7-module driver (superseded)
  Generate-Nav.ps1          # legacy 7-link nav (superseded)
  Generate-ModulePages.ps1  # legacy helper (superseded)
SESSION_HANDOFF.md          # this file
```

---

## The 15 modules

12 live + 3 roadmap-only (yellow "soon" badge). Edit the `$modules` array in `scripts/Build-Site.ps1` to change tagline / what / who / detail copy.

| Category | Tile | Slug | Status |
|---|---|---|---|
| Programs | Homebuyer Education | `/hbe/` | live |
| Programs | Down Payment Assistance | `/dpa/` | live |
| Programs | Home Repair | `/hrrp/` | live |
| Programs | Construction Management | `/cms/` | live |
| Programs | Property Management | `/property-management/` | live |
| Operations | Accounts Payable | `/accounts-payable/` | live |
| Operations | Procurement | `/procurement/` | live |
| Operations | Property Analyzer | `/find-jurisdiction/` | live |
| Engagement | Fundraising | `/fundraising/` | live |
| Engagement | Grants | `/grants/` | live |
| Engagement | Volunteers | `/volunteers/` | live |
| Engagement | Bulk Email | `/bulk-email/` | live |
| Roadmap | Human Resources | `/hr/` | soon |
| Roadmap | Learning Management | `/lms/` | soon |
| Roadmap | Plan Manager | `/plan-manager/` | soon |

> Property Analyzer was renamed from "Jurisdiction Finder" — display labels changed, slug intentionally kept as `/find-jurisdiction/` to avoid breaking the existing page record.

---

## Navigation shape

Top nav = **Home + 4 category dropdowns**. Each parent has a stable hardcoded GUID so re-runs never duplicate them:

- `aa000001-…-001` Programs
- `aa000002-…-002` Operations
- `aa000003-…-003` Engagement
- `aa000004-…-004` Roadmap

Children are wired via `adx_parentweblinkid` in the yml. Child weblinkIds are preserved across re-runs by `pageId` lookup (Build-Site.ps1 reads existing yml first).

---

## Brand colors

| Use | Value |
|---|---|
| Primary brand blue (links, hero h1) | `#1F66B5` |
| Deep brand blue (footer bg) | `#1A4F8C` |
| AI-section dark blue (legacy, currently unused) | `#0f3a6a` |
| Card accent blue | `#16467d` |
| Brand gray (h2 / muted) | `#7A6A65` |
| Soft section bg | `#f7f8fa` |
| Roadmap section bg | `#f1f3f5` |
| "Soon" badge | bg `#fff3cd`, text `#856404`, border `#ffeeba` |

The header was orange-tan from the default Power Pages theme. Two fixes ship in source:
1. `web-templates/footer/Footer.webtemplate.source.html` — `data-component-theme="portalThemeColor5"` removed; inline `style="background-color:#1A4F8C;"` set.
2. `content-snippets/footer/Footer.en-US.contentsnippet.value.html` and `content-snippets/mobile-header/Mobile-Header.en-US.contentsnippet.value.html` — both ship a `<style>` block with `!important` rules so the next portal theme update can't undo them.

---

## Get-in-touch contact form (Power Pages Web API)

The Home page footer CTA is a real form, not a `mailto:`. Submission flow:

1. Browser fetches anti-forgery token from `/_layout/tokenhtml`
2. POST `/_api/leads` with header `__RequestVerificationToken` and JSON body of form fields
3. Dataverse creates a `lead` record on the MPP env, owner = SYSTEM (per default ownership rules)
4. Inline status message (green success / red error)

Fields posted: `firstname`, `lastname`, `emailaddress1` (required), `companyname`, `telephone1`, `subject`, `description`. The allowed-field allowlist is stored in `Webapi/lead/fields`.

### Verification (after restart)

1. Open https://mpp2.powerappsportals.com/ in private window
2. Submit a test message
3. Check Dynamics 365 → Sales → Leads on MPP env. New record should appear with the submitted fields.

### Common failure modes

- **403 on submit** → cache; restart the MPP2 site in PPAC, wait 2 min, retry.
- **400 with "field not allowed"** → add the field to `Webapi/lead/fields` in Setup-LeadForm.ps1 and re-run.
- **401** → table permission lost its association with Anonymous Users role. Re-run Setup-LeadForm.ps1 (it re-associates).
- **Network error in console** → CSRF token fetch failed (rare); page may need a hard refresh.

---

## Session-shaping mistakes that cost time (don't repeat)

1. **`pac pages upload` does not delete records that disappear from yml.** Initial 7→15 expansion + later renames left 16+ orphan pages and 8 orphan weblinks → nav showed duplicates (22 links). Always run `Cleanup-Orphans.ps1` after Build + upload.
2. **V2 site uses `mspp_*` entities, not `adx_*`.** First orphan-delete attempt against `adx_weblinks` returned 404 ("does not exist") on every record. Correct entities: `mspp_webpages`, `mspp_weblinks`, `mspp_weblinksets`, `mspp_sitesettings`, `mspp_entitypermissions`, `mspp_webroles`. Note that the entity-permission entity is still called `mspp_entitypermission` (legacy name preserved), not `mspp_tablepermission`.
3. **Entity-permission entity uses `mspp_entityname`, not `mspp_name`** as the human-readable display field. Field names differ from the legacy `adx_entitypermission` schema.
4. **Generate-ModulePages.ps1 / earlier Build-Site Step 1 created NEW pageId GUIDs every run** because pageIds weren't pinned. Build-Site now reads the existing on-disk yml and pins the existing pageId before considering creation.
5. **`$pid` is read-only in PowerShell.** Renamed to `$pgid` in Build-Site Step 4 — silent crash before that.
6. **PATCH to Dataverse needs `If-Match: *`** for upserts. Setup-LeadForm.ps1 only PATCHes when the value actually differs, with that header.
7. **Az CLI default tenant ≠ MPP tenant.** First Web API attempt returned 403 "user is not a member of the organization" because `az` was on `tampabaynhs.org`. Fixed with `az account set --subscription a7defd4f-0547-4efb-b978-0003793e30d6`.
8. **Orange footer / tan header** were portal theme defaults (`portalThemeColor5`) — not in the export source. Fix lives in two snippets + the Footer web template (see Brand section).

---

## Open / nice-to-have

- 3 orphan pages couldn't be deleted by Cleanup-Orphans.ps1 (HTTP 400 — likely have child references blocking delete). Harmless: not in nav, not in any sitemap. Could revisit with `unbind` calls if they become a problem.
- Lead form has no CAPTCHA. Consider adding Power Pages reCAPTCHA site setting or honeypot field if spam appears.
- No analytics tag yet. If wanted, add to a custom JS web file referenced from the page template.
- Module detail pages all share one HTML template (`scripts/Build-Site.ps1` Step 2). To customize per-module visuals (e.g. screenshot strip), parameterize per `$m`.
- Auth header / Sign-in link still appears in the navbar even though the site is purely marketing — could hide via Mobile-Header snippet CSS if undesired.

---

## How to resume next session

1. Pull latest: `git pull origin main` in the website repo.
2. Read `scripts/Build-Site.ps1` — every content change starts there.
3. Make changes, then run the 4-step pipeline above.
4. If anything looks duplicated in the live nav or sitemap, run `Cleanup-Orphans.ps1`.
5. Always remind the user to **restart MPP2 in PPAC** — Studio sync alone does not bust the public CDN.

---

_Generated 2026-05-16 at handoff request after commits `498ee72 → b6164b6 → ca00dfd → 92a6c01 → 36e93d5`._
