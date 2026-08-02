$ErrorActionPreference = 'Stop'
Set-Location 'C:\Users\MaxMaraj\OneDrive - Max Power Platform\Repos\mpp\nonprofit-suite-website'

$rootPages   = 'src/portal/mpp2---mpp2/web-pages'
$homeHtml    = "$rootPages/home/content-pages/Home.en-US.webpage.copy.html"

# --- Home page rewrite ---
$homeBody = @"
<div class="row sectionBlockLayout text-center" style="display:flex;flex-wrap:wrap;margin:0;padding:64px 8px 32px;background:#ffffff;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <img src="/mpp-logo.png" alt="Max Power Platform" style="max-width:480px;width:80%;height:auto;margin:0 auto 28px;display:block;" />
      <h1 style="margin:0 0 12px;color:#1F66B5;font-weight:700;">Affordable Housing Nonprofit Suite</h1>
      <p style="font-size:1.2rem;max-width:860px;margin:0 auto 8px;color:#444;">Seven connected modules built on Microsoft Power Platform &mdash; purpose-built for nonprofit housing agencies that deliver homebuyer education, down payment assistance, home repair, and the fundraising, grants, volunteer, and communications work that surrounds them.</p>
      <p style="font-size:1rem;max-width:760px;margin:8px auto 0;color:#666;">Dataverse + model-driven apps + Power Pages + Copilot Studio &mdash; one platform, one constituent record, one set of reports.</p>
    </div>
  </div>
</div>

