Import-Module oh-my-posh
Import-Module posh-git
Set-PoshPrompt -Theme ~/.config/themes/kamack.omp.json
Import-Module npm-completion
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module -Name Appx -UseWindowsPowerShell -WarningAction SilentlyContinue
$env:POSH_GIT_ENABLED = $true
Set-Alias -Name exp -Value C:\Windows\explorer.exe
Set-Alias -Name List-Module -Value Get-InstalledModule
function qrcode {curl qrcode.show/$args}
function .. {Set-Location ../}
function ... {Set-Location ../../}
function .... {Set-Location ../../../}
function ..... {Set-Location ../../../../}
function ...... {Set-Location ../../../../../}
function reset {clear; pwsh.exe -nologo}
Set-Alias -Name ytdl -Value youtube-dl.exe
function youtube-dl-best {youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" $args}
function youtube-dl-mp3 {youtube-dl --extract-audio -f bestaudio[ext=mp3] --no-playlist $args}
function youtube-dl-music {youtube-dl --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail -o "%(title)s.%(ext)s" $args}
function wheater {
	param ($param1)
	Invoke-RestMethod http://wttr.in/$param1
}
function ln { 
	param(
		[switch]$s,
		
		[Parameter(Mandatory)]
		[string]$Path,
		
		[Parameter(Mandatory)]
		[string]$Target
	)
	if ($s -eq $true) {
		New-Item -ItemType SymbolicLink -Path $Path -Target $Target
	}
	else {
		New-Item -ItemType HardLink -Path $Path -Target $Target
	}
}
function gle {
	for ( $i = 0; $i -lt $args.count; $i++ ) {
	$search = $search + $($args[$i]) + "+"
	} 
	start "https://www.google.com/search?q=$search" 
}

winfetch
