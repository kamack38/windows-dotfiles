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

Write-Host "Settting environment variables..." -ForegroundColor yellow
[System.Environment]::SetEnvironmentVariable("WAKATIME_HOME", "$HOME\.config\wakatime", "User")

Write-Host "Installing programs..." -ForegroundColor yellow

# Disable confirmation
choco feature enable -n allowGlobalConfirmation

# Install Programs
choco install firefox-dev --pre --limit-output
choco install git.install --params "/NoShellIntegration /NoOpenSSH" --limit-output
choco install gh --limit-output
choco install python3 --limit-output
choco install openjdk --limit-output
choco install gpg4win --limit-output
choco install winrar --limit-output
choco install powershell-core --params '"/CleanUpPath"' --limit-output
choco install nushell --limit-output
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
choco install powertoys --limit-output
choco install procmon --limit-output
choco install nerd-fonts-firacode --limit-output
choco install croc --limit-output
choco install oh-my-posh --limit-output

# Non-chocolatey programs

# Refresh environmental variables
Write-Host "Refreshing environment variables..." -ForegroundColor yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
Write-Host "Environment variables has been refreshed!" -ForegroundColor green

# Install powershell modules
pwsh.exe -Command Set-PSRepository PSGallery -InstallationPolicy Trusted
pwsh.exe -Command Install-Module -Name posh-git -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force

# Better Discord
Set-Location "$HOME\Downloads"
$ProgressPreference = 'SilentlyContinue'
Write-Host "Downloading BetterDiscord Installer..." -ForegroundColor yellow
Invoke-WebRequest -Uri "https://github.com/BetterDiscord/Installer/releases/download/v1.0.0-hotfix/BetterDiscord-Windows.exe" -o BetterDiscord.exe
Write-Host "BetterDiscord Installer has been downloaded!" -ForegroundColor green

# LogitechG HUB
Write-Host "Downloading LogitechG HUB Installer..." -ForegroundColor yellow
Invoke-WebRequest -Uri "https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.exe" -o LGHUBInstaller.exe
Write-Host "LogitechG HUB Installer has been downloaded!" -ForegroundColor green

# Faceit Anit-Cheat
Write-Host "Downloading Faceit Anit-Cheat Installer..." -ForegroundColor yellow
Invoke-WebRequest -Uri "https://anticheat-client.faceit-cdn.net/FACEITInstaller_64.exe" -o "Faceit-Anit-Cheat.exe"
Write-Host "Faceit Anit-Cheat Installer has been downloaded!" -ForegroundColor green

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
# MIIGHwYJKoZIhvcNAQcCoIIGEDCCBgwCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCB8adA8B3GOmdpC
# ljjpp/ImjuQjAW0jZACMjAYN0E6QrKCCA2YwggNiMIICSqADAgECAhB36Jox1p+m
# oUV8lSg8nWQkMA0GCSqGSIb3DQEBCwUAMEkxHTAbBgNVBAMMFEtyenlzenRvZiBN
# YWNraWV3aWN6MSgwJgYJKoZIhvcNAQkBFhlrYW1hY2szOC5iaXpuZXNAZ21haWwu
# Y29tMB4XDTIxMDgwNzE5MTYxMVoXDTI5MTIzMTIyMDAwMFowSTEdMBsGA1UEAwwU
# S3J6eXN6dG9mIE1hY2tpZXdpY3oxKDAmBgkqhkiG9w0BCQEWGWthbWFjazM4LmJp
# em5lc0BnbWFpbC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCn
# zmb5hWsioCU1fWZkpU/CNk2eTM2RjDrc11SAHTuadwMVzFWckc20YywsvAmyOnIs
# W7uT1nsc0wuv/yWxCF1BASwzIzkrD439f2QOPvaxuToKMiA8w3tUhYuIdte9coz7
# B3jwsNUt9OfOarO0sbLq2tONLrv1jMwbbkmSk4lKBM/f5g667So1Fz6BOG/NxUsR
# HUo2lj9JtVyP/lA+zmpEEUto+wuGSOy3MuJXZD32bLXzhjlJPtDkFg2xJ9QmPNP8
# q8KAKz+FqgTcLCsqWdOIAqduvjGrW7HIlDIAF7yrf1xSou6oOts39A2utnnuVW4J
# OMiSeINbx/d0WxYpki9JAgMBAAGjRjBEMA4GA1UdDwEB/wQEAwIFoDATBgNVHSUE
# DDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQUSYtl/28nMvD/VTSKnBbvU4/z02EwDQYJ
# KoZIhvcNAQELBQADggEBAB6lztGdJd+YAeKVKDyahJ9xPV4QMeqOFbOppQvyTQw+
# h3t4EuGBUM46eYVUZnLW4juEG5mx2+IAogsyYlDvlCDCl35gb+ndAM2YZGKZNIf/
# CS1yo6NFSH0J13u9gl/ZM+a6OG8UKXhszhQDm7kE0PnA/qaBb0U3WH3gsKquPeZ7
# MfO2OTj4NhvxA/GJuyMp9T9ZLhwWlLLCZvvmSxI4dOGfE1UNt7rwda9Q6N7FNWfq
# G3Y/9xOn32OiqPjDlUajmiSIuCKD7nFtja09fZiOcE45C+FD/yjshOoUxb4Cyhnw
# G8ccxbA3u3dOd4rdYYkT3gYKJ4K6BvFfG0j4XUEayGsxggIPMIICCwIBATBdMEkx
# HTAbBgNVBAMMFEtyenlzenRvZiBNYWNraWV3aWN6MSgwJgYJKoZIhvcNAQkBFhlr
# YW1hY2szOC5iaXpuZXNAZ21haWwuY29tAhB36Jox1p+moUV8lSg8nWQkMA0GCWCG
# SAFlAwQCAQUAoIGEMBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcN
# AQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUw
# LwYJKoZIhvcNAQkEMSIEIJxUmAP9shuN8z9U1U6XrOiXGFurGeUTbfv540t/HRj9
# MA0GCSqGSIb3DQEBAQUABIIBACtGwHVHPAoEd5vDNjqG/gBahl6+4xyATt2B44Qa
# akmpKTj8E/It1QNjzJT5nyktzYUdTUxamiBAWGo/Q/QbCgPt+1Ioz4wiEW1D2LGJ
# 3rx3qoNGFyEbI5ckY4Zio1AeuTERffSaO3HR6XqAP6kLYMiqygK6Vmi/ugxPhbk/
# c3UeDlZoO+oV4ORBerirLg7fhiHFfaYXXSHzUdR6vnfAQwop7LbQQQPcgxeVJjBw
# m+UcbkpewRLrqGU5jlKoFTBGqSozTyFwpdaJ4Cvlhx3zKHxbwx7sDciNXkLSRG1V
# vx3m+Kle+VLNBcBZcmqUOFZnBnLR+qXnNV5OHqW8VNOWUp8=
# SIG # End signature block
