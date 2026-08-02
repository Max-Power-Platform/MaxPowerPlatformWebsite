#requires -Version 7
<#
  Build-Site.ps1
  Single source of truth for the public marketing site.
  - Defines all 15 modules in 4 categories
  - Creates page records (root + content) for any module that doesn't have one yet
  - Rewrites every module's content-page HTML using a shared template
  - Rewrites the Home page (frontier/AI-first hero + categorized tile grid + AI capabilities section)
  - Rewrites the primary nav weblink set (all 15 module links)
  - Rewrites the Footer snippet link row to span all categories
#>

$ErrorActionPreference = 'Stop'
Set-Location 'C:\Users\MaxMaraj\OneDrive - Max Power Platform\Repos\mpp\nonprofit-suite-website'

# --- Constants pulled from existing portal export ---
$rootPages      = 'src/portal/mpp2---mpp2/web-pages'
$pageTemplateId = '383840f8-ed48-4d41-ab6c-bf5cd0d7ef21'
$publishingId   = 'eb607d5d-29cd-4e84-b47d-3bf053b90cb2'
$languageId     = '616149d4-cf5f-4127-bf22-ac929aaf11e2'
$homeId         = 'e600cd70-cdf2-4226-99de-5295c93fa12a'
$weblinkSetId   = '9b44a949-a98d-4969-afd9-8569b33f7829'
$homeWebLinkId  = '120e8f8c-3b45-4197-bdfd-36118d26332f'

