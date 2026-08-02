# OWNERS — `MaxPowerPlatformWebsite`

> Who is accountable for what in this repo. Required by `suite-scope.json` and the Suite ALM checklist.

| Area | Primary | Backup |
| --- | --- | --- |
| Repo (overall) | max@maxpowerplatform.com | _unassigned_ |
| Power Pages site | max@maxpowerplatform.com | _unassigned_ |
| Web templates (Liquid) | max@maxpowerplatform.com | _unassigned_ |
| Content / copy | max@maxpowerplatform.com | _unassigned_ |
| Scripts (download/upload) | max@maxpowerplatform.com | _unassigned_ |
| CI/CD workflows | max@maxpowerplatform.com | _unassigned_ |
| Documentation | max@maxpowerplatform.com | _unassigned_ |

> Authoritative environment + infra config: [`docs/environments.md`](docs/environments.md).

## Decision rights

- **Content changes:** primary owner, no extra approval.
- **Template / Liquid changes:** primary owner + UAT smoke test before Prod.
- **Site settings / auth changes:** primary owner + review.
- **Prod deploy:** GH environment review gate required.
