###############################################################################
### Debloat Windows                                                           #
###############################################################################
Write-Host "Debloating Windows..." -ForegroundColor "Yellow"

[regex]$WhitelistedApps = 'Microsoft.ScreenSketch|Microsoft.Paint3D|Microsoft.WindowsCalculator|Microsoft.WindowsStore|Microsoft.Windows.Photos|CanonicalGroupLimited.UbuntuonWindows|`
Microsoft.WindowsCamera|.NET|Framework|Microsoft.HEIFImageExtension|Microsoft.ScreenSketch|Microsoft.StorePurchaseApp|`
Microsoft.VP9VideoExtensions|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.DesktopAppInstaller'
Get-AppxPackage -AllUsers | Where-Object {$_.Name -NotMatch $WhitelistedApps} | Remove-AppxPackage -ErrorAction SilentlyContinue
# Run this again to avoid error on 1803 or having to reboot.
Get-AppxPackage -AllUsers | Where-Object {$_.Name -NotMatch $WhitelistedApps} | Remove-AppxPackage -ErrorAction SilentlyContinue
$AppxRemoval = Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -NotMatch $WhitelistedApps} 
ForEach ( $App in $AppxRemoval) {
    Remove-AppxProvisionedPackage -Online -PackageName $App.PackageName 
}

# Uninstall Windows Media Player
Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null

$Keys = @(
        
    #Remove Background Tasks
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
    
    #Windows File
    "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    
    #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
    
    #Scheduled Tasks to delete
    "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
    
    #Windows Protocol Keys
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
    "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
       
    #Windows Share Target
    "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
)

#This writes the output of each key it is removing and also removes the keys listed above.
ForEach ($Key in $Keys) {
    Write-Output "Removing $Key from registry"
    Remove-Item $Key -Recurse -ErrorAction SilentlyContinue
}

###############################################################################
### Disable Telemetry                                                         #
###############################################################################
Write-Host "Disabling Telemetry..." -ForegroundColor "Yellow"

#Creates a PSDrive to be able to access the 'HKCR' tree
New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    
#Disables Windows Feedback Experience
Write-Output "Disabling Windows Feedback Experience program"
$Advertising = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo'
If (Test-Path $Advertising) {
    Set-ItemProperty $Advertising -Name Enabled -Value 0 -Verbose
}
    
#Stops Cortana from being used as part of your Windows Search Function
Write-Output "Stopping Cortana from being used as part of your Windows Search Function"
$Search = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
If (Test-Path $Search) {
    Set-ItemProperty $Search -Name AllowCortana -Value 0 -Verbose
}
    
#Stops the Windows Feedback Experience from sending anonymous data
Write-Output "Stopping the Windows Feedback Experience program"
$Period1 = 'HKCU:\Software\Microsoft\Siuf'
$Period2 = 'HKCU:\Software\Microsoft\Siuf\Rules'
$Period3 = 'HKCU:\Software\Microsoft\Siuf\Rules\PeriodInNanoSeconds'
If (!(Test-Path $Period3)) { 
    mkdir $Period1 -ErrorAction SilentlyContinue
    mkdir $Period2 -ErrorAction SilentlyContinue
    mkdir $Period3 -ErrorAction SilentlyContinue
    New-ItemProperty $Period3 -Name PeriodInNanoSeconds -Value 0 -Verbose -ErrorAction SilentlyContinue
}
            
Write-Output "Adding Registry key to prevent bloatware apps from returning"
#Prevents bloatware applications from returning
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
If (!(Test-Path $registryPath)) {
    Mkdir $registryPath -ErrorAction SilentlyContinue
    New-ItemProperty $registryPath -Name DisableWindowsConsumerFeatures -Value 1 -Verbose -ErrorAction SilentlyContinue
}          

Write-Output "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
$Holo = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic'    
If (Test-Path $Holo) {
    Set-ItemProperty $Holo -Name FirstRunSucceeded -Value 0 -Verbose
}

#Disables live tiles
Write-Output "Disabling live tiles"
$Live = 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications'    
If (!(Test-Path $Live)) {
    mkdir $Live -ErrorAction SilentlyContinue     
    New-ItemProperty $Live -Name NoTileApplicationNotification -Value 1 -Verbose
}

#Turns off Data Collection via the AllowTelemtry key by changing it to 0
Write-Output "Turning off Data Collection"
$DataCollection = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection'    
If (Test-Path $DataCollection) {
    Set-ItemProperty $DataCollection -Name AllowTelemetry -Value 0 -Verbose
}

#Disables People icon on Taskbar
Write-Output "Disabling People icon on Taskbar"
$People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
If (Test-Path $People) {
    Set-ItemProperty $People -Name PeopleBand -Value 0 -Verbose
}

#Disables suggestions on start menu
Write-Output "Disabling suggestions on the Start Menu"
$Suggestions = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'    
If (Test-Path $Suggestions) {
    Set-ItemProperty $Suggestions -Name SystemPaneSuggestionsEnabled -Value 0 -Verbose
}


    Write-Output "Removing CloudStore from registry if it exists"
    $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
    If (Test-Path $CloudStore) {
    Stop-Process -Name explorer -Force
    Remove-Item $CloudStore -Recurse -Force
    Start-Process Explorer.exe -Wait
}

#Loads the registry keys/values below into the NTUSER.DAT file which prevents the apps from redownloading. Credit to a60wattfish
reg load HKU\Default_User C:\Users\Default\NTUSER.DAT
Set-ItemProperty -Path Registry::HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name SystemPaneSuggestionsEnabled -Value 0
Set-ItemProperty -Path Registry::HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name PreInstalledAppsEnabled -Value 0
Set-ItemProperty -Path Registry::HKU\Default_User\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager -Name OemPreInstalledAppsEnabled -Value 0
reg unload HKU\Default_User

#Disables scheduled tasks that are considered unnecessary 
Write-Output "Disabling scheduled tasks"
#Get-ScheduledTask -TaskName XblGameSaveTaskLogon | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask -TaskName XblGameSaveTask | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask -TaskName Consolidator | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask -TaskName UsbCeip | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask -TaskName DmClient | Disable-ScheduledTask -ErrorAction SilentlyContinue
Get-ScheduledTask -TaskName DmClientOnScenarioDownload | Disable-ScheduledTask -ErrorAction SilentlyContinue

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
New-Shortcut "sndvol.exe" "$LinkDir\Sound Mixer.lnk"

# Set nvim-qt settings (More info at: https://github.com/equalsraf/neovim-qt/wiki/Configuration-Options)
$nvimQt = "HKCU:\Software\nvim-qt\nvim-qt"
if (test-path $nvimQt) {
    Set-ItemProperty $nvimQt "ext_tabline" "false"
    Set-ItemProperty $nvimQt "ext_popupmenu" "false"
}

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

# Titlebar: Enable theme colors on titlebar
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\DWM" "ColorPrevalence" 1

# Recycle Bin: Disable Delete Confirmation Dialog
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" "ConfirmFileDelete" 0

# System: Enable Dark Theme
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "AppsUseLightTheme" 0

# Desktop: Set Custom Wallpaper
Set-ItemProperty "HKCU:\Control Panel\Desktop" "WallPaper" "$HOME\.config\themes\Minimalist Code by Daze_.jpg"

# System: Enable Transparency
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "EnableTransparency" 1

# System: Set Theme Colors
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" "StartColorMenu" "4288567808"
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" "AccentColorMenu" "4292311040"
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent" "AccentPalette" -Value ([byte[]](0xa6,0xd8,0xff,0x00,0x76,0xb9,0xed,0x00,0x42,0x9c,0xe3,0x00,0x00,0x78,0xd7,0x00,0x00,0x5a,0x9e,0x00,0x00,0x42,0x75,0x00,0x00,0x26,0x42,0x00,0xf7,0x63,0x0c,0x00)) -Type Binary

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

# Install custom cursors

# Minecraft cursors
pnputil -i -a $HOME\.config\themes\cursors\minecraft-cursors\install.inf
# Capitaine cursors. see: https://github.com/keeferrourke/capitaine-cursors
pnputil -i -a $HOME\.config\themes\cursors\capitaine-cursors\install.inf
  
# SIG # Begin signature block
# MIIF+gYJKoZIhvcNAQcCoIIF6zCCBecCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUhKzapb2fwoKJhARHa93kCgjP
# +7mgggNmMIIDYjCCAkqgAwIBAgIQd+iaMdafpqFFfJUoPJ1kJDANBgkqhkiG9w0B
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
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU7eMzMuXBOAnX
# 5L4cWATFgxNxjnUwDQYJKoZIhvcNAQEBBQAEggEApadlFBv+IbLOnbHqLlVYlRwQ
# tLRulUM5MfUNv68gfy3FAcmxZM+eI1c99Y3FCNaOvvm4es5OC+ydEB/MSmUYeK3Z
# Ci1H7qB7uC6dFNMqRaCFk7a3Xr2XEbJ28Vzx4zrmDv15K3aEcqX/lGakbhZ/WoQ0
# zj9yQDYeGgbobgI4huEThueFmUbxM3CdftvVeJZ8X4XokyjiSWEGb782dlHJBnmC
# zCA4buScK0zr9yAIANFJaPJxxX85ggS2em1rr3DE4znAO4XctDPQzz7YtHGH+Cp9
# z14hGU29dSDOfU0+DudvnKy6UAOaU0Zm6nSn8NynD+8ak8OrdZjyhDQ1ORD1jQ==
# SIG # End signature block
