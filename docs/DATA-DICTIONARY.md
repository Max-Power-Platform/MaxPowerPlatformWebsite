# Data Dictionary
## MaxPowerPlatformWebsite — `www.maxpowerplatform.com`

**Version**: 1.0  
**Date**: 2026-08-02  
**Status**: As-Is Documentation

---

## 1. Site Settings (24)

All configuration stored as `adx_sitesetting` records in Dataverse. Rendered via `{% settings %}` Liquid object.

### 1.1 Authentication — Azure AD B2C

| Setting Name | Value | Description |
|---|---|---|
| `Authentication/OpenIdConnect/AAD-B2C_1/Authority` | `https://mppportalusers.b2clogin.com/tfp/3f6e9128-d4c4-4439-bd9e-6178becef4c4/b2c_1_loginflow/v2.0/` | B2C authority URL |
| `Authentication/OpenIdConnect/AAD-B2C_1/ClientId` | `7c253859-d3b9-42e2-9142-7f1778c69efb` | B2C application client ID |
| `Authentication/OpenIdConnect/AAD-B2C_1/RedirectUri` | `https://mpp2.powerappsportals.com/signin-aad-b2c_1` | Post-login redirect |
| `Authentication/OpenIdConnect/AAD-B2C_1/Caption` | `Email` | Login button label |
| `Authentication/OpenIdConnect/AAD-B2C_1/DefaultPolicyId` | `B2C_1_passwordreset` | Default B2C policy |
| `Authentication/OpenIdConnect/AAD-B2C_1/PasswordResetPolicyId` | `B2C_1_passwordreset` | Password reset policy |
| `Authentication/OpenIdConnect/AAD-B2C_1/ValidIssuers` | `https://mppportalusers.b2clogin.com/tfp/3f6e9128-d4c4-4439-bd9e-6178becef4c4/b2c_1_passwordreset/v2.0/` | Valid token issuers |
| `Authentication/OpenIdConnect/AAD-B2C_1/RegistrationEnabled` | `true` | Allow self-registration |
| `Authentication/OpenIdConnect/AAD-B2C_1/AllowContactMappingWithEmail` | `true` | Map B2C users to Dataverse Contacts by email |
| `Authentication/OpenIdConnect/AAD-B2C_1/ExternalLogoutEnabled` | `true` | Federated sign-out |
| `Authentication/Registration/LocalLoginEnabled` | `false` | Disable local (non-federated) login |

### 1.2 Feature Toggles

| Setting Name | Value | Description |
|---|---|---|
| `Site/BootstrapV5Enabled` | `true` | Use Bootstrap 5 (not v4) |
| `Search/Enabled` | `True` | Enable site-wide search index |
| `Profile/Enabled` | `true` | Enable user profile page |
| `ThemeFeature` | `{"status":"enable","selectedThemeId":"0f6ab1e0-...","version":"V2"}` | Theme V2 with selected theme |
| `MultiLanguage/DisplayLanguageCodeInURL` | `False` | Don't show lang code in URL |

### 1.3 Performance & Caching

| Setting Name | Value | Description |
|---|---|---|
| `Header/OutputCache/Enabled` | `True` | Cache header template output |
| `Footer/OutputCache/Enabled` | `True` | Cache footer template output |

### 1.4 Security

| Setting Name | Value | Description |
|---|---|---|
| `HTTP/X-Frame-Options` | `SAMEORIGIN` | Prevent clickjacking |
| `OnlineDomains` | `sharepoint.com;microsoftonline.com` | Allowed domains for iframe embedding |

### 1.5 UI

| Setting Name | Value | Description |
|---|---|---|
| `Header/ShowAllProfileNavigationLinks` | `false` | Limit profile nav to current user links |
| `CustomerSupport/DisplayAllUserActivitiesOnTimeline` | `false` | Hide full timeline for support users |

### 1.6 Internal

| Setting Name | Value | Description |
|---|---|---|
| `Metadata/Template-Version` | `1.2304.1.0` | Power Pages template version |
| `MultiLanguage/MaximumDepthToClone` | `3` | Max depth when cloning multi-language pages |

---

## 2. Web Pages (25 records in Dataverse: `adx_webpage`)

