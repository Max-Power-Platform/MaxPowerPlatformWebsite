$ErrorActionPreference = 'Stop'
$rootPages = 'C:\Users\MaxMaraj\OneDrive - Max Power Platform\Repos\mpp\nonprofit-suite-website\src\portal\mpp2---mpp2\web-pages'

$homeId         = 'e600cd70-cdf2-4226-99de-5295c93fa12a'
$pageTemplateId = '383840f8-ed48-4d41-ab6c-bf5cd0d7ef21'
$publishingId   = 'eb607d5d-29cd-4e84-b47d-3bf053b90cb2'
$languageId     = '616149d4-cf5f-4127-bf22-ac929aaf11e2'

$modules = @(
  @{ slug='hbe';         folder='hbe';         title='Higher-Ed Benefits (HBE)';   icon='&#127979;'; tagline='Streamline scholarship and education-benefit applications, eligibility, and disbursements.'; what='HBE manages the full lifecycle of education-benefit programs &mdash; from online applications and document collection through eligibility review, award decisions, and disbursement tracking.'; who='Foundations, employer-sponsored education programs, and nonprofits administering scholarships or tuition assistance.' },
  @{ slug='dpa';         folder='dpa';         title='Down Payment Assistance (DPA)'; icon='&#127968;'; tagline='Run homebuyer-assistance programs end-to-end: intake, underwriting, awards, and reporting.'; what='DPA orchestrates homebuyer assistance programs: applicant intake, income/asset verification, underwriting workflows, award letters, lien tracking, and HUD-style reporting.'; who='HUD-funded nonprofits, CDFIs, and housing counseling agencies running down-payment or closing-cost assistance programs.' },
  @{ slug='hrrp';        folder='hrrp';        title='Home Repair &amp; Rehab (HRRP)'; icon='&#128736;'; tagline='Manage rehabilitation projects from inspection through draws, completion, and compliance.'; what='HRRP runs the home rehabilitation lifecycle: applicant qualification, scope of work, contractor assignment, draw schedules, inspections, and final compliance documentation.'; who='Housing nonprofits, weatherization programs, and government-funded home rehabilitation initiatives.' },
  @{ slug='fundraising'; folder='fundraising'; title='Fundraising &amp; Engagement';  icon='&#128176;'; tagline='Donor management, campaigns, events, and stewardship in one connected experience.'; what='A complete CRM for nonprofit fundraising: donor profiles and giving history, campaigns and appeals, event registration, pledges, and stewardship workflows &mdash; all on Dataverse.'; who='Development teams at nonprofits replacing siloed donor databases or Excel-based donor tracking.' },
  @{ slug='grants';      folder='grants';      title='Grant Management';            icon='&#128221;'; tagline='Track grant opportunities, applications, awards, budgets, and reporting in one place.'; what='Manage your grants pipeline from prospecting and applications to award acceptance, budget tracking, milestone deliverables, and funder reporting deadlines.'; who='Nonprofits managing federal, state, foundation, or corporate grant portfolios.' },
  @{ slug='volunteers';  folder='volunteers';  title='Volunteer Management';        icon='&#129309;'; tagline='Recruit, schedule, and recognize volunteers &mdash; and capture impact hours automatically.'; what='Volunteer onboarding, opportunity scheduling, hour tracking, background checks, recognition workflows, and impact reporting connected to programs and outcomes.'; who='Volunteer coordinators and program managers running structured volunteer programs.' },
  @{ slug='bulk-email';  folder='bulk-email';  title='Bulk Email Management';       icon='&#128231;'; tagline='Send compliant, segmented bulk communications to constituents with delivery tracking.'; what='Compose, schedule, and send segmented bulk email to donors, applicants, and constituents with built-in opt-out compliance, delivery tracking, and engagement analytics.'; who='Communications teams sending newsletters, appeals, and program-update emails to constituent audiences.' }
)

