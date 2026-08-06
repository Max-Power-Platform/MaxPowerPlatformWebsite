#requires -Version 7.0
<#
.SYNOPSIS
  Wraps `pac pages upload` for the canonical reviewed Power Pages source only.

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
$src      = [System.IO.Path]::GetFullPath((Join-Path $repoRoot 'src/portal/mpp2---mpp2'))

if ($Env -eq 'prod' -and -not $ConfirmProd) {
  throw "Refusing to upload to Prod without -ConfirmProd. Re-run with -ConfirmProd to proceed."
}
if (-not (Test-Path $src)) {
  throw "Canonical source dir not found: $src."
}

$profile = "nonprofit-website-$Env"
if ($PSCmdlet.ShouldProcess($profile, 'pac auth select')) {
  pac auth select --name $profile
  if ($LASTEXITCODE -ne 0) { throw "Profile '$profile' missing. See docs/AUTH.md" }
}

if ($PSCmdlet.ShouldProcess($src, 'pac pages upload --modelVersion 2')) {
  & pac pages upload --path $src --modelVersion 2
  if ($LASTEXITCODE -ne 0) { throw 'pac pages upload failed' }
  Write-Host "Uploaded → $Env"
}

# Bust portal cache so changes show up immediately
if ($PSCmdlet.ShouldProcess($Env, 'pac pages cache-clear')) {
  & pac pages cache-clear
  if ($LASTEXITCODE -ne 0) { Write-Warning 'pac pages cache-clear failed (non-fatal); manual purge may be needed' }
}
