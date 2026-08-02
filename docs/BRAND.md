# Brand & Content Guide
## MaxPowerPlatformWebsite — `www.maxpowerplatform.com`

**Version**: 1.0  
**Date**: 2026-08-02  
**Status**: As-Is Documentation

---

## 1. Brand Identity

### 1.1 Logo

| Asset | Usage |
|---|---|
| `mpp-logo.png` | Primary logo — used in hero section, displayed at max-width 480px, 80% on mobile |
| `mpp-logo-square.jpg` | Square variant (for favicon / social preview) |
| `Logo-sm-64.png` | Small 64px variant (mobile header) |
| `Cat-PC.png` | PC category icon |

**Logo placement**: Centered in hero section above the tagline, left-aligned in the Bootstrap navbar.

### 1.2 Tagline

> **"Frontier-first · AI-first"**

Rendered as a pill badge: `background: #e8f1fb`, `color: #1F66B5`, `font-weight: 600`, `font-size: .85rem`, `letter-spacing: .04em`, `text-transform: uppercase`, `padding: 6px 14px`, `border-radius: 99px`.

---

## 2. Color Palette

### Primary Colors

| Role | Hex | CSS Variable (implied) | Usage |
|---|---|---|---|
| **Primary Blue** | `#1F66B5` | — | Headings, tile top borders, buttons, links, brand badge |
| **Dark Blue** | `#1A4F8C` | — | Footer background |

### Secondary & UI Colors

| Role | Hex | Usage |
|---|---|---|
| **Light Blue Tint** | `#e8f1fb` | Tagline badge background |
| **Section Background** | `#f7f8fa` | Program, Operations, Engagement section backgrounds |
| **Roadmap Section Background** | `#f1f3f5` | "On the roadmap" section (slightly darker gray) |
| **Hero Background** | `#ffffff` | Hero section (white) |
| **Contact Section Background** | `#ffffff` | Contact section (white) |
| **Tile Background** | `#ffffff` | Tile card backgrounds |
| **Tile Border** | `#e3e3e3` | Tile card borders (`1px solid`) |
| **Roadmap Tile Border** | `#bdbdbd` | Roadmap tile top border (gray instead of blue) |
| **Tile Shadow** | `rgba(0,0,0,.06)` | `box-shadow: 0 1px 3px` |
| **Card Border Radius** | `8px` | Tile cards |
| **Contact Card Border Radius** | `10px` | Contact form card |

### Text Colors

| Role | Hex | Usage |
|---|---|---|
| **Body Text** | `#444` | Tile descriptions, general copy |
| **Muted Text** | `#666` | Section subtitles, secondary text |
| **Section Title** | `#7A6A65` | "Housing programs", "Back-office operations", etc. |
| **Heading Blue** | `#1F66B5` | H1, H2 (contact section), H3 tile titles |

### Button & Form Colors

| Role | Hex | Usage |
|---|---|---|
| **Primary Button Background** | `#1F66B5` | "Send message" button |
| **Primary Button Text** | `#ffffff` | White on blue |
| **Input Border** | `#ccc` | Form inputs (`1px solid`) |
| **Input Border Radius** | `6px` | All form inputs |
| **Success Text** | `#1a7f37` | Form submission success status |
| **Error Text** | `#b32525` | Form submission error status |

### Status Badges (Roadmap)

| Role | Hex | Usage |
|---|---|---|
| **"Soon" Badge Background** | `#fff3cd` | Yellow pill badge |
| **"Soon" Badge Text** | `#856404` | Dark yellow text |
| **"Soon" Badge Border** | `#ffeeba` | `1px solid` |

---

## 3. Typography

### Font Stack

The site inherits Power Pages Bootstrap 5 defaults. No custom `@font-face` declarations found — fonts rely on Bootstrap's native stack:

```css
font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
```

### Type Scale (from home page inline styles)

| Element | Size | Weight | Color |
|---|---|---|---|
| Tagline badge | `.85rem` | 600 | `#1F66B5` |
| H1 (hero) | *(Browser default ~2.5rem)* | 700 | `#1F66B5` |
| H2 (section titles) | *(Browser default ~2rem)* | *(default)* | `#7A6A65` |
| H3 (tile titles) | `1.1rem` | *(default)* | `#1F66B5` |
| Tile description | `.92rem` | *(default)* | `#444` |
| Section subtitle | `1rem` | *(default)* | `#666` |
| Hero description | `1.2rem` | *(default)* | `#444` |
| Form labels | `.9rem` | *(default)* | `#444` |
| Form inputs | `1rem` | *(default)* | *(browser default)* |
| Buttons | `1rem` | 600 | `#ffffff` |