<div class="row sectionBlockLayout text-start" style="display:flex;flex-wrap:wrap;margin:0;padding:32px 8px 64px;background:#f7f8fa;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <h2 style="text-align:center;margin:0 0 8px;color:#7A6A65;">The seven modules</h2>
      <p style="text-align:center;color:#666;margin-bottom:32px;">Click any tile to learn what it does, who it&rsquo;s for, and how it&rsquo;s built.</p>

      <div class="row" style="display:flex;flex-wrap:wrap;gap:20px;justify-content:center;">

        <a href="/hbe/" style="text-decoration:none;color:inherit;flex:1 1 300px;max-width:360px;">
          <div style="border:1px solid #e3e3e3;border-top:4px solid #1F66B5;border-radius:8px;padding:24px;height:100%;background:#fff;box-shadow:0 1px 3px rgba(0,0,0,.06);">
            <div style="font-size:2.25rem;line-height:1;margin-bottom:10px;">&#127968;</div>
            <h3 style="margin:0 0 8px;color:#1F66B5;">Homebuyer Education</h3>
            <p style="margin:0;color:#444;">HUD-style classes, 1:1 counseling, education lock-in, and certificate issuance &mdash; the front door to every assistance program.</p>
          </div>
        </a>

        <a href="/dpa/" style="text-decoration:none;color:inherit;flex:1 1 300px;max-width:360px;">
          <div style="border:1px solid #e3e3e3;border-top:4px solid #1F66B5;border-radius:8px;padding:24px;height:100%;background:#fff;box-shadow:0 1px 3px rgba(0,0,0,.06);">
            <div style="font-size:2.25rem;line-height:1;margin-bottom:10px;">&#128176;</div>
            <h3 style="margin:0 0 8px;color:#1F66B5;">Down Payment Assistance</h3>
            <p style="margin:0;color:#444;">SHIP &amp; HOME-funded purchase assistance: applications, underwriting, awards, closings, liens, and HUD reporting.</p>
          </div>
        </a>

        <a href="/hrrp/" style="text-decoration:none;color:inherit;flex:1 1 300px;max-width:360px;">
          <div style="border:1px solid #e3e3e3;border-top:4px solid #1F66B5;border-radius:8px;padding:24px;height:100%;background:#fff;box-shadow:0 1px 3px rgba(0,0,0,.06);">
            <div style="font-size:2.25rem;line-height:1;margin-bottom:10px;">&#128736;</div>
            <h3 style="margin:0 0 8px;color:#1F66B5;">Home Repair &amp; Rehab</h3>
            <p style="margin:0;color:#444;">City-referred housing repair / replacement programs: outreach, scope of work, contractor handoff, draws, and compliance.</p>
          </div>
        </a>

        <a href="/fundraising/" style="text-decoration:none;color:inherit;flex:1 1 300px;max-width:360px;">
          <div style="border:1px solid #e3e3e3;border-top:4px solid #1F66B5;border-radius:8px;padding:24px;height:100%;background:#fff;box-shadow:0 1px 3px rgba(0,0,0,.06);">
            <div style="font-size:2.25rem;line-height:1;margin-bottom:10px;">&#129505;</div>
            <h3 style="margin:0 0 8px;color:#1F66B5;">Fundraising &amp; Engagement</h3>
            <p style="margin:0;color:#444;">Donors, gifts, pledges, recurring giving, events, silent auctions, planned giving, GL export &mdash; with Stripe and donor portal.</p>
          </div>
        </a>

        <a href="/grants/" style="text-decoration:none;color:inherit;flex:1 1 300px;max-width:360px;">
          <div style="border:1px solid #e3e3e3;border-top:4px solid #1F66B5;border-radius:8px;padding:24px;height:100%;background:#fff;box-shadow:0 1px 3px rgba(0,0,0,.06);">
            <div style="font-size:2.25rem;line-height:1;margin-bottom:10px;">&#128221;</div>
            <h3 style="margin:0 0 8px;color:#1F66B5;">Grant Management</h3>
            <p style="margin:0;color:#444;">Track grant opportunities, applications, awards, budget commitments, and 90/60/30/14/7-day deadline alerts.</p>
          </div>
        </a>

        <a href="/volunteers/" style="text-decoration:none;color:inherit;flex:1 1 300px;max-width:360px;">
          <div style="border:1px solid #e3e3e3;border-top:4px solid #1F66B5;border-radius:8px;padding:24px;height:100%;background:#fff;box-shadow:0 1px 3px rgba(0,0,0,.06);">
            <div style="font-size:2.25rem;line-height:1;margin-bottom:10px;">&#129309;</div>
            <h3 style="margin:0 0 8px;color:#1F66B5;">Volunteer Management</h3>
            <p style="margin:0;color:#444;">Recruit, schedule, track hours, and recognize volunteers &mdash; tied to the same Dataverse contact and program records.</p>
          </div>
        </a>

        <a href="/bulk-email/" style="text-decoration:none;color:inherit;flex:1 1 300px;max-width:360px;">
          <div style="border:1px solid #e3e3e3;border-top:4px solid #1F66B5;border-radius:8px;padding:24px;height:100%;background:#fff;box-shadow:0 1px 3px rgba(0,0,0,.06);">
            <div style="font-size:2.25rem;line-height:1;margin-bottom:10px;">&#128231;</div>
            <h3 style="margin:0 0 8px;color:#1F66B5;">Bulk Email Management</h3>
            <p style="margin:0;color:#444;">Newsletters and segmented bulk email through Azure Communication Services with marketing-list automation and unsubscribe handling.</p>
          </div>
        </a>

      </div>

      <div style="text-align:center;margin-top:48px;color:#7A6A65;font-size:.95rem;">
        <p style="margin:0;">Have a housing nonprofit need that doesn&rsquo;t fit a tile? <a href="mailto:max@maxpowerplatform.com" style="color:#1F66B5;">Get in touch.</a></p>
      </div>
    </div>
  </div>
</div>
"@
Set-Content -Path $homeHtml -Value $homeBody -NoNewline -Encoding UTF8
Write-Host "Wrote home: $homeHtml"

