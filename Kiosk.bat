set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

@echo off
:: Disable Task Manager
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /t REG_DWORD /d 1 /f

:: Disable USB Storage write access (file transfer)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies" /v WriteProtect /t REG_DWORD /d 1 /f

:: Disable USB Storage read access (file reading)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR" /v Start /t REG_DWORD /d 4 /f

:: Disable Ctrl+Alt+Delete options by hiding the security screen
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableLockWorkstation /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableChangePassword /t REG_DWORD /d 1 /f

:: Hide "This PC" and other Explorer windows
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoViewOnDrive /t REG_DWORD /d 1 /f

:: Disable File Explorer for the current user by hiding Desktop and Explorer access
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoFileFolderOpening /t REG_DWORD /d 1 /f

:: Disable write access to USB devices
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDrives /t REG_DWORD /d 4 /f

:: Disable desktop icons by setting NoDesktop key in the registry
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDesktop /t REG_DWORD /d 1 /f

:: Disable Win+R and other hotkeys
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoWinKeys /t REG_DWORD /d 1 /f

:: Disable Alt+Tab
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoAltTab /t REG_DWORD /d 1 /f

:: Disable Control Panel and Settings
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel /t REG_DWORD /d 1 /f

:: Disable access to Recycle Bin
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecycleBin" /t REG_DWORD /d 1 /f

:: Disable Command Prompt for the current user
@rem reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System" /v DisableCMD /t REG_DWORD /d 2 /f

:: Create a Chrome startup shortcut
setlocal

:: Set up Chrome to run in kiosk mode with specified URL
set "chromePath=C:\Program Files\Google\Chrome\Application\chrome.exe"
set "kioskURL=https://training-nazhealth-kudjip-png.trias.in"  :: Change to your desired URL

:: Create a batch file to launch Chrome and log out on exit
set "launchKiosk=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\launchKiosk.bat"
(
echo @echo off
echo "%chromePath%" --incognito --kiosk --disable-infobars --use-fake-ui-for-media-stream --no-first-run %kioskURL%
echo shutdown /l
) > "%launchKiosk%"

:: Create a batch file to launch AutoHotkey script at startup
set "launchAHK=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\launchAHK.bat"
(
echo @echo off
echo start "" "%userprofile%\Desktop\Utilities\2\AutoHotkey.ahk"
) > "%launchAHK%"

:: Give the batch files execute permissions (optional)
icacls "%launchKiosk%" /inheritance:r
icacls "%launchKiosk%" /grant:r "%username%":(R,X)
icacls "%launchAHK%" /inheritance:r
icacls "%launchAHK%" /grant:r "%username%":(R,X)

:: Instructions
echo Kiosk mode for Chrome has been set up for the current user.
echo The AutoHotkey script will also run at startup.
echo The next time you log in, Chrome will start in kiosk mode at %kioskURL%.

endlocal

:: Inform the user

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