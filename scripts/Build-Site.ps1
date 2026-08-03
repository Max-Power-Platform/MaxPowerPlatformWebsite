#requires -Version 7
<#
  Build-Site.ps1
  Single source of truth for the public marketing site.
  - Defines Managed M365 service + all suite modules in 4 categories
  - Creates page records (root + content) for any module/service that doesn't have one yet
  - Rewrites every module's content-page HTML using a shared template
  - Rewrites the M365 service page
  - Rewrites the Home page (M365 hero + suite hero + categorized tile grid + contact form)
  - Rewrites the primary nav weblink set (Managed M365 + Home + 4 category dropdowns)
  - Rewrites the Footer snippet link row
#>

$ErrorActionPreference = 'Stop'
Set-Location (Split-Path -Parent $PSScriptRoot)
[System.IO.Directory]::SetCurrentDirectory($PWD.Path)  # sync .NET working dir with PS location

# --- Constants pulled from existing portal export ---
$rootPages      = 'src/portal/mpp2---mpp2/web-pages'
$pageTemplateId = '383840f8-ed48-4d41-ab6c-bf5cd0d7ef21'
$publishingId   = 'eb607d5d-29cd-4e84-b47d-3bf053b90cb2'
$languageId     = '616149d4-cf5f-4127-bf22-ac929aaf11e2'
$homeId         = 'e600cd70-cdf2-4226-99de-5295c93fa12a'
$weblinkSetId   = '9b44a949-a98d-4969-afd9-8569b33f7829'
$homeWebLinkId  = '120e8f8c-3b45-4197-bdfd-36118d26332f'
$m365WebLinkId  = 'aa000005-0000-4000-8000-000000000005'

# --- Helper: write text as UTF-8 (no BOM), no trailing newline corruption ---
function Write-Utf8NoBom([string]$path, [string]$text) {
  $full = [System.IO.Path]::GetFullPath($path)
  [System.IO.File]::WriteAllText($full, $text, (New-Object System.Text.UTF8Encoding $false))
}

# --- Web-file helper: ensure YAML record exists (JS/CSS are hand-authored in web-files) ---
function Update-WebFile([string]$name, [string]$mimeType, [string]$sourcePath) {
  $destFolder = 'src/portal/mpp2---mpp2/web-files'
  $destPath   = "$destFolder/$name"
  $ymlPath    = "$destPath.webfile.yml"
  # Only copy if source is different from dest (no-op for hand-authored files already in web-files)
  $srcAbs = [System.IO.Path]::GetFullPath($sourcePath)
  $dstAbs = [System.IO.Path]::GetFullPath($destPath)
  if ($srcAbs -ne $dstAbs) { Copy-Item $sourcePath $destPath -Force | Out-Null }
  if (-not (Test-Path $ymlPath)) {
    $webfileId    = [guid]::NewGuid().ToString()
    $annotationId = [guid]::NewGuid().ToString()
    $yml = @"
adx_contentdisposition: 756150000
adx_enabletracking: false
adx_excludefromsearch: false
adx_hiddenfromsitemap: false
adx_name: $name
adx_parentpageid: $homeId
adx_partialurl: $name
adx_publishingstateid: $publishingId
adx_webfileid: $webfileId
filename: $name
isdocument: true
mimetype: $mimeType
objectid: $webfileId
objecttypecode: adx_webfile
annotationid: $annotationId
"@
    Write-Utf8NoBom $ymlPath $yml
    Write-Host "  + created web-file record for $name"
  }
}

# --- Step 0: ensure web-file YAML records exist for OS diagram (JS+CSS are hand-authored) ---
Write-Host "Step 0: checking OS web-file records..."
Update-WebFile -name 'mpp-os.js' -mimeType 'text/javascript' -sourcePath 'src/portal/mpp2---mpp2/web-files/mpp-os.js'
Update-WebFile -name 'mpp-os.css' -mimeType 'text/css' -sourcePath 'src/portal/mpp2---mpp2/web-files/mpp-os.css'
Write-Host "Step 0 done."

# --- Managed Microsoft 365 service (separate from suite modules) ---
$m365Service = @{
  slug='m365'; folder='m365'; pretty='M365'; category='m365'
  pageId=$null
  navName='Managed M365'; title='Managed Microsoft 365 for Nonprofits'; icon='&#9729;'
  badge='Frontier-first &middot; Secure-first'
  p1='Professional email, files, phones, security, and device management on one platform &mdash; managed for you so you don&rsquo;t need an IT hire. Replaces Zoom, Dropbox, antivirus, and phone systems with one vendor and one bill. New starter up in minutes. Leaver off in one click.'
  p2='Business Premium + conditional access + Defender for Endpoint + Purview data loss prevention + Copilot Chat &mdash; enterprise-grade security and AI that used to be reserved for companies with a thousand seats, managed and monitored by a team that knows your nonprofit.'
  bullets=@('Business email, Teams, phone, and 1 TB storage per person','MFA + conditional access + endpoint protection','Copilot Chat with enterprise data protection','One vendor, one bill, one place to manage')
  what='Managed Microsoft 365 for nonprofits delivers professional IT without an IT hire. We configure and monitor your Microsoft 365 tenant from day one: Entra ID identity, conditional access, multi-factor authentication, Defender for Endpoint on every device, Purview data loss prevention, and Copilot Chat with enterprise data protection. New staff are fully provisioned in minutes; departing staff are offboarded in one click.'
  who='Nonprofits that need professional IT without an IT hire. Small teams that want enterprise security. Organizations switching from Google Workspace, Dropbox, or Zoom. Startups building their IT foundation deliberately from day one.'
  detail='<h3 style="color:#7A6A65;margin:24px 0 8px;">What&rsquo;s included</h3><ul style="color:#444;line-height:1.7;"><li>Professional email on your domain with 100 GB mailbox</li><li>Teams for chat, video, and business phone</li><li>1 TB cloud storage per person</li><li>Multi-factor authentication + conditional access</li><li>Defender for Endpoint on every device</li><li>Purview data loss prevention</li><li>Copilot Chat with enterprise data protection</li><li>SPF, DKIM, and DMARC configuration</li><li>Immutable audit trail on admin actions</li><li>Automated onboarding and offboarding workflows</li></ul><p style="color:#444;"><strong>Built on:</strong> Microsoft 365 Business Premium + Microsoft Graph + Azure Durable Functions + Dataverse + Power Platform &mdash; managed and monitored by Max Power Platform.</p>'
}

