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
  - [Other Settings](#other-settings)
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

## Other Settings

<details>
  <summary>
      VSCode Extesions
  </summary>
  <ul>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments">aaron-bond.better-comments</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=akamud.vscode-caniuse">akamud.vscode-caniuse</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=AlanWalk.markdown-toc">AlanWalk.markdown-toc</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=aster.vscode-subtitles">aster.vscode-subtitles</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=bagetx.inf">bagetx.inf</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=bierner.emojisense">bierner.emojisense</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=bierner.markdown-preview-github-styles">bierner.markdown-preview-github-styles</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=bungcip.better-toml">bungcip.better-toml</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=christian-kohler.npm-intellisense">christian-kohler.npm-intellisense</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense">christian-kohler.path-intellisense</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=chunsen.bracket-select">chunsen.bracket-select</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=cschlosser.doxdocgen">cschlosser.doxdocgen</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint">DavidAnson.vscode-markdownlint</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint">dbaeumer.vscode-eslint</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=dirt-lxiv.language-csgo-cfg">dirt-lxiv.language-csgo-cfg</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=dkundel.vscode-npm-source">dkundel.vscode-npm-source</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=DotJoshJohnson.xml">DotJoshJohnson.xml</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=dsznajder.es7-react-js-snippets">dsznajder.es7-react-js-snippets</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens">eamodio.gitlens</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ecmel.vscode-html-css">ecmel.vscode-html-css</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=eg2.vscode-npm-script">eg2.vscode-npm-script</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=enkia.tokyo-night">enkia.tokyo-night</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-community-material-theme">Equinusocio.vsc-community-material-theme</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=Equinusocio.vsc-material-theme">Equinusocio.vsc-material-theme</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=equinusocio.vsc-material-theme-icons">equinusocio.vsc-material-theme-icons</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode">esbenp.prettier-vscode</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=firefox-devtools.vscode-firefox-debug">firefox-devtools.vscode-firefox-debug</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner">formulahendry.code-runner</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=GEEKiDoS.vdf">GEEKiDoS.vdf</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=GitHub.github-vscode-theme">GitHub.github-vscode-theme</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github">GitHub.vscode-pull-request-github</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=GrapeCity.gc-excelviewer">GrapeCity.gc-excelviewer</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=humao.rest-client">humao.rest-client</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=icrawl.discord-vscode">icrawl.discord-vscode</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ionutvmi.reg">ionutvmi.reg</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=jeff-hykin.better-cpp-syntax">jeff-hykin.better-cpp-syntax</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=Kp.discord-js-snippets">Kp.discord-js-snippets</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=liximomo.sftp">liximomo.sftp</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=mgmcdermott.vscode-language-babel">mgmcdermott.vscode-language-babel</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=mikestead.dotenv">mikestead.dotenv</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=mrmlnc.vscode-apache">mrmlnc.vscode-apache</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker">ms-azuretools.vscode-docker</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-python.python">ms-python.python</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance">ms-python.vscode-pylance</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers">ms-vscode-remote.remote-containers</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh">ms-vscode-remote.remote-ssh</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh-edit">ms-vscode-remote.remote-ssh-edit</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl">ms-vscode-remote.remote-wsl</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools">ms-vscode.cmake-tools</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools">ms-vscode.cpptools</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-vscode.powershell">ms-vscode.powershell</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-vscode.vscode-typescript-next">ms-vscode.vscode-typescript-next</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare">ms-vsliveshare.vsliveshare</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ms-vsliveshare.vsliveshare-audio">ms-vsliveshare.vsliveshare-audio</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools">mtxr.sqltools</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=patbenatar.advanced-new-file">patbenatar.advanced-new-file</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=PKief.material-icon-theme">PKief.material-icon-theme</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=pranaygp.vscode-css-peek">pranaygp.vscode-css-peek</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml">redhat.vscode-yaml</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=richie5um2.vscode-sort-json">richie5um2.vscode-sort-json</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ritwickdey.live-sass">ritwickdey.live-sass</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer">ritwickdey.LiveServer</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced">shd101wyy.markdown-preview-enhanced</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=slevesque.vscode-autohotkey">slevesque.vscode-autohotkey</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=softwaredotcom.music-time">softwaredotcom.music-time</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=SPGoding.datapack-language-server">SPGoding.datapack-language-server</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker">streetsidesoftware.code-spell-checker</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker-polish">streetsidesoftware.code-spell-checker-polish</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=syler.sass-indented">syler.sass-indented</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=TabNine.tabnine-vscode">TabNine.tabnine-vscode</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=twxs.cmake">twxs.cmake</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=VisualStudioExptTeam.vscodeintellicode">VisualStudioExptTeam.vscodeintellicode</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=vscode-icons-team.vscode-icons">vscode-icons-team.vscode-icons</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=WakaTime.vscode-wakatime">WakaTime.vscode-wakatime</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=WallabyJs.quokka-vscode">WallabyJs.quokka-vscode</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=WallabyJs.wallaby-vscode">WallabyJs.wallaby-vscode</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=wix.vscode-import-cost">wix.vscode-import-cost</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=xabikos.JavaScriptSnippets">xabikos.JavaScriptSnippets</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=xyz.plsql-language">xyz.plsql-language</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one">yzhang.markdown-all-in-one</a></li>
      <li><a href="https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.material-theme">zhuangtongfa.material-theme</a></li>
  </ul>
</details>

## Credits

`windows.ps1` - some reg keys taken from [jayharris/dotfiles-windows](https://github.com/jayharris/dotfiles-windows/blob/master/windows.ps1)

`windows.ps1` - debloat script taken from [Sycnex/Windows10Debloater](https://github.com/Sycnex/Windows10Debloater/blob/master/Windows10SysPrepDebloater.ps1)
