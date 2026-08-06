#requires -Version 7
# DEPRECATED_FAIL_CLOSED: AB2074 / accepted AB2044 content-authority contract.
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
throw 'Generate-ModulePages.ps1 is retired and cannot write portal source. Edit scripts/Build-Site.ps1 and scripts/content-authority.ids.json, then run scripts/Test-ContentAuthority.ps1.'
