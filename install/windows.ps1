###############################################################################
### Set Default Windows Applications                                          #
###############################################################################

# Set pwsh.exe as default OpenSSH
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Program Files\PowerShell\7\pwsh.exe" -PropertyType String -Force

# Set Windows Terminal as default batch opening porgram
if (!(Test-Path "HKCR:\")) { New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR }
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
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Multimedia\Audio" "UserDuckingPreference" 3

###############################################################################
### Customization                                                             #
###############################################################################
Write-Host "Configuring Explorer, Taskbar, and System Tray..." -ForegroundColor "Yellow"

# Explorer: Show hidden files by default: Show Files: 1, Hide Files: 2
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1

# Explorer: Show file extensions by default
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0

# Explorer: Show path in title bar
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" "FullPath" 1

# Explorer: Delete 3D Objects folder
if (Test-Path "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\Namespace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}") {
    Remove-Item "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\Namespace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
}

# Taskbar: Show colors on Taskbar, Start, and SysTray: Disabled: 0, Taskbar, Start, & SysTray: 1, Taskbar Only: 2
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "ColorPrevalence" 1

# Taskbar: Enable Transparency
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 0

# Taskbar: Combine taskbar buttons: 0 - Always combine, hide labels, 1 - Combine when taskbar is full, 2 - Never combine
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "TaskbarGlomLevel" 0

# Taskbar: Show on screen keyboard button: 0 - Disabled, 1 - Enabled
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\TabletTip\1.7" "TipbandDesiredVisibility" 1

# Taskbar: Show windows search: 0 - Hide, 1 - Show search icon, 2 - Show search bar
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" "SearchboxTaskbarMode" 0

# Taskbar: Disable task view button
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowTaskViewButton" 0

# Taskbar: Don't show taskbar on multiple displays
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "MMTaskbarEnabled" 0

# Titlebar: Enable theme colors on titlebar
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\DWM" "ColorPrevalence" 1

# Recycle Bin: Disable Delete Confirmation Dialog
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "ConfirmFileDelete" 0

# System: Enable Dark Theme
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0

# Desktop: Set Custom Wallpaper
Set-ItemProperty "HKCU:\Control Panel\Desktop" "WallPaper" "$HOME\.config\themes\backgrounds\Minimalist Code by Daze_.jpg"

# System: Enable Transparency
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 1

# System: Set Theme Colors
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" "StartColorMenu" "4288567808"
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" "AccentColorMenu" "4292311040"
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" "AccentPalette" -Value ([byte[]](0xa6, 0xd8, 0xff, 0x00, 0x76, 0xb9, 0xed, 0x00, 0x42, 0x9c, 0xe3, 0x00, 0x00, 0x78, 0xd7, 0x00, 0x00, 0x5a, 0x9e, 0x00, 0x00, 0x42, 0x75, 0x00, 0x00, 0x26, 0x42, 0x00, 0xf7, 0x63, 0x0c, 0x00)) -Type Binary

# Start Menu: Enable Settings, Explorer and Downloads
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Start" "VisiblePlaces" -Value ([byte[]](0x86, 0x08, 0x73, 0x52, 0xAA, 0x51, 0x43, 0x42, 0x9F, 0x7B, 0x27, 0x76, 0x58, 0x46, 0x59, 0xD4, 0xBC, 0x24, 0x8A, 0x14, 0x0C, 0xD6, 0x89, 0x42, 0xA0, 0x80, 0x6E, 0xD9, 0xBB, 0xA2, 0x48, 0x82, 0x2F, 0xB3, 0x67, 0xE3, 0xDE, 0x89, 0x55, 0x43, 0xBF, 0xCE, 0x61, 0xF3, 0x7B, 0x18, 0xA9, 0x37)) -Type Binary

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
# MIIF+gYJKoZIhvcNAQcCoIIF6zCCBecCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU55kj//KkF7IX5YToEWAKtJ/P
# L5GgggNmMIIDYjCCAkqgAwIBAgIQd+iaMdafpqFFfJUoPJ1kJDANBgkqhkiG9w0B
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
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUPsfrdV2+okjC
# wk6BjjgTHiE4q6EwDQYJKoZIhvcNAQEBBQAEggEALlna7ZfXBl+TPRcISiahVb88
# a1Ioqkhpd/O5okKxpSmKzXNNTmH2LFUJihu8EPRMEKpM49GTxp9PC7U7gZ3nWZuB
# ffYXwV4X4hGVHEgkbEgqCUoo/IjDfg/hxgAUUMibfopbFrcTfZRT/wZRcKIaUBfO
# glnOq1AOX9ik3089cX/9EFyyMtHBzbjhBbVecFI2mnrsN6+CGinGo7i7+FgAzDe0
# ECqfsBaWcAxD2o/RdIRo/90UJENLAj3AcYTKi+6ujQd3RwrzyRddRZ9Nxl+Bon4O
# +Q7zOKfq0ludPzXZSGf0ihaw5rp5phDWBM1phdCe0PdXgM0AKdIATopfAvpdmA==
# SIG # End signature block