# --- M365 tiles that appear only on the Home page ---
$m365Tiles = @(
  @{ icon='&#128274;'; title='Enterprise Security & Compliance'; summary='Lock down every account, device, and email.'; bullets=@('MFA + conditional access on every sign-in','Defender for Endpoint on every laptop, tablet, and phone','Purview DLP catches SSN, card, and bank numbers before they leave') },
  @{ icon='&#127970;'; title='One Platform, One Bill'; summary='Replace Zoom, Dropbox, antivirus, and phone systems with one vendor.'; bullets=@('Business email, Teams chat/video/phone, and 1 TB per person','New starter provisioned in minutes','Leaver offboarded in one click') },
  @{ icon='&#129302;'; title='AI Built In'; summary='Frontier AI inside your work account.'; bullets=@('Copilot Chat answers questions and reads contracts','Word, Excel, and PowerPoint agents from a description','Your prompts and data never train models') },
  @{ icon='&#128203;'; title='Startup IT Foundation'; summary='Tenant built correctly from day one.'; bullets=@('Domain, identity, and single sign-on configured','Password manager and security policies','SPF, DKIM, and DMARC so invoices land in inboxes') },
  @{ icon='&#128737;'; title='Protecting Personal Data'; summary='PII is found before it leaves the tenant.'; bullets=@('Detects SSN, cards, bank details, passports, and licenses','Warn, encrypt, or block before send','Breach-notification readiness for every state') }
)