foreach ($m in $modules) {
  $rootFolder = Join-Path $rootPages $m.folder
  $contentFolder = Join-Path $rootFolder 'content-pages'
  New-Item -ItemType Directory -Force -Path $contentFolder | Out-Null

  $rootGuid    = [guid]::NewGuid().ToString()
  $contentGuid = [guid]::NewGuid().ToString()
  $pretty      = $m.folder.Substring(0,1).ToUpper() + $m.folder.Substring(1)
  $partial     = $m.slug
  $title       = $m.title

  $rootYml = @"
adx_displayorder: 50
adx_enablerating: false
adx_enabletracking: false
adx_excludefromsearch: false
adx_feedbackpolicy: 756150000
adx_hiddenfromsitemap: true
adx_isroot: true
adx_name: $pretty
adx_pagetemplateid: $pageTemplateId
adx_parentpageid: $homeId
adx_partialurl: $partial
adx_publishingstateid: $publishingId
adx_sharedpageconfiguration: false
adx_title: $title
adx_webpageid: $rootGuid
"@
  Set-Content -Path (Join-Path $rootFolder "$pretty.webpage.yml") -Value $rootYml -NoNewline
  Set-Content -Path (Join-Path $rootFolder "$pretty.webpage.copy.html") -Value '' -NoNewline
  Set-Content -Path (Join-Path $rootFolder "$pretty.webpage.summary.html") -Value '' -NoNewline
  Set-Content -Path (Join-Path $rootFolder "$pretty.webpage.custom_css.css") -Value '' -NoNewline
  Set-Content -Path (Join-Path $rootFolder "$pretty.webpage.custom_javascript.js") -Value '' -NoNewline

  $contentYml = @"
adx_displayorder: 50
adx_enablerating: false
adx_enabletracking: false
adx_excludefromsearch: false
adx_feedbackpolicy: 756150000
adx_hiddenfromsitemap: true
adx_isroot: false
adx_name: $pretty
adx_pagetemplateid: $pageTemplateId
adx_parentpageid: $homeId
adx_partialurl: $partial
adx_publishingstateid: $publishingId
adx_rootwebpageid: $rootGuid
adx_sharedpageconfiguration: false
adx_title: $title
adx_webpageid: $contentGuid
adx_webpagelanguageid: $languageId
"@
  Set-Content -Path (Join-Path $contentFolder "$pretty.en-US.webpage.yml") -Value $contentYml -NoNewline

  $copy = @"
<div class="row sectionBlockLayout text-center" style="display:flex;flex-wrap:wrap;margin:0;padding:48px 8px 24px;background:#ffffff;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <p style="margin:0 0 8px;"><a href="/" style="color:#1F66B5;text-decoration:none;">&larr; Nonprofit Suite</a></p>
      <div style="font-size:3rem;line-height:1;margin:8px 0;">$($m.icon)</div>
      <h1 style="margin:0 0 8px;color:#1F66B5;">$title</h1>
      <p style="font-size:1.15rem;max-width:780px;margin:0 auto;color:#555;">$($m.tagline)</p>
    </div>
  </div>
</div>

<div class="row sectionBlockLayout text-start" style="display:flex;flex-wrap:wrap;margin:0;padding:24px 8px 56px;background:#f7f8fa;">
  <div class="container" style="padding:0;">
    <div class="col-lg-8 columnBlockLayout" style="margin:0 auto;max-width:820px;background:#fff;border:1px solid #e3e3e3;border-radius:8px;padding:32px;">
      <h2 style="color:#7A6A65;margin:0 0 12px;">What this module does</h2>
      <p style="color:#444;">$($m.what)</p>

      <h2 style="color:#7A6A65;margin:24px 0 12px;">Who it's for</h2>
      <p style="color:#444;">$($m.who)</p>

      <h2 style="color:#7A6A65;margin:24px 0 12px;">Built on</h2>
      <p style="color:#444;">Microsoft Power Platform &mdash; Dataverse, model-driven apps, Power Automate, and Power Pages.</p>

      <p style="margin-top:32px;"><a href="/" style="display:inline-block;background:#1F66B5;color:#fff;padding:10px 20px;border-radius:6px;text-decoration:none;">&larr; Back to all modules</a></p>
    </div>
  </div>
</div>
"@
  Set-Content -Path (Join-Path $contentFolder "$pretty.en-US.webpage.copy.html") -Value $copy -NoNewline -Encoding UTF8
  Set-Content -Path (Join-Path $contentFolder "$pretty.en-US.webpage.summary.html") -Value '' -NoNewline
  Set-Content -Path (Join-Path $contentFolder "$pretty.en-US.webpage.custom_css.css") -Value '' -NoNewline
  Set-Content -Path (Join-Path $contentFolder "$pretty.en-US.webpage.custom_javascript.js") -Value '' -NoNewline

  Write-Host "  $title -> /$partial/  root=$rootGuid"
}
Write-Host "`nDone. 7 module pages created."
