###############################################################################
### System                                                                    #
###############################################################################

# Enables Dark Theme
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" "SystemUsesLightTheme" 0

###############################################################################
### Devices, Power, and Startup                                               #
###############################################################################
Write-Host "Configuring Devices, Power, and Startup..." -ForegroundColor "Yellow"

# Power: Enable Hibernatio
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
### Default Windows Applications                                              #
###############################################################################
Write-Host "Configuring Default Windows Applications..." -ForegroundColor "Yellow"

# Uninstall 3D Builder
Get-AppxPackage "Microsoft.3DBuilder" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.3DBuilder" | Remove-AppxProvisionedPackage -Online

# Uninstall Alarms and Clock
Get-AppxPackage "Microsoft.WindowsAlarms" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.WindowsAlarms" | Remove-AppxProvisionedPackage -Online

# Uninstall Autodesk Sketchbook
Get-AppxPackage "*.AutodeskSketchBook" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.AutodeskSketchBook" | Remove-AppxProvisionedPackage -Online

# Uninstall Bing Finance
Get-AppxPackage "Microsoft.BingFinance" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.BingFinance" | Remove-AppxProvisionedPackage -Online

# Uninstall Bing News
Get-AppxPackage "Microsoft.BingNews" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.BingNews" | Remove-AppxProvisionedPackage -Online

# Uninstall Bing Sports
Get-AppxPackage "Microsoft.BingSports" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.BingSports" | Remove-AppxProvisionedPackage -Online

# Uninstall Bing Weather
Get-AppxPackage "Microsoft.BingWeather" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.BingWeather" | Remove-AppxProvisionedPackage -Online

# Uninstall Bubble Witch 3 Saga
Get-AppxPackage "king.com.BubbleWitch3Saga" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "king.com.BubbleWitch3Saga" | Remove-AppxProvisionedPackage -Online

# Uninstall Calendar and Mail
Get-AppxPackage "Microsoft.WindowsCommunicationsApps" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.WindowsCommunicationsApps" | Remove-AppxProvisionedPackage -Online

# Uninstall Candy Crush Soda Saga
Get-AppxPackage "king.com.CandyCrushSodaSaga" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "king.com.CandyCrushSodaSaga" | Remove-AppxProvisionedPackage -Online

# Uninstall Disney Magic Kingdoms
Get-AppxPackage "*.DisneyMagicKingdoms" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.DisneyMagicKingdoms" | Remove-AppxProvisionedPackage -Online

# Uninstall Dolby
Get-AppxPackage "DolbyLaboratories.DolbyAccess" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "DolbyLaboratories.DolbyAccess" | Remove-AppxProvisionedPackage -Online

# Uninstall Facebook
Get-AppxPackage "*.Facebook" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.Facebook" | Remove-AppxProvisionedPackage -Online

# Uninstall Get Started
Get-AppxPackage "Microsoft.GetStarted" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.GetStarted" | Remove-AppxProvisionedPackage -Online

# Uninstall Maps
Get-AppxPackage "Microsoft.WindowsMaps" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.WindowsMaps" | Remove-AppxProvisionedPackage -Online

# Uninstall March of Empires
Get-AppxPackage "*.MarchofEmpires" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.MarchofEmpires" | Remove-AppxProvisionedPackage -Online

# Uninstall Messaging
Get-AppxPackage "Microsoft.Messaging" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.Messaging" | Remove-AppxProvisionedPackage -Online

# Uninstall Mobile Plans
Get-AppxPackage "Microsoft.OneConnect" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.OneConnect" | Remove-AppxProvisionedPackage -Online

# Uninstall OneNote
Get-AppxPackage "Microsoft.Office.OneNote" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.Office.OneNote" | Remove-AppxProvisionedPackage -Online

# Uninstall Paint
Get-AppxPackage "Microsoft.MSPaint" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.MSPaint" | Remove-AppxProvisionedPackage -Online

# Uninstall People
Get-AppxPackage "Microsoft.People" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.People" | Remove-AppxProvisionedPackage -Online