# --- All suite modules (existing pageIds preserved, new ones get fresh GUIDs at runtime) ---
$modules = @(
  # --- Programs ---
  @{ slug='hbe'; folder='hbe'; pretty='Hbe'; category='programs'; status='live'
     pageId='0e9aa125-8701-4c1b-8836-346e31aebad4'
     navName='Homebuyer Education'; title='Homebuyer Education'; icon='&#127968;'
     tagline='HUD-style classes, 1:1 counseling, education lock-in, and certificate issuance. HUD-9902 compliant reporting built in. Electronic signatures. One console your counselors, educators, and directors all use &mdash; the front door to every assistance program.'
     summary='HUD-style homebuyer education and counseling in one console.'
     bullets=@('Online intake, e-signature, and class scheduling','Attendance tracking and auto-issued certificates','HUD-9902 reporting built in')
     what='The HBE Console delivers the full housing counseling lifecycle &mdash; intake, financial assessment, education classes, 1:1 counseling, and HUD-9902 ARM reporting. Clients apply online and sign electronically. Staff schedule in-person and virtual classes with capacity management. Attendance is tracked per person, certificates issue automatically, and every step is auditable.'
     who='HUD-approved housing counseling agencies, nonprofit homebuyer education providers, and any organization required to deliver pre-purchase education before disbursing assistance funds.'
     detail='<p style="color:#444;"><strong>Why it matters for affordable housing:</strong> Most state and federal down payment programs &mdash; including Florida SHIP and HUD HOME &mdash; require borrowers to complete a HUD-certified homebuyer education workshop <em>before</em> closing. Homebuyer Education is the system of record that proves it.</p><p style="color:#444;"><strong>Connected to:</strong> The same contact record flows into Down Payment Assistance, so a household&rsquo;s class completion is one click from their loan application.</p>'
  },
  @{ slug='dpa'; folder='dpa'; pretty='Dpa'; category='programs'; status='live'
     pageId='e7cb8f63-e495-4d98-bb8b-ad6c0ccdde2e'
     navName='Down Payment Assistance'; title='Down Payment Assistance'; icon='&#128176;'
     tagline='SHIP, HOME, and HTF-funded purchase assistance &mdash; applications, underwriting, awards, closings, liens, and HUD reporting. Multi-jurisdiction and multi-funding-source support. Real-time financial calculations.'
     summary='End-to-end purchase-assistance loan administration.'
     bullets=@('Multi-jurisdiction and multi-funding-source programs','Income verification, AMI calc, and underwriting flow','Liens, closings, payoffs, and HUD reporting')
     what='End-to-end administration of down payment assistance loan programs. Online intake, household income verification, AMI calculation, underwriting business process flow, award letters, closing tab, lien tracking, payoff/satisfaction, and reporting. Built on Dataverse with a React/TypeScript DPA Console SPA for staff and a constituent portal for applicants.'
     who='HUD-approved nonprofit housing agencies and CDFIs administering federal/state-funded purchase assistance &mdash; for example, the City of Clearwater Home Purchase Assistance Program (SHIP/HOME) is delivered through approved nonprofit housing agencies.'
     detail='<h3 style="color:#7A6A65;margin:24px 0 8px;">Real-world example: City of Clearwater SHIP DPA</h3><p style="color:#444;">Clearwater&rsquo;s SHIP-funded program (loans up to $75,000 for purchases approved after July&nbsp;1,&nbsp;2025) is a representative DPA workflow this module supports:</p><ul style="color:#444;line-height:1.7;"><li>50% amortized over 20 years (payments deferred 5 years), 50% deferred &amp; forgiven at maturity</li><li>Household income test against AMI; all members 18+ counted</li><li>Borrower must complete a HUD-certified homebuyer education workshop (handled by the <a href="/hbe/" style="color:#1F66B5;">Homebuyer Education</a> module)</li><li>Borrower contributes 1% from own funds; primary residence; lead-paint/code requirements</li><li>Application submitted through an approved nonprofit housing agency</li><li>Lien recorded; full balance due on sale before maturity unless hardship rules apply</li></ul><p style="color:#444;"><em>The DPA module captures every one of those rules as configurable program parameters, business process stages, and validation rules &mdash; so a single deployment can serve multiple funding sources (SHIP, HOME, ARPA, HTF, county-specific) without code changes.</em></p>'
  },
  @{ slug='cms'; folder='cms'; pretty='Cms'; category='programs'; status='live'
     pageId=$null
     navName='Construction Management'; title='Construction Management System'; icon='&#127959;'
     tagline='Construction project management &mdash; proformas, deals, development tracking, draws, time tracking, payment approvals, and document control. Three purpose-built consoles. AI agent alongside your project managers. SharePoint document control.'
     summary='Construction delivery from proforma to final draw.'
     bullets=@('Proforma, deal, and development consoles','Time tracking, draw approvals, and payment control','AI agent and SharePoint document control')
     what='The Construction Management System runs the full lifecycle &mdash; from land acquisition and proforma through construction contracting, budgeting, draws, and payment approvals. Three dedicated consoles: a Construction Management app for project managers, a Contracts app for architectural plans and vendor approvals, and Outlook integration for field access. ProformaAgent &mdash; a Copilot Studio AI agent &mdash; works alongside your project managers directly on the property form. SharePoint document control with full taxonomy.'
     who='Affordable-housing developers, community development corporations (CDCs), and program managers running new-construction or rehab portfolios alongside their direct-service programs.'
     detail='<p style="color:#444;"><strong>Built around three consoles:</strong> Proforma Console (financial feasibility), Deal Console (acquisition / closing pipeline), and Dev Console (construction delivery and draws). Owns shared finance tables &mdash; <code>mpp_constructionpaymentapproval</code> and <code>mpp_timetracking</code> &mdash; so spend rolls up into Accounts Payable cleanly.</p>'
  },
  @{ slug='property-management'; folder='property-management'; pretty='PropertyManagement'; category='programs'; status='live'
     pageId=$null
     navName='Property Management'; title='Property Management'; icon='&#127977;'
     tagline='Real-estate portfolio, units, tenants, leases, and rent rolls in one console. Vacancy and turn-time metrics. Florida-specific lease notices. Tenant self-service portal. Work order management.'
     summary='Portfolio, units, tenants, leases, and work orders in one place.'
     bullets=@('Vacancy and turn-time dashboards','Florida-specific lease notices','Tenant self-service portal and rent collection')
     what='The Property Management Platform handles the full residential real-estate lifecycle &mdash; portfolio tracking, rental applications, tenant onboarding, lease administration, rent collection, maintenance case management, and vendor bill processing. Staff work in a model-driven back-office app. Tenants have a self-service Power Pages portal to apply, pay rent, and request maintenance. Florida-specific lease notices.'
     who='Affordable-housing nonprofits that own, manage, or operate rental units &mdash; including community land trusts, lease-purchase programs, and transitional / supportive housing operators.'
     detail='<p style="color:#444;"><strong>Targeted layering:</strong> <code>PM_Core / PM_DataLayer / PM_Application / PM_UI</code>, with shared boundary tables (<code>mpp_application*</code>, <code>mpp_employment</code>, <code>mpp_documentupload</code>, <code>mpp_tenant</code>) moving into <code>MPP_Shared_*</code> so Property Management, DPA, and HBE all reference the same family records.</p>'
  },
  # --- Operations ---
  @{ slug='accounts-payable'; folder='accounts-payable'; pretty='AccountsPayable'; category='operations'; status='live'
     pageId=$null
     navName='Accounts Payable'; title='Accounts Payable'; icon='&#129534;'
     tagline='AI reads your invoices &mdash; PDFs, images, and emails &mdash; and extracts the data automatically. QuickBooks Online syncs live. Approval workflows in Teams. One dashboard for everything your AP team touches &mdash; built on the shared <code>mpp_bill</code> family.'
     summary='AI reads invoices; approvals and QuickBooks sync live.'
     bullets=@('PDF, image, and email body extraction','Teams approval workflows with full audit trail','Live QuickBooks Online sync via MCP')
     what='Accounts Payable automates every step from invoice to payment. Bills arrive by email &mdash; AI reads PDFs, images, and email bodies and extracts vendor, amount, and line items automatically. Approvals route through Teams with a full audit trail. Approved bills sync to QuickBooks Online through a live MCP service &mdash; zero re-keying. The AP Dashboard SPA gives finance leadership real-time pipeline visibility with bulk actions.'
     who='Finance and operations teams at affordable-housing nonprofits, CDCs, and managing partners that need controlled invoice approval and audit trails across multiple programs and funding sources.'
     detail='<p style="color:#444;"><strong>Owns the Tier-1 bound:</strong> <code>mpp_bill</code>, <code>mpp_accountspayablebilltype</code>, <code>mpp_constructionpaymentapproval</code>, <code>mpp_emailconfiguration</code>, <code>mpp_flowfailurelog</code> &mdash; tables shared with Construction Management, HBE, and Property Management as <code>MPP_Shared_Finance</code>.</p><p style="color:#444;"><strong>AI extraction:</strong> Built on Azure AI Content Understanding + Azure OpenAI on the same Foundry account, with confidence-gated field extraction from PDF, image, and email-body sources.</p>'
  },
  @{ slug='procurement'; folder='procurement'; pretty='Procurement'; category='operations'; status='live'
     pageId=$null
     navName='Procurement'; title='Procurement'; icon='&#128230;'
     tagline='Sealed bidding, vendor compliance, contract buyout, and purchase order matching &mdash; the full procure-to-pay lifecycle. Funding-source tracking for audit-ready procurement. Real-time analytics console.'
     summary='RFP-to-contract with fair-and-open vendor selection.'
     bullets=@('Sealed bidding and vendor compliance','Side-by-side proposal evaluation','Funding-source tracking for audit-ready procurement')
     what='Procurement manages the full RFP-to-contract lifecycle &mdash; draft RFPs scoped to properties, invite bidders, capture vendor responses with line-item detail, evaluate proposals side-by-side, award the winning vendor, and generate the RFP contract. The Operator SPA handles day-to-day work. An analytics console shows real-time spend and tolerance. Vendor compliance tracking, sealed bidding, and funding-source tracking for audit-ready procurement.'
     who='Procurement officers, compliance teams, and program managers at federally and state-funded nonprofits that must document fair-and-open vendor selection.'
     detail='<p style="color:#444;"><strong>Standalone-first design:</strong> Zero hard cross-solution dependencies on AP or CMS &mdash; Procurement-owned primitives use the <code>mpp_proc*</code> prefix when AP/CMS already use the unprefixed name (e.g. <code>mpp_procapprovalrequest</code>, <code>mpp_fundingsource</code>, <code>mpp_documentlink</code>, <code>mpp_vendorcertificate</code>) so it imports cleanly anywhere.</p><p style="color:#444;"><strong>Acceptance evidence:</strong> Playwright live screenshots only &mdash; flow / API success codes are not enough.</p>'
  },
  @{ slug='find-jurisdiction'; folder='find-jurisdiction'; pretty='FindJurisdiction'; category='operations'; status='live'
     pageId=$null
     navName='Property Analyzer'; title='Property Analyzer'; icon='&#128205;'
     tagline='Florida address &rarr; instant jurisdiction, zoning, flood, permits, and utilities. Multi-county coverage with server-side address suggestions. Public-records CMA and ARV forecast. One printable report for your land committee.'
     summary='Address &rarr; jurisdiction, zoning, flood, and permits.'
     bullets=@('Hillsborough, Pinellas, and Pasco coverage','Server-side address suggestions','Printable land-committee report')
     what='Given a Florida street address, the Property Analyzer determines the county, municipality, tax district, and incorporated/unincorporated status, saves the public-record result into Dataverse, and presents land-feasibility due-diligence context in the Property Appraiser Info (PAI) Console. Covers Hillsborough (HCPA), Pinellas (PCPAO), and Pasco (PASCOPAO) counties today, with server-side Azure Maps address suggestions and surfaces for zoning/FLU, permits, inspections, utilities, flood/coastal, plus a public-records CMA / ARV Forecast tab with a real subject/comp/new-permit map.'
     who='Real-estate acquisitions teams, development underwriters, and counselors performing site eligibility, zoning, and feasibility checks for affordable-housing programs.'
     detail='<p style="color:#444;"><strong>Single-purpose plugin pack</strong> (<code>FindJurisdiction_Plugins</code>, no model-driven app of its own). It is consumed by HBE, DPA, CMS, and Property Management to enrich any property record the moment an address is entered.</p>'
  },
  # --- Engagement ---
  @{ slug='fundraising'; folder='fundraising'; pretty='Fundraising'; category='engagement'; status='live'
     pageId='c2b19808-49ac-42f9-b532-b96789943fd2'
     navName='Fundraising'; title='Fundraising and Engagement'; icon='&#129505;'
     tagline='Donors, gifts, pledges, recurring giving, events, silent auctions, planned giving, GL export. Stripe-powered donation processing. Real-time auction with proxy bidding. Donor portal and newsletter campaigns &mdash; all on one platform.'
     summary='Donors, gifts, auctions, events, and email campaigns.'
     bullets=@('Stripe-powered donations and silent auctions','Donor portal for giving history','Bulk email and newsletter journeys with unsubscribes')
     what='Fundraising & Engagement is the end-to-end nonprofit development platform &mdash; gift processing, campaigns, silent auctions, events, planned giving, and donor communications. Stripe-powered donations with PCI-compliant processing. Real-time silent auctions with proxy bidding and automated winner checkout. Donor portal for self-service giving history. Newsletter and segmented bulk email through Azure Communication Services with quota throttling, RFC-8058 one-click unsubscribe, and automated journeys. General ledger export to QuickBooks, Intacct, or MIP.'
     who='Development and communications teams at affordable-housing nonprofits, community foundations, and any 501(c)(3) replacing siloed donor databases or spreadsheet-based giving records.'
     detail='<p style="color:#444;"><strong>Why it pairs with the housing modules:</strong> Donor restricted-fund tracking ties every gift to the program it supports (e.g., &ldquo;Emergency Repair Fund&rdquo;, &ldquo;Homebuyer Scholarship&rdquo;), and the donor portal, auction site, and email campaigns are delivered through the same Power Pages surface as this website.</p>'
  },
  @{ slug='grants'; folder='grants'; pretty='Grants'; category='engagement'; status='live'
     pageId='c96f6cb7-0016-4be7-bfaf-519e1da0b020'
     navName='Grants'; title='Grant Management'; icon='&#128221;'
     tagline='Track grant opportunities, applications, awards, and budget commitments. Automated deadline alerts at 90, 60, 30, 14, and 7 days. AI grant agent to match opportunities to your programs.'
     summary='Grant lifecycle from opportunity to compliance.'
     bullets=@('Deadline alerts at 90/60/30/14/7 days','Post-award compliance tracking (Davis-Bacon, BABA, Section 3)','AI agent matches opportunities to your programs')
     what='MPP Grant Management is the first Dataverse-native grant management solution built specifically for affordable housing nonprofits. Track opportunities with structured fit scoring. Manage applications with automated deadline alerts. Monitor post-award compliance &mdash; Davis-Bacon, BABA, Section 3 &mdash; with flag tracking. Automate HUD 9902 and CAPER reporting. Link grant performance directly to client outcomes. AI grant agent matches opportunities to your organizational profile and program capacity.'
     who='Grants managers at affordable-housing nonprofits managing federal (HUD, Treasury), state (SHIP, NSP), county, foundation, and corporate grant portfolios.'
     detail='<p style="color:#444;"><strong>Roles included:</strong> Grant Manager (full lifecycle), Grant Scout (research/prospecting only). Tables include grant opportunity, grant application, grant award, and the v1.2+ commitment ledger for budget burn tracking.</p>'
  },
  @{ slug='volunteers'; folder='volunteers'; pretty='Volunteers'; category='engagement'; status='live'
     pageId='ad8d0569-cf44-4683-ba0d-0c4ebe29e69c'
     navName='Volunteers'; title='Volunteer Management'; icon='&#129309;'
     tagline='Recruit, schedule, track hours, and recognize volunteers &mdash; tied to the same Dataverse contact and program records. Recognition and retention dashboards.'
     summary='Recruit, schedule, track hours, and recognize impact.'
     bullets=@('Shift sign-ups and hour tracking','Background-check status and waivers','Same contact record as donors and applicants')
     what='Volunteer onboarding and waiver management, opportunity scheduling, shift sign-ups, hour tracking, background-check status, recognition workflows, and impact reporting connected to the programs and outcomes the volunteer supported.'
     who='Volunteer coordinators at housing nonprofits running build days, education-class instructor pools, financial-coaching volunteer corps, and event volunteer teams.'
     detail='<p style="color:#444;"><strong>Shared Dataverse contact:</strong> A volunteer who later applies for assistance, donates, or registers for a class is the same contact record &mdash; no duplicates, no reconciliation.</p>'
  },
  # --- Coming soon (skeleton repos) ---
  @{ slug='hr'; folder='hr'; pretty='Hr'; category='coming-soon'; status='live'
     pageId=$null
     navName='Human Resources'; title='Human Resources'; icon='&#128101;'
     tagline='Staff onboarding, time-off tracking, performance reviews, and HR document control &mdash; all connected to the same platform your programs run on.'
     summary='People operations on the same platform.'
     bullets=@('Onboarding, time-off, and reviews','HR document control','Planned after MPP_Shared_People lands')
     what='Planned HR module covering employee onboarding, time-off requests and balances, performance reviews, training records, and HR document control. Reserved repo (<code>HR_</code> publisher prefix) with DevDocs in place; build kicks off after the <code>MPP_Shared_People</code> boundary lands.'
     who='Internal HR and people-ops leads at affordable-housing nonprofits standardizing on the Power Platform suite for both program work and back-office.'
     detail='<p style="color:#444;"><strong>Status:</strong> Reserved skeleton repo following the suite&rsquo;s standard layering (<code>HR_Core / HR_DataLayer / HR_Application / HR_UI</code>). No Dataverse solution shipped yet.</p>'
  },
  @{ slug='lms'; folder='lms'; pretty='Lms'; category='coming-soon'; status='live'
     pageId=$null
     navName='Learning Management'; title='Learning Management'; icon='&#127891;'
     tagline='Training catalog, course completions, certifications, and CEU tracking. Your staff and partner agencies stay current &mdash; tracked and auditable.'
     summary='Training catalog and certification tracking.'
     bullets=@('Course catalog and enrollment','Completion certificates and CEUs','Shares roster patterns with HBE and Volunteers')
     what='Planned LMS module covering course catalog, instructor scheduling, learner enrollment, attendance and completion tracking, certification issuance and expiry alerts, and CEU tracking. Will share the same constituent contact record used by Homebuyer Education and Volunteer Management.'
     who='Training and capacity-building teams delivering staff certifications, partner-agency trainings, and continuing-ed credit programs.'
     detail='<p style="color:#444;"><strong>Status:</strong> Reserved skeleton repo (<code>LMS_</code> prefix). Will sit alongside Homebuyer Education and reuse class/roster patterns proven there.</p>'
  },
  @{ slug='plan-manager'; folder='plan-manager'; pretty='PlanManager'; category='coming-soon'; status='live'
     pageId=$null
     navName='Plan Manager'; title='Plan Manager'; icon='&#128202;'
     tagline='Architectural plan and drawing management for construction projects &mdash; version control, markups, submittals, RFIs, and approval workflows. Connected to the same property and project records your team already works from.'
     summary='Architectural plan and drawing control.'
     bullets=@('Version control and markups','Submittals, RFIs, and approvals','Tied to CMS property and project records')
     what='Planned architectural plan and drawing management module for construction projects. Version control for blueprints and drawings, markups, submittals, RFIs, and approval workflows. Connected to the same property and project records in the Construction Management System.'
     who='Construction project managers, architects, and plan reviewers who need drawing control tied to the same property and project data the field team uses.'
     detail='<p style="color:#444;"><strong>Status:</strong> Reserved skeleton repo following the suite&rsquo;s standard layering. References the <code>mpp_ArchitecturalPlanPage</code> entity and integrates with CMS document control.</p>'
  }
)