# --- All 15 modules (existing pageIds preserved, new ones get fresh GUIDs at runtime) ---
# category: programs | operations | engagement | coming-soon
$modules = @(
  # --- Programs ---
  @{ slug='hbe'; folder='hbe'; pretty='Hbe'; category='programs'; status='live'
     pageId='0e9aa125-8701-4c1b-8836-346e31aebad4'
     navName='Homebuyer Education'; title='Homebuyer Education'; icon='&#127968;'
     tagline='HUD-style classes, 1:1 counseling, education lock-in, and certificate issuance &mdash; the front door to every assistance program.'
     what='Manage the full homebuyer education pipeline: class scheduling and rosters, attendance and completion tracking, 1:1 counseling sessions, document collection, education lock-in to a specific program, and HUD-eligible certificate issuance. Includes a manager dashboard, daily exception briefs, and class-readiness scans powered by Copilot Studio agents.'
     who='HUD-approved housing counseling agencies, nonprofit homebuyer education providers, and any organization required to deliver pre-purchase education before disbursing assistance funds.'
     detail='<p style="color:#444;"><strong>Why it matters for affordable housing:</strong> Most state and federal down payment programs &mdash; including Florida SHIP and HUD HOME &mdash; require borrowers to complete a HUD-certified homebuyer education workshop <em>before</em> closing. Homebuyer Education is the system of record that proves it.</p><p style="color:#444;"><strong>Connected to:</strong> The same contact record flows into Down Payment Assistance, so a household&rsquo;s class completion is one click from their loan application.</p>'
  },
  @{ slug='dpa'; folder='dpa'; pretty='Dpa'; category='programs'; status='live'
     pageId='e7cb8f63-e495-4d98-bb8b-ad6c0ccdde2e'
     navName='Down Payment Assistance'; title='Down Payment Assistance'; icon='&#128176;'
     tagline='SHIP &amp; HOME-funded purchase assistance: applications, underwriting, awards, closings, liens, and HUD reporting.'
     what='End-to-end administration of down payment assistance loan programs. Online intake, household income verification, AMI calculation, underwriting business process flow, award letters, closing tab, lien tracking, payoff/satisfaction, and reporting. Built on Dataverse with a React/TypeScript DPA Console SPA for staff and a constituent portal for applicants.'
     who='HUD-approved nonprofit housing agencies and CDFIs administering federal/state-funded purchase assistance &mdash; for example, the City of Clearwater Home Purchase Assistance Program (SHIP/HOME) is delivered through approved nonprofit housing agencies.'
     detail='<h3 style="color:#7A6A65;margin:24px 0 8px;">Real-world example: City of Clearwater SHIP DPA</h3><p style="color:#444;">Clearwater&rsquo;s SHIP-funded program (loans up to $75,000 for purchases approved after July&nbsp;1,&nbsp;2025) is a representative DPA workflow this module supports:</p><ul style="color:#444;line-height:1.7;"><li>50% amortized over 20 years (payments deferred 5 years), 50% deferred &amp; forgiven at maturity</li><li>Household income test against AMI; all members 18+ counted</li><li>Borrower must complete a HUD-certified homebuyer education workshop (handled by the <a href="/hbe/" style="color:#1F66B5;">Homebuyer Education</a> module)</li><li>Borrower contributes 1% from own funds; primary residence; lead-paint/code requirements</li><li>Application submitted through an approved nonprofit housing agency</li><li>Lien recorded; full balance due on sale before maturity unless hardship rules apply</li></ul><p style="color:#444;"><em>The DPA module captures every one of those rules as configurable program parameters, business process stages, and validation rules &mdash; so a single deployment can serve multiple funding sources (SHIP, HOME, ARPA, county-specific) without code changes.</em></p>'
  },
  @{ slug='hrrp'; folder='hrrp'; pretty='Hrrp'; category='programs'; status='live'
     pageId='1f4ea8b7-2768-4a86-b38a-cae699f53021'
     navName='Home Repair'; title='Home Repair and Rehab'; icon='&#128736;'
     tagline='City-referred housing repair / replacement programs: outreach, scope of work, contractor handoff, draws, and compliance.'
     what='Receive city/county housing-repair referrals, validate homeowner contact, deduplicate against existing records, schedule inspections, define scope of work, assign contractors, manage draw schedules, track inspections through completion, and generate compliance reports. Includes a Copilot Studio HRRP Manager agent for triage and homeowner outreach automation.'
     who='Nonprofit partners delivering city- or county-funded Housing Repair &amp; Replacement Programs (HRRP), weatherization assistance, and emergency repair grants for low-income homeowners.'
     detail='<p style="color:#444;"><strong>Typical referral flow:</strong> A city housing department refers a homeowner under their HRRP. The intake agent validates contact info (phone/email), runs deduplication, and either auto-handoffs to the city contact with a templated referral packet or routes to a counselor for follow-up &mdash; all logged on the homeowner timeline.</p>'
  },
  @{ slug='cms'; folder='cms'; pretty='Cms'; category='programs'; status='live'
     pageId=$null  # to be generated
     navName='Construction Management'; title='Construction Management System'; icon='&#127959;'
     tagline='Construction project management: proforma, deals, dev consoles, draws, time tracking, payment approvals, and document control.'
     what='End-to-end construction project management for affordable-housing developers and rehabilitation programs. Proforma modeling, deal tracking, development consoles (React/TypeScript web resources), construction payment approvals, time tracking, contractor and vendor coordination, and project document control. Released as a managed train (mpp_CMSCore &rarr; mpp_CMSApplication &rarr; mpp_CMSConsoles) with a separate flows release stream and a dedicated Copilot Studio CMS agent.'
     who='Affordable-housing developers, community development corporations (CDCs), and program managers running new-construction or rehab portfolios alongside their direct-service programs.'
     detail='<p style="color:#444;"><strong>Built around three consoles:</strong> Proforma Console (financial feasibility), Deal Console (acquisition / closing pipeline), and Dev Console (construction delivery and draws). Owns shared finance tables &mdash; <code>mpp_constructionpaymentapproval</code> and <code>mpp_timetracking</code> &mdash; so spend rolls up into Accounts Payable cleanly.</p><p style="color:#444;"><strong>On the roadmap:</strong> Migration to the layered <code>CMS_Core / CMS_DataLayer / CMS_Application / CMS_Documents / CMS_UI</code> architecture, succeeded by the <code>ConstructionManagementSystem</code> repo for the next-generation rebuild.</p>'
  },
  @{ slug='property-management'; folder='property-management'; pretty='PropertyManagement'; category='programs'; status='live'
     pageId=$null
     navName='Property Management'; title='Property Management'; icon='&#127977;'
     tagline='Real-estate portfolio, units, tenants, rent rolls, and onboarding workflows for nonprofit-owned properties.'
     what='Track the nonprofit&rsquo;s real-estate portfolio: properties, units, tenants, leases, rent rolls, employment verification, and document upload. Built as a Power Platform solution (PropertyManagement, currently v1.6.0.x) with model-driven app, workflows, option sets, and security roles &mdash; all sourced under <code>src/Entities</code>, <code>src/Workflows</code>, <code>src/AppModules</code>.'
     who='Affordable-housing nonprofits that own, manage, or operate rental units &mdash; including community land trusts, lease-purchase programs, and transitional / supportive housing operators.'
     detail='<p style="color:#444;"><strong>Targeted layering:</strong> <code>PM_Core / PM_DataLayer / PM_Application / PM_UI</code>, with shared boundary tables (<code>mpp_application*</code>, <code>mpp_employment</code>, <code>mpp_documentupload</code>, <code>mpp_tenant</code>) moving into <code>MPP_Shared_*</code> so Property Management, DPA, and HBE all reference the same family records.</p>'
  },
  # --- Operations ---
  @{ slug='accounts-payable'; folder='accounts-payable'; pretty='AccountsPayable'; category='operations'; status='live'
     pageId=$null
     navName='Accounts Payable'; title='Accounts Payable'; icon='&#129534;'
     tagline='Vendor invoice intake, multi-step approvals, AP role teams, and Copilot Studio AP agents &mdash; built on the shared <code>mpp_bill</code> family.'
     what='Receive and code vendor invoices, route multi-stage approvals based on bill type and amount, capture supporting documents, and export approved bills to the GL. AP role teams (manager, approver, processor) provide baseline privileges and visibility scoping; the AccountsPayableAgents solution adds Copilot Studio agents that triage incoming invoices, summarize bill packets, and answer vendor-status questions inside Dynamics 365.'
     who='Finance and operations teams at affordable-housing nonprofits, CDCs, and managing partners that need controlled invoice approval and audit trails across multiple programs and funding sources.'
     detail='<p style="color:#444;"><strong>Owns the Tier-1 bound:</strong> <code>mpp_bill</code>, <code>mpp_accountspayablebilltype</code>, <code>mpp_constructionpaymentapproval</code>, <code>mpp_emailconfiguration</code>, <code>mpp_flowfailurelog</code> &mdash; tables shared with Construction Management, HBE, and Property Management as <code>MPP_Shared_Finance</code>.</p><p style="color:#444;"><strong>Roles included today:</strong> AP role teams + baseline privileges + 09 visibility spec (BT-235, BT-222, BT-236).</p>'
  },
  @{ slug='procurement'; folder='procurement'; pretty='Procurement'; category='operations'; status='live'
     pageId=$null
     navName='Procurement'; title='Procurement'; icon='&#128230;'
     tagline='RFPs, vendor evaluation, awards, funding sources, vendor certificates, document links &mdash; with a real-time analytics console.'
     what='Manage the procurement lifecycle: RFP intake and lifecycle, vendor scoring and award decisions, funding-source allocations, vendor-certificate compliance tracking, and document-link management. Includes a Vite + React + ECharts analytics web resource (<code>mpp_procurementanalytics.js</code>) and live Playwright acceptance tests for the RFP lifecycle.'
     who='Procurement officers, compliance teams, and program managers at federally and state-funded nonprofits that must document fair-and-open vendor selection.'
     detail='<p style="color:#444;"><strong>Standalone-first design:</strong> Zero hard cross-solution dependencies on AP or CMS &mdash; Procurement-owned primitives use the <code>mpp_proc*</code> prefix when AP/CMS already use the unprefixed name (e.g. <code>mpp_procapprovalrequest</code>, <code>mpp_fundingsource</code>, <code>mpp_documentlink</code>, <code>mpp_vendorcertificate</code>) so it imports cleanly anywhere.</p><p style="color:#444;"><strong>Acceptance evidence:</strong> Playwright live screenshots only &mdash; flow / API success codes are not enough.</p>'
  },
  @{ slug='find-jurisdiction'; folder='find-jurisdiction'; pretty='FindJurisdiction'; category='operations'; status='live'
     pageId=$null
     navName='Property Analyzer'; title='Property Analyzer'; icon='&#128205;'
     tagline='Florida address &rarr; jurisdiction, zoning, permits, flood, utilities, and a public-records CMA / ARV forecast &mdash; the full property due-diligence packet in one tab.'
     what='Given a Florida street address, the Property Analyzer determines the county, municipality, tax district, and incorporated/unincorporated status, saves the public-record result into Dataverse, and presents land-feasibility due-diligence context in the Property Appraiser Info (PAI) Console. Covers Hillsborough (HCPA), Pinellas (PCPAO), and Pasco (PASCOPAO) counties today, with server-side Azure Maps address suggestions and surfaces for zoning/FLU, permits, inspections, utilities, flood/coastal, plus a public-records CMA / ARV Forecast tab with a real subject/comp/new-permit map.'
     who='Real-estate acquisitions teams, development underwriters, and counselors performing site eligibility, zoning, and feasibility checks for affordable-housing programs.'
     detail='<p style="color:#444;"><strong>Single-purpose plugin pack</strong> (<code>FindJurisdiction_Plugins</code>, no model-driven app of its own). It is consumed by HBE, DPA, CMS, and Property Management to enrich any property record the moment an address is entered.</p>'
  },
  # --- Engagement ---
  @{ slug='fundraising'; folder='fundraising'; pretty='Fundraising'; category='engagement'; status='live'
     pageId='c2b19808-49ac-42f9-b532-b96789943fd2'
     navName='Fundraising'; title='Fundraising and Engagement'; icon='&#129505;'
     tagline='Donors, gifts, pledges, recurring giving, events, silent auctions, planned giving, GL export &mdash; with Stripe and donor portal.'
     what='A complete nonprofit development platform: donor profiles and giving history, multi-fund accounting, campaigns and appeals, gift batches, pledges and recurring gifts, fundraising events with ticketing and check-in, silent auctions with real-time bidding, planned giving and Legacy Society tracking, and GL export adapters for QuickBooks Online, Sage Intacct, and MIP. PCI-compliant Stripe boundary (SAQ&nbsp;A).'
     who='Development and finance teams at affordable-housing nonprofits, community foundations, and any 501(c)(3) replacing siloed donor databases or spreadsheet-based giving records.'
     detail='<p style="color:#444;"><strong>Why it pairs with the housing modules:</strong> Donor restricted-fund tracking ties every gift to the program it supports (e.g., &ldquo;Emergency Repair Fund&rdquo;, &ldquo;Homebuyer Scholarship&rdquo;), and the donor portal &amp; auction site are delivered through the same Power Pages surface as this website.</p>'
  },
  @{ slug='grants'; folder='grants'; pretty='Grants'; category='engagement'; status='live'
     pageId='c96f6cb7-0016-4be7-bfaf-519e1da0b020'
     navName='Grants'; title='Grant Management'; icon='&#128221;'
     tagline='Track grant opportunities, applications, awards, budget commitments, and 90/60/30/14/7-day deadline alerts.'
     what='Manage your inbound grants pipeline from prospecting through close-out. Capture grant opportunities, application drafts and submissions, award acceptance and amendments, budget line items and commitment ledger, milestone deliverables, and funder reporting deadlines. Built-in deadline alert workflows fire at 90/60/30 and 14/7 days before any reporting due date.'
     who='Grants managers at affordable-housing nonprofits managing federal (HUD, Treasury), state (SHIP, NSP), county, foundation, and corporate grant portfolios.'
     detail='<p style="color:#444;"><strong>Roles included:</strong> Grant Manager (full lifecycle), Grant Scout (research/prospecting only). Tables include grant opportunity, grant application, grant award, and the v1.2+ commitment ledger for budget burn tracking.</p>'
  },
  @{ slug='volunteers'; folder='volunteers'; pretty='Volunteers'; category='engagement'; status='live'
     pageId='ad8d0569-cf44-4683-ba0d-0c4ebe29e69c'
     navName='Volunteers'; title='Volunteer Management'; icon='&#129309;'
     tagline='Recruit, schedule, track hours, and recognize volunteers &mdash; tied to the same Dataverse contact and program records.'
     what='Volunteer onboarding and waiver management, opportunity scheduling, shift sign-ups, hour tracking, background-check status, recognition workflows, and impact reporting connected to the programs and outcomes the volunteer supported.'
     who='Volunteer coordinators at housing nonprofits running build days, education-class instructor pools, financial-coaching volunteer corps, and event volunteer teams.'
     detail='<p style="color:#444;"><strong>Shared Dataverse contact:</strong> A volunteer who later applies for assistance, donates, or registers for a class is the same contact record &mdash; no duplicates, no reconciliation.</p>'
  },
  @{ slug='bulk-email'; folder='bulk-email'; pretty='Bulk-email'; category='engagement'; status='live'
     pageId='44aa8df7-3a54-45a9-a1b7-64a5bbe17972'
     navName='Bulk Email'; title='Bulk Email Management'; icon='&#128231;'
     tagline='Newsletters and segmented bulk email through Azure Communication Services with marketing-list automation and unsubscribe handling.'
     what='Compose and schedule bulk email to dynamic and static marketing lists, send through Azure Communication Services Email, automatically remove bounced and unsubscribed contacts from static lists, and track opens/clicks. Per-recipient signed unsubscribe tokens prevent unauthorized list manipulation.'
     who='Communications staff sending newsletters, fundraising appeals, program updates, class reminders, and donor receipts to constituent audiences across the suite.'
     detail='<p style="color:#444;"><strong>Built on:</strong> 10 Power Automate cloud flows in the <code>BulkEmailManagement</code> Dataverse solution, with API keys stored in environment variables (never in flow defaults) per the project&rsquo;s code-review hardening standard.</p>'
  },
  # --- Coming soon (skeleton repos) ---
  @{ slug='hr'; folder='hr'; pretty='Hr'; category='coming-soon'; status='soon'
     pageId=$null
     navName='Human Resources'; title='Human Resources'; icon='&#128101;'
     tagline='Coming soon &mdash; staff onboarding, time-off, performance reviews, and HR document control on the same Dataverse tenant.'
     what='Planned HR module covering employee onboarding, time-off requests and balances, performance reviews, training records, and HR document control. Reserved repo (<code>HR_</code> publisher prefix) with DevDocs in place; build kicks off after the <code>MPP_Shared_People</code> boundary lands.'
     who='Internal HR and people-ops leads at affordable-housing nonprofits standardizing on the Power Platform suite for both program work and back-office.'
     detail='<p style="color:#444;"><strong>Status:</strong> Reserved skeleton repo following the suite&rsquo;s standard layering (<code>HR_Core / HR_DataLayer / HR_Application / HR_UI</code>). No Dataverse solution shipped yet.</p>'
  },
  @{ slug='lms'; folder='lms'; pretty='Lms'; category='coming-soon'; status='soon'
     pageId=$null
     navName='Learning Management'; title='Learning Management'; icon='&#127891;'
     tagline='Coming soon &mdash; training catalog, course completions, certifications, and CEU tracking for staff and partner agencies.'
     what='Planned LMS module covering course catalog, instructor scheduling, learner enrollment, attendance and completion tracking, certification issuance and expiry alerts, and CEU tracking. Will share the same constituent contact record used by Homebuyer Education and Volunteer Management.'
     who='Training and capacity-building teams delivering staff certifications, partner-agency trainings, and continuing-ed credit programs.'
     detail='<p style="color:#444;"><strong>Status:</strong> Reserved skeleton repo (<code>LMS_</code> prefix). Will sit alongside Homebuyer Education and reuse class/roster patterns proven there.</p>'
  },
  @{ slug='plan-manager'; folder='plan-manager'; pretty='PlanManager'; category='coming-soon'; status='soon'
     pageId=$null
     navName='Plan Manager'; title='Plan Manager'; icon='&#128202;'
     tagline='Coming soon &mdash; strategic plan, outcomes, KPIs, and quarterly progress tracking woven through every module.'
     what='Planned strategic-planning module: organizational strategic plan and goals, outcomes and KPIs tied to specific programs, quarterly check-ins, board reporting, and roll-up dashboards that pull live numbers from Homebuyer Education, DPA, HRRP, Fundraising, Grants, and Volunteers.'
     who='Executive directors, board chairs, and program directors who currently track strategic plans in slide decks and want them living next to the operational data.'
     detail='<p style="color:#444;"><strong>Status:</strong> Reserved skeleton repo (<code>PlanManager_</code> prefix). Will be the cross-cutting outcomes layer over the operational modules.</p>'
  }
)

