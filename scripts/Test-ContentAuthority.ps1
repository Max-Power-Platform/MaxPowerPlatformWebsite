#requires -Version 7
[CmdletBinding()]
param(
  [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot),
  [switch]$SkipGenerationProof
)

$ErrorActionPreference = 'Stop'
$RepoRoot = [System.IO.Path]::GetFullPath($RepoRoot)
$failures = [System.Collections.Generic.List[string]]::new()
function Fail([string]$rule, [string]$expected, [string]$actual) {
  $failures.Add("${rule}: expected [$expected]; actual [$actual]")
}
function Read-Repo([string]$relative) {
  Get-Content -LiteralPath (Join-Path $RepoRoot $relative) -Raw
}

$canonicalRelative = 'src/portal/mpp2---mpp2'
$shadowRelative = 'src/website'
if (Test-Path -LiteralPath (Join-Path $RepoRoot $shadowRelative)) {
  Fail 'CA01 one deployable source' "$canonicalRelative only" "$shadowRelative exists"
}

$authorityFiles = @(
  'README.md','AGENTS.md','.github/copilot-instructions.md',
  'docs/EDIT-WORKFLOW.md','docs/DEPLOYMENT.md','docs/ENVIRONMENTS.md',
  'docs/BACKLOG.md','docs/WEBSITE-UPDATE-PLAN.md','docs/SPRINT-PLAN.md','docs/TDD.md',
  '.github/workflows/pages-export.yml','.github/workflows/pages-deploy-uat.yml',
  '.github/workflows/pages-deploy-prod.yml','scripts/pages-download.ps1','scripts/pages-upload.ps1'
)
foreach ($relative in $authorityFiles) {
  $content = Read-Repo $relative
  if ($content -match '(?i)src[\\/]website') {
    Fail 'CA02 canonical path' "no src/website reference" $relative
  }
}

$build = Read-Repo 'scripts/Build-Site.ps1'
if ($build -match '\[guid\]::NewGuid') {
  Fail 'CA06 runtime identifiers' 'zero runtime GUID creation' 'Build-Site.ps1 contains [guid]::NewGuid'
}
$manifestPath = Join-Path $RepoRoot 'scripts/content-authority.ids.json'
try { $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json -AsHashtable }
catch { Fail 'CA06 stable manifest' 'valid JSON object' $_.Exception.Message; $manifest = @{} }
$duplicateIds = @($manifest.Values | Group-Object | Where-Object Count -gt 1)
if ($duplicateIds.Count -gt 0) { Fail 'CA06 unique identifiers' 'all GUIDs unique' ($duplicateIds.Name -join ', ') }
$requiredKeys = @(
  'webfile.mpp-os.js.record','webfile.mpp-os.js.annotation',
  'webfile.mpp-os.css.record','webfile.mpp-os.css.annotation',
  'page.operating-system.root','page.operating-system.content','page.m365.root','page.m365.content'
)
$slugs = [regex]::Matches($build, "@\{ slug='([^']+)'\s*; folder=") | ForEach-Object { $_.Groups[1].Value }
foreach ($slug in $slugs) { $requiredKeys += "page.$slug.root","page.$slug.content","weblink.$slug" }
foreach ($key in $requiredKeys) {
  if (-not $manifest.ContainsKey($key)) { Fail 'CA06 complete manifest' "key $key" 'missing' }
  else {
    $parsedGuid = [guid]::Empty
    if (-not [guid]::TryParse([string]$manifest[$key], [ref]$parsedGuid)) {
      Fail 'CA06 valid identifier' "GUID at $key" ([string]$manifest[$key])
    }
  }
}

foreach ($relative in @('scripts/Update-Content.ps1','scripts/Generate-ModulePages.ps1','scripts/Generate-Nav.ps1')) {
  $content = Read-Repo $relative
  if (-not ($content.Contains('DEPRECATED_FAIL_CLOSED') -and $content -match '(?m)^throw ')) {
    Fail 'CA05 obsolete generator' 'fail-closed deprecation stub' $relative
  }
}

