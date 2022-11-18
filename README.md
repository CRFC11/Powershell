# CHECK THIS
Ensure Modules are present for instance https://www.powershellgallery.com/packages/ExchangeOnlineManagement/3.0.0

# Powershell
2 Steps before using scripts:

1

Connect-MsolService


2

Get-MsolUser -All | Where {$_.StrongAuthenticationMethods -ne $null -or $_.StrongAuthenticationRequirements.State -ne $nul}

# For 365/AAD edits commands can be found at:
https://learn.microsoft.com/en-us/powershell/module/msonline/?view=azureadps-1.0#msonline

# For Exch
Import-Module ExchangeOnlineManagement

# This will prompt a MFA login on the default browser#

Connect-ExchangeOnline -UserPrincipalName navin@contoso.com 