# --- Categories: ordered for display ---
$categoryMeta = @(
  @{ key='programs';     title='Housing programs';            blurb='Direct-service modules that touch homeowners, applicants, and rehab projects every day.' }
  @{ key='operations';   title='Back-office operations';      blurb='Finance, procurement, and place data that keep the programs running and the audits clean.' }
  @{ key='engagement';   title='Fundraising and engagement';  blurb='Donors, grants, volunteers, and the bulk communications that connect the suite to its community.' }
  @{ key='coming-soon';  title='On the roadmap';              blurb='Reserved repos with the standard layering already declared. Build starts as soon as the Tier&nbsp;1 boundaries land.' }
)

# --- Helper: write text as UTF-8 (no BOM), no trailing newline corruption ---
function Write-Utf8NoBom([string]$path, [string]$text) {
  $full = [System.IO.Path]::GetFullPath($path)
  [System.IO.File]::WriteAllText($full, $text, (New-Object System.Text.UTF8Encoding $false))
}

# --- Step 1: pin pageIds from existing on-disk yml first (so we never create duplicates) ---
foreach ($m in $modules) {
  $rootYmlPath = "$rootPages/$($m.folder)/$($m.pretty).webpage.yml"
  if ((-not $m.pageId) -and (Test-Path $rootYmlPath)) {
    $rawY = Get-Content $rootYmlPath -Raw
    if ($rawY -match 'adx_webpageid:\s*([0-9a-fA-F-]{36})') { $m.pageId = $Matches[1] }
  }
}
$missingCount = 0
foreach ($m in $modules) {
  if (-not $m.pageId) {
    $rootGuid    = [guid]::NewGuid().ToString()
    $contentGuid = [guid]::NewGuid().ToString()
    $rootFolder    = "$rootPages/$($m.folder)"
    $contentFolder = "$rootFolder/content-pages"
    New-Item -ItemType Directory -Force -Path $contentFolder | Out-Null

    $rootYml = @"
adx_displayorder: 50
adx_enablerating: false
adx_enabletracking: false
adx_excludefromsearch: false
adx_feedbackpolicy: 756150000
adx_hiddenfromsitemap: true
adx_isroot: true
adx_name: $($m.pretty)
adx_pagetemplateid: $pageTemplateId
adx_parentpageid: $homeId
adx_partialurl: $($m.slug)
adx_publishingstateid: $publishingId
adx_sharedpageconfiguration: false
adx_title: $($m.title)
adx_webpageid: $rootGuid
"@
    Write-Utf8NoBom "$rootFolder/$($m.pretty).webpage.yml" $rootYml
    Write-Utf8NoBom "$rootFolder/$($m.pretty).webpage.copy.html" ''
    Write-Utf8NoBom "$rootFolder/$($m.pretty).webpage.summary.html" ''
    Write-Utf8NoBom "$rootFolder/$($m.pretty).webpage.custom_css.css" ''
    Write-Utf8NoBom "$rootFolder/$($m.pretty).webpage.custom_javascript.js" ''

    $contentYml = @"
adx_displayorder: 50
adx_enablerating: false
adx_enabletracking: false
adx_excludefromsearch: false
adx_feedbackpolicy: 756150000
adx_hiddenfromsitemap: true
adx_isroot: false
adx_name: $($m.pretty)
adx_pagetemplateid: $pageTemplateId
adx_parentpageid: $homeId
adx_partialurl: $($m.slug)
adx_publishingstateid: $publishingId
adx_rootwebpageid: $rootGuid
adx_sharedpageconfiguration: false
adx_title: $($m.title)
adx_webpageid: $contentGuid
adx_webpagelanguageid: $languageId
"@
    Write-Utf8NoBom "$contentFolder/$($m.pretty).en-US.webpage.yml" $contentYml
    Write-Utf8NoBom "$contentFolder/$($m.pretty).en-US.webpage.summary.html" ''
    Write-Utf8NoBom "$contentFolder/$($m.pretty).en-US.webpage.custom_css.css" ''
    Write-Utf8NoBom "$contentFolder/$($m.pretty).en-US.webpage.custom_javascript.js" ''

    $m.pageId = $rootGuid
    Write-Host "  + created page records for $($m.title) (root=$rootGuid)"
    $missingCount++
  }
}
Write-Host "Step 1 done: created $missingCount new module page records."

