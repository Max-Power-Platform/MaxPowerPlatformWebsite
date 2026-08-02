#requires -Version 7.0
<#
.SYNOPSIS
  Run `pac pages list` against each configured profile to discover websiteId GUIDs.

.DESCRIPTION
  Iterates dev / uat / prod profiles (nonprofit-website-{env}) and prints the site list.
  Use the output to populate scripts/.site-ids.json.
  Profiles should be created with --azureCliAuth (see docs/AUTH.md). Run `az login` first.

.EXAMPLE
  az login --tenant <MPP_TENANT_ID>
  pwsh ./scripts/list-sites.ps1
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

# Confirm az session
$account = az account show 2>$null | ConvertFrom-Json
if (-not $account) { throw "Run 'az login --tenant <MPP_TENANT_ID>' first." }
Write-Host "Azure CLI signed in as $($account.user.name)" -ForegroundColor Cyan

foreach ($env in @('dev','uat','prod')) {
  $profile = "nonprofit-website-$env"
  Write-Host "`n=== Env: $env (profile: $profile) ===" -ForegroundColor Cyan
  pac auth select --name $profile 2>$null
  if ($LASTEXITCODE -ne 0) {
    Write-Warning "Profile '$profile' not found. Create it first:"
    Write-Warning "  pac auth create --name $profile --environment <URL> --azureCliAuth"
    continue
  }
  pac pages list
}

Write-Host "`nCopy the WebSiteId GUIDs into scripts/.site-ids.json" -ForegroundColor Yellow
