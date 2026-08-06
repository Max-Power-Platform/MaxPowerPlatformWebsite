#requires -Version 7
$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot

& (Join-Path $repoRoot 'scripts/Test-ContentAuthority.ps1') -RepoRoot $repoRoot -SkipGenerationProof
if ($LASTEXITCODE -ne 0) { throw 'Baseline content-authority controls failed.' }

foreach ($script in @('Update-Content.ps1','Generate-ModulePages.ps1','Generate-Nav.ps1')) {
  & pwsh -NoProfile -File (Join-Path $repoRoot "scripts/$script") 2>$null
  if ($LASTEXITCODE -eq 0) { throw "$script did not fail closed." }
}

$manifest = Get-Content -LiteralPath (Join-Path $repoRoot 'scripts/content-authority.ids.json') -Raw | ConvertFrom-Json -AsHashtable
if (@($manifest.Values | Select-Object -Unique).Count -ne $manifest.Count) {
  throw 'Stable identifier manifest contains duplicate values.'
}
Write-Host 'PASS focused content-authority regression tests.'
$global:LASTEXITCODE = 0
