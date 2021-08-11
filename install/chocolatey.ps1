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
choco install mpv.install --limit-output
choco install youtube-dl --limit-output
choco install discord --limit-output
choco install steam-client --limit-output
choco install epicgameslauncher --limit-output
choco install minecraft-launcher --limit-output
choco install edgedeflector --limit-output
choco install micro --limit-output
choco install microsoft-windows-terminal --pre --limit-output
choco install openssh --pre --limit-output
choco install speedtest --limit-output
choco install vscode --limit-output
choco install firacodenf --limit-output

# Non-chocolatey programs

Write-Host "Refreshing environment variables..." -ForegroundColor yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
Write-Host "Environment variables has been refreshed!" -ForegroundColor green

# Better Discord
cd $HOME\Downloads\
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

# Install powershell modules
pwsh.exe -Command Install-Module oh-my-posh -Scope CurrentUser -Force
pwsh.exe -Command Install-Module posh-git -Scope CurrentUser -Force

iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/kamack38/dotfiles/main/install/install.ps1'))

Write-Warning "This script will change your Windows settings!" -WarningAction Inquire

iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/kamack38/dotfiles/main/install/windows.ps1'))

# SIG # Begin signature block
# MIIF+gYJKoZIhvcNAQcCoIIF6zCCBecCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUgcz0/i/0sAgYno51LZ+pC/ZI
# v9mgggNmMIIDYjCCAkqgAwIBAgIQd+iaMdafpqFFfJUoPJ1kJDANBgkqhkiG9w0B
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
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUE/fgrmo8PYnO
# GsM+ZHQL827fCYAwDQYJKoZIhvcNAQEBBQAEggEAf95aKON7bnF61bU88k5yhn25
# KV7oCaktYEFAFPS6mBXA6pKUmjQw3tjIOy8pdJbzduxA+GepaC2ZLPYtcK0wT1Ze
# MBAPa8kLT8bOHjXYlLH5wKSmR+Nn/A2FGB3NO0GGWWDBy9xi3jRlZ/q9CvZDtcSc
# kkdN5bk05nppVbXdZxO1AN+Fb3P3fKfjTojARznWY79T/c0Rn9WmBjANxvXpPpPk
# 5woAo9o5YbjeyHRe8CSLUWRhFaez9E8tDr0nzVwRA2AlX4ZES8UAZ5KDwZWBKIUa
# NccgViYQfhL9mFKA9Y+Bq07h8l0hJHAL5e95Mp7ea9XyoqdAWKd/VGEvsNyKAA==
# SIG # End signature block