| Field | Description | Example |
|---|---|---|
| `adx_name` | Logical name | `Home`, `Hbe`, `Dpa` |
| `adx_title` | Display title | `Home`, `Homebuyer Education` |
| `adx_partialurl` | URL slug | `/`, `hbe`, `dpa` |
| `adx_pagetemplateid` | Page template reference | `383840f8-ed48-4d41-ab6c-bf5cd0d7ef21` |
| `adx_parentpageid` | Parent page reference | `e600cd70-...` (Home) |
| `adx_publishingstateid` | Published/Draft | `eb607d5d-...` (Published) |
| `adx_displayorder` | Sort order | 1, 2, 50 |
| `adx_hiddenfromsitemap` | Hide from nav | `true` for module pages |
| `adx_excludefromsearch` | Exclude from search index | `true` for Access Denied, 404 |
| `adx_copy` | Editable HTML content | (rich text from Studio) |
| `adx_summary` | Meta description | (from `.webpage.summary.html`) |
| `adx_customcss` | Page-specific CSS | (from `.webpage.custom_css.css`) |
| `adx_customjavascript` | Page-specific JS | (from `.webpage.custom_javascript.js`) |

---

## 3. Page Templates (4 records: `adx_pagetemplate`)

| Field | Default Studio Template | Access Denied | Profile | Search |
|---|---|---|---|---|
| `adx_name` | Default studio template | Access Denied | Profile | Search |
| `adx_type` | Web Template (`756150001`) | Rewrite URL (`756150000`) | Rewrite URL (`756150000`) | Rewrite URL (`756150000`) |
| `adx_rewriteurl` | *(none)* | `~/Pages/AccessDenied.aspx` | `~/Pages/Profile.aspx` | `~/Pages/Search.aspx` |
| `adx_webtemplateid` | `03b1ca80-...` | *(none)* | *(none)* | `9c5c6682-...` |

---

## 4. Web Templates (12 records: `adx_webtemplate`)

| Name | MIME Type | Key Liquid Objects |
|---|---|---|
| Breadcrumbs | `text/html` | `page.breadcrumbs`, `page.title` |
| Default studio template | `text/html` | `adx_copy` |
| Footer | `text/html` | `snippets.Footer` |
| Header | `text/html` | `snippets["Mobile Header"]`, `snippets["Logo URL"]` |
| Languages Dropdown | `text/html` | `website.languages` |
| Layout 2 Column Wide Left | `text/html` | `{% block %}`, `adx_title`, `adx_copy` |
| Page Copy | `text/html` | `adx_copy` |
| Page Header | `text/html` | `adx_title` |
| Pagination | `text/html` | `current_page`, `page_size`, `total` |
| Power Virtual Agents | `text/html` | `adx_botconsumer` |
| search | `text/html` | `snippets["Header/Search/ToolTip"]` |
| Search Results | `text/html` | `{% searchindex %}`, `{% for result in searchresults %}` |

---

## 5. Content Snippets (11 records: `adx_contentsnippet`)

| Display Name | Internal Name | Type | Purpose |
|---|---|---|---|
| Footer | `Footer` | HTML | Footer content (copyright, links) |
| Header/Search/ToolTip | `Header/Search/ToolTip` | Text | Search input tooltip |
| Header/Toggle Navigation | `Header/Toggle Navigation` | HTML | Mobile nav toggle |
| Logo alt text | `Logo alt text` | Text | Logo `<img alt="">` |
| Logo URL | `Logo URL` | Text | Logo image URL |
| Mobile Header | `Mobile Header` | HTML | Mobile header markup (logo) |
| Search/No Results | `Search/NoResults` | Text | "No results found" message |
| Search/Results Count | `Search/ResultsCount` | Text | "X results found" message |
| Search/Results Title | `Search/ResultsTitle` | Text | Search results page title |
| Search/Title | `Search/Title` | Text | Search page title |
| Site name | `Site name` | Text | Browser tab title |

---

## 6. Web Link Sets (2 records: `adx_weblinkset`)

### `default` — Main Navigation

| Link Name | Parent | Target Page | Display Order |
|---|---|---|---|
| Home | *(none)* | Home | 1 |
| Programs | *(none)* | *(none — container)* | 2 |
| ↳ Homebuyer Education | Programs | Hbe | 1 |
| ↳ Down Payment Assistance | Programs | Dpa | 2 |
| ↳ Home Repair | Programs | Hrrp | 3 |
| ↳ Construction Management | Programs | Cms | 4 |
| ↳ Property Management | Programs | PropertyManagement | 5 |
| Operations | *(none)* | *(none — container)* | 3 |
| ↳ Accounts Payable | Operations | AccountsPayable | 1 |
| ↳ Procurement | Operations | Procurement | 2 |
| ↳ Property Analyzer | Operations | FindJurisdiction | 3 |
| Engagement | *(none)* | *(none — container)* | 4 |
| ↳ Fundraising | Engagement | Fundraising | 1 |
| ↳ Grants | Engagement | Grants | 2 |
| ↳ Volunteers | Engagement | Volunteers | 3 |
| ↳ Bulk Email | Engagement | Bulk-email | 4 |
| Roadmap | *(none)* | *(none — container)* | 5 |
| ↳ Human Resources | Roadmap | Hr | 1 |
| ↳ Learning Management | Roadmap | Lms | 2 |
| ↳ Plan Manager | Roadmap | PlanManager | 3 |

