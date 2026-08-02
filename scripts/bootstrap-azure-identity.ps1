#requires -Version 7.0
<#
.SYNOPSIS
  One-time bootstrap: create the Azure AD app + SP + federated credentials for this repo.

.DESCRIPTION
  Idempotent. Re-running is safe — it skips items that already exist.
  Requires Azure CLI ≥ 2.60 and an operator account with Application Administrator (or higher)
  in Entra ID. See docs/AUTH.md.

.PARAMETER Repo
  GitHub repo in `owner/name` form. Defaults to Max-Power-Platform/nonprofit-suite-website.

.PARAMETER AppName
  Azure AD application display name. Default: mpp-pages-website.

.EXAMPLE
  pwsh ./scripts/bootstrap-azure-identity.ps1
#>
[CmdletBinding(SupportsShouldProcess)]
param(
  [string]$Repo = 'Max-Power-Platform/nonprofit-suite-website',
  [string]$AppName = 'mpp-pages-website'
)

$ErrorActionPreference = 'Stop'

# Ensure az is signed in
$account = az account show 2>$null | ConvertFrom-Json
if (-not $account) { throw "Run 'az login --tenant <MPP_TENANT_ID>' first." }
Write-Host "Operator: $($account.user.name) (tenant $($account.tenantId))" -ForegroundColor Cyan

# 1. Find or create the app
$existing = az ad app list --display-name $AppName --query "[0]" 2>$null | ConvertFrom-Json
if ($existing) {
  $appId = $existing.appId
  Write-Host "Re-using existing app: $AppName ($appId)" -ForegroundColor Yellow
} else {
  if ($PSCmdlet.ShouldProcess($AppName, 'az ad app create')) {
    $app  = az ad app create --display-name $AppName --sign-in-audience AzureADMyOrg | ConvertFrom-Json
    $appId = $app.appId
    Write-Host "Created app: $appId" -ForegroundColor Green
  }
}

# 2. Find or create the SP
$sp = az ad sp list --filter "appId eq '$appId'" --query "[0]" 2>$null | ConvertFrom-Json
if (-not $sp) {
  if ($PSCmdlet.ShouldProcess($appId, 'az ad sp create')) {
    az ad sp create --id $appId | Out-Null
    Write-Host "Created SP" -ForegroundColor Green
  }
} else {
  Write-Host "Re-using existing SP" -ForegroundColor Yellow
}

# 3. Federated credentials (per-environment + main branch)
$creds = @(
  @{ name='github-dev';         subject="repo:$($Repo):environment:dev"  },
  @{ name='github-uat';         subject="repo:$($Repo):environment:uat"  },
  @{ name='github-prod';        subject="repo:$($Repo):environment:prod" },
  @{ name='github-main-branch'; subject="repo:$($Repo):ref:refs/heads/main" }
)

$existingCreds = az ad app federated-credential list --id $appId | ConvertFrom-Json

foreach ($c in $creds) {
  if ($existingCreds | Where-Object { $_.name -eq $c.name }) {
    Write-Host "  ✓ federated cred '$($c.name)' already exists" -ForegroundColor Yellow
    continue
  }
  $body = @{
    name      = $c.name
    issuer    = 'https://token.actions.githubusercontent.com'
    subject   = $c.subject
    audiences = @('api://AzureADTokenExchange')
  } | ConvertTo-Json -Compress
  if ($PSCmdlet.ShouldProcess($c.name, 'az ad app federated-credential create')) {
    az ad app federated-credential create --id $appId --parameters $body | Out-Null
    Write-Host "  + created federated cred '$($c.name)'" -ForegroundColor Green
  }
}

Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "  1. Add this app as Application User (System Administrator role) in each Power Platform env."
Write-Host "     pac admin assign-user --environment <URL> --user $appId --role 'System Administrator' --applicationUser"
Write-Host "  2. Set GitHub repo variables:"
Write-Host "       MPP_TENANT_ID    = $($account.tenantId)"
Write-Host "       MPP_PAGES_APP_ID = $appId"
Write-Host "       MPP_DEV_ENV_URL  = <dev env URL>"
Write-Host "       MPP_UAT_ENV_URL  = <uat env URL>"
Write-Host "       MPP_PROD_ENV_URL = <prod env URL>"
Write-Host "  3. Local: pac auth create --name nonprofit-website-dev --environment <URL> --azureCliAuth"
