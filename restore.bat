@echo off
:: Enable Task Manager
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /t REG_DWORD /d 0 /f

:: Enable USB Storage write access (file transfer)
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies" /v WriteProtect /f

:: Enable USB Storage read access (file reading)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v Start /t REG_DWORD /d 3 /f

:: Enable Ctrl+Alt+Delete options by showing the security screen
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableLockWorkstation /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableChangePassword /f

:: Show "This PC" and other Explorer windows
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoViewOnDrive /f

:: Enable File Explorer for the current user
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoFileFolderOpening /f

:: Enable write access to USB devices
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDrives /f

:: Enable desktop icons by resetting NoDesktop key
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDesktop /f

:: Enable Win+R and other hotkeys
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoWinKeys /f

:: Enable Alt+Tab
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAltTab /f

:: Enable Control Panel and Settings
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel /f

:: Enable access to Recycle Bin
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecycleBin" /f

:: Disable AutoAdminLogon
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /d "0" /f

:: Enabling right-click context menu in Windows Explorer for the current user (reverts the first command).
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoViewContextMenu /t REG_DWORD /d 0 /f

:: Enabling read access to USB drives for the current user (reverts read restriction).
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\RemovableStorageDevices" /v Deny_Read /t REG_DWORD /d 0 /f

:: Enabling write access to USB drives for the current user (reverts write restriction).
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\RemovableStorageDevices" /v Deny_Write /t REG_DWORD /d 0 /f


:: Remove DefaultPassword entry for security
@rem reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /f


echo Revert script executed successfully.

@echo off
cls
:: Clear the existing code

echo All settings have been applied. The system will log out in

:: Countdown from 5 to 1
for /l %%i in (5,-1,1) do (
    echo %%i seconds....
    timeout /t 1 >nul
)

:: Log out the user
shutdown /l

:: End of script
