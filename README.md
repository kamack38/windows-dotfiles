# My .dotfiles for Windows 10

A collection of configuration files fo Windows, including application installation through [**Chocolatey**](https://chocolatey.org/) or **Curl**

<!-- TOC -->

- [My .dotfiles for Windows 10](#my-dotfiles-for-windows-10)
  - [Pre-requirements](#pre-requirements)
  - [Installation](#installation)
    - [Installation using chocolatey and git via powershell script](#installation-using-chocolatey-and-git-via-powershell-script)
    - [Installation using batch script **[DEPRECATED]**](#installation-using-batch-script-deprecated)
  - [Setup WSL 2](#setup-wsl-2)
    - [Enable WSL 2 and update the linux kernel (Source)](#enable-wsl-2-and-update-the-linux-kernel-source)
    - [Install common dependencies](#install-common-dependencies)
  - [GPG key](#gpg-key)
    - [Restore](#restore)
    - [Create](#create)
  - [Credits](#credits)

<!-- /TOC -->

## Pre-requirements

- Windows 10 version 1903 or higher with Build 18362 or higher
- PowerShell 5.0 or higher

> **Note:** With PowerShell, you must ensure `Get-ExecutionPolicy` is not Restricted. I suggest using `Set-ExecutionPolicy Bypass -Scope Process` to bypass the policy or `Set-ExecutionPolicy RemoteSigned` for quite a bit more security.

## Installation

### Installation using chocolatey and git via powershell script

From [PowerShell](https://docs.microsoft.com/en-us/powershell/):
> **Note:** You **DON'T** need [**Chocolatey**](https://chocolatey.org/) and [**Git**](https://git-scm.com/) installed, because the script will download them automatically, but make sure PowerShell is run as administrator.

```powershell
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/kamack38/dotfiles/main/install/chocolatey.ps1'))
```

**OR** (Shorter version)

```powershell
Set-ExecutionPolicy RemoteSigned; iwr -useb https://git.io/JEt6s | iex
```

### Installation using batch script **[DEPRECATED]**

From CMD :

```batch
curl "https://raw.githubusercontent.com/kamack38/dotfiles/main/install/setup.bat" -L -o setup.bat && setup.bat
```

## Setup WSL 2

### Enable WSL 2 and update the linux kernel ([Source](https://docs.microsoft.com/en-us/windows/wsl/install-win10))

```powershell
# In PowerShell as Administrator

# Enable WSL and VirtualMachinePlatform features
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Download and install the Linux kernel update package
$wslUpdateInstallerUrl = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$downloadFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$wslUpdateInstallerFilePath = "$downloadFolderPath/wsl_update_x64.msi"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($wslUpdateInstallerUrl, $wslUpdateInstallerFilePath)
Start-Process -Filepath "$wslUpdateInstallerFilePath"

# Set WSL default version to 2
wsl --set-default-version 2
```

- [Install Ubuntu from Microsoft Store](https://www.microsoft.com/pl-pl/p/ubuntu/9nblggh4msv6)
- [Install Arch from github](https://github.com/yuk7/ArchWSL)

### Install common dependencies

```shell script
#!/bin/bash

sudo apt update && sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    git \
    make \
    tig \
    tree \
    zip unzip
```

## GPG key

If you already have a GPG key, restore it. If you did not have one, you can create one.

### Restore

- On old system, create a backup of a GPG key
  - `gpg --list-secret-keys`
  - `gpg --export-secret-keys {{KEY_ID}} > /tmp/private.key`
- On new system, import the key:
  - `gpg --import /tmp/private.key`
- Delete the `/tmp/private.key` on both side

### Create

- `gpg --full-generate-key`

[Read GitHub documentation about generating a new GPG key for more details](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key).

## Credits

`windows.ps1` - taken from [jayharris/dotfiles-windows](https://github.com/jayharris/dotfiles-windows/blob/master/windows.ps1)
