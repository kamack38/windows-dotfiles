# Ensure that file is run as admin
Write-Host "Checking for elevated permissions..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again."
    Break
}
else {
    Write-Host "Script is running as administrator - go on executing the script..." -ForegroundColor Green
}

# Checking execution policy
Write-Host "Checking execution policy..."
$executionPolicy = (Get-ExecutionPolicy)
$allowedExecutionPolicies = @(
    "RemoteSigned",
    "Bypass",
    "Unrestricted"
)
if ($executionPolicy -in $allowedExecutionPolicies) {
    Write-Host "Execution policy is set to $executionPolicy. Continuing script execution." -ForegroundColor Green
}
else {
    Write-Warning "Execution policy is set to $executionPolicy which is NOT recommended."
    Break
}

# Send welcome message
Clear-Host
Write-Output "  ___  __    _____ ______   ________  ________"
Write-Output " |\  \|\  \ |\   _ \  _   \|\_____  \|\   __  \     "
Write-Output " \ \  \/  /|\ \  \\\__\ \  \|_____\  \ \  \|\  \    Kamack38"
Write-Output "  \ \   ___  \ \  \\|__| \  \|______  \ \   __  \   https://twitter.com/kamack38"
Write-Output "   \ \  \\ \  \ \  \    \ \  \| ____\  \ \  \|\  \  https://github.com/kamack38"
Write-Output "    \ \__\\ \__\ \__\    \ \__\|\_______\ \_______\ "
Write-Output "     \|__| \|__|\|__|     \|__|\|_______|\|_______| "
Write-Output " "
Write-Output "Thank you for downloading my dotfiles <3"

# Ensure chocolatey is installed
if (! (Get-Command choco -errorAction SilentlyContinue)) {
    Write-Host "Chocolatey needs to be installed!" -ForegroundColor red
    Write-Host "Installing Chocolatey..." -ForegroundColor yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "Chocolatey has been installed successfully!" -ForegroundColor green
    Write-Host "Refreshing environment variables..." -ForegroundColor yellow
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    Write-Host "Environment variables has been refreshed!" -ForegroundColor green
}
else {
    Write-Host "Chocolatey is already installed!" -ForegroundColor green
}

Write-Host "Installing programs..." -ForegroundColor yellow

# Disable confirmation
choco feature enable -n allowGlobalConfirmation

# Install Programs
choco install firefox-dev --pre --limit-output
choco install git.install --params "/NoShellIntegration /NoOpenSSH" --limit-output
choco install gh --limit-output
choco install python3 --limit-output
choco install openjdk --limit-output
choco install nvm.install --limit-output
choco install gpg4win --limit-output
choco install winrar --limit-output
choco install powershell-core --params '"/CleanUpPath"' --limit-output
choco install mpv.install --limit-output
choco install yt-dlp --limit-output
choco install ffmpeg --limit-output
choco install neovim --limit-output
choco install bat --limit-output
choco install delta --limit-output
choco install ripgrep --limit-output
choco install mingw --limit-output
choco install llvm --limit-output
choco install nircmd --limit-output
choco install fastfetch --limit-output
#Present by default on Windows 11
#choco install microsoft-windows-terminal --limit-output
choco install openssh --limit-output
choco install discord.install --limit-output
choco install steam-client --limit-output
choco install epicgameslauncher --limit-output
choco install minecraft-launcher --limit-output
choco install powertoys --limit-output
choco install procmon --limit-output
choco install nerd-fonts-firacode --limit-output
choco install croc --limit-output
choco install oh-my-posh --limit-output
choco install cmake.install --ia 'ADD_CMAKE_TO_PATH=System' --limit-output
choco install autohotkey --limit-output

# Non-chocolatey programs

# Refresh environmental variables
Write-Host "Refreshing environment variables..." -ForegroundColor yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
Write-Host "Environment variables has been refreshed!" -ForegroundColor green

# Install node
nvm install lts
nvm use lts

# NPM Packages
npm i -g git-cz

# Install powershell modules
pwsh.exe -Command Set-PSRepository PSGallery -InstallationPolicy Trusted
pwsh.exe -Command Install-Module -Name posh-git -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name npm-completion -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name nvm-completion -Scope CurrentUser -Force

# Better Discord
Set-Location $HOME\Downloads\
$ProgressPreference = 'SilentlyContinue'
Write-Host "Downloading BetterDiscord Installer..." -ForegroundColor yellow
Invoke-WebRequest -Uri "https://github.com/BetterDiscord/Installer/releases/download/v1.0.0-hotfix/BetterDiscord-Windows.exe" -o BetterDiscord.exe
Write-Host "BetterDiscord Installer has been downloaded!" -ForegroundColor green

# LogitechG HUB
Write-Host "Downloading LogitechG HUB Installer..." -ForegroundColor yellow
Invoke-WebRequest -Uri "https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.exe" -o LGHUBInstaller.exe
Write-Host "LogitechG HUB Installer has been downloaded!" -ForegroundColor green

