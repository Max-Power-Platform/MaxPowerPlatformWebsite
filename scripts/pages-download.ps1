#requires -Version 7.0
<#
.SYNOPSIS
  Downloads a live Power Pages snapshot into an isolated comparison directory.

.PARAMETER Env
  dev | uat | prod. Selects the `nonprofit-website-{Env}` pac profile and the matching
  websiteId from scripts/.site-ids.json.

.EXAMPLE
  pwsh ./scripts/pages-download.ps1 -Env dev -ComparisonPath .worktree/portal-comparison/dev
#>
[CmdletBinding(SupportsShouldProcess)]
param(
  [Parameter(Mandatory)][ValidateSet('dev','uat','prod')][string]$Env,
  [Parameter(Mandatory)][string]$ComparisonPath
)

$ErrorActionPreference = 'Stop'
$repoRoot  = Resolve-Path (Join-Path $PSScriptRoot '..')
$siteIds   = Get-Content -Raw (Join-Path $PSScriptRoot '.site-ids.json') | ConvertFrom-Json
$websiteId = $siteIds.$Env

if (-not $websiteId -or $websiteId -like 'REPLACE-*') {
  throw "websiteId for env=$Env not set. Run: pwsh ./scripts/list-sites.ps1 then update scripts/.site-ids.json"
}

$profile = "nonprofit-website-$Env"
$canonical = [System.IO.Path]::GetFullPath((Join-Path $repoRoot 'src/portal/mpp2---mpp2'))
$out = [System.IO.Path]::GetFullPath((Join-Path $repoRoot $ComparisonPath))
if ($out -eq $canonical -or $out.StartsWith("$canonical$([System.IO.Path]::DirectorySeparatorChar)")) {
  throw 'ComparisonPath must not be the canonical portal tree.'
}
if ($out.StartsWith([System.IO.Path]::GetFullPath((Join-Path $repoRoot 'src')))) {
  throw 'ComparisonPath must be outside src/ so a live download cannot become deployable source.'
}

if ($PSCmdlet.ShouldProcess($profile, 'pac auth select')) {
  pac auth select --name $profile
  if ($LASTEXITCODE -ne 0) { throw "Profile '$profile' missing. See docs/AUTH.md" }
}

if (-not (Test-Path $out)) {
  New-Item -ItemType Directory -Path $out -Force | Out-Null
}

if ($PSCmdlet.ShouldProcess($out, 'pac pages download --modelVersion 2 --overwrite')) {
  & pac pages download --webSiteId $websiteId --path $out --modelVersion 2 --overwrite
  if ($LASTEXITCODE -ne 0) { throw 'pac pages download failed' }
  Write-Host "Downloaded isolated $Env comparison snapshot -> $out"
}
