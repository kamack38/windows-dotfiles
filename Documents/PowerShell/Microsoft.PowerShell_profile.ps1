Import-Module oh-my-posh
Import-Module posh-git
Set-PoshPrompt -Theme ~/.config/themes/kamack.omp.json
$env:POSH_GIT_ENABLED = $true