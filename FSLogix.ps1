$softwareRepo = "C:\buildArtifacts\FSLogix"

# Create FSLogix software repository
Write-Host "VM Build: Creating FSLogix software repository"
if( -Not (Test-Path -Path $softwareRepo ) )
{
    New-Item -ItemType directory -Path $softwareRepo -Force -ErrorAction SilentlyContinue
}

# Download FSLogix Apps
Write-Host "VM Build: Downloading FSLogix Apps latest software"
$progressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://aka.ms/fslogix/download" -OutFile "$softwareRepo\FSLogix.zip"

# Extract FSLogix Apps
Write-Host "VM Build: Extracting FSLogix Apps software"
Expand-Archive -Path "$softwareRepo\FSLogix.zip" -DestinationPath "$softwareRepo" -Force
Start-Sleep 5

# Install FSLogix Apps
Write-Host "VM Build: Installing FSLogix Apps"
Start-Process -FilePath "$softwareRepo\x64\Release\FSLogixAppsSetup.exe" -ArgumentList "/install /quiet /norestart /log $softwareRepo\FSLogixApps.log" -Wait
Write-Host "VM Build: Completed FSLogix Apps installation"