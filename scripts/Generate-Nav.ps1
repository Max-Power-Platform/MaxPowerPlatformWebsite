$ErrorActionPreference = 'Stop'
Set-Location 'C:\Users\MaxMaraj\OneDrive - Max Power Platform\Repos\mpp\nonprofit-suite-website'

$set    = '9b44a949-a98d-4969-afd9-8569b33f7829'
$pub    = 'eb607d5d-29cd-4e84-b47d-3bf053b90cb2'
$homeId = 'e600cd70-cdf2-4226-99de-5295c93fa12a'

$modules = @(
  @{ name='Homebuyer Education';      pid='0e9aa125-8701-4c1b-8836-346e31aebad4' }
  @{ name='Down Payment Assistance';  pid='e7cb8f63-e495-4d98-bb8b-ad6c0ccdde2e' }
  @{ name='Home Repair';              pid='1f4ea8b7-2768-4a86-b38a-cae699f53021' }
  @{ name='Fundraising';              pid='c2b19808-49ac-42f9-b532-b96789943fd2' }
  @{ name='Grants';                   pid='c96f6cb7-0016-4be7-bfaf-519e1da0b020' }
  @{ name='Volunteers';               pid='ad8d0569-cf44-4683-ba0d-0c4ebe29e69c' }
  @{ name='Bulk Email';               pid='44aa8df7-3a54-45a9-a1b7-64a5bbe17972' }
)

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add('- adx_disablepagevalidation: false')
$lines.Add('  adx_displayimageonly: false')
$lines.Add('  adx_displayorder: 1')
$lines.Add('  adx_displaypagechildlinks: false')
$lines.Add('  adx_name: Home')
$lines.Add('  adx_openinnewwindow: false')
$lines.Add("  adx_pageid: $homeId")
$lines.Add("  adx_publishingstateid: $pub")
$lines.Add('  adx_robotsfollowlink: true')
$lines.Add('  adx_weblinkid: 120e8f8c-3b45-4197-bdfd-36118d26332f')
$lines.Add("  adx_weblinksetid: $set")

$order = 2
foreach ($m in $modules) {
  $wid = [guid]::NewGuid().ToString()
  $lines.Add('- adx_disablepagevalidation: false')
  $lines.Add('  adx_displayimageonly: false')
  $lines.Add("  adx_displayorder: $order")
  $lines.Add('  adx_displaypagechildlinks: false')
  $lines.Add("  adx_name: $($m.name)")
  $lines.Add('  adx_openinnewwindow: false')
  $lines.Add("  adx_pageid: $($m.pid)")
  $lines.Add("  adx_publishingstateid: $pub")
  $lines.Add('  adx_robotsfollowlink: true')
  $lines.Add("  adx_weblinkid: $wid")
  $lines.Add("  adx_weblinksetid: $set")
  $order++
}

$path = 'src/portal/mpp2---mpp2/weblink-sets/default/Default.en-US.weblinkset.weblink.yml'
Set-Content -Path $path -Value ($lines -join "`n") -NoNewline
Write-Host "Wrote $(($order-1)+1) links to $path"
