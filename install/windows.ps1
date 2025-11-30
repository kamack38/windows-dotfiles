###############################################################################
### Set Default Windows Applications                                          #
###############################################################################

# Set pwsh.exe as default OpenSSH
New-ItemProperty -Path "HKLM:\Software\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

# Set WindowsTerminal as the default terminal app
Set-ItemProperty "HKCU:\Console\%%Startup" "DelegationConsole" "{2EACA947-7F5F-4CFA-BA87-8F7FBEEFBE69}"
Set-ItemProperty "HKCU:\Console\%%Startup" "DelegationTerminal" "{E12CFF52-A866-4C77-9A90-F570A7AA2C6B}"

# Create Links to System Utilities
$LinkDir = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"

function New-Shortcut {
    param ( 
        [Parameter(Mandatory)][string]$SourceExe, 
        [Parameter(Mandatory)][string]$DestinationPath,
        [string]$IconPath,
        [string]$Arguments
    )

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($DestinationPath)
    $Shortcut.TargetPath = $SourceExe
    if (![System.String]::IsNullOrEmpty($IconPath)) {
        $Shortcut.IconLocation = "$IconPath"
    }
    if (![System.String]::IsNullOrEmpty($Arguments)) {
        $Shortcut.Arguments = $Arguments
    }
    $Shortcut.Save()
}

New-Shortcut "diskmgmt.msc" "$LinkDir\Disc Manager.lnk"
New-Shortcut "main.cpl" "$LinkDir\Mouse Settings.lnk" "main.cpl, 0"
New-Shortcut "mmsys.cpl" "$LinkDir\Sound Settings.lnk" "mmsys.cpl,0"
New-Shortcut "devmgmt.msc" "$LinkDir\Device Manager.lnk"
New-Shortcut "control.exe" "$LinkDir\Control Panel.lnk"
New-Shortcut "sndvol.exe" "$LinkDir\Sound Mixer.lnk"
New-Shortcut "appwiz.cpl" "$LinkDir\App Uninstaller.lnk" "appwiz.cpl,3"
New-Shortcut (where.exe rundll32.exe) "$LinkDir\Set Env Variables.lnk" "sysdm.cpl,2" "sysdm.cpl,EditEnvironmentVariables"

# Set nvim-qt settings (More info at: https://github.com/equalsraf/neovim-qt/wiki/Configuration-Options)
$nvimQt = "HKCU:\Software\nvim-qt\nvim-qt"
if (test-path $nvimQt) {
    Set-ItemProperty $nvimQt "ext_tabline" "false"
    Set-ItemProperty $nvimQt "ext_popupmenu" "false"
}