# --- Step 2: rewrite content-page HTML for every module (shared template) ---
foreach ($m in $modules) {
  $copyPath = "$rootPages/$($m.folder)/content-pages/$($m.pretty).en-US.webpage.copy.html"
  $soonBadge = ''
  if ($m.status -eq 'soon') {
    $soonBadge = '<span style="display:inline-block;background:#fff3cd;color:#856404;font-size:.78rem;font-weight:600;padding:3px 10px;border-radius:99px;margin-left:8px;vertical-align:middle;border:1px solid #ffeeba;">Coming soon</span>'
  }
  $copy = @"
<div class="row sectionBlockLayout text-center" style="display:flex;flex-wrap:wrap;margin:0;padding:56px 8px 24px;background:#ffffff;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <p style="margin:0 0 8px;"><a href="/" style="color:#1F66B5;text-decoration:none;">&larr; Affordable Housing Nonprofit Suite</a></p>
      <div style="font-size:3.25rem;line-height:1;margin:8px 0;">$($m.icon)</div>
      <h1 style="margin:0 0 10px;color:#1F66B5;">$($m.title)$soonBadge</h1>
      <p style="font-size:1.18rem;max-width:800px;margin:0 auto;color:#555;">$($m.tagline)</p>
    </div>
  </div>
</div>

<div class="row sectionBlockLayout text-start" style="display:flex;flex-wrap:wrap;margin:0;padding:24px 8px 64px;background:#f7f8fa;">
  <div class="container" style="padding:0;">
    <div class="col-lg-8 columnBlockLayout" style="margin:0 auto;max-width:860px;background:#fff;border:1px solid #e3e3e3;border-radius:8px;padding:36px;">

      <h2 style="color:#7A6A65;margin:0 0 12px;">What this module does</h2>
      <p style="color:#444;line-height:1.6;">$($m.what)</p>

      <h2 style="color:#7A6A65;margin:28px 0 12px;">Who it&rsquo;s for</h2>
      <p style="color:#444;line-height:1.6;">$($m.who)</p>

      $($m.detail)

      <h2 style="color:#7A6A65;margin:28px 0 12px;">Built on</h2>
      <p style="color:#444;line-height:1.6;">Microsoft Power Platform &mdash; Dataverse for the data and security model, model-driven apps for staff, Power Automate for workflows, Power Pages for constituent self-service, and <strong>Copilot Studio agents wired through the native Dataverse MCP server</strong> so frontier AI models can read and act on the same records the staff are looking at.</p>

      <p style="margin-top:36px;text-align:center;">
        <a href="/" style="display:inline-block;background:#1F66B5;color:#fff;padding:12px 24px;border-radius:6px;text-decoration:none;font-weight:600;">&larr; Back to all modules</a>
      </p>
    </div>
  </div>
</div>
"@
  Write-Utf8NoBom $copyPath $copy
}
Write-Host "Step 2 done: rewrote content-page HTML for all $($modules.Count) modules."

