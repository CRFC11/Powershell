$softwareRepo = "C:\buildArtifacts\M365"
$odt = "officedeploymenttool_16227-20258.exe"

# Create M365 software repository
Write-Host "VM Build: Creating M365 software repository"
if( -Not (Test-Path -Path $softwareRepo ) )
{
    New-Item -ItemType Directory -Path $softwareRepo -Force -ErrorAction SilentlyContinue
}

# Download latest Office Deployment Tool
Write-Host "VM Build: Downloading the latest Office Deployment Tool software"
Invoke-WebRequest -Uri "https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/$odt" -OutFile "$softwareRepo\ODT.exe"

# Extract Office Deployment Tool software
Write-Host "VM Build: Extracting the Office Deployment Tool software"
Invoke-Expression -Command "$softwareRepo\ODT.exe /extract:$softwareRepo /quiet /norestart"
Start-Sleep 5

# Install Microsoft 365 Apps for Enterprise
Write-Host "VM Build: Installing Microsoft 365 Apps for Enterprise"
Start-Process -FilePath "$softwareRepo\Setup.exe" -ArgumentList "/configure $softwareRepo\M365_Apps.xml" -Wait 
Write-Host "VM Build: Completed Microsoft 365 Apps for Enterprise installation"