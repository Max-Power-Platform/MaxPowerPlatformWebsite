#requires -Version 7.0
<#
.SYNOPSIS
  Wraps `pac pages upload` to push src/website/ to the target Power Pages env.

.PARAMETER Env
  dev | uat | prod.

.PARAMETER ConfirmProd
  REQUIRED for -Env prod. Belt-and-braces guard.

.EXAMPLE
  pwsh ./scripts/pages-upload.ps1 -Env dev
  pwsh ./scripts/pages-upload.ps1 -Env prod -ConfirmProd
#>
[CmdletBinding(SupportsShouldProcess)]
param(
  [Parameter(Mandatory)][ValidateSet('dev','uat','prod')][string]$Env,
  [switch]$ConfirmProd
)

$ErrorActionPreference = 'Stop'
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$src      = Join-Path $repoRoot 'src/website'

if ($Env -eq 'prod' -and -not $ConfirmProd) {
  throw "Refusing to upload to Prod without -ConfirmProd. Re-run with -ConfirmProd to proceed."
}
if (-not (Test-Path $src)) {
  throw "Source dir not found: $src. Run pages-download.ps1 first."
}

$profile = "nonprofit-website-$Env"
if ($PSCmdlet.ShouldProcess($profile, 'pac auth select')) {
  pac auth select --name $profile
  if ($LASTEXITCODE -ne 0) { throw "Profile '$profile' missing. See docs/AUTH.md" }
}

$cmd = "pac pages upload --path `"$src`" --modelVersion 2"
if ($PSCmdlet.ShouldProcess($src, $cmd)) {
  Invoke-Expression $cmd
  if ($LASTEXITCODE -ne 0) { throw 'pac pages upload failed' }
  Write-Host "Uploaded → $Env"
}

# Bust portal cache so changes show up immediately
$cacheCmd = 'pac pages cache-clear'
if ($PSCmdlet.ShouldProcess($Env, $cacheCmd)) {
  Invoke-Expression $cacheCmd
  if ($LASTEXITCODE -ne 0) { Write-Warning 'pac pages cache-clear failed (non-fatal); manual purge may be needed' }
}