# --- Step 3: rewrite Home page (frontier/AI-first hero + categorized tile grid + AI capabilities + CTA) ---
function Tile-Html($m) {
  $borderColor = if ($m.status -eq 'soon') { '#bdbdbd' } else { '#1F66B5' }
  $opacity     = if ($m.status -eq 'soon') { '0.85' } else { '1' }
  $titleSuffix = if ($m.status -eq 'soon') { ' <span style="display:inline-block;font-size:.7rem;font-weight:600;background:#fff3cd;color:#856404;padding:2px 8px;border-radius:99px;border:1px solid #ffeeba;vertical-align:middle;">soon</span>' } else { '' }
  return @"
        <a href="/$($m.slug)/" style="text-decoration:none;color:inherit;flex:1 1 280px;max-width:340px;opacity:$opacity;">
          <div style="border:1px solid #e3e3e3;border-top:4px solid $borderColor;border-radius:8px;padding:22px;height:100%;background:#fff;box-shadow:0 1px 3px rgba(0,0,0,.06);">
            <div style="font-size:2rem;line-height:1;margin-bottom:10px;">$($m.icon)</div>
            <h3 style="margin:0 0 6px;color:#1F66B5;font-size:1.1rem;">$($m.navName)$titleSuffix</h3>
            <p style="margin:0;color:#444;font-size:.92rem;line-height:1.5;">$($m.tagline)</p>
          </div>
        </a>
"@
}

