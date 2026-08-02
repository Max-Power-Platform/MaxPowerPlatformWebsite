# Edit workflow

Two valid editors. Pick one per session.

## Path A — Studio first (recommended for content / copy)

1. Edit in Power Pages Studio against Dev.
2. From repo root: `pwsh ./scripts/pages-download.ps1 -Env dev`
3. Review diff in Git, commit, push, PR.
4. Merge → CI runs lint + size budget.
5. Promote: `pwsh ./scripts/pages-upload.ps1 -Env uat`
6. Sanity check UAT URL.
7. Promote: `pwsh ./scripts/pages-upload.ps1 -Env prod -ConfirmProd`

## Path B — Local first (recommended for Liquid / structural changes)

1. Edit `.html` (Liquid) or `.json` (site settings) under `src/website/`.
2. `pwsh ./scripts/pages-upload.ps1 -Env dev`
3. Verify in Dev portal URL.
4. Commit, PR, merge, promote (steps 4-7 from Path A).

## Conflict resolution

If you edited Studio AND local since the last download:

1. `pwsh ./scripts/pages-download.ps1 -Env dev` (writes Studio's version into a new branch `chore/studio-resync-{date}`)
2. Resolve conflicts in Git.
3. `pwsh ./scripts/pages-upload.ps1 -Env dev` once green.

## Hard rules

- **Never** upload directly to Prod without going through UAT first.
- **Never** commit secrets (tokens, env URLs containing GUIDs of secret resources).
- The `Anonymous Users` web role must remain the only role granting access to home + module pages. CI will fail PRs that change that.