# --- Module page rewrite ---
$modules = @(
  @{
    folder='hbe'; pretty='Hbe'; title='Homebuyer Education'; icon='&#127968;'
    tagline='HUD-style classes, 1:1 counseling, education lock-in, and certificate issuance &mdash; the front door to every assistance program.'
    what='Manage the full homebuyer education pipeline: class scheduling and rosters, attendance and completion tracking, 1:1 counseling sessions, document collection, education lock-in to a specific program, and HUD-eligible certificate issuance. Includes a manager dashboard, daily exception briefs, and class-readiness scans powered by Copilot Studio agents.'
    who='HUD-approved housing counseling agencies, nonprofit homebuyer education providers, and any organization required to deliver pre-purchase education before disbursing assistance funds.'
    detail='<p style="color:#444;"><strong>Why it matters for affordable housing:</strong> Most state and federal down payment programs &mdash; including Florida SHIP and HUD HOME &mdash; require borrowers to complete a HUD-certified homebuyer education workshop <em>before</em> closing. Homebuyer Education is the system of record that proves it.</p><p style="color:#444;"><strong>Connected to:</strong> The same contact record flows into Down Payment Assistance, so a household&rsquo;s class completion is one click from their loan application.</p>'
  },
  @{
    folder='dpa'; pretty='Dpa'; title='Down Payment Assistance'; icon='&#128176;'
    tagline='SHIP &amp; HOME-funded purchase assistance: applications, underwriting, awards, closings, liens, and HUD reporting.'
    what='End-to-end administration of down payment assistance loan programs. Online intake, household income verification, AMI calculation, underwriting business process flow, award letters, closing tab, lien tracking, payoff/satisfaction, and reporting. Built on Dataverse with a React/TypeScript DPA Console SPA for staff and a constituent portal for applicants.'
    who='HUD-approved nonprofit housing agencies and CDFIs administering federal/state-funded purchase assistance &mdash; for example, the City of Clearwater Home Purchase Assistance Program (SHIP/HOME) is delivered through approved nonprofit housing agencies.'
    detail='<h3 style="color:#7A6A65;margin:24px 0 8px;">Real-world example: City of Clearwater SHIP DPA</h3><p style="color:#444;">Clearwater&rsquo;s SHIP-funded program (loans up to $75,000 for purchases approved after July&nbsp;1,&nbsp;2025) is a representative DPA workflow this module supports:</p><ul style="color:#444;line-height:1.7;"><li>50% amortized over 20 years (payments deferred 5 years), 50% deferred &amp; forgiven at maturity</li><li>Household income test against AMI; all members 18+ counted</li><li>Borrower must complete a HUD-certified homebuyer education workshop (handled by the <a href="/hbe/" style="color:#1F66B5;">Homebuyer Education</a> module)</li><li>Borrower contributes 1% from own funds; primary residence; lead-paint/code requirements</li><li>Application submitted through an approved nonprofit housing agency</li><li>Lien recorded; full balance due on sale before maturity unless hardship rules apply</li></ul><p style="color:#444;"><em>The DPA module captures every one of those rules as configurable program parameters, business process stages, and validation rules &mdash; so a single deployment can serve multiple funding sources (SHIP, HOME, ARPA, county-specific) without code changes.</em></p>'
  },
  @{
    folder='hrrp'; pretty='Hrrp'; title='Home Repair &amp; Rehab'; icon='&#128736;'
    tagline='City-referred housing repair / replacement programs: outreach, scope of work, contractor handoff, draws, and compliance.'
    what='Receive city/county housing-repair referrals, validate homeowner contact, deduplicate against existing records, schedule inspections, define scope of work, assign contractors, manage draw schedules, track inspections through completion, and generate compliance reports. Includes a Copilot Studio HRRP Manager agent for triage and homeowner outreach automation.'
    who='Nonprofit partners delivering city- or county-funded Housing Repair &amp; Replacement Programs (HRRP), weatherization assistance, and emergency repair grants for low-income homeowners.'
    detail='<p style="color:#444;"><strong>Typical referral flow:</strong> A city housing department refers a homeowner under their HRRP. The intake agent validates contact info (phone/email), runs deduplication, and either auto-handoffs to the city contact with a templated referral packet or routes to a counselor for follow-up &mdash; all logged on the homeowner timeline.</p>'
  },
  @{
    folder='fundraising'; pretty='Fundraising'; title='Fundraising &amp; Engagement'; icon='&#129505;'
    tagline='Donors, gifts, pledges, recurring giving, events, silent auctions, planned giving, GL export &mdash; with Stripe and donor portal.'
    what='A complete nonprofit development platform: donor profiles and giving history, multi-fund accounting, campaigns and appeals, gift batches, pledges and recurring gifts, fundraising events with ticketing and check-in, silent auctions with real-time bidding, planned giving and Legacy Society tracking, and GL export adapters for QuickBooks Online, Sage Intacct, and MIP. PCI-compliant Stripe boundary (SAQ&nbsp;A).'
    who='Development and finance teams at affordable-housing nonprofits, community foundations, and any 501(c)(3) replacing siloed donor databases or spreadsheet-based giving records.'
    detail='<p style="color:#444;"><strong>Why it pairs with the housing modules:</strong> Donor restricted-fund tracking ties every gift to the program it supports (e.g., &ldquo;Emergency Repair Fund&rdquo;, &ldquo;Homebuyer Scholarship&rdquo;), and the donor portal &amp; auction site are delivered through the same Power Pages surface as this website.</p>'
  },
  @{
    folder='grants'; pretty='Grants'; title='Grant Management'; icon='&#128221;'
    tagline='Track grant opportunities, applications, awards, budget commitments, and 90/60/30/14/7-day deadline alerts.'
    what='Manage your inbound grants pipeline from prospecting through close-out. Capture grant opportunities, application drafts and submissions, award acceptance and amendments, budget line items and commitment ledger, milestone deliverables, and funder reporting deadlines. Built-in deadline alert workflows fire at 90/60/30 and 14/7 days before any reporting due date.'
    who='Grants managers at affordable-housing nonprofits managing federal (HUD, Treasury), state (SHIP, NSP), county, foundation, and corporate grant portfolios.'
    detail='<p style="color:#444;"><strong>Roles included:</strong> Grant Manager (full lifecycle), Grant Scout (research/prospecting only). Tables include grant opportunity, grant application, grant award, and the v1.2+ commitment ledger for budget burn tracking.</p>'
  },
  @{
    folder='volunteers'; pretty='Volunteers'; title='Volunteer Management'; icon='&#129309;'
    tagline='Recruit, schedule, track hours, and recognize volunteers &mdash; tied to the same Dataverse contact and program records.'
    what='Volunteer onboarding and waiver management, opportunity scheduling, shift sign-ups, hour tracking, background-check status, recognition workflows, and impact reporting connected to the programs and outcomes the volunteer supported.'
    who='Volunteer coordinators at housing nonprofits running build days, education-class instructor pools, financial-coaching volunteer corps, and event volunteer teams.'
    detail='<p style="color:#444;"><strong>Shared Dataverse contact:</strong> A volunteer who later applies for assistance, donates, or registers for a class is the same contact record &mdash; no duplicates, no reconciliation.</p>'
  },
  @{
    folder='bulk-email'; pretty='Bulk-email'; title='Bulk Email Management'; icon='&#128231;'
    tagline='Newsletters and segmented bulk email through Azure Communication Services with marketing-list automation and unsubscribe handling.'
    what='Compose and schedule bulk email to dynamic and static marketing lists, send through Azure Communication Services Email, automatically remove bounced and unsubscribed contacts from static lists, and track opens/clicks. Per-recipient signed unsubscribe tokens prevent unauthorized list manipulation.'
    who='Communications staff sending newsletters, fundraising appeals, program updates, class reminders, and donor receipts to constituent audiences across the suite.'
    detail='<p style="color:#444;"><strong>Built on:</strong> 10 Power Automate cloud flows in the <code>BulkEmailManagement</code> Dataverse solution, with API keys stored in environment variables (never in flow defaults) per the project&rsquo;s code-review hardening standard.</p>'
  }
)

