#requires -Version 7.0
<#
.SYNOPSIS
  Wraps `pac pages download` to pull the live Power Pages site into src/website/.

.PARAMETER Env
  dev | uat | prod. Selects the `nonprofit-website-{Env}` pac profile and the matching
  websiteId from scripts/.site-ids.json.

.EXAMPLE
  pwsh ./scripts/pages-download.ps1 -Env dev
#>
[CmdletBinding(SupportsShouldProcess)]
param(
  [Parameter(Mandatory)][ValidateSet('dev','uat','prod')][string]$Env
)

$ErrorActionPreference = 'Stop'
$repoRoot  = Resolve-Path (Join-Path $PSScriptRoot '..')
$siteIds   = Get-Content -Raw (Join-Path $PSScriptRoot '.site-ids.json') | ConvertFrom-Json
$websiteId = $siteIds.$Env

if (-not $websiteId -or $websiteId -like 'REPLACE-*') {
  throw "websiteId for env=$Env not set. Run: pwsh ./scripts/list-sites.ps1 then update scripts/.site-ids.json"
}

$profile = "nonprofit-website-$Env"
$out     = Join-Path $repoRoot 'src/website'

if ($PSCmdlet.ShouldProcess($profile, 'pac auth select')) {
  pac auth select --name $profile
  if ($LASTEXITCODE -ne 0) { throw "Profile '$profile' missing. See docs/AUTH.md" }
}

if (-not (Test-Path $out)) {
  New-Item -ItemType Directory -Path $out -Force | Out-Null
}

$cmd = "pac pages download --webSiteId $websiteId --path `"$out`" --modelVersion 2 --overwrite"
if ($PSCmdlet.ShouldProcess($out, $cmd)) {
  Invoke-Expression $cmd
  if ($LASTEXITCODE -ne 0) { throw 'pac pages download failed' }
  Write-Host "Downloaded $Env site → $out"
}
