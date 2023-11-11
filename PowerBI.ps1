$softwareRepo = "C:\buildArtifacts\PowerBI\Desktop"

# Download the latest PowerBI Desktop software
Write-Host "VM Build: Downloading the latest PowerBI Desktop software"
Invoke-WebRequest -Uri "https://download.microsoft.com/download/8/8/0/880BCA75-79DD-466A-927D-1ABF1F5454B0/PBIDesktopSetup_x64.exe" -OutFile "$softwareRepo\PBIDesktopSetup_x64.exe"

# Install Microsoft Teams per-machine
Write-Host "VM Build: Installing PowerBI Desktop"
Start-Process -FilePath $softwareRepo\PBIDesktopSetup_x64.exe -ArgumentList "/quiet /norestart /log $softwareRepo\PowerBI_Install.log ACCEPT_EULA=1 DISABLE_UPDATE_NOTIFICATION=1" -Wait
Write-Host "VM Build: Completed PowerBI Desktop installation"