#requires -Version 7
$ErrorActionPreference = 'Stop'
Set-Location 'C:\Users\MaxMaraj\OneDrive - Max Power Platform\Repos\mpp\nonprofit-suite-website'

$tok = (az account get-access-token --resource https://mpp1.crm.dynamics.com/ --query accessToken -o tsv)
$h   = @{ Authorization = "Bearer $tok"; Accept = 'application/json' }
$base = 'https://mpp1.crm.dynamics.com/api/data/v9.2'
$websiteId    = '379c4182-4ae2-46d0-9112-324244319bd6'
$weblinkSetId = '9b44a949-a98d-4969-afd9-8569b33f7829'

# --- Canonical page IDs from disk ---
$keepPages = New-Object System.Collections.Generic.HashSet[string]
Get-ChildItem 'src/portal/mpp2---mpp2/web-pages' -Recurse -Filter '*.webpage.yml' | ForEach-Object {
  $t = Get-Content $_.FullName -Raw
  if ($t -match 'adx_webpageid:\s*([0-9a-fA-F-]{36})')   { [void]$keepPages.Add($Matches[1].ToLower()) }
  if ($t -match 'adx_rootwebpageid:\s*([0-9a-fA-F-]{36})') { [void]$keepPages.Add($Matches[1].ToLower()) }
  if ($t -match 'adx_parentpageid:\s*([0-9a-fA-F-]{36})')  { [void]$keepPages.Add($Matches[1].ToLower()) }
}
"On-disk canonical page IDs: $($keepPages.Count)"

# --- All V2 pages on the website ---
$pagesUri = "$base/mspp_webpages?`$filter=_mspp_websiteid_value eq $websiteId&`$select=mspp_webpageid,mspp_name,mspp_partialurl,_mspp_rootwebpageid_value"
$allPages = (Invoke-RestMethod -Uri $pagesUri -Headers $h).value
"Server pages total: $($allPages.Count)"

$orphanPages = $allPages | Where-Object { -not $keepPages.Contains($_.mspp_webpageid.ToLower()) }
"Orphan pages to delete: $($orphanPages.Count)"
foreach ($p in $orphanPages) {
  try {
    Invoke-RestMethod -Method Delete -Uri "$base/mspp_webpages($($p.mspp_webpageid))" -Headers $h -ErrorAction Stop | Out-Null
    "  - deleted page $($p.mspp_partialurl) ($($p.mspp_name)) $($p.mspp_webpageid)"
  } catch { "  ! FAIL page $($p.mspp_webpageid): $($_.Exception.Message)" }
}

# --- Canonical weblink IDs from disk ---
$navYml = Get-Content 'src/portal/mpp2---mpp2/weblink-sets/default/Default.en-US.weblinkset.weblink.yml' -Raw
$keepLinks = New-Object System.Collections.Generic.HashSet[string]
[regex]::Matches($navYml, 'adx_weblinkid:\s*([0-9a-fA-F-]{36})') | ForEach-Object { [void]$keepLinks.Add($_.Groups[1].Value.ToLower()) }
"On-disk canonical weblink IDs: $($keepLinks.Count)"

# --- All V2 weblinks in this set ---
$linksUri = "$base/mspp_weblinks?`$filter=_mspp_weblinksetid_value eq $weblinkSetId&`$select=mspp_weblinkid,mspp_name"
$allLinks = (Invoke-RestMethod -Uri $linksUri -Headers $h).value
"Server weblinks total: $($allLinks.Count)"

$orphanLinks = $allLinks | Where-Object { -not $keepLinks.Contains($_.mspp_weblinkid.ToLower()) }
"Orphan weblinks to delete: $($orphanLinks.Count)"
foreach ($l in $orphanLinks) {
  try {
    Invoke-RestMethod -Method Delete -Uri "$base/mspp_weblinks($($l.mspp_weblinkid))" -Headers $h -ErrorAction Stop | Out-Null
    "  - deleted weblink $($l.mspp_name) $($l.mspp_weblinkid)"
  } catch { "  ! FAIL link $($l.mspp_weblinkid): $($_.Exception.Message)" }
}

"DONE"
