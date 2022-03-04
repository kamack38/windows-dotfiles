# Modules
Import-Module posh-git
Import-Module npm-completion
Import-Module yarn-completion
Import-Module nvm-completion
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module -Name Appx -UseWindowsPowerShell -WarningAction SilentlyContinue
$env:POSH_GIT_ENABLED = $true
Import-Module Terminal-Icons
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
Set-Alias -Name firefox -Value "C:\Program Files\Firefox Developer Edition\firefox.exe"
function rmrf { Remove-Item -Recurse -Force $args }
function la { Get-ChildItem -Force }
function lw { Get-ChildItem | Format-Wide }
function lo { Get-ChildItem | Format-Wide -Column 3 }
function qrcode { curl qrcode.show/$args }
function ~ { Set-Location ~ }
function .. { Set-Location ../ }
function ... { Set-Location ../../ }
function .... { Set-Location ../../../ }
function ..... { Set-Location ../../../../ }
function ...... { Set-Location ../../../../../ }
function reset { Clear-Host; pwsh.exe -nologo }
function ip { 'Private Adress: ' + (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -eq 'Dhcp' }).IPAddress; 'Public Adress: ' + (curl -s ifconfig.me) }
oh-my-posh --init --shell pwsh --config ~/.config/oh-my-posh/kamack.omp.json | Invoke-Expression