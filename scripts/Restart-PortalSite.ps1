<#
.SYNOPSIS
  Restart the Max Power Platform marketing portal (mpp2 / www.maxpowerplatform.com).

.DESCRIPTION
  Resolves the Power Pages management website id from the Dataverse website id
  and calls the Power Pages restart API to clear the server cache so uploaded
  content is served. Preview by default; pass -Execute to restart.

.EXAMPLE
  pwsh -File .\scripts\Restart-PortalSite.ps1
  pwsh -File .\scripts\Restart-PortalSite.ps1 -Execute
#>
param(
  [string]$EnvironmentId   = '5504328a-862d-e5d8-84e6-3d4bdd931c1b',
  [string]$DataverseSiteId = '379c4182-4ae2-46d0-9112-324244319bd6',
  [string]$SiteNameHint    = 'mpp2',
  [string]$ApiVersion      = '2024-10-01',
  [switch]$Execute
)
$ErrorActionPreference = 'Stop'
$mode = if ($Execute) { 'EXECUTE' } else { 'PREVIEW' }
Write-Host "=== Power Pages site restart ($mode) ===" -ForegroundColor Cyan

$tok = az account get-access-token --resource 'https://api.powerplatform.com/' --query accessToken -o tsv
if (-not $tok) { throw 'Could not acquire a Power Platform API token — az login first.' }
$h = @{ Authorization = "Bearer $tok"; Accept = 'application/json' }
$root = "https://api.powerplatform.com/powerpages/environments/$EnvironmentId/websites"

$sites = (Invoke-RestMethod "${root}?api-version=$ApiVersion" -Headers $h).value
Write-Host "  environment $EnvironmentId hosts $($sites.Count) site(s)"

$site = $sites | Where-Object {
  $_.websiteRecordId -eq $DataverseSiteId -or
  $_.id -eq $DataverseSiteId -or
  ($_ | ConvertTo-Json -Depth 5 -Compress) -match [regex]::Escape($DataverseSiteId)
} | Select-Object -First 1
if (-not $site) {
  $site = $sites | Where-Object { $_.name -eq $SiteNameHint -or $_.websiteUrl -like "*$SiteNameHint*" } | Select-Object -First 1
  if ($site) { Write-Host "  [WARN] matched by NAME '$SiteNameHint', not by Dataverse id — confirm before executing." -ForegroundColor Yellow }
}
if (-not $site) {
  $sites | Select-Object id, name, websiteUrl | Format-Table -AutoSize | Out-String | Write-Host
  throw "Could not resolve a management website for Dataverse site $DataverseSiteId — refusing to guess."
}

$mgmtId = $site.id
Write-Host "  site   : $($site.name)"
Write-Host "  url    : $($site.websiteUrl)"
Write-Host "  mgmtId : $mgmtId   (Dataverse id: $DataverseSiteId)"

if (-not $Execute) {
  Write-Host "`n  [PREVIEW] would POST ${root}/$mgmtId/restart?api-version=$ApiVersion" -ForegroundColor Yellow
  Write-Host '  Re-run with -Execute to restart (brief downtime on a live site).' -ForegroundColor Yellow
  return
}

Write-Host "`n  restarting…"
Invoke-RestMethod -Method POST "${root}/$mgmtId/restart?api-version=$ApiVersion" -Headers $h -Body '{}' -ContentType 'application/json' | Out-Null
Write-Host '  [OK] restart accepted' -ForegroundColor Green
