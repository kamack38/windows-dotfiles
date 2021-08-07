# My .dotfiles for Windows 10

A collection of configuration files fo Windows, inculding application instalation through [**Chocolatey**](https://chocolatey.org/) or **Curl**

## Pre-requirements

- Windows 10 version 1903 or higher with Build 18362 or higher
- PowerShell 5.0 or higher

> **Note:** With PowerShell, you must ensure `Get-ExecutionPolicy` is not Restricted. We suggest using `Set-ExecutionPolicy Bypass -Scope Process` to bypass the policy or `Set-ExecutionPolicy AllSigned` for quite a bit more security.

## Instalation

### Instalation using chcolatey and git via powershell script

From [PowerShell](https://docs.microsoft.com/en-us/powershell/):
> **Note:** You **DON'T** need [**Chocolatey**](https://chocolatey.org/) and [**Git**](https://git-scm.com/) installed, because the script will download them automatically, but make sure PowerShell is run as administrator.

```powershell
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/kamack38/dotfiles/main/install/chocolatey.ps1'))
```

### Instaltion using batch script

From CMD :

```batch
curl "https://raw.githubusercontent.com/kamack38/dotfiles/main/install/setup.bat" -L -o setup.bat && setup.bat
```
