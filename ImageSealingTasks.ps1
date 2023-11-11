Write-Host "Deleting logs, please wait" -ForegroundColor Green
Start-Process PowerShell.exe -ArgumentList "C:\buildArtifacts\Scripts\EventLogs\Delete-Logs.ps1" -Wait

Write-Host "Removing Appx Packages, please wait" -ForegroundColor Green
Start-Process PowerShell.exe -ArgumentList "C:\buildArtifacts\Scripts\AppxPackage\Remove-AppxPackage.ps1" -Wait

Write-Host "Deleting local user profiles, please wait" -ForegroundColor Green
Start-Process PowerShell.exe -ArgumentList "C:\buildArtifacts\Scripts\UserProfiles\Delete-User-Profiles.ps1" -Wait

Write-Host "Cleaning up Appx Packages, please wait" -ForegroundColor Green
Start-Process PowerShell.exe -ArgumentList "C:\buildArtifacts\Scripts\AppxPackage\Cleanup-AppxPackage.ps1" -Wait

Write-Host "Configuring Foxit PDF display in browser settings, please wait" -ForegroundColor Green
Start-Process Cmd.exe -ArgumentList "/c `"C:\Program Files (x86)\Foxit Software\Foxit PDF Reader\FoxitPDFReader.exe`" -displayinbrowser"

Write-Host "Executing Sysprep, please confirm to continue" -ForegroundColor Green
Start-Process Cmd.exe -ArgumentList "/c C:\buildArtifacts\Scripts\Sysprep\Sysprep.cmd"
