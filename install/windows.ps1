###############################################################################
### Devices, Power, and Startup                                               #
###############################################################################
Write-Host "Configuring Devices, Power, and Startup..." -ForegroundColor "Yellow"

# Power: Enable Hibernation
powercfg /hibernate on

###############################################################################
### Explorer, Taskbar, and System Tray                                        #
###############################################################################
Write-Host "Configuring Explorer, Taskbar, and System Tray..." -ForegroundColor "Yellow"

# Explorer: Show hidden files by default: Show Files: 1, Hide Files: 2
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1

# Explorer: Show file extensions by default
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0

# Explorer: Show path in title bar
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" "FullPath" 1

# Taskbar: Show colors on Taskbar, Start, and SysTray: Disabled: 0, Taskbar, Start, & SysTray: 1, Taskbar Only: 2
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "ColorPrevalence" 1

# Taskbar: Enable Transparency
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 0

# Titlebar: Enable theme colors on titlebar
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\DWM" "ColorPrevalence" 1

# Recycle Bin: Disable Delete Confirmation Dialog
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "ConfirmFileDelete" 0

###############################################################################
### Sound                                                                     #
###############################################################################

Set-ItemProperty "HKCU\SOFTWARE\Microsoft\Multimedia\Audio" "UserDuckingPreference" 3

###############################################################################
### Debloat Windows                                                           #
###############################################################################
Write-Host "Configuring Default Windows Applications..." -ForegroundColor "Yellow"

$programs = @(
    'Microsoft.3DBuilder',
    'Microsoft.WindowsAlarms',
    '*.AutodeskSketchBook',
    'Microsoft.BingFinance',
    'Microsoft.BingNews',
    'Microsoft.BingSports',
    'Microsoft.BingWeather',
    'king.com.BubbleWitch3Saga',
    'Microsoft.WindowsCommunicationsApps',
    'king.com.CandyCrushSodaSaga',
    '*.DisneyMagicKingdoms',
    '*.Facebook',
    'Microsoft.GetStarted',
    'Microsoft.WindowsMaps',
    '*.MarchofEmpires',
    'Microsoft.Messaging',
    'Microsoft.OneConnect',
    'Microsoft.Office.OneNote',
    'Microsoft.MSPaint',
    'Microsoft.People',
    # 'Microsoft.Windows.Photos',
    'Microsoft.Print3D',
    'Microsoft.SkypeApp',
    '*.SlingTV',
    'Microsoft.MicrosoftStickyNotes',
    'Microsoft.Office.Sway',
    '*.Twitter',
    'Microsoft.WindowsSoundRecorder',
    'Microsoft.WindowsPhone',
    'Microsoft.ZuneMusic',
    'Microsoft.ZuneVideo',
    '*.McAfeeSecurity'
)

foreach ($item in $programs) {
    Get-AppxPackage "$item" -AllUsers | Remove-AppxPackage
    Get-AppXProvisionedPackage -Online | Where-Object DisplayName -like "$item" | Remove-AppxProvisionedPackage -Online
}

# Uninstall Windows Media Player
Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null

# Prevent "Suggested Applications" from returning
if (!(Test-Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent")) {New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Type Folder | Out-Null}
Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1

#Turns off Data Collection via the AllowTelemtry key by changing it to 0
Write-Host "Turning off Data Collection"
$DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
$DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
If (Test-Path $DataCollection1) {
    Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
}
If (Test-Path $DataCollection2) {
    Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
}
If (Test-Path $DataCollection3) {
    Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
}

###############################################################################
### Set Default Windows Applications                                          #
###############################################################################

# Set pwsh.exe as default OpenSSH
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

# Set Windows Terminal as default batch opening porgram
if (!(Test-Path "HKCR:\")) {New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR}
Set-ItemProperty "HKCR:\batfile\shell\open\command" "(default)" """C:\Users\$env:USERNAME\AppData\Local\Microsoft\WindowsApps\wt.exe"" -p ""Command Prompt"" ""%1"" %*"

# Set Windows Terminal as default .ps1 file opening porgram
cmd /c assoc .ps1=PowerShellFileV
cmd /c ftype PowerShellFileV=wt.exe pwsh.exe -wd "%1\.." -NoExit -NoLogo -ExecutionPolicy Bypass -File %1 -Command "& `"%1`""

# Create Links to System Utilities

$LinkDir = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"

function New-Shortcut {
    param ( 
        [Parameter(Mandatory)][string]$SourceExe, 
        [Parameter(Mandatory)][string]$DestinationPath,
        [string]$IconPath
    )

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($DestinationPath)
    $Shortcut.TargetPath = $SourceExe
    if (![System.String]::IsNullOrEmpty($IconPath)) {
        $Shortcut.IconLocation = "$IconPath"
    }
    $Shortcut.Save()
}

New-Shortcut "diskmgmt.msc" "$LinkDir\Disc Manager.lnk"
New-Shortcut "main.cpl" "$LinkDir\Mouse Settings.lnk" "main.cpl, 0"
New-Shortcut "mmsys.cpl" "$LinkDir\Sound Settings.lnk" "mmsys.cpl,0"
New-Shortcut "devmgmt.msc" "$LinkDir\Device Manager.lnk"
New-Shortcut "control.exe" "$LinkDir\Control Panel.lnk"


$nvimQt = "HKCU:\Software\nvim-qt\nvim-qt"
if (test-path $nvimQt) {
    Set-ItemProperty $nvimQt "ext_tabline" "false"
    Set-ItemProperty $nvimQt "ext_popupmenu" "false"
}


###############################################################################
### Customization                                                             #
###############################################################################

# Enable Dark Theme
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0

# Set Custom Wallpaper
Set-ItemProperty "HKCU:\Control Panel\Desktop" "WallPaper" "$HOME\.config\themes\Minimalist Code by Daze_.jpg"

# Install custom cursors
pnputil -i -a $HOME\.config\themes\cursors\Install.inf
   
# SIG # Begin signature block
# MIIF+gYJKoZIhvcNAQcCoIIF6zCCBecCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUQVLa/Z4mjnpnKm5G4Xk5QMa5
# f6ygggNmMIIDYjCCAkqgAwIBAgIQd+iaMdafpqFFfJUoPJ1kJDANBgkqhkiG9w0B
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
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUM9fy896N/GkF
# TBP39p91w5HqMvwwDQYJKoZIhvcNAQEBBQAEggEAQBRJdGdLAi9/n2SCnSCm6SaT
# FBjUNmZEdFEpy827ZDuDBhiiyRma8PK9TENMiMRGBwaPkzG8Cxv7ozEjv2meFflD
# sJ5q1m2J4MycKi5KIE/ADWjcEBwTGmXEpFgJkHA80JWiMLh37MuHRXpiXuWDJD0x
# RK2MZQGGjmuRrgSuxE3TRL44WKq1p+2D59n/i9saoa3f5Rrh2u0wMAG4M215wtag
# d2tXW0Bl3JH0fbQMEUcxJgcl7OF/6uWcjN+6w+hzQlOIOLETSiRaqQCXw/o5bW6X
# TS8kvP4zUB9pFLQiR4b2KHHrXiBohmLFPPN7n2NdA3kW7jH1YRYjqtoodx7NGw==
# SIG # End signature block