$download = Read-Repo 'scripts/pages-download.ps1'
if (-not ($download.Contains('ComparisonPath') -and $download.Contains('outside src/') -and -not ($download -match '(?i)src[\\/]website'))) {
  Fail 'CA08 isolated download' 'required comparison path outside src/' 'download wrapper does not enforce isolation'
}
$upload = Read-Repo 'scripts/pages-upload.ps1'
if (-not ($upload.Contains($canonicalRelative) -and -not ($upload -match '(?i)src[\\/]website'))) {
  Fail 'CA09 exact upload source' $canonicalRelative 'upload wrapper differs'
}
$exportWorkflow = Read-Repo '.github/workflows/pages-export.yml'
if ($exportWorkflow -match '(?m)^\s*schedule:' -or $exportWorkflow.Contains('create-pull-request')) {
  Fail 'CA08 drift workflow' 'manual evidence-only workflow' 'scheduled or source-writing behavior remains'
}
foreach ($relative in @('.github/workflows/pages-deploy-uat.yml','.github/workflows/pages-deploy-prod.yml')) {
  if (-not (Read-Repo $relative).Contains('if: ${{ false }}')) {
    Fail 'CA10 release workflow boundary' 'fail-closed until separate release envelope' $relative
  }
}

$combinedGuidance = ($authorityFiles | ForEach-Object { Read-Repo $_ }) -join "`n"
foreach ($phrase in @('task branch','target `dev`','release branch','Azure Boards is the only mutable recovery authority')) {
  if (-not $combinedGuidance.Contains($phrase)) { Fail 'CA10 consistent guidance' "phrase $phrase" 'missing' }
}
$handoff = Read-Repo 'SESSION_HANDOFF.md'
if (-not ($handoff.Contains('must not contain independently maintained active-session state') -and
          $handoff.Contains('Azure Boards owns current status'))) {
  Fail 'CA11 recovery authority' 'deprecation pointer only' 'SESSION_HANDOFF.md contract missing'
}

$changed = @(& git -C $RepoRoot diff --name-only HEAD; & git -C $RepoRoot diff --name-only --cached)
$generatedChanged = @($changed | Where-Object { $_ -like 'src/portal/mpp2---mpp2/*' })
if ($generatedChanged.Count -gt 0 -and $changed -notcontains 'scripts/Build-Site.ps1') {
  Fail 'CA04 generated ownership' 'Build-Site.ps1 changes with generated outputs' ($generatedChanged -join ', ')
}

if (-not $SkipGenerationProof -and $failures.Count -eq 0) {
  $tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("mpp-content-authority-" + [guid]::NewGuid())
  try {
    $runs = @()
    foreach ($run in 1,2) {
      $runRoot = Join-Path $tempRoot "run$run"
      New-Item -ItemType Directory -Path $runRoot -Force | Out-Null
      Copy-Item -LiteralPath (Join-Path $RepoRoot 'scripts') -Destination $runRoot -Recurse
      Copy-Item -LiteralPath (Join-Path $RepoRoot 'src') -Destination $runRoot -Recurse
      & pwsh -NoProfile -File (Join-Path $runRoot 'scripts/Build-Site.ps1') *> $null
      if ($LASTEXITCODE -ne 0) { throw "Build-Site failed in deterministic run $run" }
      $portalRoot = Join-Path $runRoot $canonicalRelative
      $inventory = Get-ChildItem -LiteralPath $portalRoot -Recurse -File | Sort-Object FullName | ForEach-Object {
        $relative = $_.FullName.Substring($portalRoot.Length + 1).Replace('\','/')
        $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
        $text = [System.Text.Encoding]::UTF8.GetString($bytes).Replace("`r`n","`n")
        $hash = [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($text)))
        "$relative|$hash"
      }
      $runs += ,$inventory
    }
    $difference = Compare-Object $runs[0] $runs[1]
    if ($difference) { Fail 'CA07 deterministic generation' 'identical normalized inventories and bytes' ($difference | Out-String) }
  } catch { Fail 'CA07 deterministic generation' 'two successful identical runs' $_.Exception.Message }
  finally { if (Test-Path $tempRoot) { Remove-Item -LiteralPath $tempRoot -Recurse -Force } }
}

if ($failures.Count -gt 0) {
  $failures | ForEach-Object { Write-Error $_ }
  exit 1
}
Write-Host 'PASS CA01-CA11 content authority, stable IDs, transfer boundaries, guidance, and recovery controls.'
