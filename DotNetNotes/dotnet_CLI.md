---
title:        dotnet_CLI
permalink:    DotNetNotes/dotnet_CLI
category:     DotNetNotes
parent:       DotNetNotes
layout:       default
has_children: false
share:        true
shortRepo:
  - dotnetnotes
  - default
---


<br/>

<details markdown="block">
<summary>
Table of contents
</summary>
{: .text-delta }
1. TOC
{:toc}
</details>

<br/>

***

<br/>

# [Docs](https://learn.microsoft.com/en-us/dotnet/core/tools/)

 ***

## [Install Scripts](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script)

```
# Windows PowerShell
Invoke-WebRequest -Uri https://dot.net/v1/dotnet-install.ps1 -OutFile "$env:temp/dotnet-install.ps1"; powershell -executionpolicy bypass "$env:temp/dotnet-install.ps1"

# PowerShell Core
Invoke-WebRequest -Uri https://dot.net/v1/dotnet-install.ps1 -OutFile "$env:temp/dotnet-install.ps1"; pwsh "$env:temp/dotnet-install.ps1"

# Shell
wget https://dot.net/v1/dotnet-install.sh && chmod +x ./dotnet-install.sh && sudo ./dotnet-install.sh

# Apt
sudo apt update
sudo apt install dotnet6

# WinGet
winget install Microsoft.DotNet.SDK.6

# Chocolatey
choco upgrade dotnet-sdk

```

- [Self Updating Plans](https://github.com/dotnet/sdk/issues/23700)
- [Chocolatey .Net Packages](https://community.chocolatey.org/packages/dotnet-sdk/)

***

### [Update](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-tool-update)

### Upgrade CLI templates

- Checking for Updates
  > Checks if there are updates available for the template packs that are currently installed. Available since .NET Core 3.0 SDK.

       dotnet new --update-check

- Applying Updates
  > Checks if there are updates available for the template packs that are currently installed and installs them. Available since .NET Core 3.0 SDK.

       dotnet new --update-apply

***

## [dotnet 6 and ubuntu](https://devblogs.microsoft.com/dotnet/dotnet-6-is-now-in-ubuntu-2204/)

- [Ubuntu Packages](https://packages.ubuntu.com/search?suite=default&section=all&arch=any&keywords=dotnet&searchon=names)

***