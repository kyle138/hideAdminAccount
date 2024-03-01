@echo off
:begin
 CLS

:choose
  CHOICE /M "Did you create a System Restore point?"
  if not errorLevel 1 goto choose
  if errorLevel 2 exit /B 

:checkPerms
  CLS
  net session >nul 2>&1
  if %errorLevel% == 0 (
    powershell.exe -executionpolicy bypass -File %0\..\EnumAdmins.ps1
    timeout /t -1
    powershell.exe -executionpolicy bypass -File %0\..\SpecialAccounts.ps1
    timeout /t -1
  ) else (
    echo Failure: This must be run as Administrator
    timeout /t -1
  )
