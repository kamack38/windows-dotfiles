# Ensure that file is run as admin
Write-Host "Checking for elevated permissions..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	Write-Warning "Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again."
	Break
}
else {
		Write-Host "Script is running as administrator - go on executing the script..." -ForegroundColor Green
}

# Ensure chocolatey is installed
if (! (Get-Command choco -errorAction SilentlyContinue)) {
	Write-Host "Chocolatey needs to be installed!" -ForegroundColor red
	Write-Host "Installing Chocolatey..." -ForegroundColor yellow
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
	Write-Host "Chocolatey has been installed succesfully!" -ForegroundColor green
	Write-Host "Refreshing environment variables..." -ForegroundColor yellow
	$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
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
choco install git --limit-output
choco install python3 --limit-output
choco install openjdk --limit-output
choco install nodejs --limit-output
choco install nuget.commandline --limit-output
choco install gpg4win --limit-output
choco install winrar --limit-output
choco install powershell-core --limit-output
choco install mpv --limit-output
choco install youtube-dl --limit-output
choco install ffmpeg --limit-output
choco install neovim --limit-output
choco install bat --limit-output
choco install delta --limit-output
choco install ripgrep --limit-output
choco install mingw --limit-output
choco install nircmd --limit-output
choco install winfetch --version 2.2.0 --limit-output
choco install onefetch --limit-output
choco install speedtest --limit-output
choco install microsoft-windows-terminal --pre --limit-output
choco install openssh --pre --limit-output
choco install discord --limit-output
choco install steam-client --limit-output
choco install epicgameslauncher --limit-output
choco install minecraft-launcher --limit-output
choco install lghub --limit-output
choco install edgedeflector --limit-output
choco install powertoys --limit-output
choco install modernflyouts --limit-output
choco install procmon --limit-output
choco install winmerge --limit-output
choco install vscode --limit-output
choco install firacodenf --limit-output

# Non-chocolatey programs

# Refresh environmental variables
Write-Host "Refreshing environment variables..." -ForegroundColor yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
Write-Host "Environment variables has been refreshed!" -ForegroundColor green

# Python Packages
pip install spotdl

# NPM Packages
npm i -g carbon-now-cli

# Install powershell modules
pwsh.exe -Command Install-Module oh-my-posh -Scope CurrentUser -Force
pwsh.exe -Command Install-Module posh-git -Scope CurrentUser -Force
pwsh.exe -Command Install-Module npm-completion -Scope CurrentUser -Force

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

# Download latest 7coil/DiscordForOffice release from github
Write-Host "Downloading DiscordForOffice Installer..." -ForegroundColor yellow
$repo = "7coil/DiscordForOffice"
$file = "DiscordForOffice.exe"

$releases = "https://api.github.com/repos/$repo/releases"

Write-Host "Determining latest release" -ForegroundColor yellow
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$tag = (Invoke-WebRequest -Uri $releases -UseBasicParsing | ConvertFrom-Json)[0].tag_name

$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$exe = "$name-$tag.exe"

Write-Host "Dowloading latest release" -ForegroundColor yellow

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest $download -Out $exe
Write-Host "DiscordForOffice Installer has been downloaded!" -ForegroundColor green

# Steam skin (metro-for-steam)
Write-Host "Downloading metro-for-steam..." -ForegroundColor yellow
Invoke-WebRequest -Uri "https://github.com/minischetti/metro-for-steam/archive/v4.4.zip" -o metro-for-steam.zip
Write-Host "metro-for-steam has been downloaded!" -ForegroundColor green
Write-Host "Downloading Unofficial Patch for MetroForSteam..." -ForegroundColor yellow
Invoke-WebRequest -Uri "https://github.com/redsigma/UPMetroSkin/archive/master.zip" -o UPMetroSkin.zip
Write-Host "Unofficial Patch for MetroForSteam has been downloaded!" -ForegroundColor green
Write-Host "Extracting files..." -ForegroundColor yellow
Expand-Archive "UPMetroSkin.zip" -Force
Expand-Archive "metro-for-steam.zip" -Force
Remove-Item "UPMetroSkin.zip", "metro-for-steam.zip" -Recurse -Force -ErrorAction SilentlyContinue
Move-Item "UPMetroSkin\UPMetroSkin-master", "metro-for-steam\metro-for-steam-4.4" -Destination "C:\Program Files (x86)\Steam\skins" -Force
Remove-Item "UPMetroSkin", "metro-for-steam" -Recurse -Force
Write-Host "All files has been extracted and moved!" -ForegroundColor green
explorer.exe "C:\Program Files (x86)\Steam\skins"

Invoke-Expression ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/kamack38/dotfiles/main/install/install.ps1'))

Write-Warning "This script will change your Windows settings!" -WarningAction Inquire

Invoke-Expression ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/kamack38/dotfiles/main/install/windows.ps1'))

# SIG # Begin signature block
# MIIF+gYJKoZIhvcNAQcCoIIF6zCCBecCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUUCx+6Ooqo58bmZyhQ57WkJT+
# yY6gggNmMIIDYjCCAkqgAwIBAgIQd+iaMdafpqFFfJUoPJ1kJDANBgkqhkiG9w0B
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
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUwSihZizDpM0f
# Ryk6ZlJp14SK3c0wDQYJKoZIhvcNAQEBBQAEggEAgr8czHBJCTX293htetL5l0bB
# TU+YMUJ9/f0E7HqvyUnS3pn00n6ThpUrlItZS4w6O/+B1ZU/0u1QmpBrrs1+MAjX
# ZA6M3AyYNMkFZ4dy/+pjP5bMgHh00QkcH4hn/0E3W0wEzXMEV1sygoqFCMT9oU+2
# NYrnDo0j8ulLW1N/QyTWdBlibcgBDsWSCR4FFaQtkmDl71yvMJmdRQdiOSW+NaT4
# 7LrdVYIJ304Djt6gg5iykgdiHts/uuATCXgHIaUJ0x30KvzF+1q0yDnhwuFLX9i6
# F4nO9fRsWOcfPiEwdhStuDhirgjjiinwhjp0woIBLbTihjVqA3WKEw9iLJ2CYw==
# SIG # End signature block
