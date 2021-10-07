# Powershell
2 Steps before using scripts:

1

Connect-MsolService


2

Get-MsolUser -All | Where {$_.StrongAuthenticationMethods -ne $null -or $_.StrongAuthenticationRequirements.State -ne $nul}


For Exch
Import-Module ExchangeOnlineManagement

#This will prompt a MFA login on the default browser#
Connect-ExchangeOnline -UserPrincipalName navin@contoso.com 
