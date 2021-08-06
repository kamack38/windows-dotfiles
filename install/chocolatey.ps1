# Ensure that file is run as admin
#Requires -RunAsAdministrator

# Ensure chocolatey is installed 
if (! (choco.exe --version)) {
	echo "Chocolatey needs to be installed!"
	echo "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
	echo "Chocolatey has been installed run this file again"
	exit 0
}

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
choco install figma
choco install minecraft-launcher
choco install edgedeflector
choco install nano
choco install microsoft-windows-terminal --pre 

# Non chocolatey programs

# Better Discord
curl "https://github.com/BetterDiscord/Installer/releases/download/v1.0.0-hotfix/BetterDiscord-Windows.exe" -L -o BetterDiscord.exe

# Install Open SSH Client and Open SSH Server
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Install powershell modules
Install-Module oh-my-posh -Scope CurrentUser -Force
Install-Module posh-git -Scope CurrentUser -Force

curl "https://raw.githubusercontent.com/kamack38/dotfiles/main/install/install.ps1" -L -o install.ps1