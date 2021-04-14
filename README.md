# Powershell
2 Steps before using scripts:

1

Connect-MsolService


2

Get-MsolUser -All | Where {$_.StrongAuthenticationMethods -ne $null -or $_.StrongAuthenticationRequirements.State -ne $nul}
