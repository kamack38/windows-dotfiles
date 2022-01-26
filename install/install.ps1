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
    Write-Warning "Execution policy is set to $executionPolicy which is NOT recomended."
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
    Write-Host "Chocolatey has been installed succesfully!" -ForegroundColor green
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
choco install git --params "/NoShellIntegration /NoOpenSSH" --limit-output
choco install python3 --limit-output
choco install openjdk --limit-output
choco install nodejs --limit-output
choco install gpg4win --limit-output
choco install winrar --limit-output
choco install powershell-core --params '"/CleanUpPath"' --pre --limit-output
choco install mpv --limit-output
choco install yt-dlp --limit-output
choco install ffmpeg --limit-output
choco install neovim --limit-output
choco install bat --limit-output
choco install delta --limit-output
choco install ripgrep --limit-output
choco install mingw --limit-output
choco install llvm --limit-output
choco install nircmd --limit-output
choco install winfetch --limit-output
choco install onefetch --limit-output
choco install speedtest --limit-output
choco install microsoft-windows-terminal --pre --limit-output
choco install openssh --pre --limit-output
choco install discord --limit-output
choco install steam-client --limit-output
choco install epicgameslauncher --limit-output
choco install minecraft-launcher --limit-output
choco install edgedeflector --limit-output
choco install dcforoffice --limit-output
choco install powertoys --limit-output
choco install modernflyouts --limit-output
choco install procmon --limit-output
choco install winmerge --limit-output
choco install vscode --params "/NoDesktopIcon" --limit-output
choco install firacodenf --limit-output
choco install ngrok --limit-output
choco install croc --limit-output
choco install cmake --ia 'ADD_CMAKE_TO_PATH=System' --limit-output
choco install autohotkey --limit-output

# Non-chocolatey programs

# Refresh environmental variables
Write-Host "Refreshing environment variables..." -ForegroundColor yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
Write-Host "Environment variables has been refreshed!" -ForegroundColor green

# Python Packages
pip install spotdl
pip install streamlink

# NPM Packages
npm i -g carbon-now-cli
npm i -g neovim
npm i -g yarn

npm i --prefix ~\.quokka dotenv-quokka-plugin
npm i --prefix ~\.quokka jsdom-quokka-plugin

# Install powershell modules
pwsh.exe -Command Set-PSRepository PSGallery -InstallationPolicy Trusted
pwsh.exe -Command Install-Module -Name oh-my-posh -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name posh-git -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name npm-completion -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force
pwsh.exe -Command Install-Module -Name yarn-completion -Scope CurrentUser -Force

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

# Steam skin (metro-for-steam)
Write-Host "Downloading metro-for-steam..." -ForegroundColor yellow
Invoke-WebRequest -Uri "https://github.com/minischetti/metro-for-steam/archive/refs/heads/master.zip" -o metro-for-steam.zip
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
Set-Location "C:\Program Files (x86)\Steam\skins"
Copy-Item ".\UPMetroSkin-master\Unofficial 4.x Patch\Main Files ``[Install First``]\*" -Destination ".\metro-for-steam-4.4\" -Force -Recurse 
Write-Host "Customize your settings..." -ForegroundColor yellow

$categories = (Get-ChildItem ".\UPMetroSkin-master\Unofficial 4.x Patch\Extras" -Directory -Exclude '*install*', '*Remastered Extra*')
$myObject = [pscustomobject]$categories
for ($j = 0; $j -lt $myObject.length; $j++) {
    $myObject[$j] | Add-Member -NotePropertyName Childs -NotePropertyValue (Get-ChildItem $myObject[$j])
    for ($i = 0; $i -lt $myObject[$j].Childs.Length; $i++) {
        $myObject[$j].Childs[$i] | Add-Member -NotePropertyName Color -NotePropertyValue "Red"
    }
}

