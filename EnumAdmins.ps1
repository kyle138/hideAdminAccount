# Set the EnumerateAdministrators value to 0
# This allows you to manually enter a local administrator account on UAC popups

#$DebugPreference = 'Continue'
$DebugPreference = 'SilentlyContinue'

# Set the registry path
$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'
$value = if ((Get-ItemProperty -Path $path -Name EnumerateAdministrators -ErrorAction SilentlyContinue).EnumerateAdministrators -eq 0) { 
  0 
} else {
  -1
}

Write-Debug $value
# Check if the value already exists, otherwise create it
if($value -ne 0) {

  Write-Debug "Not detected"

  # Check if the key already exists, otherwise create it
  $key = try {
    Get-Item -Path $path -ErrorAction Stop
    Write-Debug "Path found"
  } catch {
    New-Item -Path $path -Force
    Write-Debug "Path not found"
    Write-Host "Creating registry key: " -ForegroundColor Yellow -NoNewline
    Write-Host $path -ForegroundColor Cyan
  }
   
  # Create the EnumerateAdministrators value of 0
  Set-ItemProperty -Path $key.PSPath -Name EnumerateAdministrators -Value 0
  Write-Host "Setting registry value..." -ForegroundColor Yellow
} else {
  Write-Host "The registry key " -ForegroundColor Yellow -NoNewline
  Write-Host $path -ForegroundColor Cyan -NoNewline
  Write-Host " already exists." -ForegroundColor Yellow
}