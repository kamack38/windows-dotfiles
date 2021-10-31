# Modules
Import-Module oh-my-posh
Import-Module posh-git
Set-PoshPrompt -Theme ~/.config/themes/kamack.omp.json
Import-Module npm-completion
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module -Name Appx -UseWindowsPowerShell -WarningAction SilentlyContinue
$env:POSH_GIT_ENABLED = $true
Import-Module -Name Terminal-Icons
Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# Aliases
Set-Alias -Name exp -Value C:\Windows\explorer.exe
Set-Alias -Name List-Module -Value Get-InstalledModule
Set-Alias -Name choco -Value choco.exe
Set-Alias -Name code -Value code.cmd
Set-Alias -Name node -Value node.exe
function rmrf {Remove-Item -Recurse -Force $args}
function la {Get-ChildItem -Force}
function lw {Get-ChildItem | Format-Wide}
function lo {Get-ChildItem | Format-Wide -Column 3}
function qrcode {curl qrcode.show/$args}
function .. {Set-Location ../}
function ... {Set-Location ../../}
function .... {Set-Location ../../../}
function ..... {Set-Location ../../../../}
function ...... {Set-Location ../../../../../}
function reset {Clear-Host; pwsh.exe -nologo}
function Uninstall-AllOutdated {Get-InstalledModule | ForEach-Object {
  $CurrentVersion = $PSItem.Version
  Get-InstalledModule -Name $PSItem.Name -AllVersions | Where-Object -Property Version -LT -Value $CurrentVersion
} | Uninstall-Module -Verbose}
Set-Alias -Name ytdl -Value youtube-dl.exe
function youtube-dl-best {youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" $args}
function youtube-dl-mp3 {youtube-dl --extract-audio -f bestaudio[ext=mp3] --no-playlist $args}
function youtube-dl-music {youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail -o "%(title)s.%(ext)s" $args}

# Custom Functions
function wheater {
	param ($param1)
	Invoke-RestMethod http://wttr.in/$param1
}
function ip {'Private Adress: ' + (Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -eq 'Dhcp' }).IPAddress; 'Public Adress: ' + (curl -s ifconfig.me)}
function gle {
	for ( $i = 0; $i -lt $args.count; $i++ ) {
	$search = $search + $($args[$i]) + "+"
	} 
	Start-Process "https://www.google.com/search?q=$search" 
}
function faceit {
  param (
    [Parameter(Mandatory)]
    [ValidateSet('on','off')]
    [string]$state
  )
  if ($on -eq $true) {
    Write-Host "Disabling Hyper-V" -Foreground Yellow
    bcdedit /set hypervisorlaunchtype off
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 0 /f
    Write-Host "Restarting Computer..." -Foreground Yellow
    shutdown.exe /t 20 /r
    Write-Host "Your computer will be restarted in 20 sceonds." -Foreground Red
    Write-Host "Use" -NoNewLine
    Write-Host " shutdown.exe /a " -Foreground Green -NoNewLine
    Write-Host "to stop restart"
    }
  else {
    Write-Host "Enabling Hyper-V" -Foreground Yellow
    bcdedit /set hypervisorlaunchtype auto
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d 1 /f
    Write-Host "Restarting Computer..."
    shutdown.exe /t 20 /r
    Write-Host "Your computer will be restarted in 20 sceonds." -Foreground Red
    Write-Host "Use" -NoNewLine
    Write-Host " shutdown.exe /a " -Foreground Green -NoNewLine
    Write-Host "to stop restart"
  }
}
