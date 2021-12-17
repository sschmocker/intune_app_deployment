# Info

This Script creates a variety of .intunewin Packages.

The following Packages will be installed with winget on the client side when deployed via Intune.
- Adobe
- Citrix
- Chrome
- Firefox
- FortiClient


Those Packages only contain a dummy .txt File wich is needed for intune, as intune otherwise will not allow to create them.


# How to use

- Run the App Selector Script
- Choose your apps
- Let the script do its magic
- Upload the Files from the Output Directory to your intune Tenant 

# Commands in Intune

The commands that intune needs for the installation/uninstallation via winget is as follows: -->
"Keep in mind to input the winget ID of the package you want to install"

| Name                    | ID                          |
| :-----------------------| :---------------------------|
| Adobe Acrobat Reader DC | Adobe.Acrobat.Reader.64-bit |
| Citrix Workspace        | Citrix.Workspace            |
| Google Chrome           | Google.Chrome               |
| Mozilla Firefox         | Mozilla.Firefox             | 
| FortiClient             | Fortinet.FortiClientVPN     |

## Commands for APP's via winget
### Install
> - cmd /c "pushd "%ProgramW6432%\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" && AppInstallerCLI.exe install --id "WINGET ID OF PACKAGE" --silent --accept-package-agreements --accept-source-agreements"

### Uninstall
> - cmd /c "pushd "%ProgramW6432%\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" && AppInstallerCLI.exe uninstall --id "WINGET ID OF PACKAGE" --silent --accept-source-agreements"


## Command for FortiClient Configuration
> - Powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -Command .\FortiClient_SSLVPN_StartPS_64bit.ps1

## Command for Company Portal 
> - PowerShell.exe -windowstyle hidden -ExecutionPolicy Bypass -Command & '.\Microsoft Company Portal.ps1'

## Command for APP installer
> - Powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -Command & '.\Microsoft Desktop App Installer.ps1'

