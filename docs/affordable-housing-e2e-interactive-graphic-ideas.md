# Affordable Housing Nonprofit — End-to-End Operations Interactive Graphic

## Prepwork goal

Turn the Max Power Platform website into a teaching tool that shows how a housing nonprofit actually runs day-to-day. Instead of a static list of modules, we want an interactive graphic that maps every operational activity to a phase of the affordable-housing lifecycle and shows which part of the Max Power Suite (or Managed M365) handles it.

The graphic should make two things obvious to a prospect in 30 seconds:

1. **You are not buying 13 apps.** You are buying one operating system for the full lifecycle of your mission.
2. **Every module is connected to the same contact, property, program, and financial record.** No re-keying, no duplicate spreadsheets, no "where did that file go?"

---

## The nonprofit lifecycle we should model

A typical affordable-housing nonprofit moves through six major phases. Each phase has a mix of **client-facing** and **back-office** work.

| Phase | What happens | Front door | Back office | Funding / compliance |
|---|---|---|---|---|
| 1. Outreach & intake | People find the agency, ask for help, get screened | Website, email, phone, community events | CRM, intake forms, eligibility pre-check | Grant narratives, funder reporting |
| 2. Education & counseling | Homebuyer education, 1:1 counseling, credit/debt review | Classes, portal, e-signature | Case notes, attendance, certificates, 9902 | HUD, SHIP, CDFI requirements |
| 3. Assistance application | Down payment / closing cost assistance, rehab loans, rental help | Online application, document upload | Income/AMI verification, underwriting, board/committee approval | Funding-source rules, audit trail |
| 4. Development & construction | New construction or rehab: land, proforma, bids, draws, inspections | Contractor/vendor portal, plan submissions | Project management, budgets, draw approvals, procurement | HUD HOME, HTF, LIHTC, state/local funds |
| 5. Property & tenancy management | Leasing, rent collection, maintenance, compliance | Tenant portal, maintenance requests | Lease admin, work orders, rent rolls, recertification | LIHTC, HOME, HUD, state/local occupancy rules |
| 6. Stewardship & impact | Ongoing reporting, fundraising, grants, volunteer engagement, finance | Donor portal, newsletters, volunteer sign-ups | AP, GL, grant compliance, financial reports, board decks | 9902, CAPER, audit, fund accounting |

This is the **one story** the graphic should tell. Every Max Power Suite module fits into one (or more) of these phases.

---

## Module-to-phase mapping

| Phase | Primary modules | Supporting modules | Managed M365 layer |
|---|---|---|---|
| 1. Outreach & intake | Fundraising & Engagement (contacts), Property Analyzer (site lookup) | Grants, Volunteers | Teams, Outlook, email, calendar |
| 2. Education & counseling | Homebuyer Education | Fundraising (newsletters), Volunteers | Teams for virtual classes, Copilot for content |
| 3. Assistance application | Down Payment Assistance | Homebuyer Education, Property Analyzer, Accounts Payable | Outlook, SharePoint, Word docs |
| 4. Development & construction | Construction Management System, Procurement, Plan Manager | Accounts Payable, Fundraising (capital campaign) | Project Teams, SharePoint, Planner |
| 5. Property & tenancy management | Property Management | Accounts Payable, Procurement | Outlook, Teams, SharePoint |
| 6. Stewardship & impact | Fundraising & Engagement, Grants, Volunteers, Accounts Payable, Human Resources, Learning Management | All modules | Entire M365 tenant: finance, comms, compliance |

Two cross-cutting themes should be visible everywhere:

- **One constituent record.** The same contact can be a homebuyer-ed student, a DPA applicant, a donor, a volunteer, and a tenant — without duplicate data entry.
- **One property record.** A property can be a development site, a rehab project, a DPA purchase, and a managed rental unit — linked across modules.

---

## Interactive graphic concepts

### Option A: Horizontal scrollable timeline / subway map

A wide, horizontally scrolling "subway map" with six station stops (the phases). Each stop is a card. Hovering or clicking a stop expands it to show the activities inside, plus the modules that power them.

**Visual ideas:**
- A flowing line or road that connects the six phases.
- Icons for each phase.
- Color-coded "trains" for the two tracks: **Client journey** (blue) and **Back-office operations** (green).
- At each stop, a "Who touches this" panel: client, counselor, loan officer, PM, property manager, finance, executive director.

