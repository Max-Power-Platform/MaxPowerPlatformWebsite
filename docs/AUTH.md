# Auth setup — Azure CLI + Service Principal (OIDC for CI)

> **TL;DR** — One Azure AD app (`mpp-pages-website`) per tenant, federated credentials per env, no client secrets in CI. Local dev uses `az login` + `pac auth create --azureCliAuth`. CI uses `azure/login@v2` (OIDC) + `pac auth create --azureCliAuth`.

Site: `https://mpp2.powerappsportals.com/` · Tenant: `mpp` · Operator: `max@maxpowerplatform.com`

---

## Prerequisites

```pwsh
# Azure CLI ≥ 2.60
az --version

# Power Platform CLI ≥ 1.34 (gives `--azureCliAuth`)
dotnet tool update --global Microsoft.PowerApps.CLI.Tool
pac --version

# Sign into Azure as the operator
az login --tenant <MPP_TENANT_ID>
az account show
```

Capture IDs once into `scripts/.local.json` (gitignored):

```json
{
  "tenantId":   "<MPP_TENANT_ID>",
  "pagesAppId": "<set after step 1>",
  "devEnv":     { "url": "https://<dev>.crm.dynamics.com",  "envId": "<dev-env-guid>"  },
  "uatEnv":     { "url": "https://<uat>.crm.dynamics.com",  "envId": "<uat-env-guid>"  },
  "prodEnv":    { "url": "https://mpp2.crm.dynamics.com",   "envId": "<prod-env-guid>" }
}
```

```pwsh
az account show --query tenantId -o tsv
pac env list --json | ConvertFrom-Json | Select-Object DisplayName, EnvironmentId, EnvironmentUrl
```

---

## 1. Create the Azure AD app + Service Principal (one-time per tenant)

```pwsh
$appName = 'mpp-pages-website'

$app = az ad app create --display-name $appName --sign-in-audience AzureADMyOrg | ConvertFrom-Json
$appId = $app.appId

az ad sp create --id $appId | Out-Null
$spId = az ad sp show --id $appId --query id -o tsv

Write-Host "AppId: $appId"
Write-Host "SPId:  $spId"
```

Record `$appId` in `scripts/.local.json` as `pagesAppId`.

---

## 2. Federated credentials for CI (OIDC, one per env)

```pwsh
param($AppId, $EnvName)

$body = @{
    name       = "gh-actions-$EnvName"
    issuer     = "https://token.actions.githubusercontent.com"
    subject    = "repo:Max-Power-Platform/MaxPowerPlatformWebsite:environment:$EnvName"
    audiences  = @("api://AzureADTokenExchange")
}

az ad app federated-credential create --id $AppId --parameters ($body | ConvertTo-Json -Compress)
```

---

## 3. Create pac auth profiles

```pwsh
pac auth create --name mpp-website-dev  --environment <DEV_URL>  --azureCliAuth
pac auth create --name mpp-website-uat  --environment <UAT_URL>  --azureCliAuth
pac auth create --name mpp-website-prod --environment <PROD_URL> --azureCliAuth
```

---

## 4. Add SP as Application User in each Power Platform env

Portal → Advanced Settings → Security → Users → Application Users → New:
- App: `mpp-pages-website`
- Role: **System Administrator**
