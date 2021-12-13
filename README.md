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

# Commands in Intune

The commands that intune needs for the installation/uninstallation via winget is as follows: -->
"Keep in mind to input the winget ID of the package you want to install"

- cmd /c "pushd "%ProgramW6432%\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" && AppInstallerCLI.exe install --id "WINGET ID OF PACKAGE" --silent --accept-package-agreements --accept-source-agreements"
- cmd /c "pushd "%ProgramW6432%\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" && AppInstallerCLI.exe uninstall --id "WINGET ID OF PACKAGE" --silent --accept-source-agreements"



# Commands for Company Portal & APP installer
Company Portal:
- PowerShell.exe -windowstyle hidden -ExecutionPolicy Bypass -Command & '.\Microsoft Company Portal.ps1'

App installer:
- Powershell.exe -windowstyle hidden -ExecutionPolicy Bypass -Command & '.\Microsoft Desktop App Installer.ps1'