foreach ($m in $modules) {
  $folder    = "$rootPages/$($m.folder)/content-pages"
  $copyPath  = "$folder/$($m.pretty).en-US.webpage.copy.html"

  $copy = @"
<div class="row sectionBlockLayout text-center" style="display:flex;flex-wrap:wrap;margin:0;padding:56px 8px 24px;background:#ffffff;">
  <div class="container" style="padding:0;">
    <div class="col-lg-12 columnBlockLayout" style="word-break:break-word;">
      <p style="margin:0 0 8px;"><a href="/" style="color:#1F66B5;text-decoration:none;">&larr; Affordable Housing Nonprofit Suite</a></p>
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
      <p style="color:#444;line-height:1.6;">Microsoft Power Platform &mdash; Dataverse for the data and security model, model-driven apps for staff, Power Automate for workflows, Power Pages for constituent self-service, and Copilot Studio agents where conversational AI accelerates the work.</p>

      <p style="margin-top:36px;text-align:center;">
        <a href="/" style="display:inline-block;background:#1F66B5;color:#fff;padding:12px 24px;border-radius:6px;text-decoration:none;font-weight:600;">&larr; Back to all modules</a>
      </p>
    </div>
  </div>
</div>
"@
  Set-Content -Path $copyPath -Value $copy -NoNewline -Encoding UTF8
  Write-Host "Wrote $copyPath"
}
Write-Host "`nAll module pages updated."