# Install ff2mpv
git clone https://github.com/woodruffw/ff2mpv/ $HOME\ff2mpv
Set-Location $HOME\ff2mpv
python .\check-config-win.py -i

# Restore settings files
$DOTFILES = "$HOME\.dotfiles"
$repo = "https://github.com/kamack38/windows-dotfiles.git"

git clone --bare $repo $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout -f

Write-Host "Programs settings have been restored!" -ForegroundColor green

Write-Host "Restoring Windows settings..." -ForegroundColor yellow
Write-Warning "This script will change your Windows settings!" -WarningAction Inquire

Invoke-Expression ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/kamack38/windows-dotfiles/main/install/windows.ps1'))

# SIG # Begin signature block
# MIIF+gYJKoZIhvcNAQcCoIIF6zCCBecCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUpaH9FiQ0nJImEHdUzehrKjhk
# 72GgggNmMIIDYjCCAkqgAwIBAgIQd+iaMdafpqFFfJUoPJ1kJDANBgkqhkiG9w0B
# AQsFADBJMR0wGwYDVQQDDBRLcnp5c3p0b2YgTWFja2lld2ljejEoMCYGCSqGSIb3
# DQEJARYZa2FtYWNrMzguYml6bmVzQGdtYWlsLmNvbTAeFw0yMTA4MDcxOTE2MTFa
# Fw0yOTEyMzEyMjAwMDBaMEkxHTAbBgNVBAMMFEtyenlzenRvZiBNYWNraWV3aWN6
# MSgwJgYJKoZIhvcNAQkBFhlrYW1hY2szOC5iaXpuZXNAZ21haWwuY29tMIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAp85m+YVrIqAlNX1mZKVPwjZNnkzN
# kYw63NdUgB07mncDFcxVnJHNtGMsLLwJsjpyLFu7k9Z7HNMLr/8lsQhdQQEsMyM5
# Kw+N/X9kDj72sbk6CjIgPMN7VIWLiHbXvXKM+wd48LDVLfTnzmqztLGy6trTjS67
# 9YzMG25JkpOJSgTP3+YOuu0qNRc+gThvzcVLER1KNpY/SbVcj/5QPs5qRBFLaPsL
# hkjstzLiV2Q99my184Y5ST7Q5BYNsSfUJjzT/KvCgCs/haoE3CwrKlnTiAKnbr4x
# q1uxyJQyABe8q39cUqLuqDrbN/QNrrZ57lVuCTjIkniDW8f3dFsWKZIvSQIDAQAB
# o0YwRDAOBgNVHQ8BAf8EBAMCBaAwEwYDVR0lBAwwCgYIKwYBBQUHAwMwHQYDVR0O
# BBYEFEmLZf9vJzLw/1U0ipwW71OP89NhMA0GCSqGSIb3DQEBCwUAA4IBAQAepc7R
# nSXfmAHilSg8moSfcT1eEDHqjhWzqaUL8k0MPod7eBLhgVDOOnmFVGZy1uI7hBuZ
# sdviAKILMmJQ75Qgwpd+YG/p3QDNmGRimTSH/wktcqOjRUh9Cdd7vYJf2TPmujhv
# FCl4bM4UA5u5BND5wP6mgW9FN1h94LCqrj3mezHztjk4+DYb8QPxibsjKfU/WS4c
# FpSywmb75ksSOHThnxNVDbe68HWvUOjexTVn6ht2P/cTp99joqj4w5VGo5okiLgi
# g+5xbY2tPX2YjnBOOQvhQ/8o7ITqFMW+AsoZ8BvHHMWwN7t3TneK3WGJE94GCieC
# ugbxXxtI+F1BGshrMYIB/jCCAfoCAQEwXTBJMR0wGwYDVQQDDBRLcnp5c3p0b2Yg
# TWFja2lld2ljejEoMCYGCSqGSIb3DQEJARYZa2FtYWNrMzguYml6bmVzQGdtYWls
# LmNvbQIQd+iaMdafpqFFfJUoPJ1kJDAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIB
# DDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEE
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUfMjk03724/aA
# R+SmpxzWM04zNQIwDQYJKoZIhvcNAQEBBQAEggEAYEyrE47g01oQro/Wgob+GzRm
# hJsxdm/PStMJrClNdT5Wm/8XTqoWg8m9ITlQkY9DUR9li341sING3CKG3CJYzysA
# RNzQfTw3NJYT2x97+1FM/FNtY9Ui+EsOk3H4dngtf/RIvmlGB9wY1oTJGmJxmcH1
# 29r0VXNKfpl9+DBZmneb3XpGTRs34amMUpGfpmPcy+zWtRTnZFD+247sWrZ7CmDq
# SsIPpJJM2T8EZfj4s/KpT1APLh0yAoRy/gmi5dOKo2lWeg7r4qyXZdq0yxd3BsFn
# KMgc/Py8w3Fi8MmxT8PZC9GRJVCryoh+8weOC3aAz/bJuJ7s8sXoZPjKKeGGEg==
# SIG # End signature block