# --- Categories: ordered for display ---
$categoryMeta = @(
  @{ key='programs';     title='Housing programs';            blurb='Homeowner-facing programs from education to closing.' }
  @{ key='operations';   title='Back-office operations';      blurb='Finance, procurement, and property data that keep audits clean.' }
  @{ key='engagement';   title='Fundraising and engagement';  blurb='Donors, grants, volunteers, and the outreach that funds the work.' }
  @{ key='coming-soon';  title='On the roadmap';              blurb='Reserved repos ready to build when shared foundations land.' }
)

# --- Operating System page metadata ---
$osPage = @{
  slug='operating-system'; folder='operating-system'; pretty='OperatingSystem'; title='How Max Power Platform runs the whole nonprofit'
  pageId=$null
  summary='One mission, one record, one operating system: public-facing work, mission operations, back-office engine, and shared data -- all running as a continuous loop.'
}

# --- Operating system page: mount the React + Fluent UI component ---
function Get-OperatingSystemHtml() {
  return @"
<div class="row sectionBlockLayout" style="display:flex;flex-wrap:wrap;margin:0;padding:0;">
  <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
    <link rel="stylesheet" href="/mpp-os.css" />
    <div id="mpp-os-root"><p style="padding:24px;color:#5E6F7D;text-align:center;font-family:sans-serif;">Loading operating system diagram...</p></div>
    <script src="/mpp-os.js?v=4"></script>
  </div>
</div>
"@
}

