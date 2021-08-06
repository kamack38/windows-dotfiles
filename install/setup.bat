@echo off 

:: Make sure the script is running as admin
call :ensure_admin
powershell -Command "& {echo Installing OpenSSH Client...; Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0; echo Installing OpenSSH Server...; Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0;}"
:wh
echo:
echo Downloading Discord...
curl "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86" -L -o DiscordSetup.exe
echo -------------------------------------------------------------------------------
echo Downloading Better Discord...
curl "https://github.com/BetterDiscord/Installer/releases/download/v1.0.0-hotfix/BetterDiscord-Windows.exe" -L -o BetterDiscord.exe
echo -------------------------------------------------------------------------------
echo Downloading Epic Games Launcher...
curl "https://launcher-public-service-prod06.ol.epicgames.com/launcher/api/installer/download/EpicGamesLauncherInstaller.msi" -L -o EpicGamesInstaller.msi
echo -------------------------------------------------------------------------------
echo Downloading GPG4Win (v3.1.16)...
curl "https://files.gpg4win.org/gpg4win-3.1.16.exe" -o GPG4Win-3.1.16.exe
echo -------------------------------------------------------------------------------
echo Downloading Figma Desktop...
curl "https://desktop.figma.com/win/FigmaSetup.exe" -o FigmaSetup.exe
echo -------------------------------------------------------------------------------
echo Downloading Firfefox Developer Edition...
curl "https://download.mozilla.org/?product=firefox-devedition-stub&os=win&lang=pl" -L -o FirefoxInstaller.exe
echo -------------------------------------------------------------------------------
echo Downloading LogitechG HUB...
curl "https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.exe" -o LGHUBInstaller.exe
echo -------------------------------------------------------------------------------
echo Downloading Minecraft Launcher...
curl "https://launcher.mojang.com/download/MinecraftInstaller.msi" -o MinecraftInstaller.msi
echo -------------------------------------------------------------------------------
echo Downloading Steam...
curl "https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe" -o SteamSetup.exe
echo -------------------------------------------------------------------------------
echo Downloading WinRAR (v6.02)...
curl "https://www.rarlab.com/rar/winrar-x64-602pl.exe" -o WinRARSetup.exe
echo -------------------------------------------------------------------------------
echo Downloading Visual Studio Code...
curl "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64" -L -o VSCodeSetup.exe
echo -------------------------------------------------------------------------------
echo Installing oh-my-posh...
powershell -Command "& {Install-Module oh-my-posh -Scope CurrentUser -Force; echo Installing posh-git...;  Install-Module posh-git -Scope CurrentUser -Force;}
echo -------------------------------------------------------------------------------
echo Other programs need to be downloaded manually!
explorer.exe "https://adoptopenjdk.net/?variant=openjdk16&jvmVariant=hotspot"
explorer.exe "https://git-scm.com/downloads"
explorer.exe "https://nodejs.org/en/download/current/"
explorer.exe "https://setup.office.com/"
explorer.exe "https://github.com/PowerShell/PowerShell/releases/latest"
explorer.exe "https://github.com/da2x/EdgeDeflector/releases/latest"
explorer.exe "ms-windows-store://pdp/?ProductId=9n8g5rfz9xk3"

call :MsgBox "Would you like to download Battle.net by Blizzard Entertainment Inc.?"  "VBYesNo+VBQuestion" "Setup by kamack38"
if errorlevel 7 (
    echo Download job terminated
) else if errorlevel 6 (
    echo -------------------------------------------------------------------------------
    echo Downloading Battle.net...
    curl "https://eu.battle.net/download/getInstaller?os=win&installer=Battle.net-Setup.exe&id=undefined" -o Battle.netSetup.exe
)

echo -------------------------------------------------------------------------------
echo Downloading settings...
curl "https://github.com/kamack38/dotfiles/archive/refs/heads/main.zip" -L -o .dotfiles.zip
echo -------------------------------------------------------------------------------
echo Settings files must be allocated manually!

call :MsgBox "All task have been completed"  "64" "Success!"

exit 0

:MsgBox prompt type title
    setlocal enableextensions
    set "tempFile=%temp%\%~nx0.%random%%random%%random%vbs.tmp"
    >"%tempFile%" echo(WScript.Quit msgBox("%~1",%~2,"%~3") & cscript //nologo //e:vbscript "%tempFile%"
    set "exitCode=%errorlevel%" & del "%tempFile%" >nul 2>nul
    endlocal & exit /b %exitCode%

:die
	if not [%1] == [] echo %~1
	if [%unattended%] == [yes] exit 1
	pause
	exit 1

:ensure_admin
	:: 'openfiles' is just a commmand that is present on all supported Windows
	:: versions, requires admin privileges and has no side effects, see:
	:: https://stackoverflow.com/questions/4051883/batch-script-how-to-check-for-admin-rights
	openfiles >nul 2>&1
	if errorlevel 1 (
        call :MsgBox "Without administrator privileges you won't be able to install SSH. Are you sure you want to continue"  "292" "Setup by kamack38"
        if errorlevel 7 (
            echo Run this file again with administrator privileges.
            call :die
        ) else if errorlevel 6 (
            echo OpenSSH Client and OpenSSH Server won't be installed.
            goto:wh
        )
	)
    goto :EOF