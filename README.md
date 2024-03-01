# hideAdminAccount
Windows scripts to hide local admin accounts from Logon screen.

## Uses
This is useful for hiding local administrator accounts on Windows workstations while maintaining UAC usability.  

## Setup 
Edit SpecialAccounts.ps1 line 11 and set $acct to the exact name of the account you want to hide. Make sure to maintain the "quotes" around the account name.
```
$acct = "JOE"
```

## Use
All three files hideWinUser.bat, EnumAdmins.ps1, and SpecialAccounts.ps1 must be in the same directory. Right-click hideWinUser and 'Run as administrator'.

## Notes
I'm not going to tell you what to do, but you'd be a fool not to create a System Restore point before running this.  
This script essentially adds the following two registry keys:  

This key enables you to manually enter the local administrator account in UAC popups.  
```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI]
"EnumerateAdministrators"=dword:00000000
```

This key specifies the account to hide from the Windows Logon screen.  
```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList]
"IT"=dword:00000000
```

## Credits
I found the following posts useful in the making of these scripts:  
- https://devblogs.microsoft.com/scripting/update-or-add-registry-key-value-with-powershell/
- https://stackoverflow.com/questions/58205772/powershell-to-add-reg-key