# Add AutoHotkey to Path
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value ((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path + ";C:\Program Files\AutoHotkey")

###############################################################################
### Devices, Power, and Startup                                               #
###############################################################################
Write-Host "Configuring Devices, Power, and Startup..." -ForegroundColor "Yellow"

# Power: Enable Hibernation
powercfg /hibernate on

###############################################################################
### Sound                                                                     #
###############################################################################

# Sound: Don't do anything when detecting comunication
Set-ItemProperty "HKCU:\Software\Microsoft\Multimedia\Audio" "UserDuckingPreference" 3

###############################################################################
### Customization                                                             #
###############################################################################
Write-Host "Configuring Explorer, Taskbar, and System Tray..." -ForegroundColor "Yellow"

# Explorer: Show hidden files by default: Show Files: 1, Hide Files: 2
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1

# Explorer: Show file extensions by default
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0

# Explorer: Show path in title bar
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" "FullPath" 1

# Explorer: Delete 3D Objects folder
if (Test-Path "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\Namespace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}") {
    Remove-Item "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\Namespace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
}

# Taskbar: Show colors on Taskbar, Start, and SysTray: Disabled: 0, Taskbar, Start, & SysTray: 1, Taskbar Only: 2
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "ColorPrevalence" 1

# Taskbar: Enable Transparency
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 0

# Taskbar: Combine taskbar buttons: 0 - Always combine, hide labels, 1 - Combine when taskbar is full, 2 - Never combine
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarGlomLevel" 0

# Taskbar: Show on screen keyboard button: 0 - Disabled, 1 - Enabled
Set-ItemProperty "HKCU:\Software\Microsoft\TabletTip\1.7" "TipbandDesiredVisibility" 1

# Taskbar: Show windows search: 0 - Hide, 1 - Show search icon, 2 - Show search bar
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" 0

# Taskbar: Disable task view button
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowTaskViewButton" 0

# Taskbar: Hide News and Interests feed
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" "ShellFeedsTaskbarViewMode" 2

# Taskbar: Don't show taskbar on multiple displays
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "MMTaskbarEnabled" 0

# Taskbar: Show the end task button
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" "TaskbarEndTask" 1

# Titlebar: Enable theme colors on titlebar
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\DWM" "ColorPrevalence" 1

# Recycle Bin: Disable Delete Confirmation Dialog
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "ConfirmFileDelete" 0

# System: Enable Dark Theme
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0

# Desktop: Set Custom Wallpaper
Set-ItemProperty "HKCU:\Control Panel\Desktop" "WallPaper" "$HOME\.config\themes\backgrounds\Minimalist Code by Daze_.jpg"

# Desktop: Decrease Menu Show Delay
Set-ItemProperty "HKCU:\Control Panel\Desktop" "MenuShowDelay" -Value "200" -Type String

# System: Enable Transparency
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 1

# System: Set Theme Colors
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" "StartColorMenu" "4288567808"
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" "AccentColorMenu" "4292311040"
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent" "AccentPalette" -Value ([byte[]](0xa6, 0xd8, 0xff, 0x00, 0x76, 0xb9, 0xed, 0x00, 0x42, 0x9c, 0xe3, 0x00, 0x00, 0x78, 0xd7, 0x00, 0x00, 0x5a, 0x9e, 0x00, 0x00, 0x42, 0x75, 0x00, 0x00, 0x26, 0x42, 0x00, 0xf7, 0x63, 0x0c, 0x00)) -Type Binary

# Start Menu: Enable Settings, Explorer and Downloads
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" "VisiblePlaces" -Value ([byte[]](0x86, 0x08, 0x73, 0x52, 0xAA, 0x51, 0x43, 0x42, 0x9F, 0x7B, 0x27, 0x76, 0x58, 0x46, 0x59, 0xD4, 0xBC, 0x24, 0x8A, 0x14, 0x0C, 0xD6, 0x89, 0x42, 0xA0, 0x80, 0x6E, 0xD9, 0xBB, 0xA2, 0x48, 0x82, 0x2F, 0xB3, 0x67, 0xE3, 0xDE, 0x89, 0x55, 0x43, 0xBF, 0xCE, 0x61, 0xF3, 0x7B, 0x18, 0xA9, 0x37)) -Type Binary

# Mouse: Disable pointer precision
Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseSpeed" 0
Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseThreshold1" 0
Set-ItemProperty "HKCU:\Control Panel\Mouse" "MouseThreshold2" 0

# Accessibility: Disable Sticky Keys
Set-ItemProperty "HKCU:\Control Panel\Accessibility\StickyKeys" "Flags" 506

# Keyboard: Disable language switch hotkey Disabled: 3, Ctrl + Shift: 2, LAlt + Shift: 1, (`): 0
Set-ItemProperty "HKCU:\Keyboard Layout\Toggle" "Language Hotkey" 3

# Keyboard: Disable layout switch hotkey Disabled: 3, Ctrl + Shift: 2, LAlt + Shift: 1, (`): 0
Set-ItemProperty "HKCU:\Keyboard Layout\Toggle" "Layout Hotkey" 3

# Install Capitaine cursors. see: https://github.com/keeferrourke/capitaine-cursors
pnputil -i -a $HOME\.config\themes\cursors\capitaine-cursors\install.inf
  
# SIG # Begin signature block
# MIIGHwYJKoZIhvcNAQcCoIIGEDCCBgwCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCAMhRrKWL5kTIPa
# FDtB6Z34DVbFb0xx43vQGInlbc8PdqCCA2YwggNiMIICSqADAgECAhB36Jox1p+m
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
# LwYJKoZIhvcNAQkEMSIEIKzqDhWFTI4PgbklES1Fz2KcrQckIzTsZFT2q7Vkh8ol
# MA0GCSqGSIb3DQEBAQUABIIBABQuby5Ghmc/7IoEOf7opRCdBHpxXiJ+PhoOTDrb
# mipyS9G5Jt/ApXSoq3uwJm6Ku9fUZz/cIJDhdAyBBDhkM3oZXmOYk3vKYRzUFLf5
# JupxOzofcID24IA6b1rmeoUqB3hvovp0hhPW6CUQ9crw9Bm3DOl9GprO3PQBXChf
# H4prEuxisKxfYLDDYRs2iDEOdrBGbkZtJKpk578CRxwgGgwbcUzz09eVmO2jKTjr
# XPlm7S/Qx6zgFakNyDkEGGzOLCU+RnroFV9mkDvQxTYiDpDR+XuJKKn6CYK2iDky
# SQszRzc8vebFHAdyOlr3Hzkf7jKYNNGfTcxCdkH9JXA4/B0=
# SIG # End signature block