### Letter Spacing

| Element | Value |
|---|---|
| Tagline badge | `.04em` |
| All other text | *(default)* |

---

## 4. Layout & Spacing

### Section Padding

| Section | Top Padding | Bottom Padding | Background |
|---|---|---|---|
| Hero | `64px` | `24px` | `#ffffff` |
| Programs | `48px` | `24px` | `#f7f8fa` |
| Operations | `48px` | `24px` | `#f7f8fa` |
| Engagement | `48px` | `24px` | `#f7f8fa` |
| Roadmap | `48px` | `24px` | `#f1f3f5` |
| Contact | `56px` | `64px` | `#ffffff` |

### Tile Grid

| Property | Value |
|---|---|
| Layout | CSS Flexbox (`flex-wrap: wrap`) |
| Gap | `18px` |
| Min Tile Width | `280px` (`flex: 1 1 280px`) |
| Max Tile Width | `340px` |
| Alignment | `justify-content: center` |
| Container | `max-width: 880px` (hero), `760px` (subtitles) |

### Tile Card Anatomy

```
┌─────────────────────────────────┐
│ border-top: 4px solid #1F66B5   │  ← Blue accent (gray for roadmap)
│ padding: 22px                   │
│                                 │
│  🏠 (emoji icon, 2rem)          │
│                                 │
│  Homebuyer Education            │  ← H3: #1F66B5, 1.1rem
│  HUD-style classes, 1:1...      │  ← P: #444, .92rem, line-height: 1.5
│                                 │
└─────────────────────────────────┘
  border: 1px solid #e3e3e3
  border-radius: 8px
  background: #ffffff
  box-shadow: 0 1px 3px rgba(0,0,0,.06)
```

---

## 5. Tone of Voice

### Brand Voice Attributes

| Attribute | Description |
|---|---|
| **Professional but approachable** | Explains complex platform capabilities in plain language |
| **Confident** | "A frontier-first, AI-first platform" — claims leadership without hyperbole |
| **Specific** | Names real integrations (Dataverse, Copilot Studio, Stripe, ACS) and compliance frameworks (SHIP, HOME, HUD) |
| **Helpful** | Every section ends with an action path — "Get in touch", email link, module drill-through |
| **Inclusive** | "your housing nonprofit need", "A real person responds" |

### Copy Patterns

**Tile descriptions** follow a consistent formula:
> `[what it is] — [key features] — [integrations/outcomes]`

Examples:
- *"HUD-style classes, 1:1 counseling, education lock-in, and certificate issuance — the front door to every assistance program."*
- *"SHIP & HOME-funded purchase assistance: applications, underwriting, awards, closings, liens, and HUD reporting."*

**Section introductions** use a two-line pattern:
```
<h2>Section title</h2>
<p>One-line description of what this group of modules does.</p>
```

### Naming Conventions

| Pattern | Example |
|---|---|
| Module names | Title Case: `Homebuyer Education`, `Down Payment Assistance` |
| Section names | Sentence case with colon: `Housing programs`, `Back-office operations` |
| Technical terms | Use real Microsoft product names: `Dataverse`, `Copilot Studio`, `Power Pages` |

---

## 6. Iconography

### Tile Icons

All tile icons are **emoji** rendered at `font-size: 2rem`:

| Module | Emoji | Unicode |
|---|---|---|
| Homebuyer Education | 🏠 | `&#127968;` |
| Down Payment Assistance | 💰 | `&#128176;` |
| Home Repair | 🔶 | `&#128736;` |
| Construction Management | 🏟 | `&#127959;` |
| Property Management | 🏛 | `&#127977;` |
| Accounts Payable | 🥶 | `&#129534;` |
| Procurement | 📦 | `&#128230;` |
| Property Analyzer | 📍 | `&#128205;` |
| Fundraising | 💝 | `&#129505;` |
| Grants | 📝 | `&#128221;` |
| Volunteers | 🤝 | `&#129309;` |
| Bulk Email | 📧 | `&#128231;` |
| Human Resources | 👥 | `&#128101;` |
| Learning Management | 🎓 | `&#127891;` |
| Plan Manager | 📊 | `&#128202;` |

---

## 7. Forms & CTAs

### Contact Form Fields