**Interaction:**
- Click a phase → the card expands and shows 3–5 key activities.
- Click an activity → shows which module(s) handle it and a 1-sentence value proposition.
- Toggle "Show M365 layer" to add the security/comms/security rail underneath.
- Toggle "Show compliance outputs" to reveal HUD 9902, CAPER, audit trail, lien documents, etc.

**Best for:** Desktop hero section on a landing page.

---

### Option B: Interactive circular "lifecycle wheel"

A radial diagram where the six phases form a ring around a central hub labeled **One Dataverse — One Constituent — One Property**. Hovering a phase segment lights up the related modules and draws connection lines to the hub.

**Visual ideas:**
- Outer ring: six phases with icons.
- Middle ring: the modules that serve each phase.
- Inner ring / center: shared data and AI layer (Copilot Studio, Dataverse MCP, shared entities).
- Animated pulse showing data moving from intake → counseling → assistance → property → long-term stewardship.

**Interaction:**
- Hover phase → other phases dim, that phase's modules glow.
- Click module → pop-over with summary, bullets, and a link to the module page.
- A "Play" button animates the lifecycle once for a visitor who just arrived.

**Best for:** A homepage explainer section or a standalone `/how-it-works/` page.

---

### Option C: "Day in the life" choose-your-own-role

Instead of a single diagram, let the visitor pick a role and see the lifecycle through that person's eyes. Roles: Executive Director, Housing Counselor, Loan Officer, Property Manager, Construction PM, Finance Director, Development Director, Tenant/Applicant.

**Visual ideas:**
- A role selector at the top.
- A vertical timeline showing a realistic week in that role.
- Each calendar block is a task; clicking it shows which module is used, how long it takes, and what data flows in/out.
- Show a before/after toggle: "Without Max Power Suite" vs. "With Max Power Suite" to demonstrate time savings and error reduction.

**Interaction:**
- Switch roles → timeline re-renders.
- Click a task → modal with module details and a screenshot or icon.
- Highlight integrations (e.g., counselor marks a class complete → DPA application sees it automatically).

**Best for:** A `/roi/` or `/how-we-work/` page for executive decision-makers.

---

### Option D: "Living org chart" — map the nonprofit, not the software

Start with a diagram of a nonprofit org chart. Click a department (Counseling, Lending, Construction, Property Management, Finance, Development, Admin) to reveal its systems and activities. The software appears as the connective tissue between departments.

**Visual ideas:**
- Org chart nodes: ED, departments, programs.
- Connecting lines show data handoffs: intake → counseling → underwriting → closing → property management → grants reporting.
- Each line is labeled with the data object being passed (contact, property, loan, invoice, draw request).
- Use badges on each node to indicate the modules in use.

**Interaction:**
- Click a department → show primary and secondary modules.
- Click a handoff line → show the integration point and how it eliminates duplicate entry.
- Toggle "AI layer" to show Copilot Studio agents that sit across multiple departments.

**Best for:** A board/finance audience that thinks in departments and handoffs.

---

### Option E: SVG-powered "connected modules" map

A clean, responsive SVG that places the modules as nodes and draws dynamic lines between them based on shared data entities. This is the most direct translation of the product architecture into a marketing graphic.

**Visual ideas:**
- Central nodes: **Contact**, **Property**, **Funding Source**, **Program**.
- Orbital nodes: the 13 modules, placed around the center by primary entity.
- Lines pulse between modules that share data (e.g., HBE → DPA, DPA → Property Management, CMS → Procurement → AP).
- M365 sits as a security/identity ring around the whole diagram.

**Interaction:**
- Hover module → show its 3 bullets and phase link.
- Hover shared entity line → show exactly what data flows (e.g., "HBE completion record → DPA application").
- Click module → navigate to detail page.
- Add a legend: blue = client journey, green = back office, gold = funding/compliance.

**Best for:** A technical but accessible diagram on the Suite overview page.

---

## Recommended first build: hybrid of Option A + Option E

Create a single Power Pages page called `/how-it-works/` with a two-tab layout:

