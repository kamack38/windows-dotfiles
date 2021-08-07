Import-Module oh-my-posh
Import-Module posh-git
Set-PoshPrompt -Theme ~/.config/themes/kamack.omp.json
$env:POSH_GIT_ENABLED = $true
Set-Alias -Name exp -Value C:\Windows\explorer.exe
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