| Field | Required | Type | Default |
|---|---|---|---|
| First name | ✅ | `text` | — |
| Last name | ✅ | `text` | — |
| Email | ✅ | `email` | — |
| Organization | ❌ | `text` | — |
| Phone | ❌ | `tel` | — |
| Subject | ✅ | `text` | `"Website inquiry"` |
| Message | ✅ | `textarea` (5 rows) | — |

**Submit button**: `"Send message"`, `background: #1F66B5`, `color: #fff`, `border-radius: 6px`, `padding: 12px 32px`, `font-weight: 600`.

**Success message**: `"Thanks! We received your message and will be in touch shortly."` (green `#1a7f37`)

**Error message**: `"Sorry, the form could not be submitted. You can also email max@maxpowerplatform.com."` (red `#b32525`)

**Network error**: `"Network error. Please try again or email max@maxpowerplatform.com."`

**API endpoint**: `POST /_api/leads` (creates a Dataverse Lead record)

### CTAs

| Location | Copy | Action |
|---|---|---|
| Contact section | "Get in touch" | Lead form |
| Bottom of every section | *(implicit)* | Tile click → module page |
| Error fallback | `mailto:max@maxpowerplatform.com` | Email client |
| Privacy page | `mailto:admin@maxpowerplatform.com` | Email client |

---

## 8. Imagery

### Stock Photography Categories

| Category | Count | Used On |
|---|---|---|
| Legal section images | 6 JPGs | *(not visible on current home page — likely on dedicated legal page)* |
| Privacy section images | 7 JPGs | *(not visible on current home page — likely on privacy page)* |
| Terms section images | 6 JPGs | *(not visible on current home page)* |
| Home page images | 3 PNGs | `home-1.png`, `home-2.png`, `subpage-one.png` |
| Decorative | 3 PNGs | `Copy-number-1/2/3.png` |
| Under Construction | 1 PNG | `Under-Construction.png` (placeholder) |

**Image style notes**: All current decorative images appear to be generic Power Pages template stock. No custom photography or illustration system defined.

---

## 9. Content Snippets (Editable Brand Tokens)

These are the "global variables" of the brand — editable in Power Pages Studio without touching code:

| Snippet | Purpose | Current Value (approx.) |
|---|---|---|
| `Site name` | Browser `<title>` | *(set in Dataverse — likely "Max Power Platform")* |
| `Logo URL` | Logo image path | *(set in Dataverse)* |
| `Logo alt text` | Logo `<img alt>` | *(set in Dataverse)* |
| `Mobile Header` | HTML: mobile logo markup | *(set in Dataverse — contains logo img)* |
| `Footer` | HTML: footer content | *(set in Dataverse — copyright, links)* |
| `Header/Search/ToolTip` | Text: search input tooltip | *(set in Dataverse)* |
| `Header/Toggle Navigation` | HTML: mobile nav label | *(set in Dataverse)* |
| `Search/NoResults` | Text: "no results" message | *(set in Dataverse)* |
| `Search/Results Count` | Text: "X results" template | *(set in Dataverse)* |
| `Search/Results Title` | Text: results page title | *(set in Dataverse)* |
| `Search/Title` | Text: search page title | *(set in Dataverse)* |

> ⚠️ Snippet values live in Dataverse, not in the YAML export. To see actual values, view them in Power Pages Studio or query the `adx_contentsnippet` table.

---

## 10. Quick Reference Card

```
┌─────────────────────────────────────────────────────┐
│  MAX POWER PLATFORM — BRAND QUICK REFERENCE          │
├─────────────────────────────────────────────────────┤
│  Primary Blue:    #1F66B5    Footer Blue:  #1A4F8C  │
│  Section BG:      #f7f8fa    Text:         #444     │
│  Muted Text:      #666        Section Title:#7A6A65  │
│                                                     │
│  Tile border:     1px #e3e3e3, top 4px #1F66B5      │
│  Tile radius:     8px         Tile shadow:  0 1px 3px│
│  Tile min/max:    280px/340px Gap:          18px     │
│                                                     │
│  H1:  700 weight, #1F66B5                           │
│  H2:  #7A6A65                                       │
│  H3:  1.1rem, #1F66B5                               │
│  P:   .92rem, #444, line-height 1.5                  │
│                                                     │
│  Button:  #1F66B5 bg, #fff text, 6px radius          │
│  Input:   1px #ccc, 6px radius                       │
│                                                     │
│  Tagline: "Frontier-first · AI-first"                │
│  Contact: max@maxpowerplatform.com                   │
│                                                     │
│  Tone: Professional, confident, specific, helpful     │
└─────────────────────────────────────────────────────┘
```