### `profile-navigation` — Profile Menu

| Link Name | Target Page |
|---|---|
| Profile | Profile |

---

## 7. Web Files (62 records: `adx_webfile` + `annotation`)

31 unique files × 2 (file + `.webfile.yml` companion):

| Category | Count | Key Files |
|---|---|---|
| CSS | 4 | `bootstrap.min.css`, `theme.css`, `portalbasictheme.css`, `thumbnail.css` |
| Logos | 5 | `mpp-logo.png`, `mpp-logo-square.jpg`, `Logo-sm-64.png`, `logo.png.png`, `Cat-PC.png` |
| Home Images | 3 | `home-1.png`, `home-2.png`, `subpage-one.png` |
| Decorative | 3 | `Copy-number-1.png`, `Copy-number-2.png`, `Copy-number-3.png` |
| Legal Section Images | 6 | `Legal_*.jpg`, `Legal-2_*.jpg`, `Legal-3_*.jpg` |
| Privacy Section Images | 7 | `Privacy*.jpg`, `Privacy-2*.jpg`, `Privacy-3..6.jpg` |
| Terms Section Images | 6 | `Terms.jpg`, `Terms-2..6.jpg` |
| Misc | 1 | `Under-Construction.png` |

Each web file record has:
- `adx_name`, `adx_partialurl`, `adx_publishingstateid`
- Associated `annotation` (file attachment) with the actual binary

---

## 8. Web Roles (3 records: `adx_webrole`)

| Name | Anonymous Users Role | Authenticated Users Role |
|---|---|---|
| Anonymous Users | ✅ | ❌ |
| Authenticated Users | ❌ | ✅ |
| Administrators | ❌ | ❌ |

---

## 9. Website Access Permissions (2 records: `adx_websiteaccess`)

| Name | Preview Unpublished | Manage Snippets | Manage Site Markers | Manage Web Link Sets | Role |
|---|---|---|---|---|---|
| Preview permission (Site design 005) | ✅ | ❌ | ❌ | ❌ | *(none)* |
| Administrative permissions (Site design 005) | ✅ | ✅ | ✅ | ✅ | Administrators |

---

## 10. Web Page Access Rules (2 records: `adx_webpageaccesscontrolrule`)

| Name | Right | Scope | Target Page | Role |
|---|---|---|---|---|
| Grant Change to Content | Grant Change (1) | All Content (1) | *(global)* | *(none)* |
| Grant Change to Administrators | Grant Change (1) | All Content (1) | Home | Administrators |

---

## 11. Site Markers (5 records: `adx_sitemarker`)

| Name | Target Page |
|---|---|
| Home | Home (`e600cd70`) |
| Page Not Found | Page Not Found (`65ddeb38`) |
| Access Denied | Access Denied (`8ea95c21`) |
| Profile | Profile (`892eb39b`) |
| Search | Search (`a1554e48`) |

---

## 12. Publishing States (2 records: `adx_publishingstate`)

| Name | Display Order | Is Default | Is Visible |
|---|---|---|---|
| Draft | 1 | ❌ | ❌ |
| Published | 2 | ✅ | ✅ |

---

## 13. Website Language (1 record: `adx_websitelanguage`)

| Name | LCID | Portal Language ID |
|---|---|---|
| English | 1033 | `616149d4-cf5f-4127-bf22-ac929aaf11e2` |

---

## 14. Bot Consumer (1 record: `adx_botconsumer`)

| Name | ID | Bot Schema Name |
|---|---|---|
| Bot Consumer | `02ede270-57f3-ee11-904c-6045bdd736b6` | `cr27b_99c91920-3594-4112-8c81-e7418fcf338d` |

---

## 15. Liquid Objects Reference

Key Liquid objects available in templates:

| Object | Description |
|---|---|
| `page` | Current page record (`page.title`, `page.breadcrumbs`, `page.children`) |
| `adx_copy` | Editable HTML content of the current page |
| `adx_title` | Title of the current page |
| `snippets` | Content snippets by name (`snippets["Footer"]`) |
| `settings` | Site settings by name (`settings["Search/Enabled"]`) |
| `website` | Website record (`website.languages`) |
| `user` | Current user (`user.fullname`, `user.roles`) |
| `entities` | Dataverse entity access (`entities.contact`) |
| `searchresults` | Search index results (in search template) |
| `adx_botconsumer` | Bot Consumer entity |
| `{% searchindex %}` | Liquid tag for search queries |