**Tab 1: "The nonprofit lifecycle" (Option A)**
- Horizontal scrollable subway map with six phases.
- Each phase expands to show activities, roles, and modules.
- Keep it high-level and mission-first.

**Tab 2: "The connected system" (Option E)**
- SVG node/line map of modules and shared entities.
- Click a module to open its detail page.
- Toggle the M365 layer on/off.

Both tabs share the same design language and call back to the same detail pages, so the site stays coherent.

---

## Content structure for the interactive page

```markdown
/how-it-works/
├── Hero: "One mission. One operating system."
├── Tab 1: The lifecycle subway map
│   ├── Phase 1: Outreach & intake
│   ├── Phase 2: Education & counseling
│   ├── Phase 3: Assistance application
│   ├── Phase 4: Development & construction
│   ├── Phase 5: Property & tenancy management
│   └── Phase 6: Stewardship & impact
├── Tab 2: The connected system map
│   ├── Central entities: Contact, Property, Funding Source, Program
│   ├── Module nodes with shared-data lines
│   └── M365 layer toggle
├── Call to action: schedule a demo / contact form
└── SEO: meta description, keywords
```

---

## Narrative arc for the page

1. **Hook:** "Affordable housing nonprofits run a dozen businesses at once — counseling, lending, development, property management, fundraising, and compliance. Most cobble together spreadsheets and apps that don't talk."
2. **Promise:** "Max Power Suite is designed as one operating system for the entire lifecycle."
3. **Proof (lifecycle):** Walk through the six phases with real activities and roles.
4. **Proof (system):** Show the modules and how they share data.
5. **Differentiator:** "Managed M365 is the secure foundation. Copilot Studio agents work across every module. You don't need an IT department to keep it running."
6. **CTA:** "See the suite in action." → contact form.

---

## Copy principles for the interactive graphic

- **Lead with the mission, not the software.** "Help a family buy their first home" is the headline; "DPA module" is the footnote.
- **Use verbs, not nouns.** "Counselors track attendance and issue certificates" is better than "Homebuyer Education functionality."
- **Show the handoff.** Every transition between phases should name the data that moves automatically (e.g., "HBE completion → DPA application").
- **Avoid feature lists inside the graphic.** The graphic is the teaser; the detail pages are the close.
- **Make the M365 layer visible but not dominant.** Security, identity, email, and AI are the rails, not the train.

---

## Technical implementation options

| Approach | Pros | Cons | Best fit |
|---|---|---|---|
| Mermaid.js + custom CSS | Already in repo, version-controlled, easy to maintain | Limited interactivity | Static diagrams in docs or detail pages |
| Custom SVG + vanilla JS | Full control, fast, no dependencies | Requires hand-coding animations | Hero interactive graphic on `/how-it-works/` |
| Power Pages embed + custom web template | Lives inside the portal, can read Dataverse | More complex build | Future: dynamic org-specific diagram |
| Excalidraw / Figma → exported SVG | Fast design iteration, beautiful | Static unless heavily post-processed | Initial concept and stakeholder review |
| React/Vue component in the site | Rich animations, state management | Adds build complexity to current Power Pages site | If we later migrate to a modern frontend |

Given the current Power Pages v2 setup, the cleanest first step is a **custom SVG inside a web template** plus a small vanilla-JS snippet for hover/click interactions. It is one HTML file, no build pipeline, and can be iterated directly in `scripts/Build-Site.ps1`.

---

## Suggested next steps

1. **Pick a primary concept.** Recommend the hybrid lifecycle + connected-system page.
2. **Draft the six-phase narrative.** Write one paragraph per phase in plain nonprofit language.
3. **Create a static Figma or Excalidraw wireframe.** Review with stakeholders before coding.
4. **Build the SVG in `Build-Site.ps1`.** Generate a new `/how-it-works/` page with both tabs.
5. **Add links from the home page.** Replace the hero "Explore the suite ↓" button with a secondary "See how the lifecycle works →" button.
6. **Measure.** Track click-through rate on the graphic and time on the `/how-it-works/` page.

---

## One-liner to test the concept

> "From the first intake form to the final HUD report, Max Power Suite runs the entire affordable-housing nonprofit lifecycle on one secure, AI-ready platform."

If that sentence resonates with prospects, the graphic is worth building.
