# Deployment Runbook
## MaxPowerPlatformWebsite — `www.maxpowerplatform.com`

**Version**: 1.0  
**Date**: 2026-08-02  
**Status**: As-Is — **Working directly in live Prod**

---

## 1. Current Operating Model

> ⚠️ All work targets the **live production** Power Pages site. There is no Dev or UAT environment in active use. This runbook covers the two editing paths: Studio-first and Code-first, both against Prod.

---

## 2. Prerequisites

- [ ] `az login --tenant <MPP_TENANT_ID>` completed
- [ ] PAC auth profile `mpp-website-prod` created (`--azureCliAuth`)
- [ ] `scripts/.site-ids.json` populated with `"prod": "379c4182-..."` 
- [ ] GitHub repo cloned: `git clone https://github.com/Max-Power-Platform/MaxPowerPlatformWebsite.git`
- [ ] On `dev` branch

---

## 3. Workflow A: Studio-First (WYSIWYG Editing)

Use when making changes through the Power Pages Studio web interface.

### Step-by-Step

```pwsh
# 1. BEFORE opening Studio: pull latest from live to avoid drift
pwsh ./scripts/pages-download.ps1 -Env prod

# 2. Open Power Pages Studio
#    → https://make.powerpages.microsoft.com/
#    → Select "MPP2 - MPP2" site
#    → Make your changes (pages, templates, snippets, settings, CSS)

# 3. AFTER closing Studio: download changes back to repo
pwsh ./scripts/pages-download.ps1 -Env prod

# 4. Review the diff
git diff --stat
git diff src/portal/

# 5. Commit and push
git add src/portal/
git commit -m "content: describe what changed in Studio"
git push origin dev

# 6. Verify live site
#    → Open https://www.maxpowerplatform.com/
#    → Confirm changes appear correctly
```

### When to Use

- Copy changes, page content edits
- Adding new pages via Studio
- Updating content snippets
- Changing site settings visually
- Theming and CSS tweaks via Studio theme editor

---

## 4. Workflow B: Code-First (Local Editing)

Use when editing Liquid templates, YAML config, or HTML/CSS/JS directly in VS Code.

### Step-by-Step

```pwsh
# 1. Pull latest from live (safety sync)
pwsh ./scripts/pages-download.ps1 -Env prod

# 2. Edit files locally
#    → src/portal/mpp2---mpp2/web-templates/  (Liquid templates)
#    → src/portal/mpp2---mpp2/web-pages/       (page content)
#    → src/portal/mpp2---mpp2/web-files/       (CSS, JS, images)
#    → src/portal/mpp2---mpp2/sitesetting.yml  (settings)
#    → etc.

# 3. Review your changes
git diff --stat
git diff

# 4. Commit
git add .
git commit -m "feat|fix|chore: description of change"

# 5. Push to upload (⚠️ REQUIRES CONFIRMATION)
pwsh ./scripts/pages-upload.ps1 -Env prod -ConfirmProd
# → You will be prompted: "Type PROD to confirm upload to production"

# 6. Verify live site
#    → Open https://www.maxpowerplatform.com/
#    → Confirm changes appear correctly

# 7. Push to GitHub
git push origin dev
```

### When to Use

- Editing Liquid web templates
- Changing YAML configuration (pages, settings, roles)
- Bulk content operations (`Update-Content.ps1`)
- Adding/removing web files
- Script development

---

## 5. Emergency Rollback

If a deployment breaks the live site:

### Option 1: Revert via Studio (fastest)

1. Open Power Pages Studio
2. Navigate to the broken page/template/setting
3. Use Studio's version history or manually undo

### Option 2: Revert via git + upload

```pwsh
# 1. Find the last known-good commit
git log --oneline -10

# 2. Revert to that state
git revert <bad-commit-hash>
# Or reset: git reset --hard <good-commit-hash>

# 3. Upload the reverted state
pwsh ./scripts/pages-upload.ps1 -Env prod -ConfirmProd

# 4. Verify fix
# → Open https://www.maxpowerplatform.com/

# 5. Push the revert
git push origin dev
```

### Option 3: Restore from backup (last resort)