function Write-OperatingSystemPage() {
  $folder = "$rootPages/$($osPage.folder)"
  $contentFolder = "$folder/content-pages"
  if (-not (Test-Path $contentFolder)) { New-Item -ItemType Directory -Force -Path $contentFolder | Out-Null }

  $rootYmlPath = "$folder/$($osPage.pretty).webpage.yml"
  if (-not (Test-Path $rootYmlPath)) {
    $rootGuid = [guid]::NewGuid().ToString()
    $contentGuid = [guid]::NewGuid().ToString()
    $rootYml = @"
adx_displayorder: 50
adx_enablerating: false
adx_enabletracking: false
adx_excludefromsearch: false
adx_feedbackpolicy: 756150000
adx_hiddenfromsitemap: true
adx_isroot: true
adx_name: $($osPage.pretty)
adx_pagetemplateid: $pageTemplateId
adx_parentpageid: $homeId
adx_partialurl: $($osPage.slug)
adx_publishingstateid: $publishingId
adx_sharedpageconfiguration: false
adx_title: $($osPage.title)
adx_webpageid: $rootGuid
"@
    Write-Utf8NoBom "$folder/$($osPage.pretty).webpage.yml" $rootYml
    Write-Utf8NoBom "$folder/$($osPage.pretty).webpage.copy.html" ''
    Write-Utf8NoBom "$folder/$($osPage.pretty).webpage.summary.html" ''
    Write-Utf8NoBom "$folder/$($osPage.pretty).webpage.custom_css.css" ''
    Write-Utf8NoBom "$folder/$($osPage.pretty).webpage.custom_javascript.js" ''

    $contentYml = @"
adx_displayorder: 50
adx_enablerating: false
adx_enabletracking: false
adx_excludefromsearch: false
adx_feedbackpolicy: 756150000
adx_hiddenfromsitemap: true
adx_isroot: false
adx_name: $($osPage.pretty)
adx_pagetemplateid: $pageTemplateId
adx_parentpageid: $homeId
adx_partialurl: $($osPage.slug)
adx_publishingstateid: $publishingId
adx_rootwebpageid: $rootGuid
adx_sharedpageconfiguration: false
adx_title: $($osPage.title)
adx_webpageid: $contentGuid
adx_webpagelanguageid: $languageId
"@
    Write-Utf8NoBom "$contentFolder/$($osPage.pretty).en-US.webpage.yml" $contentYml
    Write-Utf8NoBom "$contentFolder/$($osPage.pretty).en-US.webpage.summary.html" ''
    Write-Utf8NoBom "$contentFolder/$($osPage.pretty).en-US.webpage.custom_css.css" ''
    Write-Utf8NoBom "$contentFolder/$($osPage.pretty).en-US.webpage.custom_javascript.js" ''

    $osPage.pageId = $rootGuid
    Write-Host "  + created page records for $($osPage.title) (root=$rootGuid)"
  } else {
    $rawY = Get-Content $rootYmlPath -Raw
    if ($rawY -match 'adx_webpageid:\s*([0-9a-fA-F-]{36})') { $osPage.pageId = $Matches[1] }
  }

  Write-Utf8NoBom "$contentFolder/$($osPage.pretty).en-US.webpage.copy.html" (Get-OperatingSystemHtml)
}


