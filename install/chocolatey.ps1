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

Write-Host "Installing programs.." -ForegroundColor yellow

# Disable confirmation
choco feature enable -n allowGlobalConfirmation

# Install Programs
choco install firefox-dev --pre
choco install git
choco install python3
choco install openjdk
choco install nodejs
choco install nuget.commandline
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

# Non-chocolatey programs

refreshenv

# Better Discord
cd $HOME\Downloads\
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://github.com/BetterDiscord/Installer/releases/download/v1.0.0-hotfix/BetterDiscord-Windows.exe" -o BetterDiscord.exe

# LogitechG HUB
Invoke-WebRequest -Uri "https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.exe" -o LGHUBInstaller.exe

# Install powershell modules
pwsh.exe -Command Install-Module oh-my-posh -Scope CurrentUser -Force
pwsh.exe -Command Install-Module posh-git -Scope CurrentUser -Force

iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/kamack38/dotfiles/main/install/install.ps1'))

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
