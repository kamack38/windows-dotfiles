# Ensure that file is run as admin
#Requires -RunAsAdministrator

# Ensure chocolatey is installed 
if (! (Get-Command choco -errorAction SilentlyContinue)) {
	echo "Chocolatey needs to be installed!"
	echo "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
	echo "Chocolatey has been installed run this command"
	pause
	exit 0
}
echo "Chocolatey is already installed!"

echo "Installing programs.."

# Disable confirmation
choco feature enable -n allowGlobalConfirmation

# Install Programs
choco install firefox-dev --pre 
choco install git
choco install python3
choco install openjdk
choco install nodejs
choco install gpg4win
choco install winrar
choco install powershell-core
choco install mpv.install
choco install youtube-dl
choco install discord
choco install steam-client
choco install epicgameslauncher
choco install minecraft-launcher
choco install edgedeflector
choco install micro
choco install microsoft-windows-terminal --pre 
choco install openssh --pre
choco install vscode 
choco install firacodenf

# Non chocolatey programs

# Better Discord
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://github.com/BetterDiscord/Installer/releases/download/v1.0.0-hotfix/BetterDiscord-Windows.exe" -o BetterDiscord.exe
Invoke-WebRequest -Uri "https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.exe" -o LGHUBInstaller.exe

# Install powershell modules
Install-Module oh-my-posh -Scope CurrentUser -Force
Install-Module posh-git -Scope CurrentUser -Force

$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."   
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/kamack38/dotfiles/main/install/install.ps1'))