function Tile-Html($m, [switch]$m365) {
  # All roadmap and live modules now render with the same blue accent and full opacity
  $borderColor = '#1F66B5'
  $opacity     = '1'
  $summary = $m.summary
  $bullets = $m.bullets
  $bulletsHtml = ($bullets | ForEach-Object { "          <li style='margin:0 0 4px 0;color:#444;font-size:.88rem;line-height:1.45;'>$($_)</li>" }) -join "`n"
  $link = if ($m365) { '/m365/' } else { "/$($m.slug)/" }
  $heading = if ($m365) { $m.title } else { $m.navName }
  return @"
        <a href="$link" style="text-decoration:none;color:inherit;flex:1 1 280px;max-width:340px;opacity:$opacity;">
          <div style="border:1px solid #e3e3e3;border-top:4px solid $borderColor;border-radius:8px;padding:22px;height:100%;background:#fff;box-shadow:0 1px 3px rgba(0,0,0,.06);">
            <div style="font-size:2rem;line-height:1;margin-bottom:10px;">$($m.icon)</div>
            <h3 style="margin:0 0 6px;color:#1F66B5;font-size:1.1rem;">$heading</h3>
            <p style="margin:0 0 10px;color:#444;font-size:.92rem;line-height:1.4;">$summary</p>
            <ul style="margin:0;padding-left:18px;">
$bulletsHtml
            </ul>
          </div>
        </a>
"@
}

