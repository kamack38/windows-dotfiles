# Modules
Import-Module posh-git, PSReadLine
$env:POSH_GIT_ENABLED = $true
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# Aliases
Set-Alias -Name exp -Value C:\Windows\explorer.exe
Set-Alias -Name List-Module -Value Get-InstalledModule
Set-Alias -Name choco -Value choco.exe
Set-Alias -Name n -Value nvim.exe
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
function Uninstall-AllOutdated {
  Get-InstalledModule | ForEach-Object {
    $CurrentVersion = $PSItem.Version
    Get-InstalledModule -Name $PSItem.Name -AllVersions | Where-Object -Property Version -LT -Value $CurrentVersion
  } | Uninstall-Module -Verbose
}
function yt-dlp-best { yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" $args }
function yt-dlp-mp3 { yt-dlp --extract-audio -f bestaudio[ext=mp3] --no-playlist $args }
function yt-dlp-music { yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail -o "%(title)s.%(ext)s" $args }

oh-my-posh init pwsh --config ~/.config/oh-my-posh/kamack.omp.json | Invoke-Expression
