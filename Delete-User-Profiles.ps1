﻿$profiles = Get-WMIObject -ClassName win32_userprofile | Where-Object {($_.LocalPath -ne "C:\Users\aglocaladm") -and ($_.LocalPath -ne "C:\Users\svr_AzureVirtualDesk") -and ($_.LocalPath -ne "C:\Windows\ServiceProfiles\UIFlowService") -and ($_.LocalPath -ne "C:\Windows\ServiceProfiles\NetworkService") -and ($_.LocalPath -ne "C:\Windows\ServiceProfiles\LocalService") -and ($_.LocalPath -ne "C:\Windows\system32\config\systemprofile")} | Select-Object LocalPath,SID
foreach ($profile in $profiles) {
    Get-WMIObject -ClassName win32_userprofile | Where-Object {$_.SID -eq $profile.SID} | Remove-WmiObject -Verbose
}