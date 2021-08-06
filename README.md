# My .dotfiles for Windows 10

A collection of configuration files fo Windows, inculding application instalation through [**Chocolatey**](https://chocolatey.org/) or **Curl**

## Instalation

### Instalation using chcolatey and git via powershell script

From PowerShell:

```powershell
curl "https://raw.githubusercontent.com/kamack38/dotfiles/main/install/chocolatey.ps1" -L -o chocolatey.ps1 && chocolatey.ps1
```

### Instaltion using batch script

```batch
curl "https://raw.githubusercontent.com/kamack38/dotfiles/main/install/setup.bat" -L -o setup.bat && setup.bat
```