# --- Helper: render the M365 service page ---
function Write-M365Page() {
  $m365RootFolder    = "$rootPages/$($m365Service.folder)"
  $m365ContentFolder = "$m365RootFolder/content-pages"
  if (-not (Test-Path $m365ContentFolder)) { New-Item -ItemType Directory -Force -Path $m365ContentFolder | Out-Null }

  $m365RootYmlPath = "$m365RootFolder/$($m365Service.pretty).webpage.yml"
  if (-not (Test-Path $m365RootYmlPath)) {
    $m365RootGuid    = [guid]::NewGuid().ToString()
    $m365ContentGuid = [guid]::NewGuid().ToString()
    $m365RootYml = @"
adx_displayorder: 50
adx_enablerating: false
adx_enabletracking: false
adx_excludefromsearch: false
adx_feedbackpolicy: 756150000
adx_hiddenfromsitemap: true
adx_isroot: true
adx_name: $($m365Service.pretty)
adx_pagetemplateid: $pageTemplateId
adx_parentpageid: $homeId
adx_partialurl: $($m365Service.slug)
adx_publishingstateid: $publishingId
adx_sharedpageconfiguration: false
adx_title: $($m365Service.title)
adx_webpageid: $m365RootGuid
"@
    Write-Utf8NoBom "$m365RootFolder/$($m365Service.pretty).webpage.yml" $m365RootYml
    Write-Utf8NoBom "$m365RootFolder/$($m365Service.pretty).webpage.copy.html" ''
    Write-Utf8NoBom "$m365RootFolder/$($m365Service.pretty).webpage.summary.html" ''
    Write-Utf8NoBom "$m365RootFolder/$($m365Service.pretty).webpage.custom_css.css" ''
    Write-Utf8NoBom "$m365RootFolder/$($m365Service.pretty).webpage.custom_javascript.js" ''

    $m365ContentYml = @"
adx_displayorder: 50
adx_enablerating: false
adx_enabletracking: false
adx_excludefromsearch: false
adx_feedbackpolicy: 756150000
adx_hiddenfromsitemap: true
adx_isroot: false
adx_name: $($m365Service.pretty)
adx_pagetemplateid: $pageTemplateId
adx_parentpageid: $homeId
adx_partialurl: $($m365Service.slug)
adx_publishingstateid: $publishingId
adx_rootwebpageid: $m365RootGuid
adx_sharedpageconfiguration: false
adx_title: $($m365Service.title)
adx_webpageid: $m365ContentGuid
adx_webpagelanguageid: $languageId
"@
    Write-Utf8NoBom "$m365ContentFolder/$($m365Service.pretty).en-US.webpage.yml" $m365ContentYml
    Write-Utf8NoBom "$m365ContentFolder/$($m365Service.pretty).en-US.webpage.summary.html" ''
    Write-Utf8NoBom "$m365ContentFolder/$($m365Service.pretty).en-US.webpage.custom_css.css" ''
    Write-Utf8NoBom "$m365ContentFolder/$($m365Service.pretty).en-US.webpage.custom_javascript.js" ''

    $m365Service.pageId = $m365RootGuid
    Write-Host "  + created page records for $($m365Service.title) (root=$m365RootGuid)"
  } else {
    $rawY = Get-Content $m365RootYmlPath -Raw
    if ($rawY -match 'adx_webpageid:\s*([0-9a-fA-F-]{36})') { $m365Service.pageId = $Matches[1] }
  }

  $m365Copy = @"
<div class="row sectionBlockLayout text-center" style="display:flex;flex-wrap:wrap;margin:0;padding:56px 8px 24px;background:#ffffff;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <p style="margin:0 0 8px;"><a href="/" style="color:#1F66B5;text-decoration:none;">&larr; Max Power Platform</a></p>
      <div style="font-size:3.25rem;line-height:1;margin:8px 0;">$($m365Service.icon)</div>
      <h1 style="margin:0 0 10px;color:#1F66B5;">$($m365Service.title)</h1>
      <p style="font-size:1.18rem;max-width:800px;margin:0 auto;color:#555;">Professional email, files, phones, security, and device management on one platform &mdash; managed for you.</p>
    </div>
  </div>
</div>

<div class="row sectionBlockLayout text-start" style="display:flex;flex-wrap:wrap;margin:0;padding:24px 8px 64px;background:#f7f8fa;">
  <div class="container" style="padding:0;">
    <div class="col-lg-8 columnBlockLayout" style="margin:0 auto;max-width:860px;background:#fff;border:1px solid #e3e3e3;border-radius:8px;padding:36px;">

      <h2 style="color:#7A6A65;margin:0 0 12px;">What this service does</h2>
      <p style="color:#444;line-height:1.6;">$($m365Service.what)</p>

      <h2 style="color:#7A6A65;margin:28px 0 12px;">Who it&rsquo;s for</h2>
      <p style="color:#444;line-height:1.6;">$($m365Service.who)</p>

      $($m365Service.detail)

      <p style="margin-top:36px;text-align:center;">
        <a href="/" style="display:inline-block;background:#1F66B5;color:#fff;padding:12px 24px;border-radius:6px;text-decoration:none;font-weight:600;">&larr; Back to Max Power Platform</a>
      </p>
    </div>
  </div>
</div>
"@
  Write-Utf8NoBom "$m365ContentFolder/$($m365Service.pretty).en-US.webpage.copy.html" $m365Copy
}

# --- Step 1: pin pageIds from existing on-disk yml first (so we never create duplicates) ---
foreach ($m in $modules) {
  $rootYmlPath = "$rootPages/$($m.folder)/$($m.pretty).webpage.yml"
  if ((-not $m.pageId) -and (Test-Path $rootYmlPath)) {
    $rawY = Get-Content $rootYmlPath -Raw
    if ($rawY -match 'adx_webpageid:\s*([0-9a-fA-F-]{36})') { $m.pageId = $Matches[1] }
  }
}
Write-M365Page
Write-OperatingSystemPage

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
  $copy = @"
<div class="row sectionBlockLayout text-center" style="display:flex;flex-wrap:wrap;margin:0;padding:56px 8px 24px;background:#ffffff;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <p style="margin:0 0 8px;"><a href="/" style="color:#1F66B5;text-decoration:none;">&larr; Max Power Platform</a></p>
      <div style="font-size:3.25rem;line-height:1;margin:8px 0;">$($m.icon)</div>
      <h1 style="margin:0 0 10px;color:#1F66B5;">$($m.title)</h1>
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
        <a href="/" style="display:inline-block;background:#1F66B5;color:#fff;padding:12px 24px;border-radius:6px;text-decoration:none;font-weight:600;">&larr; Back to Max Power Platform</a>
      </p>
    </div>
  </div>
</div>
"@
  Write-Utf8NoBom $copyPath $copy
}
Write-Host "Step 2 done: rewrote content-page HTML for all $($modules.Count) modules."

