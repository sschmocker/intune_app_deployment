######################################
#                                    #
#    ######  APP Selector  ######    #
#                                    #
######################################
#                                    #
#      Author: Sandro Schmocker      #
#      Creation Date: 08.12.2021     #
#      Last Updated: 13.12.2021      #
#                                    #
######################################


cls
Write-host "Welcome to the App Selector"
Write-Host ""
pause
cls

Write-Host "Checking if sources are already available"


$Folder = 'C:\intune\'
timeout 2
Write-Host ""
cls
if (Test-Path -Path $Folder) {
    "Path '$Folder' exists! Proceeding with Script"
    Write-Host ""
    pause
    cls
} else {
    "Path doesn't exist. We need to Download the sources from Github
    Press Enter to Confirm or cancel the script to leave"
    pause
    
    #Download of Sources
    $Location = "C:\intune"
    $Name = "applications"

    # Force to create a zip file 
    $ZipFile = "$location\$Name.zip"
    New-Item $ZipFile -ItemType File -Force
 
    $RepositoryZipUrl = "https://github.com/sschmocker/intune_app_deployment/archive/refs/heads/main.zip"
    
    # download the zip 
    Write-Host 'Starting downloading the GitHub Repository'
    Invoke-RestMethod -Uri $RepositoryZipUrl -OutFile $ZipFile
    Write-Host 'Download finished'
    
    #Extract Zip File
    Write-Host 'Starting unzipping the GitHub Repository locally'
    Expand-Archive -Path $ZipFile -DestinationPath $location -Force
    Write-Host 'Unzip finished'
    

    # remove the zip file
    Remove-Item -Path $ZipFile -Force

    #Rename Folder
    Rename-Item "$location\intune_app_deployment-main" -NewName "Applications"
    cls

Write-Host "Sources have been downloaded and saved under $Location\Applications"
Write-Host "Press enter to get to the main Selector"
Write-Host ""
pause
cls

}


Write-Host "Next you will need to enter the customer name"
Write-Host ""


$customer = Read-Host "customer Name"
cls

Write-Host "Going to Main Menu now"
Write-Host ""
Timeout 2


$outputDirectory = "C:\intune\Applications\Sources\x_Output_Files\$customer"