for ($j = 0; $j -lt $myObject.Length; $j++) {
    function Show-Menu {
        param (
            [string]$Title = 'My Menu'
        )
        Clear-Host
        Write-Host "================ $Title ================"
        Write-Host "What dou you want to install?"
        for ($i = 0; $i -lt $myObject[$j].Childs.Length; $i++) {
            $index = $i + 1
            Write-Host "Press '$index' to select: " $myObject[$j].Childs[$i].Name -ForegroundColor $myObject[$j].Childs[$i].Color
        }
        Write-Host "A: Press 'A' to save settings and install them."
        Write-Host "C: Press 'C' to cancel selection and go to another category."
        Write-Host "Q: Press 'Q' to cancel EVERYTHING and quit."
    }
    do {
        Show-Menu -Title $myObject[$j].Name
        $selection = Read-Host "Please make a selection"
        if ($selection -match "^\d+$" -and $myObject[$j].Childs[$selection - 1].Color -ne "Green") {
            $myObject[$j].Childs[$selection - 1].Color = "Green"
        }
        elseif ($selection -match "^\d+$" -and $myObject[$j].Childs[$selection - 1].Color -ne "Red") {
            $myObject[$j].Childs[$selection - 1].Color = "Red"
        }
        elseif ($selection -eq "a") {
            Write-Host Installing selected settings... -ForegroundColor yellow
            (($myObject[$j].childs | Where-Object -Property color -EQ "Green").PSPath -split ".*::").Split('', [System.StringSplitOptions]::RemoveEmptyEntries).ForEach({ $_ + "\Install\*" }) | Copy-Item -Destination ".\metro-for-steam-4.4\" -Force -Recurse
            break
        }
        elseif ($selection -eq "q") {
            $j = $myObject.Length
            break
        }
        elseif ($selection -ne "c") {
            Write-Host 'Wrong Input!' -ForegroundColor red
            pause
        }
    }
    until ($selection -eq "c")
}

Write-Host "All files has been extracted and moved!" -ForegroundColor yellow

# Install ff2mpv
git clone https://github.com/woodruffw/ff2mpv/ $HOME\ff2mpv
Set-Location $HOME\ff2mpv
python .\check-config-win.py -i

# Setup NvChad
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
git clone https://github.com/NvChad/NvChad "$env:LOCALAPPDATA\nvim"

# Restore settings files
$DOTFILES = "$HOME\.dotfiles"
$repo = "https://github.com/kamack38/dotfiles.git"

git clone --bare $repo $DOTFILES
git --git-dir="$DOTFILES" --work-tree="$HOME" fetch --all
git --git-dir="$DOTFILES" --work-tree="$HOME" config --local status.showUntrackedFiles no
git --git-dir="$DOTFILES" --work-tree="$HOME" checkout

Write-Host "Programs settings have been restored!" -ForegroundColor green

Write-Host "Restoring Windows settings..." -ForegroundColor yellow
Write-Warning "This script will change your Windows settings!" -WarningAction Inquire

Invoke-Expression ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/kamack38/dotfiles/main/install/windows.ps1'))

# SIG # Begin signature block
# MIIF+gYJKoZIhvcNAQcCoIIF6zCCBecCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU3uJmYr86lDfcai8wul7BxvsE
# saGgggNmMIIDYjCCAkqgAwIBAgIQd+iaMdafpqFFfJUoPJ1kJDANBgkqhkiG9w0B
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
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUPleEI0Bex1Jj
# gFHmAKIpxuXdckowDQYJKoZIhvcNAQEBBQAEggEAFGNtDfYSJniqw2qwH7bfSOKL
# iKNnbzGewRWGl7mo1TMZQroINScJtbS7ptll6kts2KhwtQzEoxmSGkhy50og2OqV
# lCMInhJ1OjscYN3KUF2JR7+3wot8XY/lbg6jZ9FiQtU7+MptSb1dc+m71yMUhfps
# CtoQZ7whA/tPLFTRFhH2ljRGieXLRE7nKTzeOWvWoMyB4GyL0njiIFzRU1W5T8Al
# tjyW+CPNvDilrskLhdI+BvbO0KZE7/vOuBUmj5uOuOeZgki48/Za3k15v/glNEJi
# aChN5dXhTOAB8DEkw3sgegWKuAC8s8b0xE9rMXT+OEZ+BRqTNHWaGrZPetVeiQ==
# SIG # End signature block
