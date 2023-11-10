$softwareRepo = "C:\buildArtifacts\MicrosoftTeams"
$installPath = "C:\Program Files (x86)\Microsoft\Teams\current\Teams.exe"

# Create Microsoft Teams software repository
Write-Host "VM Build: Creating Microsoft Teams software repository"
if ( -Not (Test-Path -Path $softwareRepo ) )
{
    New-Item -ItemType Directory -Path $softwareRepo -Force -ErrorAction SilentlyContinue
}

# Create registry key for Microsoft Teams on AVD
Write-Host "VM Build: Adding registry key for Microsoft Teams optimization on AVD"
New-Item -Path HKLM:\SOFTWARE\Microsoft -Name "Teams" -ErrorAction SilentlyContinue
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Teams -Name "IsWVDEnvironment" -Type "Dword" -Value "1" -ErrorAction SilentlyContinue
Write-Host "VM Build: Completed adding registry key for Microsoft Teams on AVD"

# Download the latest Microsoft Visual C++ Redistributable 
Write-Host "VM Build: Downloading the latest Microsoft Visual C++ Redistributable"
Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vc_redist.x64.exe" -OutFile "$softwareRepo\VisualC++Redist.exe"

# Install Microsoft Visual C++ Redistributable 
Write-Host "VM Build: Installing Microsoft Visual C++ Redistributable"
Start-Process -FilePath "$softwareRepo\VisualC++Redist.exe" -ArgumentList "/q /norestart /log $softwareRepo\VisualC++Redist.log" -Wait
Write-Host "VM Build: Completed Microsoft Visual C++ Redistributable installation"

# Download the latest Remote Desktop WebRTC Redirector Service 
Write-Host "VM Build: Downloading the latest Remote Desktop WebRTC Redirector Service software"
Invoke-WebRequest -Uri "https://aka.ms/msrdcwebrtcsvc/msi" -OutFile "$softwareRepo\MsRdcWebRTCSvc.msi"

# Install Remote Desktop WebRTC Redirector Service
Write-Host "VM Build: Installing the Remote Desktop WebRTC Redirector Service"
Start-Process -FilePath Msiexec.exe -ArgumentList "/i $softwareRepo\MsRdcWebRTCSvc.msi /qn /l*v $softwareRepo\MsRdcWebRTCSvc.log"
Write-Host "VM Build: Completed Remote Desktop WebRTC Redirector Service installation"

# Check if Teams is already installed, and if so, uninstall
Write-Host "VM Build: Checking for existing Microsoft Teams installation"
if (Test-Path -Path $installPath)
{
    Start-Process -FilePath Msiexec.exe -ArgumentList "/x $softwareRepo\MsTeamsPerMachine.msi /l*v $softwareRepo\MsTeamsPerMachineUninstall.log /qn" -Wait
}

# Download the latest Microsoft Teams per-machine software
Write-Host "VM Build: Downloading the latest Microsoft Teams per-machine software"
Invoke-WebRequest -Uri "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=windows&arch=x64&managedInstaller=true&download=true" -OutFile "$softwareRepo\MsTeamsPerMachine.msi"

# Install Microsoft Teams per-machine
Write-Host "VM Build: Installing Microsoft Teams per-machine"
Start-Process -FilePath Msiexec.exe -ArgumentList "/i $softwareRepo\MsTeamsPerMachine.msi /l*v $softwareRepo\MsTeamsPerMachine.log ALLUSER=1 ALLUSERS=1 /qn" -Wait
Write-Host "VM Build: Completed Microsoft Teams per-machine installation"