Power Pages has built-in site backups. Contact Microsoft support or use the Power Platform admin center to restore.

---

## 6. Common Operations

### Add a New Module Page

```pwsh
# 1. Generate the page structure
pwsh ./scripts/Generate-ModulePages.ps1 -ModuleName "NewModule" -Title "New Module"

# 2. Edit the generated page content
# → src/portal/mpp2---mpp2/web-pages/newmodule/

# 3. Add to navigation
# → Edit weblink-sets/default/ to add the nav link

# 4. Upload and verify
pwsh ./scripts/pages-upload.ps1 -Env prod -ConfirmProd
```

### Update Home Page Tile Copy

```pwsh
# 1. Pull latest
pwsh ./scripts/pages-download.ps1 -Env prod

# 2. Edit the home page content
# → src/portal/mpp2---mpp2/web-pages/home/content-pages/Home.en-US.webpage.copy.html
# → Find the tile section and update copy

# 3. Commit and upload
git add . && git commit -m "content: update tile copy for [module]"
pwsh ./scripts/pages-upload.ps1 -Env prod -ConfirmProd
```

### Update Site Settings

```pwsh
# 1. Pull latest
pwsh ./scripts/pages-download.ps1 -Env prod

# 2. Edit sitesetting.yml
# → src/portal/mpp2---mpp2/sitesetting.yml

# 3. Upload
pwsh ./scripts/pages-upload.ps1 -Env prod -ConfirmProd
```

### Bulk Content Update

```pwsh
# Use Update-Content.ps1 for find-and-replace across pages
pwsh ./scripts/Update-Content.ps1 -Find "old text" -Replace "new text"
```

---

## 7. Prod Confirmation Process

The `pages-upload.ps1 -Env prod` script enforces a typed confirmation:

```
WARNING: You are about to upload to PRODUCTION (mpp2.powerappsportals.com).
Type PROD to confirm:
```

Type `PROD` (exact, all caps) and press Enter. Any other input cancels the operation.

In CI/CD (`pages-deploy-prod.yml`), this is enforced via:
1. GitHub Environment `prod` with required reviewer
2. `workflow_dispatch` input requiring typed `PROD`

---

## 8. Pre-Deployment Checklist

Before any Prod upload:

- [ ] `git status` is clean (no unexpected changes)
- [ ] Latest live state downloaded (`pages-download.ps1 -Env prod`)
- [ ] No merge conflicts
- [ ] Screenshot of before state taken (for reference)
- [ ] Change is scoped — know exactly what pages/templates/settings are affected
- [ ] Fallback email (`max@maxpowerplatform.com`) is correct in error messages
- [ ] Commit message describes what changed and why

---

## 9. Post-Deployment Verification

After every Prod upload:

- [ ] Home page loads: https://www.maxpowerplatform.com/
- [ ] Navigation menus render correctly
- [ ] At least 3 module drill-through pages load
- [ ] Search returns results
- [ ] Privacy page loads: https://www.maxpowerplatform.com/privacy/
- [ ] Contact form submits (test with real data if safe)
- [ ] Mobile responsive: test at 375px width
- [ ] No console errors in browser DevTools

---

## 10. Script Quick Reference

| Script | Purpose | Prod Usage |
|---|---|---|
| `pages-download.ps1 -Env prod` | Pull live → local | Start of every session |
| `pages-upload.ps1 -Env prod -ConfirmProd` | Push local → live | After local edits (requires PROD confirm) |
| `list-sites.ps1` | Discover website IDs | One-time setup |
| `bootstrap-azure-identity.ps1` | Create SP + OIDC | One-time setup |
| `Generate-ModulePages.ps1` | Scaffold new module page | When adding modules |
| `Generate-Nav.ps1` | Regenerate navigation | After page structure changes |
| `Build-Site.ps1` | Validate Liquid templates | Before upload |
| `Cleanup-Orphans.ps1` | Remove orphaned content | Maintenance |
| `Setup-LeadForm.ps1` | Configure lead capture | One-time / reconfig |
| `Update-Content.ps1` | Bulk find-and-replace | Content migrations |
