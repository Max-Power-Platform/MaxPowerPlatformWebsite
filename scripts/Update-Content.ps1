#requires -Version 7
# DEPRECATED_FAIL_CLOSED: AB2074 / accepted AB2044 content-authority contract.
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
throw 'Update-Content.ps1 is retired and cannot write portal source. Edit scripts/Build-Site.ps1, then run scripts/Test-ContentAuthority.ps1.'
