[CmdletBinding()]
param(
    [switch]$CheckExternalLinks
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$fsbpUrl = 'https://github.com/Max-Power-Platform/FullStackBestPractices'
$adoProjectUrl = 'https://dev.azure.com/maxpowerplatform/MPP'
$adoStoryUrl = 'https://dev.azure.com/maxpowerplatform/MPP/_workitems/edit/2042'

$governanceFiles = @(
    'AGENTS.md',
    'CLAUDE.md',
    '.github/copilot-instructions.md',
    'SESSION_HANDOFF.md',
    'docs/governance/TRACEABILITY.md',
    '.github/workflows/governance-validation.yml'
)

$failures = [System.Collections.Generic.List[string]]::new()
foreach ($relativePath in $governanceFiles) {
    $absolutePath = Join-Path $repoRoot $relativePath
    if (-not (Test-Path -LiteralPath $absolutePath -PathType Leaf)) {
        $failures.Add("Missing required governance file: $relativePath")
        continue
    }
    $content = Get-Content -LiteralPath $absolutePath -Raw
    foreach ($requiredUrl in @($fsbpUrl, $adoProjectUrl, $adoStoryUrl)) {
        if (-not $content.Contains($requiredUrl)) {
            $failures.Add("$relativePath does not link to $requiredUrl")
        }
    }
}

$agents = Get-Content -LiteralPath (Join-Path $repoRoot 'AGENTS.md') -Raw
foreach ($phrase in @(
    'FSBP wins for shared rules',
    'Azure Boards is the only mutable recovery authority',
    'is a discoverability and portfolio-guidance layer',
    'Repository and GitHub'
)) {
    if (-not $agents.Contains($phrase)) {
        $failures.Add("AGENTS.md is missing authority assertion: $phrase")
    }
}

$claudeLines = @(Get-Content -LiteralPath (Join-Path $repoRoot 'CLAUDE.md'))
if ($claudeLines.Count -gt 10 -or -not (($claudeLines -join "`n").Contains('[AGENTS.md](AGENTS.md)'))) {
    $failures.Add('CLAUDE.md must remain a concise pointer to AGENTS.md.')
}

$handoff = Get-Content -LiteralPath (Join-Path $repoRoot 'SESSION_HANDOFF.md') -Raw
foreach ($phrase in @(
    'retained only as a compatibility pointer',
    'must not contain independently maintained active-session state',
    'Azure Boards owns current status',
    'GitHub owns the current branch and commit',
    'FSBP owns shared governance'
)) {
    if (-not $handoff.Contains($phrase)) {
        $failures.Add("SESSION_HANDOFF.md is missing deprecation assertion: $phrase")
    }
}
foreach ($forbiddenHeading in @('## Current state', '## Next session', '## Blockers', '## Completed work')) {
    if ($handoff.Contains($forbiddenHeading)) {
        $failures.Add("SESSION_HANDOFF.md contains mutable state heading: $forbiddenHeading")
    }
}

$forbiddenNames = @('LEDGER.md', 'NEXT.md', 'RESUME.md')
$files = Get-ChildItem -LiteralPath $repoRoot -Recurse -File -Force |
    Where-Object { $_.FullName -notlike "$(Join-Path $repoRoot '.git')*" }
foreach ($file in $files) {
    if ($forbiddenNames -contains $file.Name) {
        $failures.Add("Forbidden mutable session ledger file: $($file.FullName.Substring($repoRoot.Length + 1))")
    }
    if ($file.Name -match '(?i)(chat[-_ ]?session|session[-_ ]?log).*\.md$') {
        $failures.Add("Forbidden chat/session state file: $($file.FullName.Substring($repoRoot.Length + 1))")
    }
}
if (Test-Path -LiteralPath (Join-Path $repoRoot '.claude/session')) {
    $failures.Add('Forbidden mutable session directory: .claude/session')
}

$markdownFiles = $governanceFiles | Where-Object { $_ -like '*.md' }
foreach ($relativePath in $markdownFiles) {
    $content = Get-Content -LiteralPath (Join-Path $repoRoot $relativePath) -Raw
    $matches = [regex]::Matches($content, '\[[^\]]+\]\(([^)]+)\)')
    foreach ($match in $matches) {
        $target = $match.Groups[1].Value
        if ($target -match '^https://') {
            if ($target -notlike 'https://github.com/Max-Power-Platform/*' -and
                $target -notlike 'https://dev.azure.com/maxpowerplatform/MPP*') {
                $failures.Add("Unapproved external governance link in ${relativePath}: $target")
            }
        } else {
            $sourceDirectory = Split-Path -Parent (Join-Path $repoRoot $relativePath)
            $resolved = Join-Path $sourceDirectory $target
            if (-not (Test-Path -LiteralPath $resolved)) {
                $failures.Add("Broken relative link in ${relativePath}: $target")
            }
        }
    }
}

if ($CheckExternalLinks) {
    foreach ($url in @($fsbpUrl, $adoProjectUrl, $adoStoryUrl)) {
        if ($url -eq $fsbpUrl) {
            $gh = Get-Command gh -ErrorAction SilentlyContinue
            if ($null -eq $gh) {
                $failures.Add('Authenticated FSBP link validation requires the GitHub CLI.')
                continue
            }
            & gh api 'repos/Max-Power-Platform/FullStackBestPractices' --silent
            if ($LASTEXITCODE -ne 0) {
                $failures.Add("Authenticated FSBP repository check failed: $url")
            }
            continue
        }
        if ($url -like "$adoProjectUrl*") {
            $az = Get-Command az -ErrorAction SilentlyContinue
            if ($null -eq $az) {
                $failures.Add('Authenticated ADO link validation requires the Azure CLI.')
                continue
            }
            if ($url -eq $adoStoryUrl) {
                & az boards work-item show --id 2042 --organization 'https://dev.azure.com/maxpowerplatform' --output none --only-show-errors
            } else {
                & az devops project show --project MPP --organization 'https://dev.azure.com/maxpowerplatform' --output none --only-show-errors
            }
            if ($LASTEXITCODE -ne 0) {
                $failures.Add("Authenticated ADO link check failed: $url")
            }
            continue
        }
        try {
            $response = Invoke-WebRequest -Uri $url -Method Head -MaximumRedirection 5 -UseBasicParsing
            if ($response.StatusCode -lt 200 -or $response.StatusCode -ge 400) {
                $failures.Add("Governance URL returned HTTP $($response.StatusCode): $url")
            }
        } catch {
            $failures.Add("Governance URL check failed: $url — $($_.Exception.Message)")
        }
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host 'PASS four-layer authority model is consistent.'
Write-Host 'PASS no second mutable session ledger exists.'
Write-Host 'PASS repository governance files and links are valid.'