# Uninstall Photos
Get-AppxPackage "Microsoft.Windows.Photos" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.Windows.Photos" | Remove-AppxProvisionedPackage -Online

# Uninstall Print3D
Get-AppxPackage "Microsoft.Print3D" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.Print3D" | Remove-AppxProvisionedPackage -Online

# Uninstall Skype
Get-AppxPackage "Microsoft.SkypeApp" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.SkypeApp" | Remove-AppxProvisionedPackage -Online

# Uninstall SlingTV
Get-AppxPackage "*.SlingTV" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.SlingTV" | Remove-AppxProvisionedPackage -Online

# Uninstall StickyNotes
Get-AppxPackage "Microsoft.MicrosoftStickyNotes" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.MicrosoftStickyNotes" | Remove-AppxProvisionedPackage -Online

# Uninstall Sway
Get-AppxPackage "Microsoft.Office.Sway" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.Office.Sway" | Remove-AppxProvisionedPackage -Online

# Uninstall Twitter
Get-AppxPackage "*.Twitter" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "*.Twitter" | Remove-AppxProvisionedPackage -Online

# Uninstall Voice Recorder
Get-AppxPackage "Microsoft.WindowsSoundRecorder" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.WindowsSoundRecorder" | Remove-AppxProvisionedPackage -Online

# Uninstall Windows Phone Companion
Get-AppxPackage "Microsoft.WindowsPhone" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.WindowsPhone" | Remove-AppxProvisionedPackage -Online

# Uninstall XBox
Get-AppxPackage "Microsoft.XboxApp" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.XboxApp" | Remove-AppxProvisionedPackage -Online

# Uninstall Zune Music (Groove)
Get-AppxPackage "Microsoft.ZuneMusic" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.ZuneMusic" | Remove-AppxProvisionedPackage -Online

# Uninstall Zune Video
Get-AppxPackage "Microsoft.ZuneVideo" -AllUsers | Remove-AppxPackage
Get-AppXProvisionedPackage -Online | Where DisplayNam -like "Microsoft.ZuneVideo" | Remove-AppxProvisionedPackage -Online

# Uninstall Windows Media Player
Disable-WindowsOptionalFeature -Online -FeatureName "WindowsMediaPlayer" -NoRestart -WarningAction SilentlyContinue | Out-Null

# Prevent "Suggested Applications" from returning
if (!(Test-Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent")) {New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Type Folder | Out-Null}
Set-ItemProperty "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1

###############################################################################
### Wallpaper                                                                 #
###############################################################################

# Enable Custom Wallpaper
Set-ItemProperty "HKCU:\Control Panel\Desktop" "WallPaper" "$HOME\.config\themes\Minimalist Code by Daze_.jpg"

###############################################################################
### Debloat Windows                                                           #
###############################################################################

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
    
# SIG # Begin signature block
# MIIF+gYJKoZIhvcNAQcCoIIF6zCCBecCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUIsGa2BUpGFW/SROmPPKvByPW
# jAqgggNmMIIDYjCCAkqgAwIBAgIQd+iaMdafpqFFfJUoPJ1kJDANBgkqhkiG9w0B
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
# AYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUQ0L2B021RpWU
# btnJxSjLGYA3kEIwDQYJKoZIhvcNAQEBBQAEggEAnwGx+s5K5WMSdT8/u7TX01xk
# slUiiE8Mm1b4FPIuXgpgsjmb4FRXGUSPs2pMuoF22tAZPncrX/VYtGCbow17jBwR
# /vE5xSVzq6HafzGgvlKzAgJUD/m7+cYUYMLwJhKNStNORw4S/CvOZJWdEyXK7JjJ
# N8luGFwjCQ1vce9M40w1r6Hd5bWah6Ar0DBreM08ek+ozX7tozovfFBWtPcu1ggU
# z0VCdEGC/8NGg9bWiUWJaRqJ/iUkpeFpHKACT3QgScqLWZQ2cgwAuSwbGGv1V9Xb
# aG235xuhpurrFVJVyT2O1hf11dEuADZjQnDFpDBpqh8HwgQRISfaWummNQGBHw==
# SIG # End signature block
