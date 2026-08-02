#requires -Version 7
$ErrorActionPreference = 'Stop'
Set-Location 'C:\Users\MaxMaraj\OneDrive - Max Power Platform\Repos\mpp\nonprofit-suite-website'

$tok  = (az account get-access-token --resource https://mpp1.crm.dynamics.com/ --query accessToken -o tsv)
$h    = @{ Authorization = "Bearer $tok"; 'Content-Type'='application/json'; Accept = 'application/json' }
$base = 'https://mpp1.crm.dynamics.com/api/data/v9.2'
$wid  = '379c4182-4ae2-46d0-9112-324244319bd6'   # MPP2 V2 site
$anonRoleId = '03913fd0-4985-4445-a833-9bacbd028a90'   # Anonymous Users

# ---- 1. Site settings: enable Web API on lead ----
$settings = @(
  @{ name='Webapi/lead/enabled';  value='true' }
  @{ name='Webapi/lead/fields';   value='subject,firstname,lastname,emailaddress1,description,companyname,telephone1' }
  @{ name='Webapi/error/innererror'; value='true' }
)
foreach ($s in $settings) {
  $existing = (Invoke-RestMethod -Uri ($base + '/mspp_sitesettings?$filter=_mspp_websiteid_value eq ' + $wid + " and mspp_name eq '$($s.name)'") -Headers $h).value
  if ($existing) {
    if ($existing[0].mspp_value -ne $s.value) {
      $id = $existing[0].mspp_sitesettingid
      $body = @{ mspp_value = $s.value } | ConvertTo-Json
      $hp = $h.Clone(); $hp['If-Match'] = '*'
      Invoke-RestMethod -Method Patch -Uri "$base/mspp_sitesettings($id)" -Headers $hp -Body $body | Out-Null
      "updated setting: $($s.name) = $($s.value)"
    } else {
      "ok (unchanged): $($s.name) = $($s.value)"
    }
  } else {
    $body = @{
      mspp_name = $s.name
      mspp_value = $s.value
      'mspp_websiteid@odata.bind' = "/mspp_websites($wid)"
    } | ConvertTo-Json
    Invoke-RestMethod -Method Post -Uri "$base/mspp_sitesettings" -Headers $h -Body $body | Out-Null
    "created setting: $($s.name) = $($s.value)"
  }
}

# ---- 2. Table permission: lead Create for Anonymous Users (Global scope) ----
$tpName = 'Lead - Anonymous Create (web form)'
$existingTp = (Invoke-RestMethod -Uri ($base + '/mspp_entitypermissions?$filter=_mspp_websiteid_value eq ' + $wid + " and mspp_entityname eq '$tpName'") -Headers $h).value
if ($existingTp) {
  $tpId = $existingTp[0].mspp_entitypermissionid
  "existing entity permission: $tpId"
} else {
  $tpBody = @{
    mspp_entityname = $tpName
    mspp_entitylogicalname = 'lead'
    mspp_scope = 756150000   # Global
    mspp_create = $true
    mspp_read = $false
    mspp_write = $false
    mspp_delete = $false
    mspp_append = $true
    mspp_appendto = $true
    'mspp_websiteid@odata.bind' = "/mspp_websites($wid)"
  } | ConvertTo-Json
  $tpResp = Invoke-WebRequest -Method Post -Uri "$base/mspp_entitypermissions" -Headers $h -Body $tpBody
  $tpId = ($tpResp.Headers.'OData-EntityId' -replace '.*\(([^)]+)\).*','$1')
  "created entity permission: $tpId"
}

# Associate webrole (N:N) - mspp_entitypermission_webrole
try {
  $assoc = @{ '@odata.id' = "$base/mspp_webroles($anonRoleId)" } | ConvertTo-Json
  Invoke-RestMethod -Method Post -Uri "$base/mspp_entitypermissions($tpId)/mspp_entitypermission_webrole/`$ref" -Headers $h -Body $assoc | Out-Null
  "associated Anonymous Users role to table permission"
} catch {
  if ($_.Exception.Message -match 'duplicate' -or $_.Exception.Message -match 'already') {
    "association already exists"
  } else { Write-Warning $_.Exception.Message }
}

"DONE"