# --- Step 3: rewrite Home page (M365 hero + suite hero + tile grid + contact CTA) ---
$homeSb = New-Object System.Text.StringBuilder

# M365 + Suite hero cards (side-by-side, above the fold)
[void]$homeSb.AppendLine(@"
<div class="row sectionBlockLayout" style="display:flex;flex-wrap:wrap;margin:0;padding:56px 8px 36px;background:#ffffff;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <div style="display:flex;flex-wrap:wrap;gap:20px;justify-content:center;align-items:stretch;">

        <!-- Managed M365 hero card -->
        <div style="flex:1 1 420px;max-width:560px;background:#f7f8fa;border:1px solid #e3e3e3;border-radius:10px;padding:32px;display:flex;flex-direction:column;justify-content:space-between;">
          <div>
            <p style="margin:0 0 10px;"><span style="display:inline-block;background:#e8f1fb;color:#1F66B5;font-weight:600;font-size:.78rem;letter-spacing:.04em;text-transform:uppercase;padding:5px 12px;border-radius:99px;">$($m365Service.badge)</span></p>
            <h1 style="margin:0 0 12px;color:#1F66B5;font-weight:700;font-size:1.6rem;">$($m365Service.title)</h1>
            <p style="font-size:1.05rem;margin:0 0 10px;color:#444;">Professional IT without an IT hire.</p>
            <ul style="margin:0 0 10px;padding-left:18px;color:#444;font-size:.95rem;line-height:1.45;">
$($($m365Service.bullets | ForEach-Object { "              <li>$($_)</li>" }) -join "`n")
            </ul>
          </div>
          <div style="margin-top:20px;">
            <a href="/$($m365Service.slug)/" style="display:inline-block;background:#1F66B5;color:#fff;padding:10px 22px;border-radius:6px;text-decoration:none;font-weight:600;">See Managed M365 &rarr;</a>
          </div>
        </div>

        <!-- Max Power Suite hero card -->
        <div style="flex:1 1 420px;max-width:560px;background:#f7f8fa;border:1px solid #e3e3e3;border-radius:10px;padding:32px;display:flex;flex-direction:column;justify-content:space-between;">
          <div>
            <p style="margin:0 0 10px;"><span style="display:inline-block;background:#e8f1fb;color:#1F66B5;font-weight:600;font-size:.78rem;letter-spacing:.04em;text-transform:uppercase;padding:5px 12px;border-radius:99px;">Frontier-first &middot; AI-first</span></p>
            <h1 style="margin:0 0 12px;color:#1F66B5;font-weight:700;font-size:1.6rem;">Max Power Suite</h1>
            <p style="font-size:1.05rem;margin:0 0 10px;color:#444;">Connected modules for nonprofit housing agencies.</p>
            <ul style="margin:0 0 10px;padding-left:18px;color:#444;font-size:.95rem;line-height:1.45;">
              <li>Homebuyer education, DPA, construction, property management</li>
              <li>Fundraising, grants, volunteers, and back-office</li>
              <li>One constituent record across every program</li>
              <li>Copilot Studio agents on the same data</li>
            </ul>
          </div>
          <div style="margin-top:20px;">
            <a href="/operating-system/" style="display:inline-block;background:#1F66B5;color:#fff;padding:10px 22px;border-radius:6px;text-decoration:none;font-weight:600;">See how it works &rarr;</a>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>
"@)

# M365 highlights section
if ($m365Tiles.Count -gt 0) {
  [void]$homeSb.AppendLine(@"
<div class="row sectionBlockLayout text-start" style="display:flex;flex-wrap:wrap;margin:0;padding:48px 8px 24px;background:#ffffff;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <h2 style="text-align:center;margin:0 0 6px;color:#7A6A65;">Managed M365 highlights</h2>
      <p style="text-align:center;color:#666;margin:0 auto 28px;max-width:760px;">Everything you need for professional IT, without the IT department.</p>
      <div class="row" style="display:flex;flex-wrap:wrap;gap:18px;justify-content:center;">
"@)
  foreach ($m in $m365Tiles) {
    [void]$homeSb.AppendLine((Tile-Html $m -m365))
  }
  [void]$homeSb.AppendLine(@"
      </div>
    </div>
  </div>
</div>
"@)
}

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
Write-Host "Step 3 done: rewrote Home with $($modules.Count) modules in $($categoryMeta.Count) categories + M365 section."

# --- Step 4: rewrite the primary nav weblink set as Managed M365 + Home + 4 category dropdowns ---
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
$osWebLinkId = 'aa000006-0000-4000-8000-000000000006'
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

# Top-level: Managed M365
Add-WL -name 'Managed M365' -order 1 -wid $m365WebLinkId -pageId $m365Service.pageId

# Top-level: Home
Add-WL -name 'Home' -order 2 -wid $homeWebLinkId -pageId $homeId

# Top-level: How it works (operating system page)
Add-WL -name 'How it works' -order 3 -wid $osWebLinkId -pageId $osPage.pageId

# Top-level: 4 category parents (no page, just labels with children)
$top = 4
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
Write-Host "Step 4 done: nav has Managed M365 + Home + $($parentOrder.Count) category dropdowns containing $($modules.Count) child links."

# --- Step 5: rewrite Footer snippet link row to span all categories ---
$footerLinks = (@($m365Service) + $modules | ForEach-Object { "      <a href=`"/$($_.slug)/`">$($_.navName)</a>" }) -join " &middot;`n"
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
    <p style="margin:0;font-weight:600;color:#ffffff;font-size:1.05rem;">Max Power Platform</p>
    <p style="margin:4px 0 0;color:#cfe1f5;font-size:.95rem;">Managed Microsoft 365 + an affordable-housing nonprofit suite, frontier-first and AI-first on Microsoft Power Platform.</p>
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
Write-Host "Step 5 done: footer link row rebuilt with Managed M365 + $($modules.Count) module links."

Write-Host "`nALL STEPS COMPLETE. Next: review diff, commit, then run pac pages upload."
