$softwareRepo = "C:\buildArtifacts\OneDrive"

# Create OneDrive for Business software repository
Write-Host "VM Build: Creating OneDrive for Business software repository"
if( -Not (Test-Path -Path $softwareRepo ) )
{
    New-Item -ItemType directory -Path $softwareRepo -Force -ErrorAction SilentlyContinue
}

# Download OneDrive for Business
Write-Host "VM Build: Downloading OneDrive for Business latest software"
Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=844652" -OutFile "$softwareRepo\OneDriveSetup.exe"

# Install OneDrive for Business
Write-Host "VM Build: Installing OneDrive for Business"
Start-Process -FilePath "$softwareRepo\OneDriveSetup.exe" -ArgumentList "/allusers" -Wait
Write-Host "VM Build: Completed OneDrive for Business installation"