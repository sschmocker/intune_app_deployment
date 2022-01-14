$Path = "$PSScriptRoot"
Get-Childitem $Path -filter *.appxbundle | %{Add-AppxPackage -Path $_.FullName -ForceApplicationShutdown}
Get-ChildItem $Path -Filter *.msixbundle | %{Add-AppxPackage -Path $_.FullName -ForceApplicationShutdown}
Get-Childitem $Path -filter *.appx| %{Add-AppxPackage -Path $_.FullName -ForceApplicationShutdown}

Add-AppxPackage -Register 'C:\Program Files\WindowsApps\microsoft.winget.source_*.*.*.*_neutral__8wekyb3d8bbwe"AppxManifest.xml' -DisableDevelopmentMode