$homeSb = New-Object System.Text.StringBuilder
[void]$homeSb.AppendLine(@"
<div class="row sectionBlockLayout text-center" style="display:flex;flex-wrap:wrap;margin:0;padding:64px 8px 24px;background:#ffffff;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <img src="/mpp-logo.png" alt="Max Power Platform" style="max-width:480px;width:80%;height:auto;margin:0 auto 28px;display:block;" />
      <p style="margin:0 0 10px;"><span style="display:inline-block;background:#e8f1fb;color:#1F66B5;font-weight:600;font-size:.85rem;letter-spacing:.04em;text-transform:uppercase;padding:6px 14px;border-radius:99px;">Frontier-first &middot; AI-first</span></p>
      <h1 style="margin:0 0 12px;color:#1F66B5;font-weight:700;">Affordable Housing Nonprofit Suite</h1>
      <p style="font-size:1.2rem;max-width:880px;margin:0 auto 8px;color:#444;">A frontier-first, AI-first platform for nonprofit housing agencies &mdash; $($modules.Count) connected modules built on Microsoft Power Platform that deliver homebuyer education, down payment assistance, home repair, construction and property management, and the fundraising, grants, volunteer, and back-office work that surrounds them.</p>
      <p style="font-size:1rem;max-width:780px;margin:8px auto 0;color:#666;">Dataverse + model-driven apps + Power Pages + <strong>Copilot Studio agents wired through the native Dataverse MCP server</strong> &mdash; one platform, one constituent record, one set of reports, with frontier AI models acting on the same data the staff see.</p>
    </div>
  </div>
</div>
"@)

# Tile sections by category
foreach ($cat in $categoryMeta) {
  $bg = if ($cat.key -eq 'coming-soon') { '#f1f3f5' } else { '#f7f8fa' }
  $catModules = @($modules | Where-Object { $_.category -eq $cat.key })
  if ($catModules.Count -eq 0) { continue }
  [void]$homeSb.AppendLine(@"

<div id="$($cat.key)" class="row sectionBlockLayout text-start" style="display:flex;flex-wrap:wrap;margin:0;padding:48px 8px 24px;background:$bg;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <h2 style="text-align:center;margin:0 0 6px;color:#7A6A65;">$($cat.title)</h2>
      <p style="text-align:center;color:#666;margin:0 auto 28px;max-width:760px;">$($cat.blurb)</p>
      <div class="row" style="display:flex;flex-wrap:wrap;gap:18px;justify-content:center;">
"@)
  foreach ($m in $catModules) {
    [void]$homeSb.AppendLine((Tile-Html $m))
  }
  [void]$homeSb.AppendLine(@"
      </div>
    </div>
  </div>
</div>
"@)
}

# Footer CTA — contact form that creates a Lead via Power Pages Web API
[void]$homeSb.AppendLine(@"

<div id="get-in-touch" class="row sectionBlockLayout text-start" style="display:flex;flex-wrap:wrap;margin:0;padding:56px 8px 64px;background:#ffffff;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <div style="max-width:720px;margin:0 auto;background:#f7f8fa;border:1px solid #e3e3e3;border-radius:10px;padding:32px;">
        <h2 style="text-align:center;margin:0 0 6px;color:#1F66B5;">Get in touch</h2>
        <p style="text-align:center;color:#666;margin:0 0 24px;">Tell us about your housing nonprofit need. A real person responds &mdash; usually same-day.</p>

        <form id="leadForm" novalidate>
          <div style="display:flex;flex-wrap:wrap;gap:14px;">
            <label style="flex:1 1 240px;font-size:.9rem;color:#444;">First name *
              <input name="firstname" required style="width:100%;padding:10px;border:1px solid #ccc;border-radius:6px;font-size:1rem;margin-top:4px;" />
            </label>
            <label style="flex:1 1 240px;font-size:.9rem;color:#444;">Last name *
              <input name="lastname" required style="width:100%;padding:10px;border:1px solid #ccc;border-radius:6px;font-size:1rem;margin-top:4px;" />
            </label>
          </div>
          <div style="display:flex;flex-wrap:wrap;gap:14px;margin-top:14px;">
            <label style="flex:1 1 240px;font-size:.9rem;color:#444;">Email *
              <input name="emailaddress1" type="email" required style="width:100%;padding:10px;border:1px solid #ccc;border-radius:6px;font-size:1rem;margin-top:4px;" />
            </label>
            <label style="flex:1 1 240px;font-size:.9rem;color:#444;">Organization
              <input name="companyname" style="width:100%;padding:10px;border:1px solid #ccc;border-radius:6px;font-size:1rem;margin-top:4px;" />
            </label>
          </div>
          <div style="display:flex;flex-wrap:wrap;gap:14px;margin-top:14px;">
            <label style="flex:1 1 240px;font-size:.9rem;color:#444;">Phone
              <input name="telephone1" type="tel" style="width:100%;padding:10px;border:1px solid #ccc;border-radius:6px;font-size:1rem;margin-top:4px;" />
            </label>
            <label style="flex:1 1 240px;font-size:.9rem;color:#444;">Subject *
              <input name="subject" required value="Website inquiry" style="width:100%;padding:10px;border:1px solid #ccc;border-radius:6px;font-size:1rem;margin-top:4px;" />
            </label>
          </div>
          <label style="display:block;margin-top:14px;font-size:.9rem;color:#444;">Message *
            <textarea name="description" required rows="5" style="width:100%;padding:10px;border:1px solid #ccc;border-radius:6px;font-size:1rem;margin-top:4px;font-family:inherit;"></textarea>
          </label>
          <div style="margin-top:18px;text-align:center;">
            <button type="submit" id="leadSubmit" style="display:inline-block;background:#1F66B5;color:#fff;padding:12px 32px;border:0;border-radius:6px;font-weight:600;font-size:1rem;cursor:pointer;">Send message</button>
          </div>
          <p id="leadStatus" role="status" style="margin:16px 0 0;text-align:center;font-size:.95rem;"></p>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
(function(){
  var form = document.getElementById('leadForm');
  if (!form) return;
  var status = document.getElementById('leadStatus');
  var btn = document.getElementById('leadSubmit');

  function getToken(){
    return fetch('/_layout/tokenhtml', { credentials: 'same-origin' })
      .then(function(r){ return r.text(); })
      .then(function(html){
        var m = html.match(/value="([^"]+)"/);
        return m ? m[1] : '';
      });
  }

  form.addEventListener('submit', function(e){
    e.preventDefault();
    if (!form.reportValidity()) return;
    btn.disabled = true;
    status.style.color = '#444';
    status.textContent = 'Sending...';

    var data = {};
    new FormData(form).forEach(function(v,k){ if (v) data[k] = v; });

    getToken().then(function(token){
      return fetch('/_api/leads', {
        method: 'POST',
        credentials: 'same-origin',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          '__RequestVerificationToken': token
        },
        body: JSON.stringify(data)
      });
    }).then(function(r){
      if (r.ok) {
        status.style.color = '#1a7f37';
        status.textContent = 'Thanks! We received your message and will be in touch shortly.';
        form.reset();
      } else {
        return r.text().then(function(t){
          status.style.color = '#b32525';
          status.textContent = 'Sorry, the form could not be submitted. You can also email max@maxpowerplatform.com.';
          console.error('Lead create failed:', r.status, t);
        });
      }
    }).catch(function(err){
      status.style.color = '#b32525';
      status.textContent = 'Network error. Please try again or email max@maxpowerplatform.com.';
      console.error(err);
    }).finally(function(){ btn.disabled = false; });
  });
})();
</script>
"@)

Write-Utf8NoBom "$rootPages/home/content-pages/Home.en-US.webpage.copy.html" $homeSb.ToString()
Write-Host "Step 3 done: rewrote Home with $($modules.Count) modules in $($categoryMeta.Count) categories + AI-first section."

# --- Step 4: rewrite the primary nav weblink set as Home + 4 category dropdowns ---
$navPath = 'src/portal/mpp2---mpp2/weblink-sets/default/Default.en-US.weblinkset.weblink.yml'
$existingByPage = @{}
if (Test-Path $navPath) {
  $raw = Get-Content $navPath -Raw
  $blocks = ($raw -split '(?m)^- ') | Where-Object { $_ -match 'adx_pageid' }
  foreach ($b in $blocks) {
    if ($b -match 'adx_pageid:\s*([0-9a-fA-F-]{36})') {
      $pgid = $Matches[1]
      if ($b -match 'adx_weblinkid:\s*([0-9a-fA-F-]{36})') { $existingByPage[$pgid] = $Matches[1] }
    }
  }
}

# Stable parent GUIDs (do not change — used for the 4 category dropdowns)
$parentIds = @{
  'programs'    = 'aa000001-0000-4000-8000-000000000001'
  'operations'  = 'aa000002-0000-4000-8000-000000000002'
  'engagement'  = 'aa000003-0000-4000-8000-000000000003'
  'coming-soon' = 'aa000004-0000-4000-8000-000000000004'
}
$parentLabels = @{
  'programs'    = 'Programs'
  'operations'  = 'Operations'
  'engagement'  = 'Engagement'
  'coming-soon' = 'Roadmap'
}
$parentOrder = @('programs','operations','engagement','coming-soon')

$navLines = New-Object System.Collections.Generic.List[string]
function Add-WL {
  param(
    [string]$name, [int]$order, [string]$wid,
    [string]$pageId = '', [string]$parentId = '', [string]$externalUrl = ''
  )
  $navLines.Add('- adx_disablepagevalidation: false')
  $navLines.Add('  adx_displayimageonly: false')
  $navLines.Add("  adx_displayorder: $order")
  $navLines.Add('  adx_displaypagechildlinks: false')
  $navLines.Add("  adx_name: $name")
  $navLines.Add('  adx_openinnewwindow: false')
  if ($pageId)      { $navLines.Add("  adx_pageid: $pageId") }
  if ($parentId)    { $navLines.Add("  adx_parentweblinkid: $parentId") }
  $navLines.Add("  adx_publishingstateid: $publishingId")
  $navLines.Add('  adx_robotsfollowlink: true')
  if ($externalUrl) { $navLines.Add("  adx_externalurl: $externalUrl") }
  $navLines.Add("  adx_weblinkid: $wid")
  $navLines.Add("  adx_weblinksetid: $weblinkSetId")
}

# Top-level: Home
Add-WL -name 'Home' -order 1 -wid $homeWebLinkId -pageId $homeId

# Top-level: 4 category parents (no page, just labels with children)
$top = 2
foreach ($key in $parentOrder) {
  Add-WL -name $parentLabels[$key] -order $top -wid $parentIds[$key] -externalUrl '#'
  $top++
}

# Children: each module under its category parent
$childOrders = @{ 'programs'=1; 'operations'=1; 'engagement'=1; 'coming-soon'=1 }
foreach ($m in $modules) {
  $wid = if ($existingByPage.ContainsKey($m.pageId)) { $existingByPage[$m.pageId] } else { [guid]::NewGuid().ToString() }
  $co = $childOrders[$m.category]
  Add-WL -name $m.navName -order $co -wid $wid -pageId $m.pageId -parentId $parentIds[$m.category]
  $childOrders[$m.category] = $co + 1
}

Write-Utf8NoBom $navPath ($navLines -join "`n")
Write-Host "Step 4 done: nav has Home + $($parentOrder.Count) category dropdowns containing $($modules.Count) child links."

# --- Step 5: rewrite Footer snippet link row to span all categories ---
$footerLinks = ($modules | ForEach-Object { "      <a href=`"/$($_.slug)/`">$($_.navName)</a>" }) -join " &middot;`n"
$footerHtml = @"
<style>
  footer.footer { background-color: #1A4F8C !important; padding-top: 0 !important; padding-bottom: 0 !important; color: #ffffff !important; }
  footer.footer .footer-bottom { background-color: #1A4F8C !important; padding: 28px 0 !important; }
  footer.footer .container { color: #ffffff; }
  .mpp-footer-card a { color: #cfe1f5 !important; text-decoration: none; }
  .mpp-footer-card a:hover { color: #ffffff !important; text-decoration: underline; }
</style>
<div class="mpp-footer-card" style="display:flex;flex-wrap:wrap;gap:24px;align-items:flex-start;justify-content:space-between;">
  <div style="flex:1 1 320px;">
    <p style="margin:0;font-weight:600;color:#ffffff;font-size:1.05rem;">Affordable Housing Nonprofit Suite</p>
    <p style="margin:4px 0 0;color:#cfe1f5;font-size:.95rem;">Frontier-first, AI-first &mdash; built on Microsoft Power Platform with Copilot Studio agents and the native Dataverse MCP server.</p>
  </div>
  <div style="flex:2 1 480px;text-align:right;">
    <p class="smallText" style="margin:0;color:#cfe1f5;">Copyright &copy; <span id="year"></span> Max Power Platform. All rights reserved.</p>
    <p style="margin:8px 0 0;font-size:.85rem;line-height:1.8;">
$footerLinks
    </p>
  </div>
</div>
<script>
  document.getElementById('year').innerHTML = new Date().getFullYear();
</script>
"@
Write-Utf8NoBom 'src/portal/mpp2---mpp2/content-snippets/footer/Footer.en-US.contentsnippet.value.html' $footerHtml
Write-Host "Step 5 done: footer link row rebuilt with $($modules.Count) module links."

Write-Host "`nALL STEPS COMPLETE. Now run:  pac auth select --index 2 ; pac pages upload --path src/portal/mpp2---mpp2 --modelVersion 2"