function Show-Menu
{
    param (
        [string]$Title = 'App Selector'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "Select the apps you want to install"
    Write-Host ""
    Write-Host "1: Adobe Acrobat Reader DC"
    Write-Host "2: App Installer (Mandatory)"
    Write-Host "3: Citrix Workspace"
    Write-Host "4: Company Portal (Mandatory)"
    Write-Host "5: Firefox"
    Write-Host "6: FortiClient"
    Write-Host "7: Google Chrome"
    Write-Host "8: All Apps"
    Write-Host ""
    Write-Host "Q: Press 'Q' to quit."
}


do
 {
     Show-Menu
     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
         '1' {
            'You chose Adobe Acrobat Reader DC'
            write-host "Config of Package starts now"
            timeout 3
            ######ADOBE#####
            cd "C:\intune\Applications\Sources"
            ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\AdobeReader\AdobeReader_Source" -s "Adobe Reader DC.txt" -o "$outputDirectory" -q

         }
         
         '2' {
            'You chose App installer'
            write-host "Config of Package starts now"
            timeout 3
            ######App Installer#####
            cd "C:\intune\Applications\Sources"
            ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\AppInstaller_Win32\AppInstaller_Source" -s "Microsoft Desktop App Installer.ps1" -o "$outputDirectory" -q


         }
         
         '3' {
            'You chose Citrix Workspace'
            write-host "Config of Package starts now"
            timeout 3
            ######Citrix#####
            cd "C:\intune\Applications\Sources"
            ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\CitrixWorkspace\CitrixWorkspace_Source" -s "Citrix Workspace.txt" -o "$outputDirectory" -q

         }
         
         '4' {
            'You chose Company Portal'
            write-host "Config of Package starts now"
            timeout 3
            ######CompanyPortal#####
            cd "C:\intune\Applications\Sources"
            ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\CompanyPortal\CompanyPortal_Source" -s "Microsoft Company Portal.ps1" -o "$outputDirectory" -q


         }
         
         '5' {
            'You chose Firefox'
            write-host "Config of Package starts now"
            timeout 3             
            ######FireFox#########
            cd "C:\intune\Applications\Sources"
            .\IntuneWinAppUtil -c "C:\intune\Applications\Sources\MozillaFirefox\MozillaFirefox_Source" -s "MozillaFirefox.txt" -o "$outputDirectory" -q
                        
         }
         
         '6' {
            'You chose FortiClient'
            write-host "Config of Package starts now"
            timeout 3
            ######FortiClient#####
            cd "C:\intune\Applications\Sources"
            ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\FortiClient_SSLVPN\FortiClient_Source" -s "FortiClient_SSL_VPN.txt" -o "$outputDirectory" -q



#------------------------------------------------------------------------------------------------------------------#
####################################################FORTI CONFIG####################################################
#------------------------------------------------------------------------------------------------------------------#


            $sourceFolderForti = "C:\intune\Applications\Sources\FortiClient_SSL_VPN_configuration\$customer\FortiClient_Source_configuration"


            #Variables for Customer VPN Tunnel#
            $tunnelName = Read-Host "insert Name for VPN Tunnel"
            $tunnelDescription = Read-Host "insert Description for VPN Tunnel"
            $vpnServer = Read-Host "insert VPN Server Adress"
            cls

            #Create ConfigFolder for specified Customer#
            if (!(Test-Path -path $sourceFolderForti)) {New-Item $sourceFolderForti -Type Directory}
            Copy-Item "C:\intune\Applications\Sources\FortiClient_SSL_VPN_configuration\FortiClient_Source_Configuration\*" -Destination $sourceFolderForti -Force
            cls

#Write Config for Registry to file#
$script=@"
           if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\$tunnelName") -ne $true) {  New-Item "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\$tunnelName" -force -ea SilentlyContinue };
            New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\$tunnelName' -Name 'Description' -Value '$tunnelDescription' -PropertyType String -Force -ea SilentlyContinue;
            New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\$tunnelName' -Name 'Server' -Value '$vpnServer' -PropertyType String -Force -ea SilentlyContinue;
            New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\$tunnelName' -Name 'promptusername' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
"@


            New-Item -Path "$sourceFolderForti" -Name "FortiClient_SSL_VPN_regKeys.ps1" -Force -Value $script


            cls
            cd "C:\intune\Applications\Sources"
            ./IntuneWinAppUtil -c "$sourceFolderForti" -s "FortiClient_SSL_VPN_Config.ps1" -o "$outputDirectory" -q
            cls



#-----------------------------------------------------------------------------------------------------------------#
###################################################################################################################
#-----------------------------------------------------------------------------------------------------------------#



         }
         
         '7' {
            'You chose Google Chrome'
            write-host "Config of Package starts now"
            timeout 3
            ######Google Chrome######
            cd "C:\intune\Applications\Sources"
            ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\GoogleChrome\GoogleChrome_Source" -s "Google Chrome.txt" -o "$outputDirectory" -q
           

         }
         
         '8' {
             'You chose All Apps, this process takes some time
             Please be patient.'
             timeout 4
             
             cls
             ######ADOBE#####
             cd "C:\intune\Applications\Sources"
             ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\AdobeReader\AdobeReader_Source" -s "Adobe Reader DC.txt" -o "$outputDirectory" -q
             cls

             ######App Installer#####
             cd "C:\intune\Applications\Sources"
             ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\AppInstaller_Win32\AppInstaller_Source" -s "Microsoft Desktop App Installer.ps1" -o "$outputDirectory" -q
             cls

             ######Citrix#####
             cd "C:\intune\Applications\Sources"
             ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\CitrixWorkspace\CitrixWorkspace_Source" -s "Citrix Workspace.txt" -o "$outputDirectory" -q
             cls

             ######CompanyPortal#####
             cd "C:\intune\Applications\Sources"
             ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\CompanyPortal\CompanyPortal_Source" -s "Microsoft Company Portal.ps1" -o "$outputDirectory" -q
             cls
             
             ######FireFox#########
             cd "C:\intune\Applications\Sources"
             .\IntuneWinAppUtil -c "C:\intune\Applications\Sources\MozillaFirefox\MozillaFirefox_Source" -s "MozillaFirefox.txt" -o "$outputDirectory" -q
             cls

             ######FortiClient#####
             cd "C:\intune\Applications\Sources"
             ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\FortiClient_SSLVPN\FortiClient_Source" -s "FortiClient_SSL_VPN.txt" -o "$outputDirectory" -q
             cls

#------------------------------------------------------------------------------------------------------------------#
####################################################FORTI CONFIG####################################################
#------------------------------------------------------------------------------------------------------------------#


            $sourceFolderForti = "C:\intune\Applications\Sources\FortiClient_SSL_VPN_configuration\$customer\FortiClient_Source_configuration"


            #Variables for Customer VPN Tunnel#
            Write-Host "You need to specify the needed variables for the VPN Tunnel in FortiClient"
            pause
            cls
            $tunnelName = Read-Host "insert Name for VPN Tunnel"
            $tunnelDescription = Read-Host "insert Description for VPN Tunnel"
            $vpnServer = Read-Host "insert VPN Server Adress"
            cls

            #Create ConfigFolder for specified Customer#
            if (!(Test-Path -path $sourceFolderForti)) {New-Item $sourceFolderForti -Type Directory}
            Copy-Item "C:\intune\Applications\Sources\FortiClient_SSL_VPN_configuration\FortiClient_Source_Configuration\*" -Destination $sourceFolderForti -Force
            cls

#Write Config for Registry to file#
$script=@"
           if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\$tunnelName") -ne $true) {  New-Item "HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\$tunnelName" -force -ea SilentlyContinue };
            New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\$tunnelName' -Name 'Description' -Value '$tunnelDescription' -PropertyType String -Force -ea SilentlyContinue;
            New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\$tunnelName' -Name 'Server' -Value '$vpnServer' -PropertyType String -Force -ea SilentlyContinue;
            New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Fortinet\FortiClient\Sslvpn\Tunnels\$tunnelName' -Name 'promptusername' -Value 1 -PropertyType DWord -Force -ea SilentlyContinue;
"@


            New-Item -Path "$sourceFolderForti" -Name "FortiClient_SSL_VPN_regKeys.ps1" -Force -Value $script


            cls
            cd "C:\intune\Applications\Sources"
            ./IntuneWinAppUtil -c "$sourceFolderForti" -s "FortiClient_SSL_VPN_Config.ps1" -o "$outputDirectory" -q
            cls


#-----------------------------------------------------------------------------------------------------------------#
###################################################################################################################
#-----------------------------------------------------------------------------------------------------------------#
             
             ######Google Chrome######
             cd "C:\intune\Applications\Sources"
             ./IntuneWinAppUtil -c "C:\intune\Applications\Sources\GoogleChrome\GoogleChrome_Source" -s "Google Chrome.txt" -o "$outputDirectory" -q
             cls

            Write-Host "Configs have been safed under $outputDirectory"       
            timeout 5
         }
     }
     pause
 }
 until ($selection -eq 'q')