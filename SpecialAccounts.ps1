# Hide the specified user from Windows logon screen by creating SpecialAccounts/UserList key

#$DebugPreference = 'Continue'
$DebugPreference = 'SilentlyContinue'

# ****************************************
# Set the name of the user account to hide
# Obviously, you must change this to the actual name of the account you wish to hide (unless it's named Joe)
# I'm not going to tell you what to do, but make sure you leaves "quotes" around whatever name you set.
# Otherwise everything breaks.
$acct = "JOE" 
# ****************************************

# Set the registry path
$path = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList'
$value = if((Get-ItemProperty -Path $path -Name "$acct" -ErrorAction SilentlyContinue).$acct -eq 0) {
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

  # Create the DWord with the same name as $acct and a value of 0
  Set-ItemProperty -Path $key.PSPath -Name "$acct" -Value 0
  Write-Host "Setting registry value..." -ForegroundColor Yellow
} else {
  Write-Host "The registry key " -ForegroundColor Yellow -NoNewline
  Write-Host $path -ForegroundColor Cyan -NoNewline
  Write-Host " already exists." -ForegroundColor Yellow
}